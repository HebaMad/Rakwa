//
//  MyAnnouncementVC.swift
//  Rakwa
//
//  Created by heba isaa on 13/11/2021.
//

import UIKit

class MyAnnouncementVC: UIViewController {
    @IBOutlet var displayTable: UITableView!
    var announcementData:[Announcement]=[]
    @IBOutlet var emptyView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true
        tabBarController?.tabBar.isHidden = true

        displayTable.register(AnnouncementsCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self
        getmyAnnouncement()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getmyAnnouncement()

    }
    
    @objc func editPreesed(_ sender : UIButton ) {
        
        
        let vc = UIStoryboard.init(name: "Announcements", bundle: nil).instantiateViewController(withIdentifier: "AddAnouncement")  as! AddAnouncement
        vc.status="Edit"
        vc.announcementID=announcementData[sender.tag].id ?? 0
        vc.itemID=Int(announcementData[sender.tag].listing_id ?? "") ?? 0
        vc.buttonText=announcementData[sender.tag].btn_text ?? ""
        vc.buttonLink=announcementData[sender.tag].btn_link ?? ""
        
        vc.announcememtDescription=announcementData[sender.tag].description ?? ""
        vc.backgroundImgData=announcementData[sender.tag].image ?? ""
        
        
        navigationController?.pushViewController(vc, animated: true)
    
     
}
    @objc func removePreesed(_ sender : UIButton ) {
        
        deleteAnnouncement(id: announcementData[sender.tag].id ?? 0)
    
     
}
    @IBAction func AddAnnouncementBtn(_ sender: Any) {
      
        self.navigationController?.pushViewController(AddAnouncement.instantiate(), animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
extension MyAnnouncementVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:AnnouncementsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureAnnouncement(announcement: announcementData[indexPath.row])
        cell.deleteBtn.addTarget(self, action: #selector(self.removePreesed(_:)), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(self.editPreesed(_:)), for: .touchUpInside)

        return cell

    }
    
}
extension MyAnnouncementVC:Storyboarded{
    static var storyboardName: StoryboardName = .Announcements
}
extension MyAnnouncementVC{
    
    func deleteAnnouncement(id:Int){
        self.showActivityIndicator()

        AdsManager.shared.deleteAnnoucement(announcement_id: id) { (response) in
 
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    self.showAlert(title: "Success", message: response.statusMessage )
                    self.getmyAnnouncement()
                    
                } catch let error {
                    self.showAlert(title: "Error", message: response.statusMessage )

                }
                }
                
            case let .failure(error):

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        
    }
        self.hideActivityIndicator()

}
    func getmyAnnouncement(){

        AdsManager.shared.myAnnouncement { (response) in

            switch response{

            case let .success(response):
                if response.statusCode == 200{
                    
                
                do {
                    guard let  responsedata = response.data else {return}
                    self.announcementData=responsedata
                    if self.announcementData.count == 0 {
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

    }
}
