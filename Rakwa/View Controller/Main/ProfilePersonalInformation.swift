//
//  ProfilePersonalInformation.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit
import SDWebImage
class ProfilePersonalInformation: UIViewController, UITextViewDelegate {
    var user:profileUserData?
    @IBOutlet var firstName: MainTF!
    @IBOutlet var lastName: MainTF!
    @IBOutlet var email: MainTF!
    @IBOutlet var phone: MainTF!
    
    var userProfileInfo:profileInfo?
    override func viewDidLoad() {
        super.viewDidLoad()


        self.firstName.valueTxt.text=userProfileInfo?.firstname ?? ""
        self.lastName.valueTxt.text=userProfileInfo?.lastname ?? ""
        self.email.valueTxt.text=userProfileInfo?.email ?? ""
        self.phone.valueTxt.text=userProfileInfo?.phone ?? ""

        
        self.firstName.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.lastName.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.email.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.phone.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)


    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
 
        UserDefaults.standard.set(self.firstName.valueTxt.text, forKey: "firstname")
        UserDefaults.standard.set(self.lastName.valueTxt.text, forKey: "lastname")
        UserDefaults.standard.set(self.email.valueTxt.text, forKey: "email")
        UserDefaults.standard.set(self.phone.valueTxt.text, forKey: "phone")

    }
    

  
    

    
}
extension ProfilePersonalInformation:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension ProfilePersonalInformation{
    func profileInfo(){
//        self.showActivityIndicator()

        HomeManager.shared.profile { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    do {
                    guard let info=response.data else {return}
                    self.firstName.valueTxt.text=info?.firstname
                    self.lastName.valueTxt.text=info?.lastname
                    self.email.valueTxt.text=info?.email
                    self.phone.valueTxt.text=info?.phone
                  
                        UserDefaults.standard.set(info?.firstname, forKey: "firstname")
                        UserDefaults.standard.set(info?.lastname, forKey: "lastname")
                        UserDefaults.standard.set(info?.email, forKey: "email")
                        UserDefaults.standard.set(info?.phone, forKey: "phone")


                } catch let error {
                }
                }
            case let .failure(error):
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                }
        }
        }
//        self.hideActivityIndicator()

    }
}
