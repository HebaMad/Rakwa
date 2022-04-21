//
//  ListingNetworkable.swift
//  Rakwa
//
//  Created by macbook on 10/31/21.
//

import Foundation
import Moya

protocol ListingNetworkable:Networkable{
    func addReview(listing_id:Int,comment:String,rating:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func EditReview(listing_id:Int,comment:String,rating:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func getListingDetails(listing_id:Int,completion: @escaping (Result<BaseResponse<ListingDetails>, Error>) -> ())
    func latest3Listing(completion: @escaping (Result<BaseResponse<Latest3Listing>, Error>) -> ())
    func getMyReviews(completion: @escaping (Result<BaseResponse<MyReviews>, Error>) -> ())
    func listingTemplate(completion: @escaping (Result<BaseResponse<[templateData]>, Error>) -> ())
    func getlistingLevel(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func deleteReview(listing_id:Int,review_id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func getListingReview(listing_id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    
    func getListingTemplates( completion: @escaping (Result<BaseResponse<[ListingTemplate]>, Error>) -> ())
    func getListingBlueprint(templateId:Int, completion: @escaping (Result<Blueprint, Error>) -> ())
    func myListing(completion: @escaping (Result<BaseResponse<myListingData>, Error>) -> ())
    func myPublished(completion: @escaping (Result<BaseResponse<[Category]>, Error>) -> ())

    
}
final class ListingManager:ListingNetworkable{

    
  
    
    
    var provider =  MoyaProvider<ListingTarget>(plugins: [NetworkLoggerPlugin()])
    
    
    typealias targetType = ListingTarget
    public static var shared: ListingManager = {
        let instance = ListingManager()
        return instance
    }()
    func getListingBlueprint(templateId: Int, completion: @escaping (Result<Blueprint, Error>) -> ()) {
        request(target: .blueprint(templateID: templateId), completion: completion)
    }
    
    func myPublished(completion: @escaping (Result<BaseResponse<[Category]>, Error>) -> ()) {
        request(target: .myPublished, completion: completion)
    }
    
    func addReview(listing_id: Int, comment: String, rating: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .addReview(listing_id: listing_id, comment: comment, rating: rating), completion: completion)
        
    }
    func myListing(completion: @escaping (Result<BaseResponse<myListingData>, Error>) -> ()) {
        request(target: .myListing, completion: completion)
    }
    func EditReview(listing_id: Int, comment: String, rating: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .EditReview(listing_id: listing_id, comment: comment, rating: rating), completion: completion)
    }
    
    
    func getListingTemplates(  completion: @escaping (Result<BaseResponse<[ListingTemplate]>, Error>) -> ()) {
        request(target: .listingTemplate, completion: completion)
    }
    
    func getListingDetails(listing_id: Int, completion: @escaping (Result<BaseResponse<ListingDetails>, Error>) -> ()) {
        request(target: .getListingDetails(listing_id: listing_id), completion: completion)
    }
    
    func latest3Listing(completion: @escaping (Result<BaseResponse<Latest3Listing>, Error>) -> ()) {
        request(target: .latest3Listing, completion: completion)
    }
    
    func getMyReviews(completion: @escaping (Result<BaseResponse<MyReviews>, Error>) -> ()) {
        request(target: .getMyReviews, completion: completion)
        
    }
    
    func listingTemplate(completion: @escaping (Result<BaseResponse<[templateData]>, Error>) -> ()) {
        request(target: .listingTemplate, completion: completion)
        
    }
    
    func getlistingLevel(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getlistingLevel, completion: completion)
        
    }
    
    func deleteReview(listing_id: Int, review_id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteReview(listing_id: listing_id, review_id: review_id), completion: completion)
    }
    
    func getListingReview(listing_id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getListingReview(listing_id: listing_id), completion: completion)
        
    }
      
    
}
