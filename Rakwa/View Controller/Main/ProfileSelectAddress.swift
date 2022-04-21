//
//  ProfileSelectAddress.swift
//  Rakwa
//
//  Created by heba isaa on 19/11/2021.
//

import UIKit
class ProfileSelectAddress: UIViewController {
    var stateID:[Int]=[]
    var stateName:[String]=[]
    var stateCategory:[city]=[]
    
    @IBOutlet weak var addressLabel: UILabel!
    var cityID:[Int]=[]
    var cityName:[String]=[]
    var cityCategory:[city]=[]
    var stateitemID=0
    var cityitemID=0
    var address:String?
    
    var user:userAddress?
    var userProfileInfo:profileInfo?
var addressFromMap=0
  var cityIdNum=0
    var stateIdNum=0
var num = 0
    @IBOutlet weak var stateTxt: UITextFieldDataPicker!
   
    @IBOutlet weak var cityTxt: UITextFieldDataPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTxt.text=userProfileInfo?.city?.name
        stateTxt.text=userProfileInfo?.state?.name
        addressLabel.text=userProfileInfo?.address

        sate()
        cityTxt.dataSource=self
        cityTxt.pickerDelegate=self
        stateTxt.dataSource=self
        stateTxt.pickerDelegate=self

  }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if addressFromMap == 1{
        addressLabel.text=address ?? ""
        }
        UserDefaults.standard.set(self.addressLabel.text, forKey: "addresss")

    }
// 
//    @IBAction func stateList(_ sender: Any) {
//        
//        self.dropDown.anchorView = self.stateAction
//        self.dropDown.dataSource = self.stateName
//        self.dropDown.cellNib = UINib(nibName: "DropDownView", bundle: nil)
//        
//        self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//        }
//        self.dropDown.selectionAction = { [self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.stateTxt.textColor = UIColor.darkGray
//            self.stateTxt.text = item
//            self.stateitemID=stateID[index]
//            UserDefaults.standard.set(self.stateitemID, forKey: "state")
//
//            city(stateID: stateitemID)
//        }
//        self.dropDown.width = self.stateTxt.frame.size.width
//        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
//        self.dropDown.show()
//    }
    
//    @IBAction func cityList(_ sender: Any) {
//
//        self.dropDown.anchorView = self.cityAction
//        self.dropDown.dataSource = self.cityName
//        self.dropDown.cellNib = UINib(nibName: "DropDownView", bundle: nil)
//
//        self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//        }
//        self.dropDown.selectionAction = { [self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.cityTxt.textColor = UIColor.darkGray
//            self.cityTxt.text = item
//            self.cityitemID=cityID[index]
//            UserDefaults.standard.set(self.cityitemID, forKey: "city")
//
//        }
//        self.dropDown.width = self.cityTxt.frame.size.width
//        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
//        self.dropDown.show()
//    }
    
    
    
    @IBAction func mapBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        let vc = MapVC.instantiate()
        vc.screen="profile"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension ProfileSelectAddress:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension ProfileSelectAddress{
    func sate(){
        self.showActivityIndicator()

        DashboardManager.shared.state { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.stateCategory  = responsedata
                        if self.stateCategory.count != 0{
                            
                       
                        for index in 0 ... self.stateCategory.count-1{
                            self.stateName.append(self.stateCategory[index].name ?? "")
                            self.stateID.append(self.stateCategory[index].id ?? 0)
                            
                            
                        }
                        }
                    } catch let error {
                        
                    }
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
        self.hideActivityIndicator()

    }
    
    func city(stateID:Int){

    
        DashboardManager.shared.city(state: stateID) { response in
   
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.cityCategory  = responsedata
                        if self.cityCategory.count != 0{
                            
                       
                        for index in 0 ... self.cityCategory.count-1{
                            self.cityName.append(self.cityCategory[index].name ?? "")
                            self.cityID.append(self.cityCategory[index].id ?? 0)
                            
                        }}
                    } catch let error {
                        
                    }}
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
            }
        }
        self.hideActivityIndicator()

    }
}
extension ProfileSelectAddress:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        if textField == cityTxt{
            cityTxt.setTextFieldTitle(title: " \(cityName[row])")
            self.cityIdNum=cityID[row]

        }else{
            stateTxt.setTextFieldTitle(title: " \(stateName[row])")
            self.stateIdNum=stateID[row]
            city(stateID: self.stateIdNum)
        }
      
    }

    func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
        if textField == cityTxt{

       num = cityName.count
        }else{
            num = stateName.count

        }
        return num
    }

    func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
print("\(title ?? "")")
        if textField == cityTxt{
            return cityName[row]
        }else{
            return stateName[row]
        }
    }

    func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
        1
    }








}
