//
//  MyEventVC.swift
//  Rakwa
//
//  Created by heba isaa on 30/11/2021.
//

import UIKit

class MyEventVC: UIViewController {
    var categoriesData:[TopCategory]=[]

    @IBOutlet var displayTableView: UITableView!
    var publishedList:[eventData]=[]
    var pendingList:[eventData]=[]
    var AllList:[eventData]=[]
    @IBOutlet var AllListing: UIButton!
    @IBOutlet var listingView: UIView!
    
    @IBOutlet var published: UIButton!
    @IBOutlet var publishedView: UIView!
    
    @IBOutlet weak var searchView: SearchView!
    
    @IBOutlet var pendingBtn: UIButton!
    @IBOutlet var pendingView: UIView!
    var buttonText="AllListing"
    @IBOutlet var emptyView: UIView!
    
    var listEvent:[eventData]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        displayTableView.register(ListingEventCell.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
        ListEvent()
        
        searchView.startHandler {
               self.displayTableView.reloadData()
           }
        searchView.editingChangeHandler {
            if (self.searchView.txtSearch.text)?.count != 0{
                
                switch self.buttonText {
                    
                case "AllListing":
                    self.AllList = self.filter(keyword:self.searchView.txtSearch.text ?? "")
               break
                case "published":
                    self.publishedList = self.filter(keyword:self.searchView.txtSearch.text ?? "")
                    break
                case "pending":

                    self.pendingList = self.filter(keyword:self.searchView.txtSearch.text ?? "")
                    break
                    
                    
                default:
                    print("")
                }
                
                
          
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
    
    
    @objc func editPreesed(_ sender : UIButton ) {
        
        let vc = AddEventVC.instantiate()
        vc.status="Edit"
        switch buttonText {
            
        case "AllListing":
            vc.eventID=AllList[sender.tag].eventID ?? 0
            vc.eventDataObj=AllList[sender.tag]
       
            break
        case "published":
            vc.eventID=publishedList[sender.tag].eventID ?? 0
            vc.eventDataObj=publishedList[sender.tag]
       
            
            break
        case "pending":
            vc.eventID=pendingList[sender.tag].eventID ?? 0
            vc.eventDataObj=pendingList[sender.tag]
       

            break
            
            
        default:
            print("")
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @objc func removePreesed(_ sender : UIButton ) {
        
        switch buttonText {
            
        case "AllListing":
            
            deleteEvent(id: AllList[sender.tag].eventID ?? 0)
            break
        case "published":
            deleteEvent(id: publishedList[sender.tag].eventID ?? 0)
            
            break
        case "pending":
            deleteEvent(id: pendingList[sender.tag].eventID ?? 0)
            break
            
            
        default:
            print("")
        }
        
        
    }
    @IBAction func AllListingBtn(_ sender: Any) {
        buttonText="AllListing"
        pendingView.backgroundColor = .white
        publishedView.backgroundColor = .white
        listingView.backgroundColor = UIColor.init(named: "btn")
        displayTableView.reloadData()
        
        
    }
    
    @IBAction func publishedBtn(_ sender: Any) {
        buttonText="published"
        pendingView.backgroundColor = .white
        publishedView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        displayTableView.reloadData()
    }
    
    @IBAction func pendingBtn(_ sender: Any) {
        buttonText="pending"
        publishedView.backgroundColor = .white
        pendingView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        displayTableView.reloadData()
        
    }
    
}
extension MyEventVC:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension MyEventVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buttonText {
            
        case "AllListing":
            if AllList.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            return AllList.count
            
        case "published":
            if publishedList.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            return publishedList.count
            
        case "pending":
            if pendingList.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            
            return pendingList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:ListingEventCell = displayTableView.dequeueReusableCell(for: indexPath)
                cell.goingBtn.isHidden=true
        cell.myListing = true
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(self.editPreesed(_:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(self.removePreesed(_:)), for: .touchUpInside)
        
        switch buttonText {
            
        case "AllListing":
            cell.configureEvent(event: AllList[indexPath.row])
            return cell
            
        case "published":
            cell.configureEvent(event: publishedList[indexPath.row])
            return cell
            
            
        case "pending":
            cell.configureEvent(event: pendingList[indexPath.row])
            return cell
            
            
        default:
            return cell
        }
        
        
        return cell
    }
    
    
}
extension MyEventVC{
    
    func ListEvent(){
        AllList=[]
        self.showActivityIndicator()
        DashboardManager.shared.myEvent { response in
            
            switch response{
                
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.pendingList=responsedata.Pending ?? []
                        self.publishedList=responsedata.Published ?? []
                        self.AllList.append(contentsOf:  self.pendingList)
                        self.AllList.append(contentsOf:  self.publishedList)
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
    
    
    func deleteEvent(id:Int){
        DashboardManager.shared.deleteEvent(id: id) { response in
            switch response{
                
            case let .success(response):
                if response.statusCode == 200{
                    
                    self.showAlert(title: "Success", message: response.statusMessage)
                    self.ListEvent()
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
    }
    
    func filter(keyword : String) -> [eventData]{
        
        switch buttonText {
            
        case "AllListing":
            
            let result : [eventData] = AllList.filter({ (txt) -> Bool in
                return  (txt.title?.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
        case "published":
            
            let result : [eventData] = publishedList.filter({ (txt) -> Bool in
                return  (txt.title?.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
        case "pending":

            let result : [eventData] = pendingList.filter({ (txt) -> Bool in
                return  (txt.title?.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
            
        default:
            let result : [eventData] = AllList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased()).contains(keyword.lowercased()) ?? false })
            break
        }
        
        return []
        
    }
    
    
}
