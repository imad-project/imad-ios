//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    @State var workBackground = ""
    @State var trend = false
    @State private var screenSize: CGSize = UIScreen.main.bounds.size
    @StateObject var vmRanking = RankingViewModel(ranking: nil, popular: PopularCache(review: nil,posting: nil))
    @StateObject var vmRecommend = RecommendViewModel(recommendAll: nil, recommendList: nil)
    @StateObject var user = UserInfoManager.instance
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(alignment:.leading,spacing:5){
                if let user = user.cache{
                    titleView(user: user)
                    trendView
                    trendWorkView
                    TodayPopularView(review: vmRanking.popular?.review, posting: vmRanking.popular?.posting)
                    RankingView()
                    UserActivityView()
                    WorkRecommandListView(filter: .genreMovie)
                    WorkRecommandListView(filter: .genreTv)
                    WorkRecommandListView(filter: .popluarTv)
                    WorkRecommandListView(filter: .popluarMovie)
                    WorkRecommandListView(filter: .topRateTv)
                    WorkRecommandListView(filter: .topRateMovie)
                }
            }
        }
        .background(.white)
        .refreshable {listUpdate(true) }
        .progress(vmRecommend.recommendAll != nil)
        .ignoresSafeArea(edges:.bottom)
        .onAppear { listUpdate(false) }
        .environmentObject(vmRanking)
        .environmentObject(vmRecommend)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let rankingCache = RankingCache(id: "a", rankingType: .all, mediaType: .all, maxPage: 1, currentPage: 1, list: CustomData.rankingList)
            let popularCache = PopularCache(review: CustomData.review,posting: CustomData.community)
            MainView(vmRanking:RankingViewModel(ranking:rankingCache, popular: popularCache), vmRecommend:RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: nil))
                .environment(\.colorScheme, .light)
        }
    }
}

extension MainView{
    func titleView(user:UserResponse) -> some View{
        Text((user.nickname ?? "") + "님 환영합니다")
            .font(.GmarketSansTTFMedium(isPad ? 40 : 25))
            .fontWeight(.black)
            .padding(.horizontal,10)
            .padding(.bottom)
            .padding(.top,10)
    }
    var trendWorkView:some View{
        GeometryReader { geometry in
            TabView{
                ListView(items:trend ? vmRecommend.workList(.trendTv).list : vmRecommend.workList(.trendMovie).list){ work in
                    NavigationLink {
                        WorkView(id: work.id,type: work.genreType.rawValue)
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack{
                            KFImageView(image: work.posterPath ?? "",width:isPad ? 300 : 175,height: isPad ? 370 : 240)
                                .cornerRadius(5)
                            Text(trend ? work.name ?? "" : work.title ?? "")
                                .bold()
                                .font(.GmarketSansTTFMedium(isPad ? 20 :15))
                                .lineLimit(1)
                            Text(work.genreType == .tv ? work.genreIds?.transTvGenreCode() ?? "" : work.genreIds?.transMovieGenreCode() ?? "")
                                .font(.GmarketSansTTFMedium(isPad ? 17.5 :12))
                                .lineLimit(1)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .padding(.bottom)
                        .onAppear{
                            withAnimation {
                                workBackground = work.backdropPath ?? ""
                            }
                        }
                        .onDisappear{
                            KingfisherManager.shared.cache.clearCache()
                        }
                    }
                }
            }
            .background{
                ZStack{
                    KFImageView(image: workBackground)
                    Color.clear
                        .background(Material.ultraThin)
                    
                }
            }
            .onChange(of: geometry.size){ screenSize = $0 }
        }
        .frame(height:isPad ? 500 : 350)
        .tabViewStyle(.page)
        .colorScheme(.dark)
    }
    
    var trendView:some View{
        VStack(alignment: .leading){
            HStack{
                Text("인기작품")
                    .fontWeight(.black)
                    .font(.GmarketSansTTFMedium(isPad ? 30 : 20))
                    .foregroundColor(.customIndigo)
                Button {
                    withAnimation(.default){
                        trend = false
                    }
                } label: {
                    Text("영화")
                        .font(.GmarketSansTTFMedium(isPad ? 23: 15))
                        .opacity(trend ? 0.5 : 1.0)
                }
                Text(" l ").foregroundColor(.gray)
                Button {
                    withAnimation(.default){
                        trend = true
                    }
                } label: {
                    Text("시리즈")
                        .font(.GmarketSansTTFMedium(isPad ? 23: 15))
                        .opacity(trend ? 1.0 : 0.5)
                }
                Spacer()
                allView(AllRecommendView(type: trend ? .trendTv : .trendMovie))
            }
            .padding(.horizontal,10)
            .foregroundColor(.customIndigo)
        }
    }
    func listUpdate(_ refresh:Bool){
        if refresh{
            RecommendCacheManager.instance.recommendAllOfStorage.removeAll()
            RankingCacheManager.instance.storage.removeAll()
            PopularCacheManager.instance.storage.removeAll()
        }
        vmRecommend.getAllRecommend()
        vmRanking.getRanking(ranking: RankingCache(id: "allall", rankingType: .all, mediaType: .all, maxPage: 1, currentPage: 1, list: []))
        vmRanking.getPopularReview()
        vmRanking.getPopularPosting()
    }
}
