//
//  DashboardVC.swift
//  Rakwa
//
//  Created by macbook on 9/15/21.
//

import UIKit
import SideMenu
class DashboardVC: UIViewController {
    var items:[DashboardMenuItems]=[]
    private var menu :SideMenuNavigationController?

    @IBOutlet weak var displayTable: SelfSizingCollectionView!
    private let itemsPerRow: CGFloat = 3
    
    private let sectionInsets = UIEdgeInsets(
      top: 2.0,
      left: 0.0,
      bottom: 2.0,
      right: 0.0)
    
    
    @IBOutlet var viewsNum: UILabel!
    @IBOutlet var leadsNum: UILabel!
    @IBOutlet var reviewsNum: UILabel!
    
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var notificationsBtn: UIButton!
    @IBOutlet var notificationNo: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
        userStatistic()
        displayTable.register(DashboardCell.self)

        displayTable.delegate=self
        displayTable.dataSource=self
        setLayers()
        setUpSideMenu()


    }
    
    @IBAction func menuBtn(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeSideMenuSide()
        tabBarController?.tabBar.isHidden = false

    }
    
    private func changeSideMenuSide(){
       
               menu?.leftSide = true
               SideMenuManager.default.rightMenuNavigationController = nil
               SideMenuManager.default.leftMenuNavigationController = menu
        
    }
    
    private func setUpSideMenu() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
            menu = SideMenuNavigationController(rootViewController: vc)
            menu?.setNavigationBarHidden(true, animated: false)
            menu?.presentationStyle = .menuSlideIn
            menu?.presentationStyle.onTopShadowColor = .black
            menu?.presentationStyle.onTopShadowRadius = 5
            menu?.presentationStyle.onTopShadowOffset = .zero
            menu?.presentationStyle.onTopShadowOpacity = 0.3
            menu?.presentationStyle.presentingScaleFactor = 0.98

            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        }

    func initializer(){
        items=DashboardMenuItems.all
  
    }
    func setLayers(){
            let layer = UICollectionViewFlowLayout()
//            layer.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            layer.minimumInteritemSpacing = 5
//////            layer.minimumLineSpacing = 5
////            layer.scrollDirection = .vertical
////            layer.invalidateLayout()
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - 4
        let widthPerItem = ((self.view.frame.width / 3)-15)
        
            layer.itemSize = CGSize(width: widthPerItem, height: 130)
        displayTable.setCollectionViewLayout(layer, animated: true)
        }

}

extension DashboardVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DashboardCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.Name.text = items[indexPath.row].labelName
            cell.img.image = items[indexPath.row].imgName
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch items[indexPath.row].self{
        case .Announcements:
         
            let vc = MyAnnouncementVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
        case .Ad_campaigns:
       
            let vc = InvoicesVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
        case .MyListings:
    
            let vc = MyListingVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
   
        case .Invoices:
       
            let vc = InvoicesVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
        case .Saved:
      
            let vc = SavedVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
        case .Reviews:
       
            let vc = RecievedReview.instantiate()

            navigationController?.pushViewController(vc, animated: true)
        case .Coupons:
           
            let vc = CopounsVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)
            
        case .Events:
       
            let vc = MyEventVC.instantiate()

            navigationController?.pushViewController(vc, animated: true)

        case .Classifieds:
       
            let vc = MyClassifieds.instantiate()
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
      // 2
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      return CGSize(width: widthPerItem, height: 110)
    }
    
    
    
}
extension DashboardVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
extension DashboardVC{
    
    func userStatistic(){
        self.showActivityIndicator()

        DashboardManager.shared.statistic { (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                
                do {
                    guard let  responsedata = response.data else {return}
                    self.viewsNum.text="\(responsedata.listings_views)"
                    self.reviewsNum.text="\(responsedata.my_listings_reviews_count)"
                    self.leadsNum.text="\(responsedata.listings_count)"

                    
                } catch let error {
                    self.showAlert(title: "Error", message: "Data not found")
                }
                }
            case let .failure(error):
                
                self.viewsNum.text="\(0)"
                self.reviewsNum.text="\(0)"
                self.leadsNum.text="\(0)"

                
//                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
//
//                }
        }
        }
        self.hideActivityIndicator()

    }
    
    
}
