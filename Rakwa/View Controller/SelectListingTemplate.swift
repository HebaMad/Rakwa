//
//  SelectListingTemplate.swift
//  Rakwa
//
//  Created by moumen isawe on 24/12/2021.
//

import Foundation
import UIKit

class SelectListingTemplate: UIViewController {
    @IBOutlet weak var templateTF:UITextFieldDataPicker!
    fileprivate var data = [ListingTemplate](){
        didSet{self.templateTF.reloadData()}
        
    }
    
    var categories:[TopCategory]?
    var selectedTemplate:ListingTemplate?
    override func viewDidLoad() {
        super.viewDidLoad()

        templateTF.dataSource = self
        templateTF.pickerDelegate = self
        // Do any additional setup after loading the view.
        
        
        HomeManager.shared.AllCategories(module: "listing") { response in
            switch response{
            case .success(let res):
                if res.statusCode >= 200 && res.statusCode < 300{
                    if let categories = res.data{
                        self.categories = categories
                        
                    }
                }else{
                    self.showAlert(title: "Erorr", message: "Some Error",hideCancelBtn: true)
                }
                
                 
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
        ListingManager.shared.getListingTemplates { response in
            switch response {
            case .success(let res ):
                if res.statusCode < 300 && res.statusCode >= 200{
                    if let data = res.data {
                        self.data = data
                        
                    }
                }else{
                    self.showAlert(title: "Warning", message: "Something wrong happend please come back later",hideCancelBtn: true)

                }
                
            case .failure(let error):
                self.showAlert(title: "Warning", message: "Something wrong happend please come back later",hideCancelBtn: true)

            }
        }
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func nextBtnPressed(){
        if let selectedTemplate = selectedTemplate {
            ListingManager.shared.getListingBlueprint(templateId: selectedTemplate.id) { response in
                switch response {
                case .failure(let error ):
                    self.showAlert(title: "Error", message: "Some",hideCancelBtn: true)
                case .success(let res):
                     
                         
                        let vc = AddListing.instantiate()
                        
                        vc.bluePrint = res
                        vc.categories = self.categories
                        self.navigationController?.pushViewController(vc, animated: true)
                       
                     
                }
            }
        
        }else{
            self.showAlert(title: "Erorr", message: "Please select Template")
        }
    }
     
}
extension SelectListingTemplate:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension SelectListingTemplate:UITextFieldDataPickerDelegate,UITextFieldDataPickerDataSource{
                func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
                    textField.text = data[row].title
                    self.selectedTemplate = data[row]
                }
                
                func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
                    return self.data.count
                }
                
                func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
                    return data[row].title
                }
                
                func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
                    return 1
                }
                
    
}
