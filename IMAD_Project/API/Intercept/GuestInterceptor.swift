//
//  GuestInterceptor.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/13/24.
//

import Foundation
import Alamofire

class GuestInterceptor:RequestInterceptor{
    
    func adapt(_ urlRequest: URLRequest, using state: RequestAdapterState, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        print("게스트 인터셉트")
        var urlReq = urlRequest
        urlReq.headers.add(.authorization("GUEST"))
        completion(.success(urlReq))
    
    }
        
}
