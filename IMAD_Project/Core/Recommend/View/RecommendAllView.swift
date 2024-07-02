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
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:[]
        }
    }
    func request(contentsId:Int){
        switch type{
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:
            vm.fetchActivityRecommend(page: vm.currentPage, contentsId: contentsId)
        case .genreMovie,.genreTv:
            vm.fetchGenreRecommend(page: vm.currentPage)
        case .imadTv,.imadMovie:
            vm.fetchImadRecommend(page: vm.currentPage)
        case .trendTv,.trendMovie:
            vm.fetchTrendRecommend(page: vm.currentPage)
        }
    }
    
    var body: some View {
        VStack{
            if vm.workList(type: type).isEmpty{
                CustomProgressView()
            }else{
                headerView
                ScrollView{
                    titleView
                    contentView
                }
            }
        }
        .onAppear{
            guard let contentsId else { return request(contentsId: 0) }
            request(contentsId: contentsId)
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
    var headerView:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
        }
        .overlay {
            Text("작품 추천")
        }
        .bold()
        .padding()
        .foregroundColor(.black)
    }
    var titleView:some View{
        VStack{
            HStack{
                Text(type.title)
                    .font(.title3)
                    .fontWeight(.black)
                Spacer()
            }.padding(.horizontal)
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
                }.padding(.horizontal)
            }
            
        }
    }
    var contentView:some View{
        VStack(spacing:0){
            ListView(items: vm.workList(type: type)) { work in
                HStack{
                    KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 70,height: 100)
                    VStack(alignment: .leading){
                        Text(work.genreType == .tv ?  work.name() ?? "" : work.title() ?? "")
                            .bold()
                            .lineLimit(1)
                            .foregroundColor(.white)
                        Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" :work.genreId()?.transMovieGenreCode() ?? "")
                            .font(.subheadline)
                            .lineLimit(1)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .background{
                    KFImageView(image: work.backdropPath()?.getImadImage() ?? "")
                        .overlay(Material.thin)
                        .environment(\.colorScheme,.dark)
                }
                
            }
            Button {
                vm.currentPage += 1
                guard let contentsId else { return request(contentsId: 0) }
                request(contentsId: contentsId)
            } label: {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .overlay{
                        Text("더보기")
                            .foregroundColor(.black)
                    }
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top)

        }
        
    }
}

#Preview {
    RecommendAllView(type: .trendMovie)
}
