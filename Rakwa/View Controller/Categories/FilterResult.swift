//
//  FlutterResult.swift
//  Rakwa
//
//  Created by heba isaa on 16/12/2021.
//

import UIKit

class FilterResult: UIViewController {

    
    var listing:[Listing] = [Listing]()
    @IBOutlet weak var displayResultTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResultTable.register(HomeCell.self)

        displayResultTable.delegate=self
        displayResultTable.dataSource=self
    
    }
    

}
extension FilterResult:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}

extension FilterResult:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listing.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = displayResultTable.dequeueReusableCell(for: indexPath)
//        cell.configureHome(listing: listing[indexPath.row])
//        cell.callBtn.addTarget(self, action: #selector(self.CallPressed(_:)), for: .touchUpInside)
//        cell.callBtn.tag = indexPath.row
//
//        cell.viewLocationBtn.tag=indexPath.row
//        cell.viewLocationBtn.addTarget(self, action: #selector(self.viewLoc(_:)), for: .touchUpInside)
//
        return cell
    }

//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        }

    
}
