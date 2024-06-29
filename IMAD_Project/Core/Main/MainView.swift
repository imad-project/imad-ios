//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher


struct MainView: View {
    
    enum RecommendListType:String{
        case genreTv
        case genreMovie
        case trendTv
        case trendMovie
        case activityTv  = "시리즈"
        case activityAnimationTv = "애니메이션 시리즈"
        case activityMovie = "영화"
        case activityAnimationMovie = "애니메이션 영화"
        case imadTv = "시리즈1"
        case imadMovie
    }
    
    let gradient = [LinearGradient(colors: [.green.opacity(0.6),.cyan.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.pink.opacity(0.6),.yellow.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.gray.opacity(0.4),.gray.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.purple.opacity(0.7),.red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing),LinearGradient(colors: [.brown.opacity(0.5),.orange.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)].shuffled()
    let items = [ GridItem(.fixed(75)), GridItem(.fixed(75)), GridItem(.fixed(75))].shuffled()
    let initValue = [WorkGenre](repeating: TVWorkGenre(tvGenre: RecommendTVResponse(id: 0, name: "", posterPath: "", backdropPath: "")), count: 10)
    
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
                        adView
                        filter
                        rankingView
                        userActivityView(user: user)
                        todayView
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
            vm.getAllRanking(page: 1, type: "all")
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
    func list(_ filter:RecommendListType) -> ([WorkGenre],RecommendListType){
        switch filter{
        case .genreTv:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.preferredGenreRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.genreTv)
        case .genreMovie:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.preferredGenreRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.genreMovie)
        case .trendTv:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.trendRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.trendTv)
        case .trendMovie:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.trendRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.trendMovie)
        case .activityTv:
            var list:[WorkGenre] = []
            if let results = vmRecommend.recommendAll?.userActivityRecommendationTv?.results {
                for i in 0..<5{
                    list.append( TVWorkGenre(tvGenre:results[i]))
                }
            }
            return (list,.activityTv)
        case .activityAnimationTv:
            var list:[WorkGenre] = []
            if let results = vmRecommend.recommendAll?.userActivityRecommendationTvAnimation?.results {
                for i in 0..<5{
                    list.append( TVWorkGenre(tvGenre:results[i]))
                }
            }
            return (list,.activityAnimationTv)
        case .activityMovie:
            var list:[WorkGenre] = []
            if let results = vmRecommend.recommendAll?.userActivityRecommendationMovie?.results {
                for i in 0..<5{
                    list.append( MovieWorkGenre(movieGenre:results[i]))
                }
            }
            return (list,.activityMovie)
        case .activityAnimationMovie:
            var list:[WorkGenre] = []
            if let results = vmRecommend.recommendAll?.userActivityRecommendationMovieAnimation?.results {
                for i in 0..<5{
                    list.append( MovieWorkGenre(movieGenre:results[i]))
                }
            }
            return (list,.activityAnimationMovie)
        case .imadTv:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.popularRecommendationTv?.results ?? []){
                list.append( TVWorkGenre(tvGenre:i))
            }
            return (list.isEmpty ? initValue : list,.imadMovie)
        case .imadMovie:
            var list:[WorkGenre] = []
            for i in (vmRecommend.recommendAll?.popularRecommendationMovie?.results ?? []){
                list.append( MovieWorkGenre(movieGenre:i))
            }
            return (list.isEmpty ? initValue : list,.imadMovie)
        }
    }
    func textTitleView(_ text:String) -> some View{
        Text(text)
            .fontWeight(.black)
            .font(.body)
            .foregroundColor(.customIndigo)
    }
    func workListView(_ filter:RecommendListType,width:CGFloat,height:CGFloat,text:Bool) -> some View{
        ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                ListView(items: list(filter).0) { work in
                    NavigationLink {
                        WorkView()
                            .environmentObject(vmAuth)
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack{
                            KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: width,height: height)
                                .cornerRadius(5)
                            if text{
                                Text(work.genreType == .tv ? work.name() ?? "" : work.title() ?? "")
                                    .lineLimit(1)
                                    .frame(width: width)
                                    .foregroundColor(.black)
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
            Text(user.nickname ?? "").bold()
            Text("님 환영합니다")
        }
        .font(.title2)
        .padding(.horizontal)
    }
    var trendView:some View{
        VStack{
            HStack{
                textTitleView("요즘 트렌드 작품")
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
            workListView(trend ? .trendTv : .trendMovie, width: 180, height: 250, text: true)
        }
    }
    var adView:some View{
        Image("ad")
            .resizable()
            .frame(height: 70)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical)
    }
    var rankingView:some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: items){
                if vm.rankingList.isEmpty{
                    ForEach(1...9,id: \.self){ _ in
                        NoImageView()
                            .frame(width: 300,height: 75)
                    }
                    .padding(.leading)
                }else{
                    ForEach(vm.rankingList.prefix(9),id:\.self){ rank in
                        NavigationLink {
                            WorkView(id: rank.contentsID)
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
    var todayView:some View{
        VStack(alignment: .leading){
            textTitleView("오늘의 리뷰&게시물")
                .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    NavigationLink {
                        ReviewDetailsView(goWork: false, reviewId: vm.popularReview?.reviewID ?? 0)
                            .environmentObject(vmAuth)
                            .navigationBarBackButtonHidden()
                    } label: {
                        PopularView(review: vm.popularReview)
                            .shadow(radius: 1)
                            .frame(width: 200)
                    }
                    NavigationLink {
                        CommunityPostView(postingId:vm.popularPosting?.postingID ?? 0,main: true,back: .constant(false))
                            .environmentObject(vmAuth)
                            .navigationBarBackButtonHidden()
                    } label: {
                        PopularView(posting: vm.popularPosting)
                            .shadow(radius: 1)
                            .frame(width: 200)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
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
                                            Text("\(work.1.rawValue)")
                                        }
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.title3)
                                        Spacer()
                                        NavigationLink {
                                            
                                        } label: {
                                            Label {
                                                Text("전체보기")
                                            } icon: {
                                                Image(systemName: "line.3.horizontal")
                                                    .font(.subheadline)
                                            }
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
                                            
                                        } label: {
                                            HStack{
                                                KFImageView(image: element.backdropPath()?.getImadImage() ?? "",width: 80,height: 45)
                                                    .cornerRadius(3)
                                                Text(element.genreType == .tv ? element.name() ?? "" : element.title() ?? "")
                                                    .frame(width: 100,alignment:.leading)
                                                    .lineLimit(1)
                                                    .bold()
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                                    .padding(.trailing,30)
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
            textTitleView(title)
                .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    workListView(filter, width: 120, height: 200, text: false)
                }
                .padding(.bottom)
            }
        }
    }
}
