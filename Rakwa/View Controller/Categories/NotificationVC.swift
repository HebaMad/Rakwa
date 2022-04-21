//
//  NotificationVC.swift
//  Rakwa
//
//  Created by macbook on 9/15/21.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet var backButton: UIButton!

    @IBOutlet var displayTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTableView.register(NotificationCell2.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
    }
    


}
extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell:NotificationCell2 = displayTableView.dequeueReusableCell(for: indexPath)

        return cell
    }
    
    
    
    
    
    
    
    
}
extension NotificationVC:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}
