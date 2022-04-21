//
//  SavedVC.swift
//  Rakwa
//
//  Created by macbook on 10/2/21.
//

import UIKit

class SavedVC: UIViewController {
    
    @IBOutlet var displayTable: UICollectionView!
    var favList:[favData]=[]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        savedFavourite()
        displayTable.register(SavedCell.self)
        displayTable.collectionViewLayout = createCompositionalLayout()
        displayTable.delegate=self
        displayTable.dataSource=self
        
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
            navigationController?.popViewController(animated: true)
    }
    
    
}
extension SavedVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return favList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell:SavedCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.configureSavedData(item: favList[indexPath.row])
        return cell
        
        
        
    }
    
    
}
extension SavedVC{
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)))
        
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
   
        
        // Second type: Main with pair
        // 3
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1.0)))
        
        mainItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        // 2
        let twiceItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1.0)))
        
        twiceItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let twiceGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/4)),
            subitems: [twiceItem, twiceItem])
        

        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [
                twiceGroup,
                fullPhotoItem,
                twiceGroup
                
            ]
        )
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
      
        
        return layout
    }
    
    
    
    
}

extension SavedVC:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}

extension SavedVC{
    
    
    func savedFavourite(){
        self.showActivityIndicator()
        HomeManager.shared.AllFavourite { response in
            switch response{

            case let .success(response):
                if response.statusCode == 200{
                    
                do {
                    guard let  responsedata = response.data else {return}
                    self.favList=responsedata
                    self.displayTable.reloadData()
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
