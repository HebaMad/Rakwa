//
//  ProfileSetting.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//
import Foundation
import UIKit
import SideMenu
import Moya
class ProfileSetting: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    private var menu :SideMenuNavigationController?
    @IBOutlet weak var editBtn: UIButton!
    var page=1
    var userprofileinformation:profileUserData?
    @IBOutlet weak var containerVC: UIView!
    var useraddressinformation:userAddress?
    
    @IBOutlet weak var nameLabel: UILabel!
    private var firstVC:ProfilePersonalInformation!
    private var secondVC:ProfileSelectAddress!
    
    @IBOutlet weak var userImg: UIImageView!
    private var currentVC = "First"
    
    var address=""
    var userProfileInfo:profileInfo?
    
    @IBOutlet var info: UIButton!
    @IBOutlet var infoView: UIView!
    
    
    @IBOutlet var addressBtn: UIButton!
    @IBOutlet var addressView: UIView!
    var selectedImage:Data?
    
    @IBOutlet var passwordBtn: UIButton!
    @IBOutlet var passwordView: UIView!
    var buttonText="BasicInfo"
    var addressFromMap=0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let totalHeight = 5 * 100
    
        setupPages()
        setUpSideMenu()
        containerHeight.constant=CGFloat(totalHeight)
        profileInfo()
     
        //        containerVCSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeSideMenuSide()
        UserDefaults.standard.set(address, forKey: "add")
        setupContainerView()
    
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return  }
        print(image)
        userImg.image=image
        selectedImage=image.jpegData(compressionQuality: 0.5)
        //        userImg.image = selectedImage
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        print(fileUrl.lastPathComponent)
        
        
    }
    
    
    func setupPages(){
        firstVC = ProfilePersonalInformation.instantiate()
        secondVC = ProfileSelectAddress.instantiate()
    }
    
    @IBAction func BasicInfo(_ sender: Any) {
        buttonText="BasicInfo"
        addressView.backgroundColor = .white
        passwordView.backgroundColor = .white
        infoView.backgroundColor = UIColor.init(named: "btn")
        info.setTitleColor(.black, for: .normal)
        
        let vc=ProfilePersonalInformation.instantiate()
        vc.userProfileInfo=self.userProfileInfo
        
        addChild(vc)
        containerVC.addSubview(vc.view)
        
        
    }
    
    @IBAction func Address(_ sender: Any) {
        buttonText="Address"
        infoView.backgroundColor = .white
        info.setTitleColor(.darkGray, for: .normal)
        
        passwordView.backgroundColor = .white
        passwordBtn.setTitleColor(.darkGray, for: .normal)
        
        addressView.backgroundColor = UIColor.init(named: "btn")
        addressBtn.setTitleColor(.black, for: .normal)
        
        let vc=ProfileSelectAddress.instantiate()
        vc.userProfileInfo=self.userProfileInfo
        addChild(vc)
        containerVC.addSubview(vc.view)
        
    }
    
    @IBAction func Password(_ sender: Any) {
        buttonText="Password"
        infoView.backgroundColor = .white
        info.setTitleColor(.darkGray, for: .normal)
        
        addressView.backgroundColor = .white
        addressBtn.setTitleColor(.darkGray, for: .normal)
        
        passwordView.backgroundColor = UIColor.init(named: "btn")
        passwordBtn.setTitleColor(.black, for: .normal)
        let vc=UpdatePasswordVC.instantiate()
        addChild(vc)
        containerVC.addSubview(vc.view)
        
        
    }
    
    
    func setupContainerView(){
        
        if buttonText == "Password"{
            let vc=UpdatePasswordVC.instantiate()
            addChild(vc)
            containerVC.addSubview(vc.view)
        }else if buttonText == "Address"{
            let vc=ProfileSelectAddress.instantiate()
            vc.userProfileInfo=self.userProfileInfo
            vc.address=address
            vc.addressFromMap=addressFromMap

            addChild(vc)
            containerVC.addSubview(vc.view)
        }else{
            let vc=ProfilePersonalInformation.instantiate()
            vc.userProfileInfo=self.userProfileInfo
            
            addChild(vc)
            containerVC.addSubview(vc.view)
        }
    }
    
    
    public static var shared: ProfileSetting = {
        let instance = ProfileSetting()
        return instance
    }()
    
    @IBAction func Done(_ sender: Any) {
        
        
        
        if editBtn.titleLabel?.text == "Edit"{
            editBtn.setTitle("Done", for: .normal)
        }else{
            
            if buttonText == "Password"{
                do{
                    
                    
                    
                    
                    let oldPassword=UserDefaults.standard.string(forKey: "oldpass")
                    let newPassword=UserDefaults.standard.string(forKey: "newpass")
                    let confirmnewPassword=UserDefaults.standard.string(forKey: "confirmnewpass")
                    
                    
                    let oldPass = try oldPassword?.validatedText(validationType: .password)
                    let newPass = try newPassword?.validatedText(validationType: .password)
                    let confirmPass = try confirmnewPassword?.validatedText(validationType: .requiredField(field: "confirm new password"))

                    if confirmPass == newPass {
                        UpdatePassword(oldpassword: oldPass ?? "", newPassword: newPass ?? "")
                        editBtn.setTitle("Edit", for: .normal)

                    }else{
                        
                    }
                    
                    
                }catch(let error){
                    self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
                }
            
            }else{
            let firstname=UserDefaults.standard.string( forKey: "firstname")
            let lastname=UserDefaults.standard.string( forKey: "lastname")
            let email=UserDefaults.standard.string( forKey: "email")
            let phone=UserDefaults.standard.string( forKey: "phone")
            let state=UserDefaults.standard.integer( forKey: "state")
            let address=UserDefaults.standard.string( forKey: "addresss")
            let city=UserDefaults.standard.integer( forKey: "city")
            
            editProfile(firstname:(firstname ?? self.userProfileInfo?.firstname ?? "") , lastname:(lastname ?? self.userProfileInfo?.lastname ?? ""), phone:(phone ?? self.userProfileInfo?.phone ?? ""), email: (email ?? self.userProfileInfo?.email ?? ""), image: (selectedImage ?? userImg.image?.jpegData(compressionQuality: 0.5)) ?? Data() , cityID: city , state: state , address: address ?? userProfileInfo?.address ?? "")
            editBtn.setTitle("Edit", for: .normal)
            
        }

    }
    }
    
    
    
    @IBAction func menuBtn(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }

    
    
    //    func containerVCSetup(){
    //        if currentVC == "First"{
    //            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfilePersonalInformation") as! ProfilePersonalInformation
    //
    //                 addChild(vc)
    //
    //                 containerVC.addSubview(vc.view)
    //            progress.title.text = "Personal information"
    //            progress.number = "Step 1"
    //            progress.p1.tintColor=UIColor(named: "btn")
    //            progress.p2.tintColor = .systemGray2
    //            progress.p3.tintColor = .systemGray2
    //            progress.v1.backgroundColor = .systemGray2
    //            progress.v2.backgroundColor = .systemGray2
    //        }else if currentVC == "Second"{
    //            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileUserAccounts") as! ProfileUserAccounts
    //                 addChild(vc)
    //                 containerVC.addSubview(vc.view)
    //            progress.title.text = "Social Media Accounts"
    //            progress.number = "Step 2"
    //            progress.p1.tintColor=UIColor(named: "btn")
    //            progress.p2.tintColor = UIColor(named: "btn")
    //            progress.p3.tintColor = .systemGray2
    //            progress.v1.backgroundColor = UIColor(named: "btn")
    //            progress.v2.backgroundColor = .systemGray2
    //
    //
    //        }else{
    //            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileSelectAddress") as! ProfileSelectAddress
    //
    //            addChild(vc)
    //            containerVC.addSubview(vc.view)
    //            progress.title.text = "Select address"
    //            progress.number = "Step 3"
    //            progress.p1.tintColor=UIColor(named: "btn")
    //            progress.p2.tintColor = UIColor(named: "btn")
    //            progress.p3.tintColor =  UIColor(named: "btn")
    //            progress.v1.backgroundColor = UIColor(named: "btn")
    //            progress.v2.backgroundColor =  UIColor(named: "btn")
    //            vc.address=address
    //
    //
    //        }
    //
    //
    //
    //
    //
    //
    //    }
    
    private func changeSideMenuSide(){
        
        menu?.leftSide = true
        SideMenuManager.default.rightMenuNavigationController = nil
        SideMenuManager.default.leftMenuNavigationController = menu
        
    }
    
    private func setUpSideMenu() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        menu = SideMenuNavigationController(rootViewController: vc)
        menu?.setNavigationBarHidden(true, animated: false)
        menu?.presentationStyle = .menuSlideIn
        menu?.presentationStyle.onTopShadowColor = .black
        menu?.presentationStyle.onTopShadowRadius = 5
        menu?.presentationStyle.onTopShadowOffset = .zero
        menu?.presentationStyle.onTopShadowOpacity = 0.3
        menu?.presentationStyle.presentingScaleFactor = 0.98
        
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
}
extension ProfileSetting:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension ProfileSetting{
    func profileInfo(){
        
        HomeManager.shared.profile { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    do {
                        guard let info=response.data else {return}
                        self.userProfileInfo=info
                        self.nameLabel.text = "\(info?.firstname ?? "") \(info?.lastname ?? "")"
                        self.userImg.sd_setImage(with:URL(string: info?.image ?? ""))
                        let vc=ProfilePersonalInformation.instantiate()
                        vc.userProfileInfo=self.userProfileInfo
                        
                        self.addChild(vc)
                        self.containerVC.addSubview(vc.view)
                    } catch let error {
                 
                    }
                }
            case let .failure(error):
                guard let error = error as? MoyaError else{ return}
                guard let responseData=error.response?.statusCode else {return}

                switch responseData{
                case   400..<500:
                    self.showNoRegisted()
                     break
                case 500:
                    self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Error in System you should try Again Later", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                    }
                    
                default:
                    print("error")
                }
            }
        }
        
    }
    
    
    func editProfile(firstname: String, lastname: String, phone: String, email: String, image: Data, cityID: Int, state: Int, address: String){
        HomeManager.shared.editProfile(firstname: firstname, lastname: lastname, phone: phone, email: email, image: image, cityID: cityID, state: state, address: address) { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{

                do {
                    self.showAlert(title: "Success", message: response.statusMessage)
           
                } catch let error {
               

                }
                }
            case let .failure(error):
 
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
    }
    
    
    func UpdatePassword(oldpassword:String,newPassword:String){

        AuthManager.shared.updatePassword(oldPassword:oldpassword, newPassword:newPassword) { (response) in
            switch response{
            case let .success(response):
                
                switch response.statusCode{
                case 200..<300:
                    self.showAlert(title: "Success", message: response.statusMessage)

                     break
       
                default:
                    break
                }
         
            case let .failure(error):
 
                guard let error = error as? MoyaError else{ return}
                guard let responseData=error.response?.statusCode else {return}

                switch responseData{
                case   400..<500:
                    self.showNoRegisted()
                     break
                case 500:
                    self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Error in System you should try Again Later", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                    }
                default:
                    break
                }
        }
        }

        
    }
}
