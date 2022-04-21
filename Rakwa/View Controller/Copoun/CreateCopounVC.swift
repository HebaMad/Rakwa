//
//  CreateCopounVC.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import UIKit
class CreateCopounVC: UIViewController ,UITextFieldDelegate{
    var timeDate = ""
    var startDate = false
    var listCategory:[Category]=[]
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var discountTxt: UITextField!
    @IBOutlet weak var copounDescription: UITextView!
    @IBOutlet weak var codeTxt: UITextField!
    @IBOutlet weak var copounTitle: UITextField!
    @IBOutlet weak var endDateTxt: DatePickingTextField!
    @IBOutlet weak var startDateTxt: DatePickingTextField!
    @IBOutlet weak var categoryTxt: UITextFieldDataPicker!
    var copounID=0
    var copounData :copouns?
//    "id": 22,
//             "listing_id": "2821",
//             "coupon_title": "testtt",
//             "coupon_code": "test",
//             "discount_value": "20",
//             "coupon_start": "21-12-2021",
//             "coupon_end": "20-01-2021",
//             "coupon_description": "Testt",
//             "coupon_status": "D"
//
    var copoundescription=""
    var copountitle=""
    var copouncode=""
    var copoundiscount=""
    var copounstartDateTxt=""
    var copounendDateTxt=""

    
    var categorydata:[String]=[]
    var categoryID:[Int]=[]
    var status = "Add"
    var announcementID=0
    var itemID=0

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.status == "Edit"{
            titleLabel.text = "Update Copoun"
            listView.isHidden=true
            codeTxt.text=copounData?.coupon_code ?? ""
            copounTitle.text=copounData?.coupon_title ?? ""
            startDateTxt.text=convertDateFormater(copounData?.coupon_start ?? "")
            endDateTxt.text=convertDateFormater(copounData?.coupon_end ?? "")
            copounDescription.text=copounData?.coupon_description ?? ""
            discountTxt.text=copounData?.discount_value ?? ""
            self.itemID = Int(copounData?.listing_id ?? "") ?? 0
        }else{
            
        }
        
        category()
        categoryTxt.pickerDelegate=self
        categoryTxt.dataSource=self


    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    
    @IBAction func saveBtn(_ sender: Any) {
        

        do{
            
            let codeText = try codeTxt.validatedText(validationType: .requiredField(field: ""))
            let copountitle = try copounTitle.validatedText(validationType: .requiredField(field: ""))
            let endDateText = try endDateTxt.validatedText(validationType: .requiredField(field: ""))
            let startDateText = try startDateTxt.validatedText(validationType: .requiredField(field: ""))
            let categoryText = try categoryTxt.validatedText(validationType: .requiredField(field: ""))
            let discountText = try discountTxt.validatedText(validationType: .requiredField(field: ""))
            
            
            if self.status == "Add"{

            createCopoun(listing_id: self.itemID, coupon_title: copountitle, coupon_code: codeText, discount_value: Int(discountText) ?? 0 , coupon_start: startDateText, coupon_end: endDateText, coupon_description: copounDescription.text ?? "")
            }else{
                updateCopoun(copounId: copounID, listing_id: self.itemID, coupon_title: copountitle, coupon_code: codeText, discount_value: Int(discountText) ?? 0 , coupon_start: startDateText, coupon_end: endDateText, coupon_description: copounDescription.text ?? "")
            }
        }catch(let error){
            self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
        }
        
        
        
        
       
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension CreateCopounVC:Storyboarded{
    static var storyboardName: StoryboardName = .Copoun
}


extension CreateCopounVC{
    func category(){
        self.showActivityIndicator()

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
        self.hideActivityIndicator()

}
    
    func createCopoun(listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String){
        self.showActivityIndicator()

        DashboardManager.shared.Addcoupoun(listing_id: listing_id, coupon_title: coupon_title, coupon_code: coupon_code, discount_value: discount_value, coupon_start: coupon_start, coupon_end: coupon_end, coupon_description: coupon_description) { response in
            
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        self.showAlert(title: "Success", message: response.statusMessage )
                    } catch let error {
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                        
                    }
                }
                
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
        self.hideActivityIndicator()

    }
    
    func  updateCopoun(copounId:Int,listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String){
        self.showActivityIndicator()

        DashboardManager.shared.updatecoupoun(copounId: copounId,listing_id: listing_id, coupon_title: coupon_title, coupon_code: coupon_code, discount_value: discount_value, coupon_start: coupon_start, coupon_end: coupon_end, coupon_description: coupon_description) { response in
    
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        self.showAlert(title: "Success", message: response.statusMessage )
                    } catch let error {
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                        
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

extension CreateCopounVC:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
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
