//
//  GirdView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/16/24.
//

import SwiftUI
import Kingfisher

struct GridView: View {
    let room:Int
    let imageList:[String]
    var list:[[String]]{
        imageList.chunks(ofCount: room)
    }
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            VStack(spacing:0){
                ForEach(list,id: \.self){ columns in
                    HStack(spacing:0){
                        ForEach(columns,id: \.self){ row in
                            KFImageView(image: row,width: size.width/CGFloat(room),height: size.height/CGFloat(room))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GridView(room: 3, imageList: CustomData.recommandAll?.popularRecommendationMovie?.results.prefix(9).map{$0.posterPath?.getImadImage() ?? ""} ?? [])
}
