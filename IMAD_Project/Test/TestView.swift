//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/23.
//

import SwiftUI
import Alamofire

struct TestView: View {
    var body: some View {
        VStack{
            Button {
                urlsessionTest()
            } label: {
                Text("URLSession")
            }
            Text("")
            Button {
                alamofireTest()
            } label: {
                Text("Alamofire")
            }
            Text("")
        }
    }
    func urlsessionTest(){
        
        let queryItem = [URLQueryItem(name:"limit", value: "3")]
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!)
        
        request.httpMethod = "GET"
        request.url?.append(queryItems:queryItem)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print(request)
    
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data,let str = String(data: data, encoding:.utf8) else { return }
            print(str)
        }
        task.resume()
    }
    func alamofireTest(){
        AF.request("https://pokeapi.co/api/v2/pokemon", method: .get, parameters: ["limit":3], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseString { stirng in
                print(stirng)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
