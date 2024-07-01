//
//  RecommendAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import SwiftUI

struct RecommendAllView: View {
    var contentsId:Int?
    let type:RecommendListType
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear{
            switch type{
            case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:
                print("")
            case .genreMovie,.genreTv:
                print("")
            case .imadTv,.imadMovie:
                print("")
            case .trendTv,.trendMovie:
                print("")
            }
        }
    }
}

#Preview {
    RecommendAllView(type: .genreTv)
}
