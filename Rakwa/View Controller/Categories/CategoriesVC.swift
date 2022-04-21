//
//  CategoriesVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit
import MapKit

class CategoriesVC: UIViewController {
    var categoriesData:[TopCategory]=[]
    private let itemsPerRow: CGFloat = 4

    private let sectionInsets = UIEdgeInsets(
        top: 8,
        left: 0,
        bottom: 0,
        right: 0)
    
    
    
    @IBOutlet var searchBar: SearchView!
    
    @IBOutlet var notificationsBtn: UIButton!
    @IBOutlet var notificationNo: UILabel!
    
    @IBOutlet var categoriesTable: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        categoriesTable.register(CategoryCell.self)
        setLayers()
        categoriesTable.delegate=self
        categoriesTable.dataSource=self
        categories(module: "listing")
        
        searchBar.startHandler {
               self.categoriesTable.reloadData()
           }
           searchBar.editingChangeHandler {
               if (self.searchBar.txtSearch.text)?.count != 0{
                   self.categoriesData = self.filter(keyword:self.searchBar.txtSearch.text ?? "")
                   self.categoriesTable.reloadData()
               }else{
 
               }
               
           }
        
        
    }
    

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func setLayers(){
            let layer = UICollectionViewFlowLayout()
            layer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//            layer.minimumInteritemSpacing = 5
//            layer.minimumLineSpacing = 5
            layer.scrollDirection = .vertical
            layer.invalidateLayout()
            
            let size = ((self.view.frame.width / 3)-20)
            layer.itemSize = CGSize(width: size, height: 120)
        categoriesTable.setCollectionViewLayout(layer, animated: true)
        }
  
}
extension CategoriesVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureCategories(item: categoriesData[indexPath.row])
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LocationVC.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
extension CategoriesVC:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}
extension CategoriesVC{
    
    func categories(module:String){
        self.showActivityIndicator()
        HomeManager.shared.AllCategories(module: module) { response in
     
        switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data  else {return}
                    self.categoriesData=responsedata
                    self.categoriesTable.reloadData()
                    
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
    func filter(keyword : String) -> [TopCategory]{
         let result : [TopCategory] = categoriesData.filter({ (txt) -> Bool in
             return  (txt.title!.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
         return result
     }
    
}
