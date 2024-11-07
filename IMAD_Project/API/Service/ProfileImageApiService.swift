//
//  ProfileImageApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Alamofire
import Combine

class ProfileImageApiService{
    
    static let intercept = BaseIntercept()
    
    static func fetchProfileCustomImage(image:Data) -> AnyPublisher<NetworkResponse<ProfileImageResponse>,AFError>{
        print("프로필 이미지 커스텀 저장 api 호출")
        let formData = MultipartFormData()
        formData.append(image, withName: "image", fileName: "\(UUID().uuidString).jpg", mimeType: "image/jpg")
        
        return ApiClient.shared.session
            .upload(multipartFormData: formData, with: ProfileImageRouter.profileCustom(image: image),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<ProfileImageResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func fetchProfileDefaultImage(image:String) -> AnyPublisher<NetworkResponse<ProfileImageResponse>,AFError>{
        print("프로필 이미지 기본 저장 api 호출")
        let formData = MultipartFormData()
        if let textData = image.data(using: .utf8) {
            formData.append(textData, withName: "image")
        }
        return ApiClient.shared.session
            .upload(multipartFormData: formData, with: ProfileImageRouter.profileDefault(image: image),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<ProfileImageResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
