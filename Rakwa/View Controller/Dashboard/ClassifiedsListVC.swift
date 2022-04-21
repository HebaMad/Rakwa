//
//  ClassifiedsListVC.swift
//  Rakwa
//
//  Created by macbook on 11/5/21.
//

import UIKit
import SDWebImage
import MapKit
class ClassifiedsListVC: UIViewController {

    @IBOutlet var searchBar: SearchView!
    @IBOutlet var displayTable: UITableView!
    
    var myClasifieds:[ClassifiedData]=[]
    @IBOutlet var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        displayTable.register(ClassifiedsCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self
        
        currentLoc()
        searchBar.startHandler {
               self.displayTable.reloadData()
           }
           searchBar.editingChangeHandler {
               if (self.searchBar.txtSearch.text)?.count != 0{
                   self.myClasifieds = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                   self.displayTable.reloadData()
               }else{
  
               }
               
           }
 
    }

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
}
extension ClassifiedsListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClasifieds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:ClassifiedsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureClassified(classified: myClasifieds[indexPath.row])
        
        cell.editBtn.isHidden=true
        cell.removeBtn.isHidden=true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        classifiedDetails(id: myClasifieds[indexPath.row].id ?? 0)
    }
    
    
    
}
extension ClassifiedsListVC:Storyboarded{
    static var storyboardName: StoryboardName = .Dashboard
}
extension ClassifiedsListVC{
func classifiedsList(lat:String,long:String){
    self.showActivityIndicator()
    DashboardManager.shared.getAllClassified(lat: lat, long: long) { response in
     
        switch response{
        case let .success(response):
            if response.statusCode == 200{
              
            do {
                guard let  responsedata = response.data else {return}
                self.myClasifieds=responsedata
                if self.myClasifieds.count == 0 {
                    self.emptyView.isHidden = false
                }else {
                    self.emptyView.isHidden = true
                    
                }
                self.displayTable.reloadData()
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
    
    func classifiedDetails(id:Int){
        
        self.showActivityIndicator()

        DashboardManager.shared.classifiedDetails(classifiedId: id) { (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data else {return}
                    let vc =  Classifieds.instantiate()
                    vc.details=responsedata
                    self.navigationController?.pushViewController(vc, animated: true)
                    
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
    
    func filter(keyword : String) -> [ClassifiedData]{
         let result : [ClassifiedData] = myClasifieds.filter({ (txt) -> Bool in
             return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
         return result
     }
    func  currentLoc(){
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
            guard let location = location else {
                        self.showAlert(title: "Location Permission Required", message: "You should activate your location ", confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { (action) in
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        }
                        return
                    }
            
                    print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
            do{
//                self.classifiedsList(lat: "\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
                self.classifiedsList(lat: "\(34.137729)", long: "\(-117.452701)")
//                self.home(levelid: 1, lat:"\( location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
//                self.home(levelid: 1, lat:"\(34.137729)", long: "\(-117.452701)")
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
                }
    }
    

}
