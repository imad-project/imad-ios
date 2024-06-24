//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher


struct MainView: View {
    let items = [ GridItem(.fixed(75)), GridItem(.fixed(75)), GridItem(.fixed(75))]
    let initTvValue = [RecommendTVResponse](repeating: RecommendTVResponse(id: 0, name: "", posterPath: "", backdropPath: ""), count: 10)
    let initMovieValue = [RecommendMovieResponse](repeating: RecommendMovieResponse(id: 0, title: "", posterPath: "", backdropPath: ""), count: 10)
    @State var ranking:RankingFilter = .all
    @StateObject var vm = RankingViewModel(rankingList: [])
    @StateObject var vmRecommend = RecommendViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var trend = false
    @State var role = false
    @State private var rotationAngle: Angle = .zero
    @State var movieIndex = 0
    
    @State var isReview = false
    @State var select = 0
    @State var anima = false
    @Binding var search:Bool
    
  
    var body: some View {
        ZStack{
            Color.white
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading,spacing:10){
                    if let user = vmAuth.user?.data{
                        HStack(spacing: 0){
                            Text(user.nickname ?? "").bold()
                            Text("님 환영합니다")
                        }
                        .font(.title2)
                        .padding(.horizontal)
                        HStack{
                            Text("요즘 트렌트 작품")
                                .font(.body)
                                .bold()
                            Spacer()
                            Button {
                                withAnimation(.default){
                                    trend = false
                                }
                            } label: {
                                Text("영화").font(.subheadline)
                                    .opacity(trend ? 0.5 : 1.0)
                            }
                            Button {
                                withAnimation(.default){
                                    trend = true
                                }
                                
                            } label: {
                                Text("시리즈").font(.subheadline)
                                    .opacity(trend ? 1.0 : 0.5)
                            }
                                
                        }
                        .foregroundColor(.customIndigo)
                        .padding(.horizontal)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                if trend{
                                    ForEach(vmRecommend.recommendAll?.trendRecommendationTv?.results ?? initTvValue,id: \.self){ work in
                                        VStack{
                                            KFImageView(image: work.posterPath?.getImadImage() ?? "",width: 180,height: 250)
                                                .cornerRadius(5)
                                            Text(work.name)
                                                .frame(width: 150)
                                                .lineLimit(1)
                                                .bold()
                                                .font(.subheadline)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }else{
                                    ForEach(vmRecommend.recommendAll?.trendRecommendationMovie?.results ?? initMovieValue,id: \.self){ work in
                                        VStack{
                                            KFImageView(image: work.posterPath?.getImadImage() ?? "",width: 180,height: 250)
                                                .cornerRadius(5)
                                            Text(work.title)
                                                .frame(width: 150)
                                                .lineLimit(1)
                                                .bold()
                                                .font(.subheadline)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                        Image("ad")
                            .resizable()
                            .frame(height: 70)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        Text("아이매드 차트")
                            .font(.body)
                            .bold()
                            .foregroundColor(.customIndigo)
                            .padding(.horizontal)
                        filter
                        rankingView
                        Text("오늘의 리뷰&게시물")
                            .font(.body)
                            .bold()
                            .foregroundColor(.customIndigo)
                            .padding(.horizontal)
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack{
                                PopularView(review: vm.popularReview)
                                    .shadow(radius: 1)
                                    .frame(width: 200)
                                PopularView(posting: vm.popularPosting)
                                    .shadow(radius: 1)
                                    .frame(width: 200)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,5)
                        }
                    }
                    
                    //                    RoundedRectangle(cornerRadius: 20)
                    //                        .frame(height: 50)
                    //                        .foregroundStyle(Color.gray.opacity(0.3))
                    //                        .overlay{
                    //                            HStack{
                    //                                Image(systemName: "magnifyingglass")
                    //                                Text("작품을 검색해주세요..")
                    //                                Spacer()
                    //                            }
                    //                            .padding(.leading)
                    //                            .foregroundStyle(.gray)
                    //                        }
                    //                        .onTapGesture {
                    //                            search = true
                    //                        }
                    //                        .padding()
                    
                    //                    reviewPosting
                    //                    movieList
                    //                    Spacer().frame(height: 100).foregroundColor(.white)
                }
                
            }
        }
        .navigationDestination(isPresented: $isReview){
            //            ReviewView(isReview: $isReview, review: poster)
            //                .navigationBarBackButtonHidden(true)
            //            WorkView(id: poster.id, type: poster.)
        }
        .ignoresSafeArea(edges:.bottom)
        //        .ignoresSafeArea(.bottom)
        //        .navigationDestination(isPresented: $search) {
        //            SearchView(postingMode: false, back: $search)
        //                .environmentObject(vmAuth)
        //                .navigationBarBackButtonHidden(true)
        //        }
        .onAppear {
            vmRecommend.fetchAllRecommend()
//            vm.getWeekRanking(page: 1, type: "all")
            vm.getPopularReview()
            vm.getPopularPosting()
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MainView(vm:RankingViewModel(rankingList: CustomData.instance.rankingList), search: .constant(false))
                .environmentObject(AuthViewModel(user: UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension MainView{
    
    
    var rankingView:some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: items){
               
                    if vm.rankingList.isEmpty{
                        ForEach(0...10,id: \.self){ _ in
                            NoImageView()
                            .frame(width: 300,height: 75)
                        }
                    }else{
                        ForEach(vm.rankingList.prefix(9),id:\.self){ rank in
                        HStack(spacing:0){
                            KFImageView(image: rank.posterPath.getImadImage(),width: 60,height: 75).cornerRadius(5)
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(rank.ranking)")
                                        .font(.body)
                                        .bold()
                                    Text(rank.title)
                                        .frame(width: 100,alignment: .leading)
                                        .lineLimit(1)
                                        .font(.subheadline)
                                }
                                .padding(.bottom,3)
                                HStack{
                                    rankUpdateView(rank: rank.rankingChanged)
                                    Text(TypeFilter(rawValue: rank.contentsType)?.name ?? "")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            
                            Spacer()
                            Circle()
                                .trim(from: 0.0, to: anima ? (rank.imadScore ?? 0) * 0.1 : 0)
                               .stroke(lineWidth: 1)
                               .rotation(Angle(degrees: 270))
                               .frame(width: 50,height: 50)
                               .overlay{
                                   VStack{
                                       Image(systemName: "star.fill")
                                           .font(.caption2)
                                       Text(String(format: "%0.1f",  rank.imadScore ?? 0))
                                           .font(.caption)
                                   }
                               }
                               .padding(.trailing)
                        }
                        .frame(width: 300,height: 75)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                                .padding([.leading])
                        
                    }
                }
            }
            
        }
    }
    
    
    
    var filter:some View{
        HStack(spacing: 5){
            HStack{
                ForEach(RankingFilter.allCases,id:\.self){ ranking in
                    Button {
                        self.ranking = ranking
                        self.movieIndex = 0
                        switch self.ranking{
                        case .all:
                            vm.getAllRanking(page: 1, type: "all")
                        case .week:
                            vm.getWeekRanking(page: 1, type: "all")
                        case .month:
                            vm.getMonthRanking(page: 1, type: "all")
                        }
                    } label: {
                        Group{
                            if self.ranking == ranking{
                                Capsule()
                            }else{
                                Capsule()
                                    .stroke(lineWidth: 1)
                            }
                        }
                        .foregroundColor(.customIndigo)
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text(ranking.name)
                                .foregroundColor(self.ranking == ranking ? .white : .customIndigo)
                        }
                    }
                }
            }
            Spacer()
            NavigationLink {
                
            } label: {
                Label {
                    Text("전체보기")
                } icon: {
                    Image(systemName: "line.3.horizontal")
                        .font(.subheadline)
                }
                .foregroundColor(.customIndigo)
            }
        }
        .font(.caption)
        .padding(.horizontal)
    }
    
        func rankUpdateView(rank:Int?) -> some View{
            HStack(spacing:2){
                if let rank,rank != 0{
                    Group{
                        Image(systemName:rank > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        Text(rank > 0 ? "\(rank)":"\(abs(rank))")
                    }
                    .font(.caption2)
                    .foregroundStyle(rank > 0 ? .green : .red)
                }else{
                    Text("-")
                }
            }
    
        }
    
    
}
