//
//  SideMenuVC.swift
//  Rakwa

//  Created by macbook on 10/5/21.


import UIKit
import Moya
protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuVC: UIViewController {
    var menuVC:SceneDelegate?
    var defaultHighlightedCell: Int = 0

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageMainView:UIView!
    @IBOutlet weak var userImg: UIImageViewDesignable!
    @IBOutlet weak var helloLbl:UILabel!
    var menuItems:[MenuItem]=[]
    @IBOutlet var displayTable: UITableView!
    var delegate: SideMenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        profileInfo()
        displayTable.register(MenuTableViewCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self
        
        
        
    }
    
    @IBAction func login(_ sender: Any) {
        sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    @IBAction func logout(_ sender: Any) {
        logout()
    }
    func initializer(){
    
        menuItems=MenuItem.all
        
    }
    

}
extension SideMenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.labelName.text = menuItems[indexPath.row].labelName
        cell.imgName.image = menuItems[indexPath.row].imgName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 :
            navigationController?.pushViewController(TabBarVC.instantiate(), animated: true)
        case 1:
        
            navigationController?.pushViewController(TabBarVC.instantiate(), animated: true)

        case 2:
        
            navigationController?.pushViewController(TabBarVC.instantiate(), animated: true)
        case 3:
            
            navigationController?.pushViewController(MyListingVC.instantiate(), animated: true)
        case 4:
   
            menuVC?.setRootVC(vc: DashboardVC.instantiate())
        case 5:
      
            
            navigationController?.pushViewController(InvoicesVC.instantiate(), animated: true)
        case 6:
      
            navigationController?.pushViewController(SavedVC.instantiate(), animated: true)
        case 7:
         
            
            navigationController?.pushViewController(RecievedReview.instantiate(), animated: true)
            
        case 8:
 
            
            navigationController?.pushViewController(Contact.instantiate(), animated: true)
            
        default:
            menuVC?.setRootVC(vc: DashboardVC.instantiate())

        }
    }
    
    
}

extension SideMenuVC{
    
    
    func logout(){

        AuthManager.shared.logout { (response) in
    
            switch response{
            case let .success(response):
                if response.statusCode == 200 {
//                    do {
//                        self.showAlert(title:  "Notice", message: "Are you sure you want to logout", confirmBtnTitle: "ok", cancelBtnTitle: "cancel", hideCancelBtn: true) { (action) in
//
                            self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())
//
//                        }
//
//                    } catch let error {
//
//                    }
                }else{
                    self.showAlert(title:  "Notice", message: "\(response.statusMessage)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                    }

                }
        
            case let .failure(error):
 
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        
    }

    }
    
        func profileInfo(){
    //        self.showActivityIndicator()
            do{
            if let token = try KeychainWrapper.get(key: AppData.email)  {
                HomeManager.shared.profile { response in
                    
                    switch response{
                    case let .success(response):
                        switch response.statusCode{
                        case 200..<300:
                            do {
                            guard let info=response.data else {return}
                                self.userName.text = (info?.firstname ?? "") + ( info?.lastname ?? "" )
                                self.userImg.image=UIImage(named: info?.image ?? "")
                                self.loginBtn.isHidden=true
                        } catch let error {
                        }
                             break
                   
                        default:
                            break
                        }
                        
                    
                    case let .failure(error):
                        guard let error = error as? MoyaError else{
                            return
                            
                        }
                        guard let responseData=error.response?.statusCode else {
                            return
                            
                        }

                        switch responseData{
                        case   400..<500:
                            self.userName.isHidden=true
                            self.loginBtn.isHidden=false
                            self.logoutBtn.isHidden=true
                            self.userImg.isHidden=true
                             break
                        case 500:
                            self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Error in System you should try Again Later", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                            
                            }
                        default:
                            break
                        }
                   
                }
                }
            }else{
                self.userImg.isHidden = true
                self.userName.isHidden = true
            }
                
            }catch{
              print("HHHH")
                self.userImg.isHidden = true
                self.userName.isHidden = true
                self.userImageMainView.isHidden = true
                self.helloLbl.isHidden = true 
            }
            
    //        self.hideActivityIndicator()

        }
}
