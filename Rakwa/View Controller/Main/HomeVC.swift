//
//  HomeVC.swift
//  Rakwa
//
//  Created by macbook on 10/7/21.
//

import UIKit
import SideMenu
import MapKit
typealias CallbackCheck = ( _ status: Bool) ->Void
typealias Callback = ( _ status: Bool,_ mapaddress:String?,_ mapcountry:String?) ->Void


class HomeVC: UIViewController{
    private var menu :SideMenuNavigationController?

    @IBOutlet weak var backGroundImg: UIImageView!
    private var isExpanded: Bool = false
    @IBOutlet var searchView: UIView!
    @IBOutlet var categoriesCollectionView: UICollectionView!
    @IBOutlet var bannerCollectionView: UICollectionView!
    
    @IBOutlet var menuBtn: UIButton!

    @IBOutlet var displayTableView: UITableView!
    
    @IBOutlet var showMoreBtn: UIButton!
    
    @IBOutlet weak var collectionPageConrtol: UIPageControl!
    var listing:[LatestListing]=[]
    var category:[TopCategory]=[]
    var bannerList:[Banner]=[]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        setUpSideMenu()
        print("test")
        //test
        if !Reachability3.isConnectedToNetwork(){
            self.showNoInternetVC()
            return
        }
        
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                        self.showNoLocationVC()
                        return
                    }
                    
            guard let location = location else {
                        self.showAlert(title: "Location Permission Required", message: "You should activate your location ", confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { (action) in
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        }
                        return
                    }
            
                    print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
            do{
                
//                self.home(levelid: 1, lat:"\( location.coordinate.latitude)", long: "\(location.coordinate.longitude)")
                self.home(levelid: 1, lat:"\(34.137729)", long: "\(-117.452701)")
                
            }catch(let error){
                self.showAlert(title: "Warning", message: (error as! ValidationError).message,hideCancelBtn: true)
            }
                }

       }
    
 
    @objc func CallPressed(_ sender : UIButton ) {
        callMobile(mobileNum: listing[sender.tag].phone ?? "")

     
}
    @objc func viewLoc(_ sender : UIButton ) {
        
        let vc = PlaceMarkVC.instantiate()
        vc.long=listing[sender.tag].longitude ?? ""
        vc.lat=listing[sender.tag].latitude ?? ""
        navigationController?.pushViewController(vc, animated: true)

        
     
}
    @IBAction func menuBtn(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }
    
    @IBAction func showFillterVC(){
        let vc = FilterVC.instantiate()
        
        self.navigationController?.show(vc, sender: self) 
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeSideMenuSide()
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
    func registerNib(){
        categoriesCollectionView.register(CategoryCell.self)
        bannerCollectionView.register(BannerCell.self)
        displayTableView.register(HomeCell.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
        
        categoriesCollectionView.delegate=self
        categoriesCollectionView.dataSource=self
        
        bannerCollectionView.delegate=self
        bannerCollectionView.dataSource=self
        

    }

    
    func setLayers() -> CGSize{
            let layer = UICollectionViewFlowLayout()
            layer.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

            layer.scrollDirection = .vertical
            layer.invalidateLayout()
            
            let size = ((self.view.frame.width / 4)-20)
            layer.itemSize = CGSize(width: size, height: 50)
        categoriesCollectionView.setCollectionViewLayout(layer, animated: true)
        return  layer.itemSize
        }
    
    
    
    
    @objc func favPreesed(_ sender : UIButton ) {
        
        if listing[sender.tag].isFavorite == 0{
            favCreated(listingId: listing[sender.tag].id ?? 0) { status in
                if status{
                    sender.tintColor = .red
                }else{
                    sender.tintColor = .white

                }
            }

        }else{
            deleteFav(listingID: listing[sender.tag].id ?? 0) { status in
                if status{
                    sender.tintColor = .white

                }else{
                    sender.tintColor = .red

                }
            }
         
        }
        
        
        
    
     
}



}

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureHome(listing: listing[indexPath.row])
        cell.callBtn.addTarget(self, action: #selector(self.CallPressed(_:)), for: .touchUpInside)
        cell.callBtn.tag = indexPath.row
        cell.viewLocationBtn.tag = indexPath.row
        cell.viewLocationBtn.addTarget(self, action: #selector(self.viewLoc(_:)), for: .touchUpInside)

        return cell
    }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
  
    
}
extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return category.count+1
       
        }else{

            return bannerList.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            let bannerCell:BannerCell = collectionView.dequeueReusableCell(for: indexPath)
            bannerCell.configureBanner(bannerList[indexPath.row])
         
            return bannerCell
        }else{
            
            
            
            let categoryCell:CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
            if indexPath.row == category.count{
                categoryCell.categoryView.backgroundColor=UIColor(named: "btn")!
                categoryCell.img.image=UIImage(named: "more")
                categoryCell.img.contentMode = .scaleAspectFit
                categoryCell.textLabel.text="more"
                categoryCell.textLabel.textColor = .white
                

            }else{
                categoryCell.configureCategories(item: category[indexPath.row])
                categoryCell.categoryView.backgroundColor = .white


            }
            return categoryCell

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {
            return  CGSize(width:((self.view.frame.width / 4)-20), height: 85)

            
        }else{
            return CGSize(width: bannerCollectionView.bounds.width, height: bannerCollectionView.bounds.height)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        collectionPageConrtol.currentPage = Int(pageNumber)
        collectionPageConrtol.currentPageIndicatorTintColor=UIColor(named: "btn")
        collectionPageConrtol.pageIndicatorTintColor = .white

        if #available(iOS 14.0, *) {
            collectionPageConrtol.preferredIndicatorImage=(UIImage(named: "pageselect"))
            collectionPageConrtol.setIndicatorImage(UIImage(named: "pageselect"), forPage: 0)
        } else {
            // Fallback on earlier versions
        }
//        if #available(iOS 14.0, *) {
//            collectionPageConrtol.preferredIndicatorImage=(UIImage(named: "pageselect"))
//
//            collectionPageConrtol.setIndicatorImage(UIImage(named: "pageselect"), forPage: 0)
//        } else {
//            // Fallback on earlier versions
//        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoriesCollectionView {
            if indexPath.row == category.count {
                let vc = CategoriesVC.instantiate()
                navigationController?.pushViewController(vc, animated: true)
            }
         
        }else{
            
        }
    }
    
    


    
}
extension HomeVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension HomeVC{
    
    func home(levelid:Int,lat:String,long:String){
        self.showActivityIndicator()

        HomeManager.shared.home(level_id: levelid, lat: lat, long: long) { (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data  else {return}
                    self.listing=responsedata.latest_listings ?? []
                    self.category=responsedata.top_categories ?? []
                    self.bannerList=responsedata.ads_campaigns?.Banner ?? []
                     self.collectionPageConrtol.numberOfPages=self.bannerList.count
                    self.collectionPageConrtol.currentPageIndicatorTintColor=UIColor(named: "btn")
                    self.collectionPageConrtol.pageIndicatorTintColor = .white

                    if #available(iOS 14.0, *) {
                        self.collectionPageConrtol.preferredIndicatorImage=(UIImage(named: "pageselect"))
                        self.collectionPageConrtol.setIndicatorImage(UIImage(named: "pageselect"), forPage: 0)
                    } else {
                        // Fallback on earlier versions
                    }
                    self.categoriesCollectionView.reloadData()
                    self.displayTableView.reloadData()
                    self.bannerCollectionView.reloadData()
                } catch let error {
                    print(error)
                }
                }
            case let .failure(error):

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        self.hideActivityIndicator()


    }

    
    
    
    func favCreated(listingId:Int,callback: @escaping CallbackCheck){
        self.showActivityIndicator()

        HomeManager.shared.createFavourite(listingId: listingId) { response in

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                
                do {
                    self.showAlert(title: "Success", message:response.statusMessage)
                    callback(true)

                } catch let error {
                    self.showAlert(title: "Error", message:response.statusMessage)
                    callback(false)

                }
                }
            case let .failure(error):
                callback(false)

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
            
        }
        self.hideActivityIndicator()

        
        
    }
    
    func deleteFav(listingID:Int,  callback: @escaping CallbackCheck)->Void{
        self.showActivityIndicator()

        HomeManager.shared.deleteFavourite(listingId: listingID) { response in

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                do {
                    self.showAlert(title: "Success", message:response.statusMessage)

                    callback(true)
                } catch let error {
                    self.showAlert(title: "Error", message:response.statusMessage)
                    callback(false)

                }
                }
            case let .failure(error):
                
                callback(false)

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        self.hideActivityIndicator()

    }
    
    
    
}
