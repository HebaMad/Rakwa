//
//  AddNewListing.swift
//  Rakwa
//
//  Created by macbook on 10/12/21.
//

import UIKit
class AddNewListing: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var categoryTxt: UITextFieldDataPicker!
    var itemID=0
    var categoryList:[templateData]=[]
    
    var categorydata:[String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        category()
        categoryTxt.pickerDelegate=self
        categoryTxt.dataSource=self
    }
    
    
  
    
}
extension AddNewListing:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}

extension AddNewListing{
    
    func category(){
        
        ListingManager.shared.listingTemplate{ response in
            
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.categoryList  = responsedata
                        for index in 0 ... self.categoryList.count-1{
                            self.categorydata.append(self.categoryList[index].title ?? "")
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
    
    
    
    
    
}
extension AddNewListing:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        categoryTxt.setTextFieldTitle(title: " \(categorydata[row])")
        self.itemID=row
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
