//
//  ResetPasswordVC.swift
//  Rakwa
//
//  Created by macbook on 9/9/21.
//

import UIKit

final class ResetPasswordVC: UIViewController {
    var validateTest:Bool=true
    
    @IBOutlet private weak var emailCustomTf: MainTF!
    
    @IBOutlet var sendNewPasswordBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendNewPassword(_ sender: Any) {
        if checkData(){
            ResetPassword()
        }
    }
    
}


extension ResetPasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .auth
}


extension ResetPasswordVC{
    
    
    func ResetPassword(){
        self.showActivityIndicator()

        AuthManager.shared.forgetPassword(email: emailCustomTf.valueTxt.text!) { (response) in
            switch response{
            case let .success(response):
                do {
                    self.showAlert(title:  "Notice", message: "The password has been sent to the entered email", confirmBtnTitle: "Login", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
//                        self.sceneDelegate.setRootVC(vc: UpdatePasswordVC .instantiate())
                        
                        
                    }
           
                } catch let error {
               

                }
            case let .failure(error):
 
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        self.hideActivityIndicator()

        
    }
    func checkData() -> Bool{
        do{
            
            let useremail = try emailCustomTf.valueTxt.validatedText(validationType: .email)
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            validateTest=false
        }
        
        
        return validateTest
        
        
        
    }
}
