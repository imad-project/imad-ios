//
//  RecommendAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import SwiftUI

struct RecommendAllView: View {
    var contentsId:Int?
    let title:String
    @State var type:RecommendListType
    @StateObject var vmRecommend = RecommendViewModel(recommendAll: nil,recommendList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing:0){
            headerView
            titleView
            listView
        }
        .progress(!vmRecommend.recommendList.isEmpty)
        .onAppearOnDisAppear({ request(type,contentsId: contentsId ?? 0, page: 1)},
                             { vmRecommend.recommendList.removeAll()})
        .onReceive(vmRecommend.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
    
}

extension RecommendAllView{
    func request(_ type:RecommendListType,contentsId:Int,page:Int){
        switch type{
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:
            vmRecommend.fetchActivityRecommend(page: page, contentsId: contentsId, type: type)
        case .genreMovie:vmRecommend.fetchGenreRecommend(page: page,type: .movie)
        case .genreTv:vmRecommend.fetchGenreRecommend(page: page,type: .tv)
        case .topRateTv:vmRecommend.fetchImadRecommend(page: page,type: .tv,category:.topRated)
        case .topRateMovie:vmRecommend.fetchImadRecommend(page: page,type: .movie,category:.topRated)
        case .trendTv:vmRecommend.fetchTrendRecommend(page: page,type: .tv)
        case .trendMovie:vmRecommend.fetchTrendRecommend(page: page,type: .movie)
        case .popluarTv:vmRecommend.fetchImadRecommend(page: page,type: .tv,category:.popular)
        case .popluarMovie:vmRecommend.fetchImadRecommend(page: page,type: .movie,category:.popular)
        }
    }
    var headerView:some View{
        HeaderView(backIcon: "chevron.left", text: title){  dismiss() }
            .padding(10)
    }
    var titleView:some View{
        HStack{
            if contentsId != nil{
                Text("추천 리스트")
                    .foregroundColor(.customIndigo)
                    .bold()
                    .font(.GmarketSansTTFMedium(20))
                    .padding(10)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }else{
                ForEach(type.option,id: \.self){ type in
                    Button {
                        vmRecommend.recommendList.removeAll()
                        request(type, contentsId: contentsId ?? 0, page: 1)
                        withAnimation(.default){
                            self.type = type
                        }
                    } label: {
                        Text(type.name)
                            .font(.GmarketSansTTFMedium(15))
                            .foregroundColor(self.type == type ? .customIndigo : .gray)
                            .padding(.horizontal,20)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom,10)
                    .overlay {
                        if self.type == type{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(height: 4)
                                .foregroundColor(.customIndigo)
                                .offset(y:10)
                        }
                    }
                    
                }
            }
            
        }
    }
    var listView:some View{
        ScrollView{
            LazyVStack(spacing:0){
                ListView(items:vmRecommend.recommendList) { work in
                    NavigationLink {
                        WorkView(id: work.id,type: work.genreType.rawValue)
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack{
                            KFImageView(image: work.posterPath?.getImadImage() ?? "",width: 120,height: 160)
                                .cornerRadius(5)
                                .padding(.vertical)
                            VStack(alignment: .leading,spacing:10){
                                Text(work.genreType == .tv ?  work.name ?? "" : work.title ?? "")
                                    .bold()
                                    .font(.GmarketSansTTFMedium(17))
                                    .foregroundColor(.white)
                                Text(work.genreType == .tv ? work.genreId?.transTvGenreCode() ?? "" :work.genreId?.transMovieGenreCode() ?? "")
                                    .font(.GmarketSansTTFMedium(13))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .background{
                            KFImageView(image: work.backdropPath?.getImadImage() ?? "")
                                .overlay(Material.thin)
                                .environment(\.colorScheme,.dark)
                        }
                    }
                    if vmRecommend.recommendList.last?.id == work.id,vmRecommend.currentPage < vmRecommend.maxPage{
                        ProgressView()
                            .onAppear{
                                request(type, contentsId: contentsId ?? 0,page: vmRecommend.currentPage + 1)
                            }
                    }
                }
            }
        }
    }
}


#Preview {
    let list = CustomData.recommandAll?.userActivityRecommendationTv?.results.map({TVWorkGenre(tvGenre: $0)}) ?? []
    return RecommendAllView(contentsId:1, title: "hh", type: .genreTv,vmRecommend: RecommendViewModel(recommendAll: nil, recommendList:list))
        .environmentObject(AuthViewModel(user: CustomData.user))
        .background(.white)
}

