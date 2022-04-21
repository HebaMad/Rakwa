//
//  AddEventVC.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import UIKit
import MapKit
import SDWebImage
class AddEventVC: UIViewController ,UIImagePickerControllerDelegate & UINavigationControllerDelegate & UITextFieldDelegate{
    var categoriesData:[TopCategory]=[]
    var eventDataObj:eventData?
    @IBOutlet weak var backgroundImg: UIImageViewDesignable!
    @IBOutlet weak var listView: UIViewDesignable!
    @IBOutlet weak var editBtn: UIButton!
    var listCategory:[Category]=[]
    var categorydata:[String]=[]
    var categoryID:[Int]=[]
    @IBOutlet weak var endTime: DatePickingTextField!
    @IBOutlet weak var startTime: DatePickingTextField!
    @IBOutlet weak var startDate: DatePickingTextField!
    var status = "Add"
    var eventID=0
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var mapAddress: UILabel!
    @IBOutlet weak var endDate: DatePickingTextField!
    var selectedImage:Data?

    @IBOutlet weak var eventCurrentLocation: UILabel!
    var itemID=0
    var listingId=0
    @IBOutlet weak var categoryTxt: UITextFieldDataPicker!
    
    @IBOutlet weak var descriptionEvent: UITextView!
    var addressFromMap:String?
    var lat:String?
    var long:String?
    var currentLat=""
    var currentLong=""
    var currentAddress=""

    var eventTitle=""
    var eventstartTime=""
    var eventsEndTime=""
    var eventStartDate=""
    var eventEndDate=""
    var eventDescription=""
var backgroundImgData=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.status == "Edit"{
            titleLabel.text = "Update Event"
            editBtn.setTitle("Edit", for: .normal)
            listView.isHidden=true
            
            startTime.text = convertTimeformat(eventDataObj?.startTime?.date ?? "")
            eventName.text=eventDataObj?.title ?? ""
            startDate.text=convertDateFormater( eventDataObj?.endDate?.date ?? "")
            endDate.text=convertDateFormater( eventDataObj?.endDate?.date ?? "")
            endTime.text = convertTimeformat(eventDataObj?.endTime?.date ?? "")
            descriptionEvent.text=eventDataObj?.adsDescription ?? ""
            backgroundImg.isHidden=false
            backgroundImg.sd_setImage(with: URL(string: eventDataObj?.image ?? ""))
            selectedImage=backgroundImg.image?.jpegData(compressionQuality: 0.5)
            self.itemID = eventDataObj?.listingID ?? 0
            
            
        }else{
            backgroundImg.isHidden=true
            titleLabel.text = "Add Event"
            editBtn.setTitle("Add", for: .normal)
            listView.isHidden=false
        }
        
        self.setupTimePicker()
        
        currentlyAddress()
        categories(module: "event")
        categoryTxt.pickerDelegate=self
        categoryTxt.dataSource=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapAddress.text=addressFromMap
        
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                present(picker,animated: true)
        
    }
    
    
    
    fileprivate func setupTimePicker() {
        startTime.setFormat(format: "HH:mm")
        endTime.setFormat(format: "HH:mm")
        startTime.setDatePickerMode(mode: .time)
        endTime.setDatePickerMode(mode: .time)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return  }
        print(image)
        selectedImage=image.jpegData(compressionQuality: 0.5)

        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
          print(fileUrl.lastPathComponent)

        
    }

    @IBAction func mapBtn(_ sender: Any) {

        let vc = MapVC.instantiate()
        vc.screen="event"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
        
        
        do{
            
            let eventname = try eventName.validatedText(validationType: .requiredField(field: "event name required"))
            let endTime = try endTime.validatedText(validationType: .requiredField(field: "end time requied"))
            let startTime = try startTime.validatedText(validationType: .requiredField(field: "end time requied"))
            let startDate = try startDate.validatedText(validationType: .requiredField(field: "end time requied"))
            let endDate = try endDate.validatedText(validationType: .requiredField(field: "end time requied"))
       
            let desc = try descriptionEvent.text.validatedText(validationType: .requiredField(field: "description event required"))
            
            if selectedImage != nil{
                
                
                
                if status == "Add"{
                    self.addEvent(listingId: self.itemID, name: eventname, startDate: startDate, endDates: endDate, startTime: startTime, endTime: endTime, description: desc, image: selectedImage!, address: (addressFromMap ?? self.currentAddress)!, lat: lat ?? currentLat, lon: long ?? currentLong)
                }else{
                    self.editEvent(id:eventID,listingId:self.itemID, name: eventname, startDate: startDate, endDates: endDate, startTime: startTime, endTime: endTime, description: desc, image: selectedImage!, address: (addressFromMap ?? self.currentAddress)!, lat: lat ?? currentLat, lon: long ?? currentLong)
                }
           
            }else{
                showAlert(title: "Notice", message: "event picture required")
            }
           
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
        
        
        
    
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension AddEventVC:Storyboarded{
    static var storyboardName: StoryboardName = .Copoun
}
extension AddEventVC{

    
    func currentlyAddress(){
        
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
            guard let location = location else {
                        self.showAlert(title: "Location Permission Required", message: "You should activate your location ", confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { (action) in
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        }
                        return
                    }
            
                    print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
            self.currentLat=" \(location.coordinate.latitude) "
            self.currentLong="\(location.coordinate.longitude)"
            do{
                
                LocationManager.shared.getAddressFromLatLon(pdblLatitude: "\(location.coordinate.latitude)", withLongitude: "\(location.coordinate.longitude)") { status, msg,country  in
                    self.eventCurrentLocation.text=msg ?? "no clear address"
                    self.currentAddress=msg ?? "no clear address"

                }
                
            }
                }
    }
    
    
    
    
    func addEvent(listingId: Int, name: String, startDate: String, endDates: String, startTime: String, endTime: String, description: String, image: Data, address: String, lat: String, lon: String){
        
        
        DashboardManager.shared.createEvent(listingId: listingId, name: name, startDate: startDate, endDates: endDates, startTime: startTime, endTime: endTime, description: description, image: image, address: address, lat: lat, lon: lon) { response in
            switch response{
            case let .success(response):
                
                switch response.statusCode{
                case 200..<300:
                    self.showAlert(title: "Error", message: response.statusMessage )

                     break
                case   400..<500:
                    self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                     break
                case 500:
                    self.showAlert(title: "Error", message: response.errors?[0].message ?? "")

                default:
                    break
                }
         
            case let .failure(error):
 
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        
        
        
    }
    
    
    func editEvent(id:Int,listingId: Int, name: String, startDate: String, endDates: String, startTime: String, endTime: String, description: String, image: Data, address: String, lat: String, lon: String){
        
        DashboardManager.shared.updateEvent(id:id,listingId: listingId, name: name, startDate: startDate, endDates: endDates, startTime: startTime, endTime: endTime, description: description, image: image, address: address, lat: lat, lon: lon) { response in
            switch response{
            case let .success(response):
                
                switch response.statusCode{
                case 200..<300:
                    self.showAlert(title: "Success", message: response.statusMessage )

                     break
                case   400..<500:
                    self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                     break
                case 500:
                    self.showAlert(title: "Error", message: response.errors?[0].message ?? "")

                default:
                    break
                }
         
            case let .failure(error):
 
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        
        
        
    }
    
    func categories(module:String){
        self.showActivityIndicator()
        HomeManager.shared.AllCategories(module: module) { response in
     
        switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data  else {return}
                    self.categoriesData=responsedata
                    if self.categoriesData.count != 0{
                        
                   
                    for index in 0 ... self.categoriesData.count-1{
                        self.categorydata.append(self.categoriesData[index].title ?? "")
                        self.categoryID.append(self.categoriesData[index].id ?? 0)
                        
                        
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

    
}
extension AddEventVC:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
      
        categoryTxt.setTextFieldTitle(title: " \(categorydata[row])")
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

