//
//  AdsNetworkable.swift
//  Rakwa
//
//  Created by moumen isawe on 29/10/2021.
//

import Foundation
import Moya


protocol AdsNetworkable:Networkable{
func getAllAnnoucements(completion: @escaping (Result<BaseResponse<[Announcement]>, Error>) -> ())
func getAnnoucementDetails(announcement_id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func getAdCampaignsLevels(forType:AdCampaigns,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func getAllAdCampaigns(completion: @escaping (Result<BaseResponse<[AdCampaign]>, Error>) -> ())
func getAllAdCampaignsByLevel(level:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func addNewAnnoucement(item_id:Int,image:Data,btn_text:String ,
                    btn_link:String,description:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func addNewAdCampaigns(title:String,listing_id:Int,days:Int,level:Int,type:AdCampaigns,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func updateAnnoucement( announcement_id:Int,item_id:Int,image:Data,btn_text:String,btn_link:String,description:String,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func updateAdCampaigns(title:String,listing_id:Int,days:Int,level:Int,type:AdCampaigns,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func deleteAnnoucement(announcement_id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
func deleteAdCampaigns(id:Int,completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ())
    
    func myAnnouncement(completion: @escaping (Result<BaseResponse<[Announcement]>, Error>) -> ())


}




final class AdsManager:AdsNetworkable{


    var provider =  MoyaProvider<AdsTarget>(plugins: [NetworkLoggerPlugin()])
    public static var shared: AdsManager = {
        let generalActions = AdsManager()
        return generalActions
    }()
    
    typealias targetType = AdsTarget

    func myAnnouncement(completion: @escaping (Result<BaseResponse<[Announcement]>, Error>) -> ()) {
        request(target: .myAnnouncement, completion: completion)
    }


    func getAllAnnoucements(completion: @escaping (Result<BaseResponse<[Announcement]>, Error>) -> ()) {
        request(target: .getAllAnnoucements, completion: completion)
    }
    
    func getAnnoucementDetails(announcement_id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getAnnoucementDetails(announcement_id: announcement_id), completion: completion)
    }
    
    func getAdCampaignsLevels(forType: AdCampaigns, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getAdCampaignsLevels(forType: forType), completion: completion)
    }
    
    func getAllAdCampaigns(completion: @escaping (Result<BaseResponse<[AdCampaign]>, Error>) -> ()) {
        request(target: .getAllAdCampaigns, completion: completion)
    }
    
    func getAllAdCampaignsByLevel(level: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .getAllAdCampaignsByLevel(level: level), completion: completion)
    }
    
    func addNewAnnoucement( item_id: Int, image: Data, btn_text: String, btn_link: String, description: String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .addNewAnnoucement( item_id: item_id, image: image, btn_text: btn_text, btn_link: btn_link, description: description), completion: completion)

    }
    
    func addNewAdCampaigns(title: String, listing_id: Int, days: Int, level: Int, type: AdCampaigns, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .addNewAdCampaigns(title: title, listing_id: listing_id, days: days, level: level, type: type), completion: completion)
    }
    
    func updateAnnoucement( announcement_id:Int,item_id:Int,image:Data,btn_text:String,btn_link:String,description:String, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateAnnoucement(announcement_id:announcement_id,item_id: item_id, image: image, btn_text: btn_text, btn_link: btn_link, description: description), completion: completion)
    }
    
    func updateAdCampaigns(title: String, listing_id: Int, days: Int, level: Int, type: AdCampaigns, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .updateAdCampaigns(title: title, listing_id: listing_id, days: days, level: level, type: type), completion: completion)
    }
    
    func deleteAnnoucement(announcement_id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteAnnoucement(announcement_id:announcement_id ), completion: completion )
    }
    
    func deleteAdCampaigns(id: Int, completion: @escaping (Result<BaseResponse<Empty>, Error>) -> ()) {
        request(target: .deleteAdCampaigns(id: id), completion: completion)
    }
    
    
    
    
}

