//
//  RecommendAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import SwiftUI

struct RecommendAllView: View {
    var contentsId:Int?
    @State var type:RecommendListType
    @StateObject var vm = RecommendViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var typeList:[RecommendListType]{
        switch type{
            case .trendTv,.trendMovie:[.trendTv,.trendMovie]
            case .genreTv,.genreMovie:[.genreTv,.genreMovie]
            case .imadTv,.imadMovie:[.imadTv,.imadMovie]
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:[.activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie]
        }
    }
    
    
    var body: some View {
        VStack{
            headerView
            ScrollView(showsIndicators: false){
                titleView
                contentView
            }
            
        }
        .padding(.horizontal)
        .onAppear{
            request()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
    var headerView:some View{
        HStack{
            Image(systemName: "chevron.left")
            Spacer()
        }
        .overlay {
            Text("작품 추천")
               
        }
        .bold()
        .padding(.vertical)
    }
    var titleView:some View{
        VStack{
            HStack{
                Text(type.title)
                    .font(.title3)
                    .fontWeight(.black)
                Spacer()
            }
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(typeList,id: \.self){ type in
                        Button {
                            self.type = type
                            print(type)
                        } label: {
                            ZStack{
                                Group{
                                    if self.type == type{
                                        Capsule()
                                    }else{
                                        Capsule()
                                            .stroke(lineWidth: 1)
                                    }
                                }
                                .foregroundColor(.customIndigo)
                                .frame(height: 30)
                                Text(type.name)
                                    .foregroundColor(self.type == type ? .white : .customIndigo)
                                    .padding(.horizontal,20)
                            }.frame(minWidth: 100,maxWidth: 250)
                        }
                        .padding(.vertical,2)
                    }
                    Spacer()
                }
            }
            
        }
    }
    var contentView:some View{
        ListView(items: vm.workList(type: type)) { work in
            KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 300,height: 300)
        }
    }
}

#Preview {
    RecommendAllView(type: .trendMovie)
}
