//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher



struct MainView: View {
    
    @State var ranking:RankingFilter = .week
    @StateObject var vm = RankingViewModel(rankingList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State private var rotationAngle: Angle = .zero
    @State var movieIndex = 0
    
    @State var isReview = false
    @State var select = 0
    @State var anima = false
    @Binding var search:Bool
    //   filterSelect @Binding var filterSelect:Bool
    
    var body: some View {
        ZStack{
            Color.white
            ScrollView(showsIndicators: false){
                VStack(spacing:10){
                    VStack(spacing: 0){
                        header
                        filter
                            .padding(.bottom)
                        rankingView
                            .padding(.bottom)
                        
                    }
                    .foregroundColor(.white)
                    .background{
                        MovieBackgroundView(url: vm.poster,height: 2, isBottomTransparency: false)
                    }
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50)
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .overlay{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text("작품을 검색해주세요..")
                                Spacer()
                            }
                            .padding(.leading)
                            .foregroundStyle(.gray)
                        }
                        .onTapGesture {
                            search = true
                        }
                        .padding()
                    
                    reviewPosting
                    //                    movieList
                    Spacer().frame(height: 100).foregroundColor(.white)
                }
            }
        }
        .navigationDestination(isPresented: $isReview){
            //            ReviewView(isReview: $isReview, review: poster)
            //                .navigationBarBackButtonHidden(true)
            //            WorkView(id: poster.id, type: poster.)
        }
        
        .ignoresSafeArea()
        .navigationDestination(isPresented: $search) {
            SearchView(postingMode: false, back: $search)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            vm.getWeekRanking(page: 1, type: "all")
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
        .onReceive(vm.success){
            if !vm.rankingList.isEmpty{
                startTimer()
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
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 3.0)){
                    if movieIndex < vm.rankingList.count - 1 {
                        movieIndex += 1
                        vm.poster = vm.rankingList[movieIndex].posterPath.getImadImage()
                    }else{
                        movieIndex = 0
                        vm.poster = vm.rankingList[movieIndex].posterPath.getImadImage()
                    }
                }
                withAnimation(Animation.linear(duration: 0.5)) {
                    rotationAngle += .degrees(180)
                }
            }
        }
    }
    
    var header:some View{
        HStack{
            HStack{
                Text("TOP100")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                Image("trophy")
                    .resizable()
                    .frame(width: 25,height: 20)
                    .rotation3DEffect(rotationAngle, axis: (x: 0, y: 1, z: 0))
            }
            
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "bell.fill")
                    .font(.title3)
                    .padding(.trailing)
            }
        }
        .padding(.vertical)
        .padding(.top,30)
    }
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .font(.title3)
                .bold()
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
        }
    }
    var reviewPosting:some View{
        VStack(alignment: .leading){
            Text("오늘의 리뷰&게시물")
                .font(.title3)
                .bold()
                .padding(.leading)
                .padding(.bottom)
            HStack(spacing: 10){
                VStack(alignment: .leading,spacing: 10){
                    Text("- 리뷰 -")
                        .font(.caption)
                        .bold()
                    VStack(alignment: .leading,spacing: 8){
                        
                        Text("#어벤져스")
                            .font(.caption)
                            .bold()
                        Text(CustomData.instance.dummyString)
                            .font(.caption2)
                    }
                    .frame(height: 120)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                VStack(alignment: .leading,spacing: 10){
                    Text("- 커뮤니티 -")
                        .font(.caption)
                        .bold()
                    VStack(alignment: .leading,spacing: 8){
                        HStack{
                            VStack(alignment: .leading,spacing: 8){
                                Text("아 이영화;;")
                                    .font(.system(size: 15))
                                
                                Text("#어벤져스")
                                    .font(.caption)
                                    .bold()
                            }
                            Spacer()
                            KFImage(URL(string: CustomData.instance.movieList[2]))
                                .resizable()
                                .frame(width: 50,height: 50)
                                .cornerRadius(10)
                        }
                        Text(CustomData.instance.dummyString)
                            .font(.caption2)
                    }.overlay(alignment: .topTrailing) {
                        
                    }
                    .frame(height: 120)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                
                
            }
            .padding(.horizontal)
            
        }.foregroundColor(.black)
    }
    
    var rankingView:some View{
        
        TabView{
            ForEach(vm.rankingList.chunks(ofCount: 3),id:\.self){ item in
                HStack{
                    ForEach(item,id:\.self){ element in
                        VStack(spacing: 15){
                            Text("\(element.rank). \(element.title)")
                                .font(.caption)
                            KFImageView(image: element.posterPath.getImadImage(),height: 150)
                                .cornerRadius(5)
                            HStack{
                                Circle()
                                    .trim(from: 0.0, to: anima ? 9.9 * 0.1 : 0)
                                    .stroke(lineWidth: 3)
                                    .rotation(Angle(degrees: 270))
                                    .frame(width: 50,height: 50)
                                    .overlay{
                                        VStack{
                                            Image(systemName: "star.fill")
                                                .font(.caption)
                                            Text(String(format: "%0.1f",  9.9))
                                                .font(.caption)
                                        }
                                    }
                                rankUpdateView(rank: element.rankChanged)
                            }
                           
                        }.padding(.horizontal,5)
                    }
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height/3 - 25)
        .padding(.horizontal)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
    
    var filter:some View{
        VStack(alignment:.leading,spacing: 5){
            ScrollView(.horizontal,showsIndicators: false){
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
                            .frame(width: 60,height: 25)
                            .padding(.vertical,5)
                            .overlay {
                                Text(ranking.name)
                                    .foregroundColor(self.ranking == ranking ? .customIndigo : .white)
                            }
                        }
                    }
                }
            }
            NavigationLink {
                
            } label: {
                Label {
                    Text("전체보기")
                } icon: {
                    Image(systemName: "line.3.horizontal")
                        .font(.subheadline)
                }
            }
        }
        .font(.caption)
        .padding(.leading)
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
                Text("--")
            }
        }
        
    }
    //    var movieList:some View{
    //        VStack{
    //
    //            ForEach(MovieGenreFilter.allCases,id:\.self){ genre in
    //                // Section(header:){
    //                ScrollView(.horizontal,showsIndicators: false){
    //                    genreHeader(name: genre.name).padding(.top)
    //                    HStack(spacing: 0){
    //                        ForEach(CustomData.instance.workList){ work in
    //                            Button {
    //                                //                                poster = work
    //                                isReview = true
    //                            } label: {
    //                                KFImageView(image: work.posterPath.getImadImage() ?? "",width: 150,height: 200)
    //
    //                                    .overlay(alignment:.topTrailing) {
    //                                        Circle()
    //                                            .trim(from: 0.0, to: anima ? 4 * 0.1 : 0)
    //                                            .stroke(lineWidth: 3)
    //                                            .rotation(Angle(degrees: 270))
    //                                            .frame(width: 40,height: 40)
    //                                            .overlay{
    //                                                VStack{
    //                                                    Image(systemName: "star.fill")
    //                                                        .font(.caption)
    //                                                    Text(String(format: "%0.1f", 4))
    //                                                        .font(.caption)
    //                                                }
    //                                            }
    //                                            .background{
    //                                                Circle().foregroundColor(.black.opacity(0.7))
    //                                            }
    //                                            .padding(5)
    //
    //                                    }
    //                            }
    //
    //                        }
    //
    //                    }
    //                }.padding(.bottom,5)
    //            }
    //
    //
    //        }
    //    }
    
}
