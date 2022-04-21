//
//  AuthTarget.swift
//  Rakwa
//
//  Created by moumen isawe on 26/10/2021.
//

import Foundation
import Moya





enum AuthApiTarget:TargetType{
    case login(email:String,password:String )
    case logout
    case register(firstName:String,lastName:String,email:String,password:String,terms:String)
    case updatePassword(oldPassword:String,newPassword:String)
    case forgetPassword(email:String)
    
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)/Auth")!
    }
    
    
    var path: String {
        switch self {
        case .login:return "Login"
        case .logout:return "Logout"
        case .register:return "register"
        

        case .updatePassword: return "Update_password"
        case .forgetPassword:return "forget_password"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .login,.logout,.register,.forgetPassword :
            // change this later
            return Method.post
          
        case .updatePassword:
            return .put
        
        }
    }
    
    var task: Task{
        switch self{
        case .logout :
            return .requestPlain
      
        
        case .register,.forgetPassword,.login,.updatePassword:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)

            
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .logout,.updatePassword:
            
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
        case .register(let firstName,let  lastName, let email, let password,let  terms):
            return ["firstname":firstName,
                    "lastname":lastName,
                    "email":email,
                    "password":password,
                    "terms":terms]
        case .login(let email, let password):
            return ["username":email,"password":password]
        case .updatePassword(let oldPassword, let newPassword):
            return ["old_password":oldPassword,"new_password":newPassword]
        case .forgetPassword(let email):
            return ["email":email]
        
            
        default : return [:]
        }
       
        
    }
}
