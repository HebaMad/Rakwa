//
//  ProfileTarget.swift
//  Rakwa
//
//  Created by heba isaa on 18/11/2021.
//

import Foundation
import Moya

enum ProfileTarget : TargetType {
    
    
    
    
    case contact(firstname:String,lastname:String,email:String,message:String,phone:String)
    
    
    var baseURL: URL{
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)")!

    }
    
    var path: String{
        switch self {
        case .contact:return "ContactUs"

            
        }
        
    }
    
    var method: Moya.Method {
        switch self{

        case .contact:
            return .post
        }
    }
    
    
    var task: Task{
        switch self{
        case .contact:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
            
        }
    }
    
    
    var headers: [String : String]?{
        switch self{
        
        case .contact:
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
        case .contact(let firstname,let lastname,let email,let message,let phone):
            return ["firstname":firstname,"lastname":lastname,"email":email,"message":message,"phone":phone]
        default : return [:]

        }
}
}
