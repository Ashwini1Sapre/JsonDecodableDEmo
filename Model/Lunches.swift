//
//  Lunches.swift
//  JsonDecodableDEmo
//
//  Created by Knoxpo MacBook Pro on 05/04/21.
//

import Foundation
import SwiftUI
struct Launch: Identifiable {
    let id: Int
    let missionName: String
    let timeline: Timeline?
    let date: Date
    let succeeded: Bool
    let rocket: String
    let site: String
    let patchURL: URL
    let payloads: String
    var patch: UIImage?
    
}

extension Launch: Decodable {
    enum CodingKeys: String, CodingKey {
        case timeline
        case links
        case rocket
        case id = "flight_number"
        case missionName = "mission_name"
        case date = "lunch_date_utc"
        case succeeded = "lunch_success"
        case launchSite = "lunch_site"
        
        enum RocketKeys: String, CodingKey {
            case rocketName = "rocket_name"
            case scondStage = "second_stage"
            
            enum SecondStageKeys: String, CodingKey {
                case payloads
                
                enum PayloadKeys: String, CodingKey {
                    case payloadName = "payload_id"
                }
            }
        }
        enum SiteKeys: String, CodingKey {
            case siteName = "site_name_long"
        }
        
        enum Linkskeys: String, CodingKey {
            case patchURL = "mission_patch"
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        missionName = try container.decode(String.self, forKey: .missionName)
        date = try container.decode(Date.self, forKey: .date)
        succeeded = try container.decode(Bool.self, forKey: .succeeded)
        timeline = try container.decodeIfPresent(Timeline.self, forKey: .timeline)
        
        let linkContainer = try container.nestedContainer(keyedBy: CodingKeys.Linkskeys.self, forKey: .links)
        patchURL = try linkContainer.decode(URL.self, forKey: .patchURL)
        
        let siteContainer = try container.nestedContainer(keyedBy: CodingKeys.SiteKeys.self, forKey: .launchSite)
        site = try siteContainer.decode(String.self, forKey: .siteName)
        
        let rocketContainer = try container.nestedContainer(keyedBy: CodingKeys.RocketKeys.self, forKey: .rocket)
        rocket = try rocketContainer.decode(String.self, forKey: .rocketName)
        
        let secondStageContainer = try rocketContainer.nestedContainer(keyedBy: CodingKeys.RocketKeys.SecondStageKeys.self,forKey: .scondStage)
     
        var payloadsContainer = try secondStageContainer.nestedUnkeyedContainer(forKey: .payloads)
        var payloads = ""
        while !payloadsContainer.isAtEnd {
            
            let payloadContainer = try payloadsContainer.nestedContainer(keyedBy:CodingKeys.RocketKeys.SecondStageKeys.PayloadKeys.self)
            let payloadName = try payloadContainer.decode(String.self, forKey: .payloadName)
            payloads += payloads == "" ? payloadName : ", \(payloadName)"
        }
        
        self.payloads = payloads
        
    }
}

struct Timeline {
    let propellerLoading: Int?
    let liftoff: Int?
    let mainEngineCutoff: Int?
    let payloadDeploy: Int?
}

extension Timeline: Decodable {
    enum CodingKeys: String, CodingKey {
        case propellerLoading = "go_for_prop_loading"
        case liftoff
        case mainEngineCutoff = "meco"
        case payloadDeploy = "payload_deploy"
    }
}

struct payload {
    let name: String
    
}


extension payload: Decodable {
    enum CodingKeys: String, CodingKey
    {
        case name = "payload_id"
    }
}













