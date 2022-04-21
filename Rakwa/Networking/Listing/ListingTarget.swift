//
//  ListingTarget.swift
//  Rakwa
//
//  Created by macbook on 10/31/21.
//

import Foundation
import Moya

enum ListingTarget:TargetType{

    
    
    case getListingDetails(listing_id:Int)
    case latest3Listing
    case listingTemplate
    case getlistingLevel
    case myListing
    case myPublished
    case blueprint(templateID:Int)
    
    
    
    // review
    
    case addReview(listing_id:Int,comment:String,rating:Int)
    case deleteReview(listing_id:Int,review_id:Int)
    case getMyReviews
    case getListingReview(listing_id:Int)
    case EditReview(listing_id:Int,comment:String,rating:Int)
    
    
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)/home")!
    }
    
    
    var path: String {
        switch self {
            
        case .getListingDetails: return "listing"

        case .latest3Listing:return "listings"
            
        case .listingTemplate:return "listing/tamplates"
            
        case .getlistingLevel:return "listing/levels"
            
        case .addReview:return "listing-review"
            
        case .deleteReview:return "listing-review"
            
        case .getMyReviews:return "my-reviews"
            
        case .getListingReview:return "listing-review"
            
        case .EditReview:return "listing-review"
            
        case .myListing:return "listings/my-collection"
            
        case .myPublished:return "listings/my-collection/published"
        case .blueprint:return "listing/blueprint"
            
        }
    }
    
    
    
    
    var method: Moya.Method {
        switch self{
            
        case .getListingDetails,.latest3Listing,.listingTemplate,.getlistingLevel,.getMyReviews,.getListingReview,.myListing,.myPublished,.blueprint:
            return .get

  
        case .addReview:
           return .post
        case .deleteReview:
            return .delete
        case .EditReview:
            return .put
        }
    }
    
    
    var task: Task{
        switch self{
        case .latest3Listing,.listingTemplate,.getlistingLevel,.getMyReviews,.myListing,.myPublished:
            return .requestPlain
      
        
        case .getListingDetails,.deleteReview,.getListingReview,.blueprint:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .addReview,.EditReview:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
            
            
        }
    }
    
    
    var headers: [String : String]?{
        switch self{
   
        case .addReview,.deleteReview,.getMyReviews,.EditReview,.myListing,.myPublished:
            do {
                let token = try KeychainWrapper.get(key: AppData.email) ?? ""
                return ["token":token ,"Accept":"application/json"]
            }
            catch{
                return ["Accept":"application/json"]
            }
      
        default:return ["Accept":"application/json"]
        }
        
        
    }
    
    var param: [String : Any]{
        
        
        switch self {
        
  

        case .deleteReview(let listing_id, let review_id):
            return ["listing_id":listing_id,"review_id":review_id]
            
        case .addReview(let listing_id,let comment, let rating),.EditReview(let listing_id,let comment, let rating):
            return ["listing_id":listing_id,"comment":comment,"rating":rating]
            
        case .getListingDetails(let listing_id),.getListingReview(let listing_id):
            return ["listing_id":listing_id]
            
        case .blueprint(let templateID):
            return ["template_id":templateID]
        default : return [:]
        }
        
        
    }

    
}
