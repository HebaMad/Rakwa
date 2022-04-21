//
//  ListingEventCell.swift
//  Rakwa
//
//  Created by macbook on 9/18/21.
//

import UIKit
import SDWebImage
class ListingEventCell: UITableViewCell,ReusableView,NibLoadableView {
var myListing=false
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
   
    @IBOutlet weak var FullDate: UILabel!
    
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var num: UIViewDesignable!
    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var img4: RoundedImageView!
    @IBOutlet weak var img3: RoundedImageView!
    @IBOutlet weak var img2: RoundedImageView!
    @IBOutlet weak var img1: RoundedImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var endDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureEvent(event:eventData){
        FullDate.text = convertDateFormaterName(event.startDate?.date ?? "").1
        monthName.text = convertDateFormaterName(event.startDate?.date ?? "").0
        eventTitle.text=event.title ?? ""
        endDate.text=convertDateFormater(event.endDate?.date ?? "")
        startDate.text=convertDateFormater(event.startDate?.date ?? "")
        startTime.text=convertTimeformat(event.startTime?.date ?? "")
        endTime.text=convertTimeformat(event.endTime?.date ?? "")
        location.text=event.address
        status.text=event.status
        backgroundImg.sd_setImage(with: URL(string: event.image ?? ""))
        if myListing == false{
            
       
            if event.isParticipant == 1{
            goingBtn.setTitle("Going", for: .normal)

        }else{
            goingBtn.setTitle("I'm Going", for: .normal)

        }
        } else{
                
            }
        if event.participants != nil{
     
            if event.participants?.users?.count == 1{
                img1.isHidden=false
                img2.isHidden=true
                img3.isHidden=true
                img4.isHidden=true
                num.isHidden=true
                img1.sd_setImage(with: URL(string: event.participants?.users?[0].image ?? ""))

            }else if event.participants?.count == 2{
                img1.isHidden=false
                img2.isHidden=false
                img3.isHidden=true
                img4.isHidden=true
                num.isHidden=true
                img1.sd_setImage(with: URL(string: event.participants?.users?[0].image ?? ""))
                img2.sd_setImage(with: URL(string: event.participants?.users?[1].image ?? ""))
            }else if event.participants?.count == 3{
                img1.isHidden=false
                img2.isHidden=false
                img3.isHidden=false
                img4.isHidden=true
                num.isHidden=true
                img1.sd_setImage(with: URL(string: event.participants?.users?[0].image ?? ""))
                img2.sd_setImage(with: URL(string: event.participants?.users?[1].image ?? ""))
                img3.sd_setImage(with: URL(string: event.participants?.users?[2].image ?? ""))
            }else if event.participants?.count == 4{
                img1.isHidden=false
                img2.isHidden=false
                img3.isHidden=false
                img4.isHidden=false
                num.isHidden=true

                img1.sd_setImage(with: URL(string: event.participants?.users?[0].image ?? ""))
                img2.sd_setImage(with: URL(string: event.participants?.users?[1].image ?? ""))
                img3.sd_setImage(with: URL(string: event.participants?.users?[2].image ?? ""))
                img4.sd_setImage(with: URL(string: event.participants?.users?[3].image ?? ""))
            }else{
                img1.isHidden=false
                img2.isHidden=false
                img3.isHidden=false
                img4.isHidden=false
                img1.sd_setImage(with: URL(string: event.participants?.users?[0].image ?? ""))
                img2.sd_setImage(with: URL(string: event.participants?.users?[1].image ?? ""))
                img3.sd_setImage(with: URL(string: event.participants?.users?[2].image ?? ""))
                img4.sd_setImage(with: URL(string: event.participants?.users?[3].image ?? ""))
                num.isHidden=false
                labelNum.text="\(event.participants?.users?.count)"
            }
 
        }else{
            img1.isHidden=true
            img2.isHidden=true
            img3.isHidden=true
            img4.isHidden=true
            num.isHidden=true
            labelNum.isHidden=true

        }
        
    }
    
}
