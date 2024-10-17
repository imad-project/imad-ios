//
//  ErrorManager.swift
//  IMAD_Project
//
//  Created by 유영웅 on 9/23/24.
//

import Foundation
import Combine
import Alamofire

class ErrorManager{
    static let instance = ErrorManager()
    private init(){}
    
    func showErrorMessage(completion: Subscribers.Completion<AFError>){
        DispatchQueue.global(qos: .background).async{
            switch completion{
            case .finished:
                print(completion)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func actionErrorMessage(completion: Subscribers.Completion<AFError>,success: @escaping()->() = {},failed:@escaping()->() = {}){
        DispatchQueue.global(qos: .background).async{
            switch completion{
            case .finished:
                print(completion)
                success()
            case let .failure(error):
                print(error.localizedDescription)
                failed()
            }
        }
    }
}
