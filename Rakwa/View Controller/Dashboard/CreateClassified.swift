//
//  CreateClassified.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit
import MapKit
class CreateClassified: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate & UITextFieldDelegate{
    var onMapClicked:((String,String,String) -> ())?

    @IBOutlet weak var listingTxt: UITextFieldDataPicker!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var stateTxt: UITextFieldDataPicker!
    var listCategory:[Category]=[]
    var categorydata:[String]=[]
    var categoryID:[Int]=[]
    var stateID:[Int]=[]
    var stateName:[String]=[]
    var stateCategory:[city]=[]
    var ClassifiedDataObj:ClassifiedData?
    
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    @IBOutlet weak var listView: UIViewDesignable!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet var titleTxt: UITextField!
    
    @IBOutlet var descriptionTxt: UITextView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var cityTxt: UITextFieldDataPicker!
    var selectedImage:Data?
    var cityCategory:[city]=[]
    
    var cityName:[String]=[]
    var cityID:[Int]=[]
    var lat=""
    var long=""
var address = ""
    var cityIDNum=0
    var stateIDNum=0
    var listingID=0

    var status = "Add"
    var classifyID=0
    
    var backgroundImgData=""

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.status == "Edit"{
            state()
            titleLabel.text = "update classified"
            listView.isHidden=true
            descriptionTxt.text=ClassifiedDataObj?.description ?? ""
            titleTxt.text=ClassifiedDataObj?.title ?? ""
            cityTxt.text = ClassifiedDataObj?.city?.name
            backgroundImg.isHidden=false
            backgroundImg.sd_setImage(with: URL(string: ClassifiedDataObj?.image ?? ""))
            selectedImage=backgroundImg.image?.jpegData(compressionQuality: 0.5)
            stateTxt.text=ClassifiedDataObj?.state?.name
            addressLabel.text=ClassifiedDataObj?.address
            listingID=ClassifiedDataObj?.listing_id ?? 0
            cityIDNum=ClassifiedDataObj?.city?.id ?? 0
            stateIDNum=ClassifiedDataObj?.state?.id ?? 0
            city(state: stateIDNum)

        }else{
            backgroundImg.isHidden=true
            titleLabel.text = "Add classified"
            editBtn.setTitle("Add", for: .normal)
            listView.isHidden=false
        }
        category()
        state()
        cityTxt.pickerDelegate=self
        cityTxt.dataSource=self
        
        stateTxt.pickerDelegate=self
        stateTxt.dataSource=self
        
        listingTxt.pickerDelegate=self
        listingTxt.dataSource=self

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressLabel.text = address

        
    }

    @IBAction func uploadPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                present(picker,animated: true)
        
    }
    
    @IBAction func mapBtn(_ sender: Any) {
        let vc =  MapVC.instantiate()
        vc.screen="classified"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)  
    }
    
    
    @IBAction func postBtn(_ sender: Any) {
     
//        if lat != "" {
            
            if self.status == "Add"{
            
            do{
                let city = try self.cityTxt.validatedText(validationType: .requiredField(field: ""))

                let title = try self.titleTxt.validatedText(validationType: .requiredField(field: ""))
                self.createClassified(stateId:stateIDNum,listingId:listingID,title: title, data: self.selectedImage ?? Data(), category: "2", description: self.descriptionTxt.text, latitude: self.lat, longitude: self.long,city_id:self.cityIDNum ,address:self.address)
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
               
        }else{
            do{
                let city = try self.cityTxt.validatedText(validationType: .requiredField(field: "Select yor city"))

                let title = try self.titleTxt.validatedText(validationType: .requiredField(field: ""))
                self.updateClassified(stateId:stateIDNum,listingId:listingID,classifiedId:self.classifyID,title: title, image: self.selectedImage ?? Data(), category: "2", description: self.descriptionTxt.text, latitude:self.lat, longitude: self.long,city_id:self.cityIDNum ,address:addressLabel.text ?? "")
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
        }
//        }else{
//            self.showAlert(title: "Warning", message: "set your location")
//
//        }
    
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
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
extension CreateClassified:Storyboarded{
    static var storyboardName: StoryboardName = .Dashboard
}
extension CreateClassified{
    func state(){
//        self.showActivityIndicator()

        DashboardManager.shared.state { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.stateCategory  = responsedata
                        if self.stateCategory.count != 0{
                            
                       
                        for index in 0 ... self.stateCategory.count-1{
                            self.stateName.append(self.stateCategory[index].name ?? "")
                            self.stateID.append(self.stateCategory[index].id ?? 0)
                            
                            
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
//        self.hideActivityIndicator()

    }
    func category(){
//        self.showActivityIndicator()

    ListingManager.shared.myPublished{ response in
        
        switch response{
        case let .success(response):
            if response.statusCode == 200{
                
                do {
                    guard let  responsedata = response.data else {return}
                    self.listCategory  = responsedata
                    if self.listCategory.count != 0{
                        
                   
                    for index in 0 ... self.listCategory.count-1{
                        self.categorydata.append(self.listCategory[index].title ?? "")
                        self.categoryID.append(self.listCategory[index].id ?? 0)
                        
                        
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
//        self.hideActivityIndicator()

}
    func  createClassified(stateId:Int,listingId:Int,title: String, data: Data, category: String, description: String, latitude: String, longitude: String,city_id:Int,address:String){

        DashboardManager.shared.createdClassified(stateId:stateId,listingId:listingId,title: title, data: data, category: category, description: description, latitude: latitude, longitude: longitude,city_id:city_id ,address:address) { (response) in
            
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

    }
 
    
    func city(state:Int){
        
        DashboardManager.shared.city(state:state) { response in

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.cityCategory  = responsedata
                        if self.cityCategory.count != 0{
                            
                       
                        for index in 0 ... self.cityCategory.count-1{
                            self.cityName.append(self.cityCategory[index].name ?? "")
                            self.cityID.append(self.cityCategory[index].id ?? 0)
                            
                            
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

    }
    
    
    
    func  updateClassified(stateId:Int,listingId:Int,classifiedId:Int,title: String, image: Data, category: String, description: String, latitude: String, longitude: String,city_id:Int,address:String){
        
//        self.showActivityIndicator()

        DashboardManager.shared.updateClassified(stateId:stateId,listingId:listingId,classifiedId:classifiedId,title: title, image: image, category: category, description: description, latitude: latitude, longitude: longitude,city_id:city_id ,address:address) { (response) in
            
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
//        self.hideActivityIndicator()

    }
    
}
extension CreateClassified:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
 
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        
        if textField == cityTxt{
            if stateIDNum != 0{
                cityTxt.setTextFieldTitle(title: " \(cityName[row])")
                self.cityIDNum=cityID[row]
//
//            }else{
//             showAlert(title: "Notice", message: "You should choose your state")
//            }
         
        }else if textField == stateTxt {
            stateTxt.setTextFieldTitle(title: " \(stateName[row])")
            self.stateIDNum=stateID[row]
            city(state: self.stateIDNum)
        }else{
            listingTxt.setTextFieldTitle(title: " \(categorydata[row])")
            self.listingID=categoryID[row]
        }
    
    }
    }
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
        if textField == cityTxt{
            if stateIDNum != 0{
                return cityName.count

            }else{
             showAlert(title: "Notice", message: "You should choose your state")
                return 0

            }
        }else if textField == stateTxt {
            return  stateName.count
        }else{
            return categorydata.count

        }
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
        print("\(title ?? "")")

        if textField == cityTxt{
            return  cityName[row]
        }else if textField == stateTxt {
            return stateName[row]
        }else {
            return categorydata[row]

        }
    }
    
    func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
        1
    }
    
    
    
    
    
    
    
    
}
