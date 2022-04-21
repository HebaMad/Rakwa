//
//  AuthNetworkable.swift
//  Rakwa
//
//  Created by moumen isawe on 26/10/2021.
//

import Foundation
import Moya
#warning("an example")
protocol AuthNetworkable:Networkable  {
    
    func login(email: String, password: String , completion: @escaping (Result<BaseResponse<User>, Error>) -> ())
    
    func logout( completion:  @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func register(firstName:String,lastName:String,email:String,password:String,terms:String ,completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func updatePassword(oldPassword:String,newPassword:String,completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    func forgetPassword(email:String,completion: @escaping (Result<BaseResponse<Empty>, Error>)-> ())
    
   
}


 class AuthManager:AuthNetworkable{


    var provider: MoyaProvider<AuthApiTarget> = MoyaProvider<AuthApiTarget>(plugins: [NetworkLoggerPlugin()])
    public static var shared: AuthManager = {
        let generalActions = AuthManager()
        return generalActions
    }()
    typealias targetType = AuthApiTarget

    
    func login(email: String, password: String, completion: @escaping (Result<BaseResponse<User>, Error>) -> ()) {
     
        request(target: .login(email: email, password: password), completion: completion)
    }
    func logout(completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .logout, completion: completion)
    }
    
    func register(firstName: String, lastName: String, email: String, password: String, terms: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .register(firstName: firstName, lastName: lastName, email: email, password: password, terms: terms ), completion: completion)
    }
    
    func updatePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updatePassword(oldPassword: oldPassword, newPassword: newPassword), completion: completion)
    }
    
    func forgetPassword(email: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .forgetPassword(email: email), completion: completion)
    }
    
    
    
}


