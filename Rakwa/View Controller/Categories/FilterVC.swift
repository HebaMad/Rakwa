//
//  FilterVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit
import MapKit
class FilterVC: UIViewController {
    @IBOutlet var sortByBtns: [UIButton]!


     @IBOutlet weak var whereMap:MKMapView!
    @IBOutlet weak var ratingControl:RatingControl!
    @IBOutlet weak var fromTF:UITextFieldDataPicker!
    @IBOutlet weak var openNowCB:CheckBoxButton!
    @IBOutlet weak var whatTF:UITextField!
    private var categories:[TopCategory]?
    private var sortMethod:SortType = .mostReviewd
    private var selectedLocation:CLLocationCoordinate2D?
    private var selectedCategoryId = 0
    
     override func viewDidLoad() {
        super.viewDidLoad()
        fromTF.dataSource = self
        fromTF.pickerDelegate = self
         setCheckdBtn(btn: self.sortByBtns.first!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        whereMap.addGestureRecognizer(tap)
         whereMap.roundCorners([.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 12)
        // Do any additional setup after loading the view.
        HomeManager.shared.AllCategories(module: "listing") { result in
            switch result{
            case .success(let cat):
                self.categories = cat.data ?? []
            case .failure(let error):
                print("error")
            }
        }
    }
    
    enum SortType:Int{
        case  mostReviewd = 0
         case mostViewd = 1
        case highestRated = 2
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let vc = SelectLocationVC(nibName: "SelectLocationVC", bundle: .main)
        vc.onSelectLocation = {[weak self ] coordinate in
            guard let self = self else { return  }
            self.selectedLocation = coordinate
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    @IBAction func endVC(){
        DispatchQueue.main.async {
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
 
    @IBAction func selectSortMethod(sender:UIButton){
        self.sortByBtns.forEach { btn in
            if btn == sender{
                self.setCheckdBtn(btn: sender)
            }else{
                self.setUnCheckdBtn(btn: btn)
            }
        }
        self.sortMethod = SortType(rawValue: sender.tag)!
        
        
        
    }

    @IBAction func applyFilterBtnPressed(){
        
        if let keyword = self.whatTF.text{
            let lat = selectedLocation?.latitude ?? 0
            let long = selectedLocation?.longitude ?? 0
            HomeManager.shared.filter(sort_by: self.sortMethod.rawValue, keyword: keyword, module: "listing", category: 1, lat: lat==0 ? "":"\(lat)", lon: lat==0 ? "":"\(long)", is_open: self.openNowCB.isChecked ? 1:0, rate: self.ratingControl.rating, page: 0) { result in
                    switch result{
                    case .success(let res):
                        #warning("handle this scenario")
                        if let items =  res.data?.items, items.count > 0 {
                            let vc = FilterResult.instantiate()
                            vc.listing = items
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }else{
                            self.showAlert(title: "Warning", message: "No data found for your preferances",hideCancelBtn:  true )
                        }
                    case .failure(let error):
                        
                        print("error")
                    }
                }
            
          
        }else{
            self.showAlert(title: "Warning", message: "keyword text field is requeired",hideCancelBtn: true)
        }
        
   

        
    }
    
    
    
    
    @IBAction func currentLocationBtnPressed(){
        
        LocationManager.shared.getLocation { location, error in
            if let error = error{
                self.showNoLocationVC()
            }else{
                guard let location = location else { return  }
                 
                
                let mapCamera = MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 10000, pitch: 65, heading: 0)
                self.whereMap.setCamera(mapCamera, animated: true)
                 
                      let myAnnotation: MKPointAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
                self.whereMap.addAnnotation(myAnnotation)
                self.selectedLocation = location.coordinate

            }
        }
        
    }
}

extension FilterVC:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        guard let category = categories else { return  }
        
        self.fromTF.text = category[row].title
        self.selectedCategoryId =  category[row].id ?? 0
        
         
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories?[row].title ?? ""
    }
    
    func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
        return 1
    }
    
    
    fileprivate func setUnCheckdBtn(btn:UIButton){
        btn.backgroundColor = .white
        btn.titleLabel?.textColor = .black
        btn.titleLabel?.font = UIFont(name: "Roboto-Regular", size: btn.titleLabel!.font.pointSize)
        btn.setTitleColor(.black, for: .normal)

        
    }
    
    fileprivate func setCheckdBtn(btn:UIButton){
        btn.backgroundColor = UIColor(color: .buttonPrimary)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font =   UIFont.boldSystemFont(ofSize: btn.titleLabel!.font.pointSize-2)
        btn.setTitleColor(.white, for: .normal)

        
    }
}
extension FilterVC:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}
