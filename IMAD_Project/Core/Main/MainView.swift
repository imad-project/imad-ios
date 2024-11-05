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
    @StateObject var vmRanking = RankingViewModel(ranking: nil, popular: PopularCache(review: nil,posting: nil))
    @StateObject var vmRecommend = RecommendViewModel(recommendAll: nil, recommendList: nil)
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(alignment:.leading,spacing:5){
                if let user = vmAuth.user{
                    titleView(user: user)
                    trendView
                    trendWorkView()
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
        .onReceive(vmRecommend.refreschTokenExpired){ vmAuth.logout(tokenExpired: true) }
        .onAppear { listUpdate(false) }
        .environmentObject(vmRanking)
        .environmentObject(vmRecommend)
        .environmentObject(vmAuth)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let rankingCache = RankingCache(id: "a", rankingType: .all, mediaType: .all, maxPage: 1, currentPage: 1, list: CustomData.rankingList)
            let popularCache = PopularCache(review: CustomData.review,posting: CustomData.community)
            MainView(vmRanking:RankingViewModel(ranking:rankingCache, popular: popularCache),vmRecommend:RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: nil))
                .environmentObject(AuthViewModel(user:CustomData.user))
                .environment(\.colorScheme, .light)
        }
    }
}

extension MainView{
    var trendFrame: CGSize {
        let width:CGFloat = mainWidth
        let height:CGFloat = isPad() ? 500 : 350
        return CGSize(width: width, height: height)
    }
    func titleView(user:UserResponse) -> some View{
        Text((user.nickname ?? "") + "님 환영합니다")
            .font(.GmarketSansTTFMedium(isPad() ? 30 : 25))
            .fontWeight(.black)
            .padding(.horizontal,10)
            .padding(.bottom)
            .padding(.top,10)
    }
    func trendWorkView() ->some View{
        ZStack{
            KFImageView(image: workBackground,width: trendFrame.width,height: trendFrame.height)
            Color.clear
                .background(Material.ultraThin)
            TabView{
                ListView(items:trend ? vmRecommend.workList(.trendTv).list : vmRecommend.workList(.trendMovie).list){ work in
                    NavigationLink {
                        WorkView(id: work.id,type: work.genreType.rawValue)
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack{
                            KFImageView(image: work.posterPath ?? "",width:isPad() ? 300 : 175,height: isPad() ? 370 : 240)
                                .cornerRadius(5)
                            Text(trend ? work.name ?? "" : work.title ?? "")
                                .bold()
                                .font(.GmarketSansTTFMedium(isPad() ? 20 :15))
                                .lineLimit(1)
                            Text(work.genreType == .tv ? work.genreId?.transTvGenreCode() ?? "" : work.genreId?.transMovieGenreCode() ?? "")
                                .font(.GmarketSansTTFMedium(isPad() ? 17.5 :12))
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
        }
        .frame(trendFrame)
        .tabViewStyle(.page)
        .colorScheme(.dark)
    }
    
    var trendView:some View{
        VStack(alignment: .leading){
            HStack{
                Text("인기작품")
                    .fontWeight(.black)
                    .font(.GmarketSansTTFMedium(isPad() ? 22 : 20))
                    .foregroundColor(.customIndigo)
                Button {
                    withAnimation(.default){
                        trend = false
                    }
                } label: {
                    Text("영화")
                        .font(.GmarketSansTTFMedium(15))
                        .opacity(trend ? 0.5 : 1.0)
                }
                Text(" l ").foregroundColor(.gray)
                Button {
                    withAnimation(.default){
                        trend = true
                    }
                } label: {
                    Text("시리즈")
                        .font(.GmarketSansTTFMedium(15))
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
