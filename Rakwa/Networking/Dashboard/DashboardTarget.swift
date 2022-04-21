//
//  DashboardTarget.swift
//  Rakwa
//
//  Created by macbook on 11/4/21.
//


import Foundation
import Moya


enum DashboardTarget : TargetType {
    
    case classifiedDetails(id:Int)
    case getAllClassified(lat:String,long:String)
    case deleteClassified(classified_id:Int)
    case myClassified
    case createdClassified(stateId:Int,listingId:Int,title:String,data:Data,category:String,description:String,latitude:String,longitude:String,city_id:Int,address:String)
    case updateClassified(stateId:Int,listingId:Int,classifiedId:Int,title:String,image:Data,category:String,description:String,latitude:String,longitude:String,city_id:Int,address:String)
    case copoun
    
    case createCopoun( listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String)
    
    case updateCopoun(coupon_id:Int,listing_id:Int,coupon_title:String,coupon_code:String,discount_value:Int,coupon_start:String,coupon_end:String,coupon_description:String)
    
    case  deleteCopoun(coupon_id:Int)
    case Allevent(lat:String,long:String)
    case deleteEvent(id:Int)
    case myEvent
    case city(state:Int)
    case state
    case statistic
    case updateEvent(id:Int,listingId:Int,name:String,startDate:String,endDates:String,startTime:String,endTime:String,description:String,image:Data,address:String,lat:String,lon:String)
    case createEvent(listingId:Int,name:String,startDate:String,endDates:String,startTime:String,endTime:String,description:String,image:Data,address:String,lat:String,lon:String)
    
    case participate(event_id:Int,participation:Int)
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)/home/")!
    }
    
    var method: Moya.Method {
        switch self{
        
        case .updateClassified,.updateCopoun:
            return .put
            
        case .getAllClassified,.classifiedDetails,.myClassified,.copoun,.Allevent,.myEvent,.city,.statistic,.state:
            return .get
        case .deleteClassified,.deleteEvent,.deleteCopoun:
            return .delete
        case .createdClassified,.createCopoun,.createEvent,.participate:
            return .post
        case .updateEvent:
            return .put
        }
    }
    
    var task: Task{
        switch self{
        case .myClassified,.copoun,.myEvent,.statistic,.state:
            return .requestPlain
            
        case .classifiedDetails,.deleteClassified,.deleteEvent,.deleteCopoun,.city,.Allevent,.getAllClassified:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .createCopoun,.updateCopoun,.participate:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
            
           
        case .createdClassified(let stateId,let listingId,let title,let data,let category,let description,let latitude,let longitude,let cityid,let address):
         let pngData = MultipartFormData(provider: .data(data), name: "image", fileName: "images", mimeType: "image/png")
           let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
            let title = MultipartFormData(provider: .data(title.data(using: .utf8)!), name: "title")
            let category = MultipartFormData(provider: .data(category.data(using: .utf8)!), name: "category")
            let latitude = MultipartFormData(provider: .data(latitude.data(using: .utf8)!), name: "latitude")
            let longitude = MultipartFormData(provider: .data(longitude.data(using: .utf8)!), name: "longitude")
            let address = MultipartFormData(provider: .data(address.data(using: .utf8)!), name: "address")
            let cityid = MultipartFormData(provider: .data("\(cityid)".data(using: .utf8)!), name: "city_id")
            let stateid = MultipartFormData(provider: .data("\(stateId)".data(using: .utf8)!), name: "state_id")
            let listingid = MultipartFormData(provider: .data("\(listingId)".data(using: .utf8)!), name: "listing_id")

            let multipartData = [pngData, description,title,category,latitude,longitude,address,cityid,stateid,listingid]

                      return .uploadMultipart(multipartData)
            
        case .updateClassified(let stateId,let listingId,let classifiedId,let title,let image,let category,let description,let latitude,let longitude,let cityid,let address):
            
            
            let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
              let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
               let title = MultipartFormData(provider: .data(title.data(using: .utf8)!), name: "title")
               let category = MultipartFormData(provider: .data(category.data(using: .utf8)!), name: "category")
               let latitude = MultipartFormData(provider: .data(latitude.data(using: .utf8)!), name: "latitude")
               let longitude = MultipartFormData(provider: .data(longitude.data(using: .utf8)!), name: "longitude")
               let address = MultipartFormData(provider: .data(address.data(using: .utf8)!), name: "address")
               let cityid = MultipartFormData(provider: .data("\(cityid)".data(using: .utf8)!), name: "city_id")
let classifiedId =  MultipartFormData(provider: .data("\(classifiedId)".data(using: .utf8)!), name: "classified_id")
            let stateid = MultipartFormData(provider: .data("\(stateId)".data(using: .utf8)!), name: "state_id")
            let listingid = MultipartFormData(provider: .data("\(listingId)".data(using: .utf8)!), name: "listing_id")

               let multipartData = [classifiedId,pngData, description,title,category,latitude,longitude,address,cityid,stateid,listingid]

                         return .uploadMultipart(multipartData)
  
        case .updateEvent(let id,let listingId,let name,let startDate,let endDates,let startTime,let endTime, let description,  let image,let address,let lat,let lon):
            
            
            let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
              let name = MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "name")
               let startDate = MultipartFormData(provider: .data(startDate.data(using: .utf8)!), name: "start_date")
               let endDates = MultipartFormData(provider: .data(endDates.data(using: .utf8)!), name: "end_date")
               let latitude = MultipartFormData(provider: .data(lat.data(using: .utf8)!), name: "latitude")
            let endTime = MultipartFormData(provider: .data(endTime.data(using: .utf8)!), name: "end_time")
            let startTime = MultipartFormData(provider: .data(startTime.data(using: .utf8)!), name: "start_time")
            let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")

               let longitude = MultipartFormData(provider: .data(lon.data(using: .utf8)!), name: "longitude")
               let address = MultipartFormData(provider: .data(address.data(using: .utf8)!), name: "address")
            let listing_id =  MultipartFormData(provider: .data("\(listingId)".data(using: .utf8)!), name: "listing_id")

            let id =  MultipartFormData(provider: .data("\(id)".data(using: .utf8)!), name: "id")

            let multipartData = [id,listing_id, name,startTime,endTime,startDate,endDates,description,pngData,address,latitude,longitude]

                         return .uploadMultipart(multipartData)
            
        case .createEvent(let listingId,let name,let startDate,let endDates,let startTime,let endTime, let description,  let image,let address,let lat,let lon):
            let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
              let name = MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "name")
               let startDate = MultipartFormData(provider: .data(startDate.data(using: .utf8)!), name: "start_date")
               let endDates = MultipartFormData(provider: .data(endDates.data(using: .utf8)!), name: "end_date")
               let latitude = MultipartFormData(provider: .data(lat.data(using: .utf8)!), name: "latitude")
            let endTime = MultipartFormData(provider: .data(endTime.data(using: .utf8)!), name: "end_time")
            let startTime = MultipartFormData(provider: .data(startTime.data(using: .utf8)!), name: "start_time")
            let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")

               let longitude = MultipartFormData(provider: .data(lon.data(using: .utf8)!), name: "longitude")
               let address = MultipartFormData(provider: .data(address.data(using: .utf8)!), name: "address")
            let listing_id =  MultipartFormData(provider: .data("\(listingId)".data(using: .utf8)!), name: "listing_id")


            let multipartData = [listing_id, name,startTime,endTime,startDate,endDates,description,pngData,address,latitude,longitude]

                         return .uploadMultipart(multipartData)
            
            
        }
    }
    var param: [String : Any]{
        
        
        switch self {
        case .city(let state):
            return ["state":state]

        case .deleteClassified( let classified_id),.classifiedDetails(let classified_id):
        return ["classified_id":classified_id]

        case .deleteEvent(let id):
        return ["id":id]
        case .createCopoun(let listing_id,let coupon_title,let coupon_code,let discount_value,let coupon_start,let coupon_end,let coupon_description):
            return ["listing_id":listing_id,"coupon_title":coupon_title,"coupon_code":coupon_code,"discount_value":discount_value,"coupon_start":coupon_start,"coupon_end":coupon_end,"coupon_description":coupon_description]
            
        case .deleteCopoun(let coupon_id):
            return ["coupon_id":coupon_id]

        case .updateCopoun(let coupon_id,let listing_id,let coupon_title,let coupon_code,let discount_value,let coupon_start,let coupon_end,let coupon_description):
            return ["coupon_id":coupon_id,"listing_id":listing_id,"coupon_title":coupon_title,"coupon_code":coupon_code,"discount_value":discount_value,"coupon_start":coupon_start,"coupon_end":coupon_end,"coupon_description":coupon_description]
            
        case .updateEvent(let id,let listingId,let name,let startDate,let endDates,let startTime,let endTime, let description,  let image,let address,let lat,let lon):
            return ["id":id,"listing_id":listingId,"name":name,"start_date":startDate,"start_time":startTime,"end_date":endDates,"end_time":endTime,"description":description,"image":image,"address":address,"latitude":lat,"longitude":lon]
            
        case .createEvent(let listingId,let name,let startDate,let endDates,let startTime,let endTime, let description,  let image,let address,let lat,let lon):
            return ["listing_id":listingId,"name":name,"start_date":startDate,"start_time":startTime,"end_date":endDates,"end_time":endTime,"description":description,"image":image,"address":address,"latitude":lat,"longitude":lon]
        case .Allevent(let lat,let long):
            return ["lat":lat,"long":long]
            
        case .participate(let event_id,let participation):
            return ["event_id":event_id,"participation":participation]
            
        case .getAllClassified(let lat,let long):
            return ["latitude":lat,"longitude":long]
        default : return [:]
        }
        
        
    }
    
    var headers: [String : String]?{
        switch self{
        
        case .deleteClassified,.myClassified,.createdClassified,.updateClassified,.copoun,.deleteEvent,.myEvent,.statistic,.createCopoun,.deleteCopoun,.updateCopoun,.state,.updateEvent,.createEvent,.Allevent,.participate:
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
    
    
    


    
    var path: String {
        switch self {
        
        case .getAllClassified:return "classified/list"
            
        case .classifiedDetails,.createdClassified,.updateClassified: return "classified"
            
        case .deleteClassified: return "classified"
            
        case .myClassified:return "classified/my-list"
            
        case .copoun,.createCopoun,.deleteCopoun,.updateCopoun:return "coupons"
            
        case .Allevent:return "events"
            
        case .deleteEvent,.updateEvent,.createEvent:return "event"
            
        case .myEvent:return "events/my-collection"
            
        case .city:return "location-city"
            
        case .statistic:return "user/statistics"
            
            
        case .state:return "location-state"
            
            
        case .participate:return "event/participate"
            
        }
        
        
        

 
}
}
