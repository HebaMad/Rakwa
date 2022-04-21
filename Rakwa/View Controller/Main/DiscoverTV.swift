//
//  DiscoverTV.swift
//  Rakwa
//
//  Created by macbook on 9/12/21.
//

import UIKit
import SideMenu
import SDWebImage

class DiscoverTV: UIViewController {
    private var menu :SideMenuNavigationController?
    var page=1


    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var notificationsBtn: UIButton!
    @IBOutlet var notificationNo: UILabel!
    var discover:DiscoverData?
    
    
    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        displayTable.register(DiscoverCVC.self)
        self.discover(page: page)
        displayTable.delegate=self
        displayTable.dataSource=self

        setUpSideMenu()


    }
    
    @IBAction func menuBtn(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false

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


}
extension DiscoverTV:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discover?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell:DiscoverCVC = tableView.dequeueReusableCell(for: indexPath)
        guard let discover = discover?.items?[indexPath.row] else { return cell }
        cell.configureDiscover(Discover: discover)
        return cell

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom == height {
                page += 1
                self.discover(page: page)

            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let discover = discover?.items?[indexPath.row] else { return  }

        let vc =  DiscoverVC.instantiate()
        vc.discoverItem=discover


        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension DiscoverTV:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension DiscoverTV{
    
    
    func discover(page:Int){

        HomeManager.shared.discover(page: page) { (response) in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                  
                do {
                    guard let  responsedata = response.data  else {return}
                    self.discover=responsedata
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
    
    
    
    
    
    
}

