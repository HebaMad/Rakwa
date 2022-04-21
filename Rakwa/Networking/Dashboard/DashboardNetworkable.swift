//
//  DashboardNetworkable.swift
//  Rakwa
//  Created by macbook on 11/4/21.
//

import Foundation
import Moya

protocol DashboardNetworkable:Networkable{
    
    func createdClassified(stateId:Int,listingId:Int,title: String, data: Data, category: String, description: String, latitude: String, longitude: String,city_id:Int,address:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func updateClassified(stateId:Int,listingId:Int,classifiedId:Int,title:String,image:Data,category:String,description:String,latitude:String,longitude:String,city_id:Int,address:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func myClassified(completion: @escaping (Result<BaseResponse<[ClassifiedData]>, Error>) -> ())
    func getAllClassified(lat:String,long:String,completion: @escaping (Result<BaseResponse<[ClassifiedData]>, Error>) -> ())
    func deleteClassified(classified_id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func classifiedDetails(classifiedId:Int,completion: @escaping (Result<BaseResponse<ClassifiedDetails>, Error>) -> ())
    
    func coupoun(completion: @escaping (Result<BaseResponse<[copouns]>, Error>) -> ())
    func Addcoupoun(listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func updatecoupoun(copounId:Int,listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func deleteCopoun(copounid:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    
    func Event(lat:String,longtitude:String,completion: @escaping (Result<BaseResponse<[eventData]>, Error>) -> ())
    func deleteEvent(id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    func myEvent(completion: @escaping (Result<BaseResponse<MyEvents>, Error>) -> ())
    func createEvent(listingId:Int,name:String,startDate:String,endDates:String,startTime:String,endTime:String,description:String,image:Data,address:String,lat:String,lon:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
        
    func updateEvent(id:Int,listingId:Int,name:String,startDate:String,endDates:String,startTime:String,endTime:String,description:String,image:Data,address:String,lat:String,lon:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    
    func city(state:Int,completion: @escaping (Result<BaseResponse<[city]>, Error>) -> ())
    func statistic(completion: @escaping (Result<BaseResponse<statisticData>, Error>) -> ())
  
    func state(completion: @escaping (Result<BaseResponse<[city]>, Error>) -> ())
func participate(event_id:Int,participation:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())



}

final class DashboardManager:DashboardNetworkable{

    

    var provider =  MoyaProvider<DashboardTarget>(plugins: [NetworkLoggerPlugin()])
    
    public static var shared: DashboardManager = {
        let instance = DashboardManager()
        return instance
    }()
    
    typealias targetType = DashboardTarget
    func participate(event_id: Int, participation: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .participate(event_id: event_id, participation: participation), completion: completion)
    }
    
    func updateEvent(id:Int,listingId: Int, name: String, startDate: String, endDates: String, startTime: String, endTime: String, description: String, image: Data, address: String, lat: String, lon: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateEvent(id:id,listingId: listingId, name: name, startDate: startDate, endDates: endDates, startTime: startTime, endTime: endTime, description: description, image: image, address: address, lat: lat, lon: lon), completion: completion)
    }
    func createEvent(listingId: Int, name: String, startDate: String, endDates: String, startTime: String, endTime: String, description: String, image: Data, address: String, lat: String, lon: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .createEvent(listingId: listingId, name: name, startDate: startDate, endDates: endDates, startTime: startTime, endTime: endTime, description: description, image: image, address: address, lat: lat, lon: lon), completion: completion)
    }
    func Addcoupoun(listing_id: Int, coupon_title: String, coupon_code: String, discount_value: Int, coupon_start: String, coupon_end: String, coupon_description: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .createCopoun(listing_id: listing_id, coupon_title: coupon_title, coupon_code: coupon_code, discount_value: discount_value, coupon_start: coupon_start, coupon_end: coupon_end, coupon_description: coupon_description), completion: completion)
    }
    func updatecoupoun(copounId: Int, listing_id: Int, coupon_title: String, coupon_code: String, discount_value: Int, coupon_start: String, coupon_end: String, coupon_description: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateCopoun(coupon_id: copounId, listing_id: listing_id, coupon_title: coupon_title, coupon_code: coupon_code, discount_value: discount_value, coupon_start: coupon_start, coupon_end: coupon_end, coupon_description: coupon_description), completion: completion)
    }
    
    func city(state: Int, completion: @escaping (Result<BaseResponse<[city]>, Error>) -> ()) {
        request(target: .city(state: state), completion: completion)
    }
    
    func deleteCopoun(copounid: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteCopoun(coupon_id: copounid), completion: completion)
    }
    
    
    
    func statistic(completion: @escaping (Result<BaseResponse<statisticData>, Error>) -> ()) {
        request(target: .statistic, completion: completion)

    }
    
    func Event(lat:String,longtitude:String,completion: @escaping (Result<BaseResponse<[eventData]>, Error>) -> ()) {
        request(target: .Allevent(lat: lat, long: longtitude), completion: completion)

    }
    
    func myEvent(completion: @escaping (Result<BaseResponse<MyEvents>, Error>) -> ()) {
        request(target: .myEvent, completion: completion)

    }
    func deleteEvent(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteEvent(id: id), completion: completion)

    }


    func coupoun(completion: @escaping (Result<BaseResponse<[copouns]>, Error>) -> ()) {
        request(target: .copoun, completion: completion)

    }


    func createdClassified(stateId:Int,listingId:Int,title: String, data: Data, category: String, description: String, latitude: String, longitude: String,city_id:Int,address:String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .createdClassified(stateId:stateId,listingId:listingId,title: title, data: data, category: category, description: description, latitude: latitude, longitude: longitude,city_id:city_id,address:address), completion: completion)
    }
    

    func updateClassified(stateId:Int,listingId:Int,classifiedId:Int,title: String, image: Data, category: String, description: String, latitude: String, longitude: String,city_id:Int,address:String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateClassified(stateId:stateId,listingId:listingId,classifiedId:classifiedId,title: title, image: image, category: category, description: description, latitude: latitude, longitude: longitude,city_id:city_id,address:address), completion: completion)
    }
    
    func myClassified(completion: @escaping (Result<BaseResponse<[ClassifiedData]>, Error>) -> ()) {
        request(target: .myClassified, completion: completion)
    }
    
    func getAllClassified(lat:String,long:String,completion: @escaping (Result<BaseResponse<[ClassifiedData]>, Error>) -> ()) {
        request(target: .getAllClassified(lat: lat, long: long), completion: completion)
    }
    
    func deleteClassified(classified_id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteClassified(classified_id: classified_id), completion: completion)
    }
    
    func classifiedDetails(classifiedId: Int, completion: @escaping (Result<BaseResponse<ClassifiedDetails>, Error>) -> ()) {
        request(target: .classifiedDetails(id: classifiedId), completion: completion)
    }
    func state(completion: @escaping (Result<BaseResponse<[city]>, Error>) -> ()) {
        request(target: .state, completion: completion)
    }
    
    

}
