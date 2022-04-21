//
//  BusinessHoursVC.swift
//  Rakwa
//
//  Created by macbook on 10/12/21.
//

import UIKit

class BusinessHoursVC: UIViewController {
    @IBOutlet var backButton: UIButton!

    @IBOutlet var displayTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTableView.register(BusinessHours.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
    }
    


}
extension BusinessHoursVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell:BusinessHours = displayTableView.dequeueReusableCell(for: indexPath)

        return cell
    }

}


extension BusinessHoursVC:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
