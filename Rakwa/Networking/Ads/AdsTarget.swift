//
//  AdsTarget.swift
//  Rakwa
//
//  Created by moumen isawe on 29/10/2021.
//

import Foundation
import Moya





enum AdsTarget:TargetType{
    case myAnnouncement
    case getAllAnnoucements
    case getAnnoucementDetails(announcement_id:Int)
    case getAdCampaignsLevels(forType:AdCampaigns)
    case getAllAdCampaigns
    case getAllAdCampaignsByLevel(level:Int)
    case addNewAnnoucement(item_id:Int,image:Data,btn_text:String ,
                           btn_link:String,description:String)
    case addNewAdCampaigns(title:String,listing_id:Int,days:Int,level:Int,type:AdCampaigns)
    case updateAnnoucement(announcement_id:Int,item_id:Int,image:Data,btn_text:String,btn_link:String,description:String)
    case updateAdCampaigns(title:String,listing_id:Int,days:Int,level:Int,type:AdCampaigns)
    case deleteAnnoucement(announcement_id:Int)
    case deleteAdCampaigns(id:Int)
  
    var baseURL: URL {
        return URL(string: "\(AppConfig.apiBaseUrl)\(AppConfig.APIVersion)/home")!
    }
    
    
    var path: String {
        switch self {
            
        case .getAllAnnoucements: return "/annoucements/list"
        case .updateAnnoucement,.deleteAnnoucement,.getAnnoucementDetails,.addNewAnnoucement:return "/annoucements"
            
        case .getAdCampaignsLevels:
            return "/ad-campaigns/levels"
        case .getAllAdCampaigns,.addNewAdCampaigns,.updateAdCampaigns,.deleteAdCampaigns:
            return "/ad-campaigns"
        case .getAllAdCampaignsByLevel:
            return "/ad-campaigns/list-by-leve"
   
   
            
        case .myAnnouncement:return "annoucements/my-collection"
            
        }
    }
    
    var method: Moya.Method {
        switch self{
            
            
        case .getAllAnnoucements,.getAnnoucementDetails,.getAdCampaignsLevels,.getAllAdCampaigns,.getAllAdCampaignsByLevel,.myAnnouncement:
            return .get
        case .updateAnnoucement,.updateAdCampaigns:
            return .put
        case .deleteAnnoucement,.deleteAdCampaigns:
            return .delete
        case .addNewAnnoucement,.addNewAdCampaigns:
            return .post
  
        }
    }
    
    var task: Task{
        switch self{
        case .getAllAnnoucements,.getAllAdCampaigns,.myAnnouncement:
            return . requestPlain
        case .deleteAnnoucement,.getAnnoucementDetails,.getAllAdCampaignsByLevel,.getAdCampaignsLevels,.updateAdCampaigns,.deleteAdCampaigns:
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
            
        case .addNewAdCampaigns:
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
            
        case .addNewAnnoucement(let item_id,let image,let btn_text,let  btn_link,let description):
         let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
           let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
         
            let btnLink = MultipartFormData(provider: .data(btn_link.data(using: .utf8)!), name: "btn_link")
            let btnTxt = MultipartFormData(provider: .data(btn_text.data(using: .utf8)!), name: "btn_text")
            let idItem = MultipartFormData(provider: .data("\(item_id)".data(using: .utf8)!), name: "item_id")

            let multipartData = [idItem,pngData,btnTxt,btnLink,description]
                      return .uploadMultipart(multipartData)
            
        case .updateAnnoucement(let announcement_id, let item_id,let image,let btn_text,let  btn_link,let description):
            
            let pngData = MultipartFormData(provider: .data(image), name: "image", fileName: "images", mimeType: "image/png")
              let description = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
            
               let btnLink = MultipartFormData(provider: .data(btn_link.data(using: .utf8)!), name: "btn_link")
               let btnTxt = MultipartFormData(provider: .data(btn_text.data(using: .utf8)!), name: "btn_text")
               let idItem = MultipartFormData(provider: .data("\(item_id)".data(using: .utf8)!), name: "item_id")
            let announcementid = MultipartFormData(provider: .data("\(announcement_id)".data(using: .utf8)!), name: "announcement_id")

               let multipartData = [announcementid,idItem,pngData,btnTxt,btnLink,description]
                         return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]?{
        switch self{
        case .addNewAnnoucement,.updateAnnoucement,.getAnnoucementDetails,.deleteAnnoucement,.deleteAdCampaigns, .addNewAdCampaigns ,.updateAdCampaigns,.getAllAdCampaigns,.myAnnouncement,.addNewAnnoucement,.updateAnnoucement:
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
  
        case .addNewAdCampaigns(let title,let listing_id,let days,let level,let type),.updateAdCampaigns(let title,let listing_id,let days,let level,let type):
            return ["title":title,"listing_id":listing_id,"days":days,"level":level,"type":type.rawValue]
        case .getAllAdCampaignsByLevel(let level):
            return ["level":level]

        case .getAdCampaignsLevels(let forType):
            return ["type":forType.rawValue]
        case .deleteAdCampaigns(let id):
            return ["id":id]
        case .deleteAnnoucement(let announcement_id),.getAnnoucementDetails(let announcement_id):
            return ["announcement_id":announcement_id]
            

        default : return [:]
        }
        
        
    }
}
enum AdCampaigns:Int{
    case Banner = 0
    case Ads = 1
}
