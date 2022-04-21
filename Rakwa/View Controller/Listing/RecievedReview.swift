//
//  RecievedReview.swift
//  Rakwa
//
//  Created by macbook on 9/20/21.
//

import UIKit

class RecievedReview: UIViewController {
    @IBOutlet var backButton: UIButton!
    var recieved:[Received]=[]
    var submitting:[Received]=[]
    var AllList:[Received]=[]
    var buttonText="AllListing"
    @IBOutlet var emptyView: UIView!
    @IBOutlet var displayTableView: UITableView!
    
    
    
    @IBOutlet var AllListingButton: UIButton!
    @IBOutlet var listingView: UIView!
    
    @IBOutlet var recievedButton: UIButton!
    @IBOutlet var recievedView: UIView!
    
    
    @IBOutlet var submittingButtn: UIButton!
    @IBOutlet var submittingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        tabBarController?.tabBar.isHidden = true

        getMyReview()
        displayTableView.register(ReviewRecievedCell.self)
        displayTableView.delegate=self
        displayTableView.dataSource=self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyReview()

    }
    
    @IBAction func AllListingBtn(_ sender: Any) {
        buttonText="AllListing"
        recievedView.backgroundColor = .white
        submittingView.backgroundColor = .white
        listingView.backgroundColor = UIColor.init(named: "btn")
        displayTableView.reloadData()

        
    }
    
    @IBAction func recievedBtn(_ sender: Any) {
        buttonText="recieved"
        submittingView.backgroundColor = .white
        recievedView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        displayTableView.reloadData()
    }
    
    @IBAction func submittingBtn(_ sender: Any) {
        buttonText="submitting"
        recievedView.backgroundColor = .white
        submittingView.backgroundColor = UIColor.init(named: "btn")
        listingView.backgroundColor = .white
        displayTableView.reloadData()

    }
    @objc func morePressed(_ sender : UIButton ) {
        
        switch buttonText {

        case "AllListing":
         
            showActionSheet(title: "Shoose your action", message:"") {
                let vc=SubmitReviewVC.instantiate()
                 vc.status = "Edit"
                 vc.listingId=self.AllList[sender.tag].listing_id ?? 0
                vc.ratingNum=self.AllList[sender.tag].reviews[0].rating  ?? 0
                vc.reviewComment=self.AllList[sender.tag].reviews[0].message ?? ""
                vc.modalPresentationStyle = .overFullScreen
                 self.present(vc, animated: true, completion: nil)
                 
            } action2: {
                self.deleteReview(reviewID: self.AllList[sender.tag].reviews[0].review_id ?? 0, listing_id: self.AllList[sender.tag].listing_id ?? 0)
            }
        case "submitting":
            showActionSheet(title: "Shoose your action", message:"") {
                let vc=SubmitReviewVC.instantiate()
                 vc.status = "Edit"
                 vc.listingId=self.submitting[sender.tag].listing_id ?? 0
                vc.ratingNum=self.submitting[sender.tag].reviews[0].rating  ?? 0
                vc.reviewComment=self.submitting[sender.tag].reviews[0].message ?? ""
                vc.modalPresentationStyle = .overFullScreen
                 self.present(vc, animated: true, completion: nil)
                 
                 
            } action2: {
                self.deleteReview(reviewID: self.submitting[sender.tag].reviews[0].review_id ?? 0, listing_id: self.submitting[sender.tag].listing_id ?? 0)
            }

        case "recieved":
            showActionSheet(title: "Shoose your action", message:"") {
               let vc=SubmitReviewVC.instantiate()
                vc.status = "Edit"
                vc.listingId=self.recieved[sender.tag].listing_id ?? 0
                vc.ratingNum=self.recieved[sender.tag].reviews[0].rating  ?? 0
                vc.reviewComment=self.recieved[sender.tag].reviews[0].message ?? ""
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                
                
            } action2: {
                self.deleteReview(reviewID: self.recieved[sender.tag].reviews[0].review_id ?? 0, listing_id: self.recieved[sender.tag].listing_id ?? 0)
            }
        default:
            print("")
        }
        
    

    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension RecievedReview:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buttonText {
            
        case "AllListing":
            if AllList.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            return AllList.count
            
        case "recieved":
            if recieved.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            return recieved.count
            
        case "submitting":
            if submitting.count == 0 {
                self.emptyView.isHidden = false
            }else {
                self.emptyView.isHidden = true
                
            }
            
            return submitting.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell:ReviewRecievedCell = displayTableView.dequeueReusableCell(for: indexPath)
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self, action: #selector(self.morePressed(_:)), for: .touchUpInside)
        switch buttonText {
            
        case "AllListing":
            cell.configureReview(item: AllList[indexPath.row])
            return cell
            
        case "published":
            cell.configureReview(item: recieved[indexPath.row])
            return cell
            
            
        case "pending":
            cell.configureReview(item: submitting[indexPath.row])
            return cell
            
            
        default:
            return cell
        }
        
        return cell
    }

}
extension RecievedReview:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension RecievedReview {
    func getMyReview(){

        self.AllList=[]
        self.recieved=[]
        self.submitting=[]
//        self.showActivityIndicator()
        ListingManager.shared.getMyReviews { response in
            
            switch response{
                
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        guard let  responsedata = response.data else {return}
                        self.recieved=responsedata.Received ?? []
                        self.submitting=responsedata.Submitted ?? []
                        self.AllList.append(contentsOf:  self.recieved)
                        self.AllList.append(contentsOf:  self.submitting)
                        self.displayTableView.reloadData()
                    } catch let error {
                        
                    }
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
//        self.hideActivityIndicator()
        
    }
    
    
    
    func deleteReview(reviewID:Int,listing_id:Int){
        ListingManager.shared.deleteReview(listing_id:listing_id , review_id: reviewID) { response in
            switch response{
                
            case let .success(response):
                if response.statusCode == 200{
                    
                    self.showAlert(title: "Success", message: response.statusMessage)
                    self.getMyReview()
                }
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
    }
    

    
    
    
}
