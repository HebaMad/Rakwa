//
//  MyListingVC.swift
//  Rakwa
//  Created by macbook on 10/1/21.

import UIKit
import SideMenu

class MyListingVC: UIViewController {
    private var menu :SideMenuNavigationController?
    
    @IBOutlet var searchBar: SearchView!
    
    @IBOutlet var AllListing: UIButton!
    @IBOutlet var listingView: UIView!
    
    @IBOutlet var published: UIButton!
    @IBOutlet var publishedView: UIView!
    
    
    @IBOutlet var pendingBtn: UIButton!
    @IBOutlet var pendingView: UIView!
    
    @IBOutlet var expiredBtn: UIButton!
    @IBOutlet var expiredView: UIView!
    
    @IBOutlet var notificationsBtn: UIButton!
    @IBOutlet var notificationNo: UILabel!
    
    @IBOutlet var disolayTable: UITableView!
    
    var publishedList:[ListingData]=[]
    var pendingList:[ListingData]=[]
    
    var expiredList:[ListingData]=[]
    var AllList:[ListingData]=[]

    @IBOutlet var emptyView: UIView!

    var buttonText="AllListing"
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpSideMenu()
        emptyView.isHidden=true

        tabBarController?.tabBar.isHidden = true
        
        disolayTable.register(MyListingTVC.self)
        disolayTable.delegate=self
        disolayTable.dataSource=self
        myListing()
        
        searchBar.startHandler {
               self.disolayTable.reloadData()
           }
           searchBar.editingChangeHandler {
               if (self.searchBar.txtSearch.text)?.count != 0{
                   
                   switch self.buttonText {
                       
                   case "AllListing":
                       self.AllList = self.filter(keyword:self.searchBar.txtSearch.text ?? "")

                  break
                   case "published":
                       self.publishedList = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                       break
                   case "pending":

                       self.pendingList = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                       break
                   case "expired":

                       self.expiredList = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                       break
                       
                   default:
                       print("")
                   }
                   
                   
             
                   self.disolayTable.reloadData()
               }else{

               }
               
           }
        
    }
    
    @IBAction func AllListingBtn(_ sender: Any) {
        buttonText="AllListing"
        expiredView.backgroundColor = .white
        pendingView.backgroundColor = .white
        publishedView.backgroundColor = .white
        listingView.backgroundColor = UIColor.init(named: "btn")
        disolayTable.reloadData()

        
    }
    
    @IBAction func publishedBtn(_ sender: Any) {
        buttonText="published"
        expiredView.backgroundColor = .white
        pendingView.backgroundColor = .white
        publishedView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        disolayTable.reloadData()
    }
    
    @IBAction func pendingBtn(_ sender: Any) {
        buttonText="pending"
        expiredView.backgroundColor = .white
        publishedView.backgroundColor = .white
        pendingView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        disolayTable.reloadData()

    }
    
    @IBAction func expiredBtn(_ sender: Any) {
        buttonText="expired"
        pendingView.backgroundColor = .white
        publishedView.backgroundColor = .white
        expiredView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        disolayTable.reloadData()

    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeSideMenuSide()
    }
    
    private func changeSideMenuSide(){
        
        menu?.leftSide = true
        SideMenuManager.default.rightMenuNavigationController = nil
        SideMenuManager.default.leftMenuNavigationController = menu
        
    }
    
    
}
extension MyListingVC:UITableViewDelegate,UITableViewDataSource{
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
            
        case "expired":
            if expiredList.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true

            }
            
            return expiredList.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyListingTVC = tableView.dequeueReusableCell(for: indexPath)
        
        switch buttonText {

        case "AllListing":
            cell.configureList(data: AllList[indexPath.row])
            return cell

        case "published":
            cell.configureList(data: publishedList[indexPath.row])
            return cell


        case "pending":
            cell.configureList(data: pendingList[indexPath.row])
            return cell

        case "expired":
            cell.configureList(data: expiredList[indexPath.row])
            return cell


        default:
            return cell
        }
    }
    
    
    
    
    
    
    
    
}
extension MyListingVC:Storyboarded{
    static var storyboardName: StoryboardName = .Dashboard
}
extension MyListingVC{
    
    func myListing(){
        AllList=[]
        ListingManager.shared.myListing { response in
            self.showActivityIndicator()

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data  else {return}
                 
                        self.pendingList=responsedata.Pending ?? []
                        self.expiredList=responsedata.Expired ?? []
                        self.publishedList=responsedata.Published ?? []
                        self.AllList.append(contentsOf:  self.pendingList)
                        self.AllList.append(contentsOf:  self.expiredList)
                        self.AllList.append(contentsOf:  self.publishedList)
                     

                     
                            if self.AllList.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true
                                
                            }

                   
                        self.disolayTable.reloadData()
                        self.hideActivityIndicator()

                    } catch let error {
                        
                    }
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
                self.hideActivityIndicator()

            }
        }

    }
    
    
    func filter(keyword : String) -> [ListingData]{
        
        switch buttonText {
            
        case "AllListing":
            
            let result : [ListingData] = AllList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased()).contains(keyword.lowercased()) ?? false })
            break
        case "published":
            
            let result : [ListingData] = publishedList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
        case "pending":

            let result : [ListingData] = pendingList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
        case "expired":

            let result : [ListingData] = expiredList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
            break
        default:
            let result : [ListingData] = AllList.filter({ (txt) -> Bool in
                return  (txt.title!.lowercased()).contains(keyword.lowercased()) ?? false })
            break
        }
        
        return []
        
    }
    
    
    
}
