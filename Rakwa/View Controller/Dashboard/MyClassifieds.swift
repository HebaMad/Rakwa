//
//  MyClassifies.swift
//  Rakwa
//
//  Created by macbook on 9/29/21.
//

import UIKit
import Moya

class MyClassifieds: UIViewController {
    @IBOutlet var searchBar: SearchView!
    @IBOutlet var displayTable: UITableView!
    
    var myClasifieds:[ClassifiedData]=[]
    @IBOutlet var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true
        tabBarController?.tabBar.isHidden = true

        displayTable.register(ClassifiedsCell.self)
        displayTable.delegate=self
        displayTable.dataSource=self
        myClassified()
        searchBar.startHandler {
               self.displayTable.reloadData()
           }
           searchBar.editingChangeHandler {
               if (self.searchBar.txtSearch.text)?.count != 0{
                   self.myClasifieds = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                   self.displayTable.reloadData()
               }else{

               }
               
           }
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myClassified()

    }

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func createAction(_ sender: Any) {
 let vc=CreateClassified.instantiate()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
    @objc func editPreesed(_ sender : UIButton ) {
        
        
        let vc = CreateClassified.instantiate()
        vc.status="Edit"
        vc.classifyID=myClasifieds[sender.tag].id ?? 0
        vc.ClassifiedDataObj=myClasifieds[sender.tag]
        navigationController?.pushViewController(vc, animated: true)
    
     
}
    
    @objc func removePreesed(_ sender : UIButton ) {
        
        removeCategory(id: myClasifieds[sender.tag].id ?? 0)
    
     
}
    
 
}

extension MyClassifieds:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClasifieds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:ClassifiedsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureClassified(classified: myClasifieds[indexPath.row])
        cell.editBtn.addTarget(self, action: #selector(self.editPreesed(_:)), for: .touchUpInside)
        cell.editBtn.tag = indexPath.row
        
        cell.removeBtn.addTarget(self, action: #selector(self.removePreesed(_:)), for: .touchUpInside)
        cell.removeBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        classifiedDetails(id: myClasifieds[indexPath.row].id ?? 0)
    }
    
    
    
}
extension MyClassifieds:Storyboarded{
    static var storyboardName: StoryboardName = .Dashboard
}
extension MyClassifieds{
    
    func classifiedDetails(id:Int){
        
        self.showActivityIndicator()

        DashboardManager.shared.classifiedDetails(classifiedId: id) { (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data else {return}
                    let vc =  Classifieds.instantiate()
                    vc.details=responsedata
                    self.navigationController?.pushViewController(vc, animated: true)
                    
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
func myClassified(){
    DashboardManager.shared.myClassified { (response) in
        switch response{
        case let .success(response):
            if response.statusCode == 200{
                
            
            do {
                guard let  responsedata = response.data else {return}
                self.myClasifieds=responsedata
                if self.myClasifieds.count == 0 {
                    self.emptyView.isHidden = false
                }else {
                    self.emptyView.isHidden = true
                    
                }
                self.displayTable.reloadData()
            } catch let error {
           
            }
            }
        case let .failure(error):

            self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
            
            }
    }

    
        
        
        
    }
    
    
}
    
    
    func removeCategory(id:Int){
        DashboardManager.shared.deleteClassified(classified_id: id) { (response) in
            self.showActivityIndicator()

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    self.showAlert(title: "Success", message: response.statusMessage )
                    self.myClassified()
                    self.displayTable.reloadData()
                } catch let error {
                    self.showAlert(title: "Error", message: response.statusMessage )

                }
                }
                self.hideActivityIndicator()

            case let .failure(error):

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
                self.hideActivityIndicator()

        }
        
    }
    
    

    
}
    
    
    func filter(keyword : String) -> [ClassifiedData]{
         let result : [ClassifiedData] = myClasifieds.filter({ (txt) -> Bool in
             return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
         return result
     }
}
