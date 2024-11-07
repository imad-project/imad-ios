//
//  RecommendAllView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/1/24.
//

import SwiftUI

struct AllRecommendView: View {
    var contentsId:Int?
    @State var title:String = ""
    @State var type:RecommendListType
    @StateObject var vmRecommend = RecommendViewModel(recommendAll: nil,recommendList: nil)
    @StateObject var user = UserInfoManager.instance
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing:0){
            headerView
            titleView
            listView
        }
        .progress(vmRecommend.recommendList != nil)
        .onAppearOnDisAppear({
            request(page:1,getNextPage:false,type,contentsId:contentsId ?? 0,cache:RecommendCache(id: type.rawValue, maxPage:1,currentPage:1,list:[]))
            title = type.title
        },{ vmRecommend.recommendList = nil})
        
    }
    
}

extension AllRecommendView{
    func request(page:Int,getNextPage:Bool,_ type:RecommendListType,category:ImadRecommendFilter? = nil,contentsId:Int? = nil,cache:RecommendCache){
        switch type{
        case .activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie:
            vmRecommend.getActivityRecommend(page:page,getNextPage:getNextPage,contentsId:contentsId ?? 0, type:type,cache:cache)
        case .genreTv,.genreMovie:
            vmRecommend.getGenreRecommend(page:page,getNextPage:getNextPage,type:type,cache:cache)
        case .trendTv,.trendMovie:
            vmRecommend.getTrendRecommend(page:page,getNextPage:getNextPage,type:type,cache:cache)
        case .topRateTv,.topRateMovie:
            vmRecommend.getImadRecommend(page:page,getNextPage:getNextPage,category:.topRated,type:type,cache:cache)
        case .popluarTv,.popluarMovie:
            vmRecommend.getImadRecommend(page:page,getNextPage:getNextPage,category:.popular,type:type,cache:cache)
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
                        if self.type != type{
                            withAnimation(.default){
                                self.type = type
                            }
                            vmRecommend.recommendList = nil
                            title = (type == .genreTv ? user.cache?.nickname ?? "" : "") + type.title
                            request(page:1,getNextPage:false,type,contentsId:0,cache:RecommendCache(id: type.rawValue, maxPage:1,currentPage:1,list:[]))
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
                ListView(items:vmRecommend.recommendList?.list ?? []) { work in
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
                    if let list = vmRecommend.recommendList,list.list.last?.id == work.id,list.currentPage < list.maxPage{
                        ProgressView()
                            .onAppear{
                                request(page:list.currentPage+1,getNextPage:true,type,contentsId:contentsId ?? 0,cache:list)
                            }
                    }
                }
            }
        }
    }
}


#Preview {
    let list = CustomData.recommandAll?.userActivityRecommendationTv?.results.map({TVWorkGenre(tvGenre: $0)}) ?? []
    let cache = RecommendCache(id: "", maxPage: 1, currentPage: 1, list: list)
    return AllRecommendView(contentsId:1,type: .genreTv,vmRecommend: RecommendViewModel(recommendAll: nil, recommendList:cache))
        .environmentObject(AuthViewModel(user: CustomData.user))
        .background(.white)
}

