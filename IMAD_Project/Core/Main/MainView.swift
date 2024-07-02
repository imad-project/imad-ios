//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher


struct MainView: View {
    
    let gradient = [LinearGradient(colors: [.green.opacity(0.6),.cyan.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.pink.opacity(0.6),.yellow.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.gray.opacity(0.4),.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.purple.opacity(0.7),.red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.brown.opacity(0.5),.orange.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)].shuffled()
    let rankingItems = [ GridItem(.fixed(75)), GridItem(.fixed(75)), GridItem(.fixed(75))]
    let workItems = [ GridItem(.fixed(220)), GridItem(.fixed(220))]
    let initValue = [WorkGenre](repeating: TVWorkGenre(tvGenre: RecommendTVResponse(id: 0, name: "", posterPath: "", backdropPath: "", genreIds: [])), count: 10)
    
    @State var ranking:RankingFilter = .all
    @StateObject var vm = RankingViewModel(rankingList: [])
    @StateObject var vmRecommend = RecommendViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var trend = false
    
    
    var body: some View {
        ZStack{
            Color.white
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading,spacing:5){
                    if let user = vmAuth.user?.data{
                        titleView(user: user)
                        trendView
                        todayView
                        filter
                        rankingView
                        userActivityView(user: user)
                        recommendView("이런 장르 영화 어때요?", .genreMovie)
                        recommendView("\(user.nickname ?? "")님을 위한 시리즈",.genreTv)
                        recommendView("아이매드 엄선 영화", .imadMovie)
                        recommendView("전 세계 사람들이 선택한 시리즈", .imadTv)
                    }
                }
            }
        }
        .ignoresSafeArea(edges:.bottom)
        .onAppear {
            vmRecommend.fetchAllRecommend()
            vm.getAllRanking(page: 1, type: ranking.rawValue)
            vm.getPopularReview()
            vm.getPopularPosting()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MainView(vm:RankingViewModel(rankingList: CustomData.instance.rankingList))
                .environmentObject(AuthViewModel(user: UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension MainView{
    func list(_ filter:RecommendListType) -> ([WorkGenre],WorkGenreType,RecommendListType,Int?){
        switch filter{
        case .genreTv:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.preferredGenreRecommendationTv?.contentsID
            for i in (vmRecommend.recommendAll?.preferredGenreRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.tv,.genreTv,contentsId)
        case .genreMovie:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.preferredGenreRecommendationMovie?.contentsID
            for i in (vmRecommend.recommendAll?.preferredGenreRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.movie,.genreMovie,contentsId)
        case .trendTv:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.trendRecommendationTv?.contentsID
            for i in (vmRecommend.recommendAll?.trendRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.tv,.trendTv,contentsId)
        case .trendMovie:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.trendRecommendationMovie?.contentsID
            for i in (vmRecommend.recommendAll?.trendRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.movie,.trendMovie,contentsId)
        case .activityTv:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.userActivityRecommendationTv?.contentsID
            if let results = vmRecommend.recommendAll?.userActivityRecommendationTv?.results {
                for i in 0..<5{
                    list.append( TVWorkGenre(tvGenre:results[i]))
                }
            }
            return (list,.tv,.activityTv,contentsId)
        case .activityAnimationTv:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.userActivityRecommendationTvAnimation?.contentsID
            if let results = vmRecommend.recommendAll?.userActivityRecommendationTvAnimation?.results {
                for i in 0..<5{
                    list.append( TVWorkGenre(tvGenre:results[i]))
                }
            }
            return (list,.tv,.activityAnimationTv,contentsId)
        case .activityMovie:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.userActivityRecommendationMovie?.contentsID
            if let results = vmRecommend.recommendAll?.userActivityRecommendationMovie?.results {
                for i in 0..<5{
                    list.append( MovieWorkGenre(movieGenre:results[i]))
                }
            }
            return (list,.movie,.activityMovie,contentsId)
        case .activityAnimationMovie:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.userActivityRecommendationMovieAnimation?.contentsID
            if let results = vmRecommend.recommendAll?.userActivityRecommendationMovieAnimation?.results {
                for i in 0..<5{
                    list.append( MovieWorkGenre(movieGenre:results[i]))
                }
            }
            return (list,.movie,.activityAnimationMovie,contentsId)
        case .imadTv:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.popularRecommendationTv?.contentsID
            for i in (vmRecommend.recommendAll?.popularRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.tv,.imadTv,contentsId)
        case .imadMovie:
            var list:[WorkGenre] = []
            let contentsId = vmRecommend.recommendAll?.popularRecommendationMovie?.contentsID
            for i in (vmRecommend.recommendAll?.popularRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.movie,.imadMovie,contentsId)
        }
    }
    func textTitleView(_ text:String) -> some View{
        HStack{
            Text(text)
                .fontWeight(.black)
                .font(.title3)
                .foregroundColor(.customIndigo)
            Spacer()
            
        }
    }
    func workListView(_ filter:RecommendListType,width:CGFloat,height:CGFloat) -> some View{
        ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                LazyHGrid(rows: workItems){
                    ListView(items: list(filter).0){ work in
                        NavigationLink {
                            WorkView(id: work.id(),type: list(filter).1.rawValue)
                                .environmentObject(vmAuth)
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack(alignment: .leading){
                                KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: width,height: height)
                                    .cornerRadius(5)
                                Text((list(filter).1 == .tv ? work.name() : work.title()) ?? "")
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .frame(width: width)
                                    .foregroundColor(.black)
                                Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" : work.genreId()?.transMovieGenreCode() ?? "")
                                    .font(.caption)
                                    .lineLimit(1)
                                    .frame(width: width)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    func titleView(user:UserResponse) -> some View{
        HStack(spacing: 0){
            Text((user.nickname ?? "") + "님 환영합니다")
        }
        .font(.title)
        .fontWeight(.black)
        .padding(.horizontal)
        .padding(.bottom)
    }
    var trendView:some View{
        VStack(alignment: .leading){
               
            HStack{
                Text("인기작품")
                    .fontWeight(.black)
                    .font(.title3)
                    .foregroundColor(.customIndigo)
                Button {
                    withAnimation(.default){
                        trend = false
                    }
                } label: {
                    Text("영화")
                        .bold()
                        .opacity(trend ? 0.5 : 1.0)
                }
                Text(" l ").foregroundColor(.gray)
                Button {
                    withAnimation(.default){
                        trend = true
                    }
                    
                } label: {
                    Text("시리즈")
                        .opacity(trend ? 1.0 : 0.5)
                        .bold()
                }
                Spacer()
                allView(RecommendAllView(type: trend ? .trendTv : .trendMovie))
            }
            .padding(.horizontal)
            .foregroundColor(.customIndigo)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ListView(items: trend ? list(.trendTv).0 : list(.trendMovie).0) { work in
                        NavigationLink {
                            WorkView(id: work.id(),type: trend ? list(.trendTv).1.rawValue : list(.trendMovie).1.rawValue)
                                .environmentObject(vmAuth)
                                .navigationBarBackButtonHidden()
                        } label: {
                            KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 200,height: 250)
                                .overlay{
                                    ZStack{
                                        LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                                            .background(Material.ultraThin)
                                        VStack{
                                            KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 100,height: 160)
                                                .cornerRadius(5)
                                            Text(trend ? work.name() ?? "" : work.title() ?? "")
                                                .bold()
                                                .lineLimit(1)
                                                .frame(width: 175)
                                            Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" : work.genreId()?.transMovieGenreCode() ?? "")
                                                .font(.subheadline)
                                                .lineLimit(1)
                                                .frame(width: 175)
                                        }
                                        .foregroundColor(.white)
                                    }
                                }
                                .environment(\.colorScheme,.dark)
                                .cornerRadius(8)
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
    var rankingView:some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: rankingItems){
                if vm.rankingList.isEmpty{
                    ForEach(1...9,id: \.self){ _ in
                        NoImageView()
                            .frame(width: 300,height: 75)
                    }
                    .padding(.leading)
                }else{
                    ForEach(vm.rankingList.prefix(9),id:\.self){ rank in
                        NavigationLink {
                            WorkView(id: rank.contentsID,type: rank.contentsType)
                                .environmentObject(vmAuth)
                                .navigationBarBackButtonHidden()
                        } label: {
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
                                    .foregroundColor(.black)
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
                                ScoreView(score: rank.imadScore ?? 0, color: .customIndigo, font: .caption, widthHeight: 50)
                                    .padding(.trailing)
                            }
                        }
                        .frame(width: 300,height: 75)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        .padding(.leading)
                        
                    }
                }
            }
        }
    }
    func allView(_ view: some View) -> some View{
        NavigationLink {
            view
                .navigationBarBackButtonHidden()
                .environmentObject(vmAuth)
        } label: {
            Text("전체보기")
                .font(.subheadline)
                .fontWeight(.regular)
            .foregroundColor(.customIndigo)
        }
    }
    
    
    var filter:some View{
        VStack(alignment: .leading,spacing: 0){
            textTitleView("아이매드 차트")
            HStack(spacing: 5){
                HStack{
                    ForEach(RankingFilter.allCases,id:\.self){ ranking in
                        Button {
                            self.ranking = ranking
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
                allView(Text(""))
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
                Text("-").foregroundColor(.gray)
            }
        }
    }
    var todayView:some View{
        ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                NavigationLink {
                    ReviewDetailsView(goWork: false, reviewId: vm.popularReview?.reviewID ?? 0)
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    PopularView(review: vm.popularReview)
                        .shadow(radius: 1)
                }
                NavigationLink {
                    CommunityPostView(postingId:vm.popularPosting?.postingID ?? 0,main: true,back: .constant(false))
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    PopularView(posting: vm.popularPosting)
                        .shadow(radius: 1)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    //추천작
    func userActivityView(user:UserResponse)->some View{
        Group{
            VStack(alignment: .leading){
                if !list(.activityTv).0.isEmpty || !list(.activityMovie).0.isEmpty || !list(.activityAnimationTv).0.isEmpty || !list(.activityAnimationMovie).0.isEmpty{
                    textTitleView("내 작품 골라보기").padding(.horizontal)
                }
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ListView(items: Array(zip([list(.activityTv),list(.activityMovie),list(.activityAnimationTv),list(.activityAnimationMovie)], gradient))){ (work,background) in
                            if !work.0.isEmpty{
                                VStack(alignment: .leading,spacing: 5){
                                    HStack(alignment: .top){
                                        VStack(alignment: .leading,spacing: 0){
                                            Text("\(user.nickname ?? "")님을 위한")
                                            Text("\(work.2.name)")
                                        }
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title3)
                                        Spacer()
                                        NavigationLink {
                                            RecommendAllView(contentsId:work.3,type: work.2)
                                                .navigationBarBackButtonHidden()
                                                .environmentObject(vmAuth)
                                        } label: {
                                            Text("전체보기")
                                                .font(.caption)
                                                .fontWeight(.regular)
                                            .foregroundColor(.white)
                                        }
                                    }
                                    .font(.caption)
                                    .padding(.vertical,10)
                                    ListView(items: work.0) { element in
                                        Divider()
                                            .background(Color.white)
                                            .padding(.vertical,5)
                                        NavigationLink {
                                            WorkView(id: element.id(),type: work.1.rawValue)
                                                .environmentObject(vmAuth)
                                                .navigationBarBackButtonHidden()
                                        } label: {
                                            HStack{
                                                KFImageView(image: element.backdropPath()?.getImadImage() ?? (element.posterPath()?.getImadImage() ?? ""),width: 80,height: 45)
                                                    .cornerRadius(3)
                                                VStack(alignment: .leading) {
                                                    Text(element.genreType == .tv ? element.name() ?? "" : element.title() ?? "")
                                                        .frame(width: 100,alignment:.leading)
                                                        .lineLimit(1)
                                                        .bold()
                                                        .font(.subheadline)
                                                        .foregroundColor(.white)
                                                    
                                                    Text(element.genreType == .tv ? element.genreId()?.transTvGenreCode() ?? "" : element.genreId()?.transMovieGenreCode() ?? "")
                                                        .lineLimit(1)
                                                        .font(.caption)
                                                        .foregroundColor(.white)
                                                        .frame(width: 100,alignment:.leading)
                                                }
                                                .padding(.trailing,20)
                                                Image(systemName: "chevron.right")
                                                    .bold()
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background{
                                    background.cornerRadius(10)
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }.padding(.vertical)
        }
    }
    func recommendView(_ title:String,_ filter:RecommendListType) -> some View{
        VStack(alignment: .leading){
            HStack(alignment:.bottom){
                textTitleView(title)
                allView(RecommendAllView(type: filter))
            }
            .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    workListView(filter, width: 130, height: 180)
                }
                .padding(.bottom)
            }
        }
    }
}
