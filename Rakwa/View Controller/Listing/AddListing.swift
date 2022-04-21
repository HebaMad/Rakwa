//
//  AddListing.swift
//  Rakwa
//
//  Created by macbook on 10/12/21.
//

import UIKit

class AddListing: UIViewController {

    
    
    @IBOutlet weak var tableView:UITableView!
     
    var bluePrint  = [BlueprintElement]()
    var dataToSubmit:[String:Any] = [:]
    
    let tableHeader = AddListingHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height*200/600))
    let tableFooter = NextAndBackView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 100))
     var currentView = 0
    var categories:[TopCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
//        tableHeader.progressView.progressBar.count = 5
        let staticList = self.createListingGeneralData()
        bluePrint = staticList+bluePrint
        
        tableHeader.progressView.progressBar.currentStep = 0
        tableHeader.progressView.progressBar.numberOfSteps = bluePrint.count
        tableView.tableHeaderView = tableHeader
//        tableHeader.numberOfSteps(number: 5)
 
        tableFooter.delegeta = self
        tableView.tableFooterView = tableFooter
        tableView.separatorColor = .clear
        tableView.backgroundColor = UIColor(named: "background")
    
    }
    
    
    
 


}
extension AddListing:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}



extension AddListing:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bluePrint[self.currentView].fields.count
        
        
    }
    
    
    
     
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let obj = self.bluePrint[self.currentView].fields[indexPath.row]
        switch obj.type {
            
        case "url","textfield":
            let cell:TextFieldTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.nameLabel.text = obj.label
            cell.apiKey = obj.apiKey
            if let text =  self.dataToSubmit[obj.apiKey] as? String{
                cell.textField.text = text
            }else{
                cell.textField.text = ""
            }
            cell.onReciveData = { apiKey,value in
                print("Hello world")
                self.dataToSubmit[apiKey] = value
            }
            return cell
        case "checkbox":
            
            
            let cell:CheckBoxTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.nameLabel.text = obj.label
            cell.apiKey = obj.apiKey
            if let checked =  self.dataToSubmit[obj.apiKey] as? Bool {
                cell.checkBox.isChecked = checked
                
            }else{
                cell.checkBox.isChecked = false
            }
            cell.onButtonClicked = { apikey , value in
                print("hi \(apikey)  , \(value )")
                self.dataToSubmit[obj.apiKey] = value
            }
            return cell
        case "textarea":
            let cell:TextAreaTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.nameLabel.text = obj.label
            cell.apiKey = obj.apiKey
            
            
            if let text =  self.dataToSubmit[obj.apiKey] as? String {
                cell.textView.text = text
            }else{
                cell.textView.text = ""
            }
            
            cell.onReciveData  = {apiKey, value in
                print("api key \(apiKey), \(value)")
                self.dataToSubmit[apiKey] = value
            }
            
            return cell
        case "dropdown":
            let cell:DropDownTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.nameLabel.text = obj.label
            cell.data = obj.data.flatMap({
                $0.value
            
            })
            
            if let text =  self.dataToSubmit[obj.apiKey] as? String {
                cell.textField.text = text
            }else{
                cell.textField.text = ""
            }
            cell.apiKey = obj.apiKey
            cell.onReciveData = { apiKey , value in
                self.dataToSubmit[apiKey] = value
            }
            return cell
        case "location":
            let cell:SelectFromMapTVC = tableView.dequeueReusableCell(for: indexPath)
            return cell
        
            
        default:
            let cell:TextFieldTVC = tableView.dequeueReusableCell(for: indexPath)
            
            return cell
        }
        let cell:TextFieldTVC = tableView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
    
    
    fileprivate func setupTableView() {
         
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextFieldTVC.self)
        tableView.register(SelectImageTVC.self)
        tableView.register(TextAreaTVC.self)
        tableView.register(DropDownTVC.self)
        tableView.register(CheckBoxTVC.self)
        tableView.register(SelectFromMapTVC.self)
    }
    
    
}
extension AddListing:NextBackDelegate{
    func backBtnPressed() {
        if currentView > 0 {
        DispatchQueue.main.async {
            
            self.currentView -= 1
            self.tableHeader.previousStep(title: self.bluePrint[self.currentView].sectionName)
            self.tableView.reloadData()
        }
        
            
            
        }
    }
    
    func nextBtnPressed() {
        
        if currentView < self.bluePrint.count-1{
        DispatchQueue.main.async {
            
            self.currentView += 1
            self.tableHeader.nextStep(title: self.bluePrint[self.currentView].sectionName)
            self.tableView.reloadData()
        }
        
        
            
            
        }
    }
    
    
    
}
extension AddListing{
    func createListingGeneralData()->[BlueprintElement]{
        var bluePrint = Blueprint()
        var catigoresName = [FieldData]()
        if let cat = self.categories {
            catigoresName = cat.compactMap({ $0.title}).flatMap({ .init(value: $0)})
        }
        
        let listingDetails = BlueprintElement(sectionName: "LISTING DETAILS", orderNumber: 0, fields: [
        Field(apiKey: "title", isRequired: true, label: "Listing title", type: "textfield", data: []),
        Field(apiKey: "category", isRequired: true, label: "Select Listing Category", type: "dropdown", data: catigoresName)
        ,
        Field(apiKey: "description", isRequired: true, label: "List Description", type: "textarea", data: [])
        
        
         

        
        ])
        let listingLocation = BlueprintElement(sectionName: "Location", orderNumber: 1, fields: [
            
            
            Field(apiKey: "state", isRequired: true, label: "Select State", type: "dropdown", data: []),
            Field(apiKey: "cityId", isRequired: true, label: "Select city", type: "dropdown", data: []),
            Field(apiKey: "location", isRequired: true, label: "Select Listing Category", type: "location", data: catigoresName)
             
        
        ])
        
        
        bluePrint.append(listingDetails)
        bluePrint.append(listingLocation)
        return bluePrint
    }
}
