//
//  InvoicesVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class InvoicesVC: UIViewController {

    @IBOutlet var searchBar: SearchView!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var displayTable: UITableView!
    @IBOutlet var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        displayTable.register(InvoicesTVC.self)
        displayTable.delegate=self
        displayTable.dataSource=self


    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }

}

extension InvoicesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:InvoicesTVC = tableView.dequeueReusableCell(for: indexPath)

        return cell
    }

    
}
extension InvoicesVC:Storyboarded{
    static var storyboardName: StoryboardName = .Invoices
}
