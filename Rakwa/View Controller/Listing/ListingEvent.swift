//
//  ListingEvent.swift
//  Rakwa
//
//  Created by macbook on 9/18/21.
//

import UIKit
import MapKit
class ListingEvent: UIViewController {
    @IBOutlet var displayTableView: UITableView!
    @IBOutlet var emptyView: UIView!

    @IBOutlet weak var searchBar: SearchView!
    var listEvent:[eventData]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        displayTableView.register(ListingEventCell.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
        LocationManager.shared.getLocation { location, error in
            
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
            
            do{
                self.ListEvent(latitude: "\(location.coordinate.latitude)", longtiude:"\(location.coordinate.longitude)")
//                self.ListEvent(latitude: "\(34.137729)", longtiude:"\(-117.452701)")
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }

        }
        searchBar.startHandler {
               self.displayTableView.reloadData()
           }
           searchBar.editingChangeHandler {
               if (self.searchBar.txtSearch.text)?.count != 0{
                   self.listEvent = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                   self.displayTableView.reloadData()
               }else{

               }
               
           }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func createNewEvent(_ sender: Any) {
        let vc=AddEventVC.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goingPressed(_ sender : UIButton ) {
        
        if listEvent[sender.tag].isParticipant == 1{
            participate(eventid: listEvent[sender.tag].eventID ?? 0, participation: 0)
        }else{
            participate(eventid: listEvent[sender.tag].eventID ?? 0, participation: 1)


        }
    }
    
}
extension ListingEvent:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell:ListingEventCell = displayTableView.dequeueReusableCell(for: indexPath)
        cell.configureEvent(event: listEvent[indexPath.row])
        cell.deleteBtn.isHidden = true
        cell.editBtn.isHidden=true
        cell.goingBtn.tag = indexPath.row
        cell.goingBtn.addTarget(self, action: #selector(self.goingPressed(_:)), for: .touchUpInside)
        return cell
    }
    
    
    
    
    
    
    
    
}
extension ListingEvent:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension ListingEvent{
    func ListEvent(latitude:String,longtiude:String){
    self.showActivityIndicator()
        DashboardManager.shared.Event(lat:latitude,longtitude:longtiude) { response in
  
        switch response{

        case let .success(response):
            if response.statusCode == 200{
                
            do {
                guard let  responsedata = response.data else {return}
                self.listEvent=responsedata
                
                if self.listEvent.count == 0 {
                    self.emptyView.isHidden = false
                }else {
                    self.emptyView.isHidden = true
                    
                }
                self.displayTableView.reloadData()
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
    
    func participate(eventid:Int,participation:Int){
        DashboardManager.shared.participate(event_id: eventid, participation: participation) { response in
       
                switch response{
                case let .success(response):
                    
                    switch response.statusCode{
                    case 200..<300:
                        self.showAlert(title: "Success", message: response.statusMessage)

                         break
                    case   400..<500:
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                         break
                    case 500:
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")

                    default:
                        break
                    }
             
                case let .failure(error):
     
                    self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                    }
            }

            
        }
    }
    
    
    func filter(keyword : String) -> [eventData]{
        let keyword = keyword.lowercased()
        return listEvent.filter { event  in
            (event.title ?? "" ).lowercased() == keyword
        }
 
     }
    
}
