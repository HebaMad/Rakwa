//  CopounsVC.swift
//  Rakwa
//  Created by macbook on 10/5/21.

import UIKit

class CopounsVC: UIViewController {
    @IBOutlet var displayTable: UITableView!
    var copounList:[copouns]=[]
    @IBOutlet var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true
        tabBarController?.tabBar.isHidden = true

        displayTable.register(CopounCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self
        coupoun()
    }
    
    @IBAction func addCoupounBtn(_ sender: Any) {
        navigationController?.pushViewController(CreateCopounVC.instantiate(), animated: true)
    }
    
    
    @objc func editPreesed(_ sender : UIButton ) {
        
        
        let vc = CreateCopounVC.instantiate()
        
        vc.status="Edit"
        vc.copounData=copounList[sender.tag]
        vc.copounID=copounList[sender.tag].id ?? 0
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @objc func removePreesed(_ sender : UIButton ) {
        
        deleteCopoun(id: copounList[sender.tag].id ?? 0)
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension CopounsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return copounList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CopounCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCopoun(copoun: copounList[indexPath.row])
        cell.removeBtn.addTarget(self, action: #selector(self.removePreesed(_:)), for: .touchUpInside)
        cell.removeBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(self.editPreesed(_:)), for: .touchUpInside)
        
        return cell
        
    }  
    
}
extension CopounsVC:Storyboarded{
    static var storyboardName: StoryboardName = .Copoun
}
extension CopounsVC{
    
    func coupoun(){
        self.showActivityIndicator()

        DashboardManager.shared.coupoun{ (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    do {
                        guard let  responsedata = response.data else {return}
                        self.copounList=responsedata
                        
                        if self.copounList.count == 0 {
                            self.emptyView.isHidden = false
                        }else {
                            self.emptyView.isHidden = true
                            
                        }
                        self.displayTable.reloadData()
                    } catch let error {
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                        
                    }
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
            
            
            
            
            
        }
        
        
        self.hideActivityIndicator()

    }
    
    func deleteCopoun(id:Int){

        DashboardManager.shared.deleteCopoun(copounid: id) { response in
            
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        self.showAlert(title: "Success", message: response.statusMessage )
                        self.coupoun()
                        
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
