//
//  HomeTarget.swift
//  Rakwa
//
//  Created by macbook on 11/2/21.
//

import Foundation
import Moya

enum HomeTarget:TargetType{

    
    case Discover(page:Int)
    case categoriesTop(lat:String,lon:String)
    case home(level_id:Int,lat:String,long:String )
    case getProfile
    case createFavourite(listingId:Int)
    case deleteFav(listingId:Int)
    case AllFavourite
    case editProfile(firstname:String,lastname:String,phone:String,email:String,image:Data,cityID:Int,state:Int,address:String)
    case categories(module:String)
    
    case filter(sort_by:Int,keyword:String,module:String,category:Int,lat:String,lon:String,is_open:Int,rate:Int,page:Int)
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)/home")!
    }
    
    
    
    
    var path: String {
        switch self {
            
        case .Discover: return "Discover"


            
        case .categoriesTop:return "categories/top"
            
        case .home:return ""
            
        case .getProfile,.editProfile:return "user/profile"
            
        case .createFavourite,.deleteFav,.AllFavourite:return "reaction/favorite"
            
            
        case .categories:return "categories"
            
        case .filter:return "search/filter"
        }
    }

    
    var method: Moya.Method {
        switch self{
            
        case .Discover,.categoriesTop,.home,.getProfile,.AllFavourite,.categories,.filter:
            return .get
        case .createFavourite:
            return .post
        case .deleteFav:
            return .delete
        case .editProfile:
            return .put
        }
    }
    
    
    var task: Task{
        switch self{
        case .getProfile,.AllFavourite:
            return .requestPlain
  
        case .Discover,.categoriesTop,.home,.createFavourite,.deleteFav,.categories,.filter:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            

            
            
        case .editProfile(let firstname,let lastname,let phone,let email, let image, let cityID, let state,let address):
      
         let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
           let firstname = MultipartFormData(provider: .data(firstname.data(using: .utf8)!), name: "firstname")
            let lastname = MultipartFormData(provider: .data(lastname.data(using: .utf8)!), name: "lastname")
            let email = MultipartFormData(provider: .data(email.data(using: .utf8)!), name: "email")
            let phone = MultipartFormData(provider: .data(phone.data(using: .utf8)!), name: "phone")
            let address = MultipartFormData(provider: .data(address.data(using: .utf8)!), name: "address")
            let state = MultipartFormData(provider: .data("\(state)".data(using: .utf8)!), name: "state")
            let cityID = MultipartFormData(provider: .data("\(cityID)".data(using: .utf8)!), name: "city")

            let multipartData = [firstname,lastname,email,phone,pngData,address,cityID,state,pngData]

                      return .uploadMultipart(multipartData)
        }
    }
    
    
    
    var headers: [String : String]?{
        switch self{
   
        case .home,.getProfile,.createFavourite,.deleteFav,.AllFavourite,.editProfile:
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
        case .createFavourite(let listingId),.deleteFav(let listingId):
            return["listing":listingId]
        case .Discover(let page):
            return ["page":page]
            
        case .categoriesTop(let lat,let lon):
            return ["lat":lat,"long":lon]
            
        case .home(let level_id,let lat,let long):
        return ["level_id":level_id,"lat":lat,"long":long]

        case .editProfile(let firstname,let  lastname,let  phone,let  email,let  image,let cityID,let state, let address):
            return["firstname":firstname,"lastname":lastname,"phone":phone,"email":email,"image":image,"city":cityID,"state":state,"address":address]
            
        case .categories(let module):
            
            return ["module":module]
        case .filter(let sort_by,let keyword,let module,let category,let lat,let lon,let is_open,let rate,let page):
            return ["sort_by":sort_by,"keyword":keyword,"module":module,"category":category,"lat":lat,"long":lon,"is_open":is_open,"rate":rate,"page":page]

        default : return [:]
        }
        
        
    }

}
