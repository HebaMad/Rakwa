//
//  LoginVC.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import Foundation
import UIKit
import MapKit


final class LoginVC: UIViewController {
    @IBOutlet  private weak var emailCustomTf: MainTF!
    
    @IBOutlet private weak var passCustomTf: MainTF!
    
    @IBOutlet var forgetPassword: UIButton!
    
    
    
    @IBOutlet var backBtn: UIButton!
    var validateTest:Bool=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func skipBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: TabBarVC.instantiate())
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        do{
            
            let userEmail = try emailCustomTf.valueTxt.validatedText(validationType: .email)
            let userPassword = try passCustomTf.valueTxt.validatedText(validationType: .password)
            Login(email: userEmail, password: userPassword)
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
      
        
    }
    
    @IBAction func signUP(_ sender: Any) {
        sceneDelegate.setRootVC(vc: SignUpVC.instantiate())

    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        sceneDelegate.setRootVC(vc: ResetPasswordVC.instantiate())

    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension LoginVC:Storyboarded{
    static var storyboardName: StoryboardName = .auth
}

extension LoginVC{
    
    
    func Login(email:String,password:String){
        self.showActivityIndicator()

        AuthManager.shared.login(email:email, password: password) { (Response) in
            switch Response{
            case let .success(response):
                do {
                    
                    guard let  responsedata = response.data else {return}
                    do{
                        try KeychainWrapper.set(value: responsedata.token ?? "", key: responsedata.email ?? "")
                        AppData.email = responsedata.email ?? ""
                    }

                    self.sceneDelegate.setRootVC(vc: TabBarVC.instantiate())

                } catch let error {
               
                    self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
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
