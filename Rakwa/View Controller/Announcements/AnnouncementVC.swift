//
//  AnnouncementVC.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import UIKit

class AnnouncementVC: UIViewController {

    @IBOutlet var displayTable: UITableView!
    var announcementData:[Announcement]=[]
    @IBOutlet var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        tabBarController?.tabBar.isHidden = true

        displayTable.register(AnnouncementsCell.self)
        getAnnouncement()
        displayTable.delegate=self
        displayTable.dataSource=self

    }
   
    @IBAction func AddAnnouncementBtn(_ sender: Any) {
        self.navigationController?.pushViewController(AddAnouncement.instantiate(), animated: true)    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension AnnouncementVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:AnnouncementsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureAnnouncement(announcement: announcementData[indexPath.row])
        cell.deleteBtn.isHidden=true
        cell.editBtn.isHidden=true
        return cell

    }
    
}

extension AnnouncementVC:Storyboarded{
    static var storyboardName: StoryboardName = .Announcements
}

extension AnnouncementVC{
func getAnnouncement(){
    self.showActivityIndicator()

    AdsManager.shared.getAllAnnoucements { (response) in
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
    self.hideActivityIndicator()

}
    
}


