//
//  PricingPlan.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class PricingPlan: UIViewController {

    @IBOutlet var premiumTable: UITableView!
    @IBOutlet var basicTable: UITableView!
    @IBOutlet var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        basicTable.register(PricingPlanCell.self)
        premiumTable.register(PricingPlanCell.self)
        
        basicTable.delegate=self
        basicTable.dataSource=self

    }
    

    @IBAction func next(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

 
    
    
    
    

}
extension PricingPlan:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:PricingPlanCell = tableView.dequeueReusableCell(for: indexPath)

        return cell

    }
    
}
extension PricingPlan:Storyboarded{
    static var storyboardName: StoryboardName = .Invoices
}
