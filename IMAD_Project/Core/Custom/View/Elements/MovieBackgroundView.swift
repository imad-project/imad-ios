//
//  MovieBackgroundView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/09.
//

import SwiftUI
import Kingfisher

struct MovieBackgroundView: View {
    let url:String
    let height:CGFloat
    var body: some View {
        ZStack{
            GeometryReader { pro in
                KFImage(URL(string: "https://image.tmdb.org/t/p" + "/original" + (url))!)
                    .resizable()
                    .overlay{
                        LinearGradient(colors: [Color.black.opacity(0.5),Color.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                    }
                    .offset(x: pro.frame(in: .global).minY > 0 ? -pro.frame(in: .global).minY : 0,
                            y: pro.frame(in: .global).minY > 0 ? -pro.frame(in: .global).minY : 0)
                    .frame(
                        width: pro.frame(in: .global).minY > 0 ?
                        UIScreen.main.bounds.width + pro.frame(in: .global).minY * 2 :
                            UIScreen.main.bounds.width,
                        height: pro.frame(in: .global).minY > 0 ?
                        UIScreen.main.bounds.height/height + pro.frame(in: .global).minY :
                            UIScreen.main.bounds.height/height
                    )
            }
            
            
        }
    }
}

struct MovieBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackgroundView(url: "/lLQZbBom0IsdQLhe1n9J9SpMzSR.jpg",height: 2.5)
    }
}
