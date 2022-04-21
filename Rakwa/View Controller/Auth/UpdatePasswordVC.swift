//
//  UpdatePasswordVC.swift
//  Rakwa
//
//  Created by macbook on 9/9/21.
//

import UIKit

final class UpdatePasswordVC: UIViewController {
    @IBOutlet  private weak var oldPasswordTf: MainTF!
    @IBOutlet  private weak var newPasswordTf: MainTF!
    
    @IBOutlet weak var confirmNewPassword: MainTF!
    var validateTest:Bool=true


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.oldPasswordTf.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.newPasswordTf.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.confirmNewPassword.valueTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)


    }
    

    @objc func textFieldDidChange(_ textField:UITextField) {
        UserDefaults.standard.set(self.oldPasswordTf.valueTxt.text, forKey: "oldpass")

        UserDefaults.standard.set(self.newPasswordTf.valueTxt.text, forKey: "newpass")
        UserDefaults.standard.set(self.confirmNewPassword.valueTxt.text, forKey: "confirmnewpass")
     

    }

    

}
extension UpdatePasswordVC:Storyboarded{
    static var storyboardName: StoryboardName = .auth
}


