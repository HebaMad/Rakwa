//
//  AddAnouncement.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import UIKit
class AddAnouncement: UIViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate & UITextFieldDelegate{
    @IBOutlet weak var listView: UIViewDesignable!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    var announcementCategory:[Category]=[]

    var selectedImage:Data?
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryTextField: UITextFieldDataPicker!
    @IBOutlet weak var AnnouncementDetails: UITextView!
    @IBOutlet weak var btnLinkTxt: UITextField!
    @IBOutlet weak var btnTxt: UITextField!
    var categorydata:[String]=[]
    var categoryID:[Int]=[]
    var status = "Add"
    var announcementID=0
    var itemID=0
    
    var buttonText=""
    var buttonLink=""
    var announcememtDescription=""
    var backgroundImgData=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.status == "Edit"{
            titleLabel.text = "Update Announcement"
            backgroundImg.isHidden=false
            backgroundImg.sd_setImage(with: URL(string: backgroundImgData))
            selectedImage=backgroundImg.image?.jpegData(compressionQuality: 0.5)
            editBtn.setTitle("Edit", for: .normal)
            btnLinkTxt.text=buttonLink
            btnTxt.text=buttonText
            AnnouncementDetails.text=announcememtDescription
            listView.isHidden=true

        }else{
            titleLabel.text = "Add Announcement"
            backgroundImg.isHidden=true
            editBtn.setTitle("Add", for: .normal)
            listView.isHidden=false
        }
        category()
        categoryTextField.pickerDelegate=self
        categoryTextField.dataSource=self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func uploadPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    @IBAction func AddAnnouncementBtn(_ sender: Any) {
        if self.status == "Add"{

        do{
            
            let categoryTxt = try categoryTextField.validatedText(validationType: .requiredField(field: ""))
            let btnLinkTxt = try btnLinkTxt.validatedText(validationType: .requiredField(field: ""))
            let btnTxt = try btnTxt.validatedText(validationType: .requiredField(field: ""))
            createAnnouncement(item_id:  self.itemID, image: selectedImage ?? Data(), btn_text: btnTxt, btn_link: btnLinkTxt, description: AnnouncementDetails.text)
            
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
        }else{
         
            do{
                
         
                let btnLinkTxt = try btnLinkTxt.validatedText(validationType: .requiredField(field: ""))
                let btnTxt = try btnTxt.validatedText(validationType: .requiredField(field: ""))
                updateAnnouncement(announcement_id:announcementID,item_id:  self.itemID, image: selectedImage ?? Data(), btn_text: btnTxt, btn_link: btnLinkTxt, description: AnnouncementDetails.text)
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return  }
        print(image)
        selectedImage=image.jpegData(compressionQuality: 0.5)
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        print(fileUrl.lastPathComponent)
        
        
    }
    
    
}
extension AddAnouncement:Storyboarded{
    static var storyboardName: StoryboardName = .Announcements
}
extension AddAnouncement{
    
    func category(){
        self.showActivityIndicator()

        ListingManager.shared.myPublished{ response in
            
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.announcementCategory  = responsedata
                        if self.announcementCategory.count != 0{
                            
                       
                        for index in 0 ... self.announcementCategory.count-1{
                            self.categorydata.append(self.announcementCategory[index].title ?? "")
                            self.categoryID.append(self.announcementCategory[index].id ?? 0)
                            
                            
                        }
                        }
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
    func createAnnouncement(item_id:Int,image:Data,btn_text:String,btn_link:String,description:String){
        self.showActivityIndicator()

        AdsManager.shared.addNewAnnoucement( item_id: item_id, image: image, btn_text: btn_text, btn_link: btn_link, description: description) { response in
            
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
    
    
    
    func  updateAnnouncement(announcement_id:Int,item_id:Int,image:Data,btn_text:String,btn_link:String,description:String){
        self.showActivityIndicator()

        AdsManager.shared.updateAnnoucement(announcement_id:announcement_id ,item_id: item_id, image: image, btn_text: btn_text, btn_link: btn_link, description: description) { response in
            
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
                
                }}}
        self.hideActivityIndicator()

    }
    
}

extension AddAnouncement:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.setTextFieldTitle(title: " \(categorydata[row])")
        self.itemID=categoryID[row]
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
        categorydata.count
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
print("\(title ?? "")")
        return categorydata[row]
    }
    
    func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
        1
    }
    
    
    
    
    
    
    
    
}
