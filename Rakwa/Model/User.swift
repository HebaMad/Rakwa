//
//  User.swift
//  Rakwa
//
//  Created by moumen isawe on 26/10/2021.
//

import Foundation
import Moya
#warning("I Just create this class with id as example")

struct User:Decodable{
    let id:Int?
    let username, firstname, lastname, email: String?
    let image: String?
    let token: String?
    let activated:Bool?
}



struct signUpResponse:Decodable{
    let id:String?
    let username:String?
}
struct Empty:Decodable{

}
// MARK: - ListingDetails

struct ListingDetails: Decodable {
    let listingID, accountID: Int?
    let title, hoursWork, phone, shortDescription: String?
    let longDescription, longitude, latitude, city: String?
    let image, imageCover: String?
    let friendlyURL, status: String?
    let views: Int?
    let gallery: [String]?
    let isWorkingNow: Int?
    let listingURL: String?
    let rate: Int?
    let video: [String]?
    let isFavorite: Int?
    let badges: String?
    let announcements: [Announcement]?
    let coupon: [String]?
}
struct Announcement: Codable {
    let id:Int?
    let description: String?
    let btn_text: String?
    let btn_link: String?
    let listing_id: String?
    let image: String?

    
}

// MARK: - Latest3Listing

struct Latest3Listing: Decodable {
    let id, accountID: Int?
    let title: String?
    let categories: [Category]?
    let image: String?
    let address: String?
    let phone, datumDescription: String?
    let rating, status: Int?
    let latitude, longitude: String?
    let isLike, isFavorite: Int?
}

struct Category: Codable {
    let id:Int?
    let title: String?

}




// MARK: - AddReview

struct AddReview: Decodable {
    let id: Int
    let comment: String
    let userID: Int
    let userName, userPic: String
    let rating: Int

}

// MARK: - MyReviews

struct MyReviews: Decodable {
    let Received, Submitted: [Received]?


}
struct Received: Codable {
    let listing_id: Int?
    let listing_image: String?
    let reviews: [Review]
}
struct Review: Codable {
    let review_id: Int?
    let reviewer_name: String?
    let reviewer_image: String?
    let message: String?
    let rating, status: Int?
}
// MARK: - ListingReview

struct ListingReview {
    let id: Int
    let comment: String
    let userID: Int
    let userPic: String
    let userName: String
    let rating: Int

}


struct AdCampaign: Codable {
    let id: Int
    let title: String
    let listingID: Int
    let status: String
    let startDate, endDate: EndDateClass
    let levelID: Int
    let image: String
    enum CodingKeys: String, CodingKey {
           case id, title
           case listingID = "listing_id"
           case status
           case startDate = "start_date"
           case endDate = "end_date"
           case levelID = "level_id"
           case image
       }
}


struct EndDateClass: Codable {
    let date: String?
    let timezone_type: Int?
    let timezone: String?
}


struct ClassifiedData: Decodable {
    
    let id,listing_id: Int?
    let title: String?
    let description: String?
    let category:String?
    let image: String?
    let url :String?
    let city:city?
    let state:city?
    let address:String?

    
}
struct ClassifiedDetails: Decodable {
    
    let id: Int?
    let userid:Int?
    let title: String?
    let description: String?
    let category:String?
    let image: String?
    let url :String?
    let location:locationData?
    
}
struct locationData: Codable {
    let latitude: String?
    let longitude: String?
    let address: String?
    let city:String?
    let state:String?
}


struct DiscoverData:Decodable{
    let items:[DiscoverItem]?
    let paging: Paging?

}
struct FilterData:Decodable{
    let items:[Listing]?
    let paging: Paging?

}
struct DiscoverItem:Codable{
    
    let id:Int?
    let accountId:Int?
    let title:String?
    let contactname:String?
    let address:String?
    let phone:String?
    let summarydesc:String?
    let latitude:String?
    let longitude:String?
    let detaildesc:String?
    let image:String?
    let timeData:CreatedAt?
    
}

struct CreatedAt: Codable {
    let date: String
    let timezoneType: Int
    let timezone: String
}
struct Paging: Codable {
    let page, pages, total: Int
}

struct statisticData:Decodable{
    let listings_views:Int
    let listings_count:Int
    let my_reviews_count:Int
    let my_listings_reviews_count:Int

}
struct HomeData :Decodable{
    let user: userData?
    let ads: [Ad]?
    let top_categories: [TopCategory]?
    let ads_campaigns: AdsCampaigns?
    let latest_listings: [LatestListing]?
    
}
struct AdsCampaigns: Codable {
    let Banner: [Banner]?
    let Ads: [AdCampaign]?
}
struct userData: Codable {
    let id: Int?
    let name: String?
    let image: String?

}
struct Banner: Codable {
    let id: Int?
    let title: String?
    let listing_id: Int?
    let status: String?
    let start_date, end_date: EndDateClass?
    let level_id: Int?
    let image: String?
}

struct LatestListing: Codable {
    let id, accountID: Int?
    let title: String?
    let category: Category?
    let image: String?
    let address: String?
    let phone, description: String?
    let rating, status: Int?
    let latitude, longitude: String?
    let isLike, isFavorite: Int?
}
struct Ad: Codable {
    let description: String
    let image: String
}
struct TopCategory: Codable {
    let id: Int?
    let title:String?
    let icon: String?
    let  friendly_url: String?
}



struct myListingData: Decodable {
    let Published, Pending, Expired: [ListingData]?
}


struct ListingData: Codable {
    let id, accountId: Int?
    let title: String?
    let categories: [Category]?
    let image: String?
    let address: String?
    let phone, description: String?
    let rating, is_open: Int?
    let latitude, longitude: String?
    let isFavorite: Int?
    let status: String?
    let views: Int?
    let start_date,end_date: EndDateClass?
    let associated_plan,specialties,established_in,building_bridges,policies,business_owner_name,business_owner_email:String?
    let social_links: SocialLinks?
    
    
}

struct MyEvents:Decodable{
    let Published, Pending: [eventData]?

}
struct SocialLinks: Codable {
    let facebook, instagram, twitter: String?
}

struct templateData: Codable {
    let id: Int?
    let title,status: String?
}
struct city:Decodable{
    
    let id:Int?
    let name:String?
    
    
}
struct copouns:Decodable{
    
    let id:Int?
    let listing_id:String?
    let coupon_title:String?
    let coupon_code:String?
    let discount_value:String?
    let coupon_start:String?
    let coupon_end:String?
    let coupon_description:String?
    let coupon_status:String?

    
}
struct eventData:Codable{
  let eventID, listingID: Int?
  let title, adsDescription: String?
  let image: String?
  let startDate, startTime, endDate, endTime: EndDateClass?
  let internalURL: String?
  let externalURL, location, zipCode: String?
  let latitude, longitude, address, status: String?
  let participants: Participant?
  let socialLinks: SocialLinks
    let isParticipant:Int?
  enum CodingKeys: String, CodingKey {
    case eventID = "event_id"
    case listingID = "listing_id"
    case title
    case adsDescription = "description"
    case image
    case startDate = "start-date"
    case startTime = "start-time"
    case endDate = "end-date"
    case endTime = "end-time"
    case internalURL = "internal-url"
    case externalURL = "external-url"
    case location
    case zipCode = "zip-code"
    case latitude, longitude, address, status, participants
    case socialLinks = "social_links"
      case isParticipant
  }
}
struct Participant: Codable {
    let count: Int?
    let users: [participantData]?
}
struct participantData: Codable {
    let id: Int?
    let image:String?
  
}

struct profileInfo:Decodable{
    
    let id:Int?
    let firstname:String?
    let lastname:String?
    let email:String?
    let phone:String?
    var bio:String?
    var image:String?
    let city,state:city?
    let address:String?
    let activated:Int?
    let social_links:SocialLinks?

    
}

struct favData:Decodable{
    
    let id:Int?
    let account_id:Int?
    let listing:Listing?


}




struct BlueprintElement: Codable {
    let sectionName: String
    let orderNumber: Int
    let fields: [Field]
}

// MARK: - Field
struct Field: Codable {
    let apiKey: String
    let isRequired: Bool
    let label, type: String
    let data: [FieldData]
     

    enum CodingKeys: String, CodingKey {
        case apiKey = "ApiKey"
        case isRequired, label, type, data
         
    }
}

// MARK: - Datum
struct FieldData: Codable {
    let value: String
}

typealias Blueprint = [BlueprintElement]




struct ListingTemplate:Codable{
    let id: Int
    let title: String
}

struct Listing:Codable{
    let id,rating,is_open:Int?
    let description,image,title,address,phone,latitude,longitude:String?
    
    let category:Category?

}

struct profileUserData{
    var firstname:String?
    var lastname:String?
    var email:String?
    var phone:String?


    init( firstname:String,lastname:String,email:String,phone:String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone



    }
    
}

struct userAddress{
    var state:String?
    var city:String?
    var address :String?


    init(state:String,city:String,address:String) {
        self.state = state
        self.city = city
        self.address = address
     



    }
    
}

//struct listingDetails{
//    let listingID, accountID: Int?
//    let title: String?
//    let hoursWork: HoursWork
//    let phone, shortDescription, longDescription, longitude: String?
//    let latitude, city: String?
//    let image: String?
//    let imageCover: [String]?
//    let friendlyURL, status: String?
//    let views: Int?
//    let gallery: [String]?
//    let isWorkingNow: Int?
//    let listingURL: String?
//    let rate: Int?
//    let video: Video
//    let isFavorite: Int
//    let features: [String]
//    let announcements: [Announcement]?
//    let coupon: [copouns]?
//    let socialLinks: SocialLinks?
//    let specialties, establishedIn, buildingBridges, policies: String?
//    let businessOwnerName, businessOwnerEmail: String?
//
//}

struct categoriesData:Decodable{
    
    let id:Int?
    let title:String?
    let icon:String?
}
