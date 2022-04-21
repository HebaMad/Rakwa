//
//  FullImgCollection.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class FullImgCollection: UIViewController {

    @IBOutlet var fullImgPic: UICollectionView!
    @IBOutlet weak var collectionPageConrtol: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    func registerNib(){
        fullImgPic.register(HomeHeader.self)

        fullImgPic.delegate=self
        fullImgPic.dataSource=self

    }

}
extension FullImgCollection:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension FullImgCollection:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
      
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let bannerCell:HomeHeader = fullImgPic.dequeueReusableCell(for: indexPath)

         
            return bannerCell
  
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: fullImgPic.bounds.width, height: fullImgPic.bounds.height)

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        collectionPageConrtol.currentPage = Int(pageNumber)
    }
    
    
}
