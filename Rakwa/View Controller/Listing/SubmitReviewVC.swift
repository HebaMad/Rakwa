//
//  SubmitReviewVC.swift
//  Rakwa
//
//  Created by macbook on 10/12/21.
//

import UIKit

class SubmitReviewVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var reviewRatingBar: RatingControl!
    @IBOutlet weak var submitBtn: UIButton!
    var status="Submit"
    var listingId=0
    var ratingNum=0
    var reviewComment=""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if status == "Edit"{
            submitBtn.setTitle("Edit", for: .normal)
            titleLabel.text="Edit Review"
            commentTxt.text=reviewComment
            reviewRatingBar.rating=ratingNum
        }else{
            submitBtn.setTitle("Submit", for: .normal)
            titleLabel.text="Submit Review"
        }
    }
    
    @IBAction func submitRatingBtn(_ sender: Any) {
        
        if commentTxt.text != nil{
            
        if status == "Edit"{
        editReview(listingId: listingId, comment: commentTxt.text, rating: reviewRatingBar.rating)
        }else{
            
        }
        }else{
            self.showAlert(title: "Notice", message: "You should add your comment")
        }
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }

}

extension SubmitReviewVC:Storyboarded{
    static var storyboardName: StoryboardName = .Listing
}
extension SubmitReviewVC{
    
    func editReview(listingId:Int,comment:String,rating:Int){
        ListingManager.shared.EditReview(listing_id: listingId, comment:comment, rating: rating) { response in
            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                    do {
                        self.showAlert(title: "Success", message: response.statusMessage )
                        self.dismiss(animated: true, completion: nil)

                    } catch let error {
                        self.showAlert(title: "Error", message: response.errors?[0].message ?? "")
                        
                    }
                }
                
            case let .failure(error):
                
                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                    
                }
            }
        }
        
    }
    
    
}
