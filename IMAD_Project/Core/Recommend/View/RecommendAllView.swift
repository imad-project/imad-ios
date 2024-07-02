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
        VStack(spacing:0){
            if vm.workList(type: type).isEmpty{
                CustomProgressView()
            }else{
                headerView
                titleView
                ScrollView{
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
            Text(type.title)
        }
        .bold()
        .padding()
        .foregroundColor(.black)
    }
    var titleView:some View{
        VStack(spacing:0){
            HStack{
                ForEach(typeList,id: \.self){ type in
                    VStack{
                        Button {
                            withAnimation(.default){
                                self.type = type
                            }
                        } label: {
                            Text(type.name)
                                .foregroundColor(self.type == type ? .customIndigo : .gray)
                                .frame(minWidth: 100,maxWidth: 250)
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
    }
    var contentView:some View{
        VStack(spacing:0){
            ListView(items: vm.workList(type: type)) { work in
                HStack{
                    KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 120,height: 160)
                        .cornerRadius(5)
                        .padding(.vertical)
                    VStack(alignment: .leading){
                        Text(work.genreType == .tv ?  work.name() ?? "" : work.title() ?? "")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.white)
                        Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" :work.genreId()?.transMovieGenreCode() ?? "")
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
    RecommendAllView(type: .trendTv)
}
