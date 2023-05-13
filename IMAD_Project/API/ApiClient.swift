//
//  ApiClient.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

final class ApiClient{
    
    var session:Session
    static let shared = ApiClient()
    static let baseURL = "http://39.119.82.229:8080"
    let monitors = [ApiLogger()] as [EventMonitor]
    
    init(){
        session = Session(eventMonitors: monitors)
    }
    
}
