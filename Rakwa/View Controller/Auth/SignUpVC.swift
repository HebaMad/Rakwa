//
//  SignUpVC.swift
//  Rakwa
//
//  Created by macbook on 9/9/21.
//

import UIKit

final class SignUpVC: UIViewController {
    @IBOutlet private weak var firstNameTf: MainTF!
    
    @IBOutlet private weak var lastNameTf: MainTF!
    
    @IBOutlet private weak var emailTf: MainTF!
    
    @IBOutlet private weak var passwordTf: MainTF!
    
    
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var login: UILabel!
    
    var validateTest:Bool=true
    
    @IBOutlet var signupBtn: UIButton!
    @IBOutlet var skipBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func skipBtn(_ sender: Any) {
        self.sceneDelegate.setRootVC(vc: TabBarVC.instantiate())
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        do{
            
            let email = try emailTf.valueTxt.validatedText(validationType: .email)
            let Password = try passwordTf.valueTxt.validatedText(validationType: .password)
            let firstname = try firstNameTf.valueTxt.validatedText(validationType: .username)
            let lastname = try firstNameTf.valueTxt.validatedText(validationType: .username)

            signUp(firstName: firstname, lastName: lastname, email: email, password: Password, terms: "1")
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
      

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        sceneDelegate.setRootVC(vc: LoginVC.instantiate())
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SignUpVC:Storyboarded{
    static var storyboardName: StoryboardName = .auth
}

extension SignUpVC{
    
    
    func signUp(firstName:String, lastName:String, email:String, password:String, terms:String){
        self.showActivityIndicator()

        AuthManager.shared.register(firstName:firstName, lastName:lastName, email:email, password:  password, terms: terms) { (Response) in
            switch Response{
            case let .success(response):
                do {
                    self.showAlert(title:  "Notice", message: "An email has been sent to the entered email, to confirm the account", confirmBtnTitle: "Login", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                        self.sceneDelegate.setRootVC(vc: LoginVC.instantiate())

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
    
    
    

}
