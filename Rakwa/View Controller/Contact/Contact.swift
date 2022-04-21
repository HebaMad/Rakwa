//
//  Contact.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class Contact: UIViewController {

    @IBOutlet var backButton: UIButton!
    @IBOutlet var technicalSupportStack: UIStackView!
    @IBOutlet var firstNameView: MainTF!
    @IBOutlet var lastName: MainTF!
    @IBOutlet var email: MainTF!
    @IBOutlet var phone: MainTF!

    @IBOutlet weak var messageTxt: UITextView!
    
    
    
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true

        super.viewDidLoad()
        profileInfo()

    }
    
    @IBAction func send(_ sender: Any) {
        
        do{
            
            let firstname = try firstNameView.valueTxt.validatedText(validationType: .username)
            let lastname = try lastName.valueTxt.validatedText(validationType: .username)
            let userEmail = try email.valueTxt.validatedText(validationType: .email)
            let phone = try phone.valueTxt.validatedText(validationType: .phoneNumber)
            
            contactSending(firstname: firstname, lastname: lastname, email: userEmail, message: messageTxt.text ?? "", phone: phone)
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
    }
    @IBAction func back(_ sender: Any) {
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        }else{
            dismiss(animated: true, completion: nil)
            
        }

    }
    

}
extension Contact:Storyboarded{
    static var storyboardName: StoryboardName = .Contact
}
extension Contact{
    
    func contactSending(firstname:String,lastname:String,email:String,message:String,phone:String){
        self.showActivityIndicator()

        ProfileManager.shared.contact(firstname: firstname, lastname: lastname, email: email, message: message, phone: phone) { response  in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    self.showAlert(title: "Success", message: response.statusMessage )
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
    
    
    func profileInfo(){
        self.showActivityIndicator()

        HomeManager.shared.profile { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    guard let info=response.data else {return}
                    self.firstNameView.valueTxt.text=info?.firstname
                    self.lastName.valueTxt.text=info?.lastname
                    self.email.valueTxt.text=info?.email
                    self.phone.valueTxt.text=info?.phone

                    
                do {
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
