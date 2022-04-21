//
//  TabBarVC.swift
//  Rakwa
//
//  Created by macbook on 9/14/21.
//

import UIKit

class TabBarVC: UITabBarController{
    
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    // Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!

    private var revealSideMenuOnTop: Bool = true
    
    var gestureEnabled: Bool = true
    
    let button = UIButton.init(type: .custom)
    let buttonBackground = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        
               button.setImage(UIImage(systemName: "plus")!, for: .normal)
               button.tintColor = .white
               button.backgroundColor = .orange
               

               button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
               self.view.insertSubview(button, aboveSubview: self.tabBar)
               self.view.insertSubview(buttonBackground, aboveSubview: self.tabBar)
            self.view.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)

    }
    

    @objc func buttonAction(sender: UIButton!) {
        selectedIndex = 2
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
 
    }

 


}
extension TabBarVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}


