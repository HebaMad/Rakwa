//
//  ActivityIndicator.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//


import UIKit

extension UIViewController{
    var activityIndicatorContainer:UIView{
        return UIView()
    }
    func showActivityIndicator() {
        guard let uiView = self.view else {
            return
        }
        DispatchQueue.main.async {
        
            let container: UIView = self.activityIndicatorContainer
        container.frame = uiView.frame
        container.center = uiView.center
            container.backgroundColor = UIColor(color: .appPrimary)?.withAlphaComponent(0.1)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
            loadingView.backgroundColor = UIColor(color: .appPrimary)?.withAlphaComponent(0.6)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        actInd.style =
            UIActivityIndicatorView.Style.large
        actInd.color = UIColor(color: .buttonPrimary)
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        container.tag = 100
            actInd.startAnimating()
            
        }
    }
    func revealViewController() -> TabBarVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is TabBarVC {
            return viewController! as? TabBarVC
        }
        while (!(viewController is TabBarVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is TabBarVC {
            return viewController as? TabBarVC
        }
        return nil
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            
            
            if let container = self.view.viewWithTag(100){
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    
                    container.alpha = 0
                }, completion: {
                    
                    (compleation ) in
                    if compleation{
                        container.removeFromSuperview()
                    }
                })
            }
            
        }
    }
}
