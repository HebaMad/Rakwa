//
//  AdCampaignsVC.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import UIKit

class AdCampaignsVC: UIViewController {

    @IBOutlet var displayTable: UITableView!
    var adCampaignData:[AdCampaign]=[]
    @IBOutlet var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        AdCampaigns()
        displayTable.register(ADCampigansCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self

    }
    
    @objc func removePreesed(_ sender : UIButton ) {
        
        removeAdCampaigns(id: adCampaignData[sender.tag].id)
      
}
    
}
extension AdCampaignsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adCampaignData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell:ADCampigansCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureAdCampaign(adCampaign: adCampaignData[indexPath.row])
        
        cell.removeAdBtn.addTarget(self, action: #selector(self.removePreesed(_:)), for: .touchUpInside)
        cell.removeAdBtn.tag = indexPath.row
        return cell

    }
    
}
extension AdCampaignsVC:Storyboarded{
    static var storyboardName: StoryboardName = .AdCampaigns
}
extension AdCampaignsVC{
func AdCampaigns(){
    self.showActivityIndicator()

    AdsManager.shared.getAllAdCampaigns { (response) in
        switch response{

        case let .success(response):
            if response.statusCode == 200{
                
            
            do {
                guard let  responsedata = response.data else {return}
                self.adCampaignData=responsedata
                if self.adCampaignData.count == 0 {
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
    
    
    
    func removeAdCampaigns(id:Int){
        AdsManager.shared.deleteAdCampaigns(id:id ) { (response) in
            
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    self.showAlert(title: "Success", message: response.statusMessage )
                    self.displayTable.reloadData()
                } catch let error {
                    self.showAlert(title: "Error", message: response.statusMessage )

                }
                }
                
            case let .failure(error):

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        
    }
    
    
    
    
}
}
