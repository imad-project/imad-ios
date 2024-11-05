//
//  TestKFImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/29/24.
//

import SwiftUI
import Kingfisher

struct TestKFImageView: View {
    let cache = KingfisherManager.shared.cache //ImageCache(name: "main")
    let a = [1,11111,2,3,4]
    @State var on = false
    @State var new :String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(5).png"
    var body: some View {
        NavigationLink {
            TabView{
                ForEach(a,id:\.self){ index in
                    let image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(index).png"
                    
                    Button {
                        new = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(index+4).png"
                        on = true
                    } label: {
                        KFImage(URL(string: image))
                            .resizable()
                            .cancelOnDisappear(true)
                            .cacheMemoryOnly()
                            .tabItem { Text("\(index)") }
                    }
                }
            }
            .sheet(isPresented: $on) {
                KFImage(URL(string: new))
                    .resizable()
                    .cancelOnDisappear(true)
                    .cacheMemoryOnly()
                    .onDisappear{
                        cache.clearMemoryCache()
                    }
            }
            .onDisappear{
                cache.clearMemoryCache()
            }
        } label: {
            Circle()
        }
//        .onAppear{
//            cache.memoryStorage.config.countLimit = 20
//        }
        
    }
}

#Preview {
    TestKFImageView()
}

