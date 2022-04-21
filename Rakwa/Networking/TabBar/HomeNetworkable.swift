//
//  HomeNetworkable.swift
//  Rakwa
//  Created by macbook on 11/8/21.


import Foundation
import Moya

protocol HomeNetworkable:Networkable  {
    func discover(page:Int, completion:  @escaping (Result<BaseResponse<DiscoverData?>, Error>)-> ())
    func home(level_id:Int,lat:String,long:String, completion:  @escaping (Result<BaseResponse<HomeData>, Error>)-> ())
    func profile(completion:  @escaping (Result<BaseResponse<profileInfo?>, Error>)-> ())
    func createFavourite(listingId:Int,completion:  @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func deleteFavourite(listingId:Int,completion:  @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func AllFavourite(completion:  @escaping (Result<BaseResponse<[favData]>, Error>)-> ())
    func categories(lat:String,long:String,completion:  @escaping (Result<BaseResponse<[categoriesData]>, Error>)-> ())
    func editProfile(firstname:String,lastname:String,phone:String,email:String,image:Data,cityID:Int,state:Int,address:String,completion:  @escaping (Result<BaseResponse<Empty>, Error>)-> ())
func filter(sort_by:Int,keyword:String,module:String,category:Int,lat:String,lon:String,is_open:Int,rate:Int,page:Int,completion:  @escaping (Result<BaseResponse<FilterData>, Error>)-> ())

    func AllCategories(module:String,completion:  @escaping (Result<BaseResponse<[TopCategory]>, Error>)-> ())
}
class HomeManager:HomeNetworkable{
  
 
    



   var provider: MoyaProvider<HomeTarget> = MoyaProvider<HomeTarget>(plugins: [NetworkLoggerPlugin()])
   public static var shared: HomeManager = {
       let generalActions = HomeManager()
       return generalActions
   }()
   typealias targetType = HomeTarget
    
func AllCategories(module: String, completion: @escaping (Result<BaseResponse<[TopCategory]>, Error>) -> ()) {
        request(target: .categories(module: module), completion: completion)
    }
    
    func editProfile(firstname: String, lastname: String, phone: String, email: String, image: Data, cityID: Int, state: Int, address: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .editProfile(firstname: firstname, lastname: lastname, phone: phone, email: email, image: image, cityID: cityID, state: state, address: address), completion: completion)
    }
    func categories(lat: String, long: String, completion: @escaping (Result<BaseResponse<[categoriesData]>, Error>) -> ()) {
        request(target: .categoriesTop(lat: lat, lon: long), completion: completion)
    }
    
    func discover(page: Int, completion: @escaping (Result<BaseResponse<DiscoverData?>, Error>) -> ()) {
        request(target: .Discover(page: page), completion: completion)

    }
    func home(level_id: Int, lat: String, long: String, completion: @escaping (Result<BaseResponse<HomeData>, Error>) -> ()) {
        request(target: .home(level_id: level_id, lat: lat, long: long), completion: completion)
    }
    func profile(completion: @escaping (Result<BaseResponse<profileInfo?>, Error>) -> ()) {
        request(target: .getProfile, completion: completion)
    }
    func createFavourite(listingId: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .createFavourite(listingId: listingId), completion: completion)
    }
    func deleteFavourite(listingId: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteFav(listingId: listingId), completion: completion)
    }
    
    func AllFavourite(completion: @escaping (Result<BaseResponse<[favData]>, Error>) -> ()) {
        request(target: .AllFavourite, completion: completion)
    }
    
    func filter(sort_by: Int, keyword: String, module: String, category: Int, lat: String, lon: String, is_open: Int, rate: Int, page: Int, completion: @escaping (Result<BaseResponse<FilterData>, Error>) -> ()) {
        request(target: .filter(sort_by: sort_by, keyword: keyword, module: module, category: category, lat: lat, lon: lon, is_open: is_open, rate: rate, page: page), completion: completion)
    }
    
    

}
