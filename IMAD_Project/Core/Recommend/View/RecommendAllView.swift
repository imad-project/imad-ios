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
    @StateObject var vmAuth = AuthViewModel(user:nil)
    @Environment(\.dismiss) var dismiss
    
   
    var body: some View {
        VStack(spacing:0){
            headerView
            titleView
            contentView
        }
        .progress(!vm.workList(type: type).isEmpty)
        .onAppearOnDisAppear({
            request(contentsId: contentsId ?? 0)
        },{
            remove()
        })
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
    
}

extension RecommendAllView{
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
    func remove(){
        switch type {
        case .genreTv,.genreMovie:
            vm.recommendGenre = ([],[])
        case .trendTv,.trendMovie:
            vm.recommendTrend = ([],[])
        case .activityTv,.activityAnimationTv,.activityMovie,.activityAnimationMovie:
            vm.recommendActivity = []
        case .imadTv,.imadMovie:
            vm.recommendImad = ([],[])
        }
    }
    var headerView:some View{
        HeaderView(backIcon: "chevron.left", text: type.title){
            dismiss()
        }
        .padding(10)
    }
    var titleView:some View{
        HStack{
            ForEach(typeList,id: \.self){ type in
                VStack{
                    Button {
                        withAnimation(.default){ self.type = type }
                    } label: {
                        Text(type.name)
                            .font(.GmarketSansTTFMedium(15))
                            .foregroundColor(self.type == type ? .customIndigo : .gray)
                            .frame(minWidth: 100,maxWidth: .infinity)
                    }
                    .padding(.vertical,2)
                    if self.type == type{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 4)
                            .foregroundColor(.customIndigo)
                    }
                }
            }
        }
    }
    var listView:some View{
        ListView(items: vm.workList(type: type)) { work in
            NavigationLink {
                WorkView(id: work.id(),type: work.genreType.rawValue)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack{
                    KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 120,height: 160)
                        .cornerRadius(5)
                        .padding(.vertical)
                    VStack(alignment: .leading,spacing:10){
                        Text(work.genreType == .tv ?  work.name() ?? "" : work.title() ?? "")
                            .bold()
                            .font(.GmarketSansTTFMedium(17))
                            .foregroundColor(.white)
                        Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" :work.genreId()?.transMovieGenreCode() ?? "")
                            .font(.GmarketSansTTFMedium(13))
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
        }
    }
    var contentView:some View{
        ScrollView{
            VStack(spacing:0){
                listView
                Button {
                    vm.currentPage += 1
                    guard let contentsId else { return  request(contentsId: 0)}
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
}


#Preview {
    RecommendAllView(contentsId:1, type: .trendTv)
       
}

