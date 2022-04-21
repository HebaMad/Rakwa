//  ListingScreenVC.swift
//  Rakwa

//  Created by macbook on 9/30/21.

import UIKit

class ListingScreenVC: UIViewController {

    @IBOutlet var displayTable: UICollectionView!
    @IBOutlet weak var collectionPageConrtol: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        
        
    }
    func registerNib(){
        displayTable.register(HomeHeader.self)
        
    }


}
extension ListingScreenVC{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
      
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let bannerCell:HomeHeader = displayTable.dequeueReusableCell(for: indexPath)

         
            return bannerCell
  
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: displayTable.bounds.width, height: displayTable.bounds.height)

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        collectionPageConrtol.currentPage = Int(pageNumber)
    }
    
    
}
