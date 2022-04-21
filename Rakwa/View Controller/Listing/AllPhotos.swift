//
//  ViewController.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit

class AllPhotos: UIViewController {
    
    @IBOutlet var displayTable: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        displayTable.register(FullImgCell.self)
        displayTable.collectionViewLayout = createCompositionalLayout()
        displayTable.delegate=self
        displayTable.dataSource=self
        
    }

    
}
extension AllPhotos: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FullImgCell = collectionView.dequeueReusableCell(for: indexPath)

        
        return cell
    }
    
    
}
extension AllPhotos{
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/3)))
        
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
        
        // Third type. Triplet
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        
        tripletItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [tripletItem, tripletItem, tripletItem])
        
        
       
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [
                tripletGroup,
                tripletGroup,
                twiceGroup,
                fullPhotoItem
                
            ]
        )
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
      
        
        return layout
    }
    
    
    
    
}

extension AllPhotos:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
