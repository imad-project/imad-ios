//
//  ProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/08.
//

import SwiftUI
import Kingfisher
import SwiftUIFlowLayout

struct ProfileView: View {
    
    @State var imageCode:ProfileFilter = .none
    @State var authProvider = ""
    @State var tokenExpired = (false,"")
    
    @State var profileSelect = false
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var vm = ReviewViewModel(reviewList: [])
    @StateObject var vmWork = WorkViewModel(workInfo: nil)
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var tv = false
    @State var tvCollection:[TVGenreFilter] = []
    @State var movie = false
    @State var movieCollection:[MovieGenreFilter] = []
    
    @State var review = false
    @State var posting = false
    @State var bookmark = false
    @State var qna = false
    @State var notice = false
    @State var setting = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                VStack(spacing: 0){
                    VStack(spacing: 0){
                        Button {
                            withAnimation(.easeIn(duration:0.5)){
                                profileSelect = true
                            }
                        } label: {
                            Group{
                                ZStack{
//                                    ForEach(ProfileFilter.allCases.filter({$0.num == vmAuth.getUserRes?.data?.profileImage ?? 0}),id:\.self){ image in
//                                        Image("\(image)")
//                                            .resizable()
//                                            .frame(width:80,height:80)
//                                            .cornerRadius(15)
//                                    }
                                }
                            }
                            .frame(width: 100,height: 100)
                            .overlay(alignment:.bottomTrailing){
                                Circle()
                                    .foregroundColor(.black.opacity(0.7))
                                    .frame(width: 30,height: 30)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }
                            }
                            
                        }
                        
                        
                    }
//                    Text(vmAuth.getUserRes?.data?.nickname ?? "콰랑")
//                        .font(.title3)
//                        .bold()
//                        .padding(.top)
                    Text(authProvider)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .onAppear{
//                            switch vmAuth.getUserRes?.data?.authProvider{
//                            case "IMAD":
//                                authProvider = "아이매드 회원"
//                            case "KAKAO":
//                                authProvider = "카카오 회원"
//                            case "APPLE":
//                                authProvider = "애플 회원"
//                            case "NAVER":
//                                authProvider = "네이버 회원"
//                            case "GOOGLE":
//                                authProvider = "구글 회원"
//                            case .none:
//                                return
//                            case .some(_):
//                                return
//                            }
                        }
                    VStack(alignment: .leading) {
                        Text("내 활동").bold()
                            .padding(.top)
                        HStack{
                            Group{
                                NavigationLink {
                                    MyReviewView(mode:0)
                                        .environmentObject(vm)
                                        .environmentObject(vmAuth)
                                        .navigationBarBackButtonHidden()    
                                } label: {
                                    VStack(spacing:10){
                                        Image(systemName: "star.bubble")
                                            .font(.title)
                                            .foregroundColor(.yellow)
                                        Text("내 리뷰").font(.caption)
                                        Text("\(vm.myReviewCnt)").bold()
                                        
                                    }
                                }

                                
                                VStack(spacing:10){
                                    Image(systemName: "text.word.spacing")
                                        .font(.title)
                                    Text("내 게시물")
                                        .font(.caption)
                                    Text(numberFormatter(number: 1203)).bold()
                                }
                                NavigationLink {
                                    MyReviewView(mode:1)
                                        .environmentObject(vm)
                                        .environmentObject(vmAuth)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    VStack(spacing:10){
                                        ZStack{
                                            Image(systemName: "heart.fill")
                                                .font(.title)
                                                .foregroundColor(.blue)
                                                .offset(x:3)
                                                .rotationEffect(Angle(degrees: -10))
                                            Image(systemName: "heart.fill")
                                                .font(.title)
                                                .foregroundColor(.red)
                                                .offset(x:-3)
                                                .rotationEffect(Angle(degrees: 10))
                                        }
                                        
                                        Text("내 반응")
                                            .font(.caption)
                                        Text("\(vm.myLikeReviewCnt)").bold()
                                        
                                    }
                               
                                }
                            }.frame(maxWidth:.infinity)
                                .frame(height:100)
                                .padding()
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                }
                            
                        }
                        HStack{
                            Text("관심 시리즈 장르").bold()
                            Spacer()
                            Button {
                                tv = true
                            } label: {
                                Text("수정하기 >")
                                    .font(.caption)
                            }
                        }
                        .padding(.top)
                        tvGenre
                        HStack{
                            Text("관심 영화 장르").bold()
                            Spacer()
                            Button {
                                movie = true
                            } label: {
                                Text("수정하기 >")
                                    .font(.caption)
                            }
                        }
                        .padding(.top)
                        movieGenre
                        HStack{
                            Text("찜 작품 목록").bold()
                            Spacer()
                            if vmWork.myBookmarkList.count > 6{
                                NavigationLink {
                                    MyBookmarkListView()
                                        .navigationBarBackButtonHidden()
                                        .environmentObject(vmWork)
                                        .environmentObject(vmAuth)
                                } label: {
                                    Text("전체보기 >")
                                        .font(.caption)
                                }
                            }
                        }
                        .padding(.top)
                        movieList
                            .padding(.bottom,80)
                    }.padding(.horizontal)
                    Spacer()
                }
            }.background(Color.white)
                .navigationBarItems(leading: Text("프로필").font(.title2).bold(), trailing: NavigationLink(destination: ProfileChangeView().environmentObject(vmAuth), label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title3)
                }))
                .foregroundColor(.customIndigo)
            
        }.colorScheme(.light)
            .background{
                Color.white
            }
            .ignoresSafeArea()
            .sheet(isPresented: $profileSelect) {
                ZStack{
                    Color.white.ignoresSafeArea()
                    VStack{
                        Text("프로필 선택")
                            .font(.title)
                            .bold()
                            .padding()
                            .padding(.bottom,50)
                            .foregroundColor(.black)
                        LazyVGrid(columns: columns,spacing: 30) {
                            ForEach(ProfileFilter.allCases,id:\.rawValue){ item in
                                if item != .none{
                                    Button {
                                        imageCode = item
                                        profileSelect = false
                                    } label: {
                                        VStack{
                                            Image(item.rawValue)
                                                .resizable()
                                                .frame(width: 150,height: 150)
                                                .overlay {
                                                    if imageCode == item{
                                                        Color.black.opacity(0.7)
                                                    }
                                                }
                                                .cornerRadius(20)
                                            Text(item.name)
                                                .foregroundColor(.black)
                                                .bold()
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
                
            }
            .onChange(of: imageCode) { newValue in
//                vmAuth.patchUser(gender: vmAuth.profileInfo.gender, ageRange: vmAuth.profileInfo.ageRange, image:imageCode.num, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre:vmAuth.profileInfo.tvGenre ?? [],movieGenre:vmAuth.profileInfo.movieGenre ?? [])
            }
            .sheet(isPresented: $tv) {
                tvGenreSelect
            }
            .sheet(isPresented: $movie) {
                movieGenreSelect
            }
            .onAppear{
                vm.myReviewList(page: vm.currentPage)
                vm.myLikeReviewList(page: vm.currentPage)
                vmWork.page = 1
                vmWork.myBookmarkList = []
                vmWork.getBookmark(page: vmWork.page)
//                guard let tvGenres = vmAuth.profileInfo.tvGenre else {return}
//                tvCollection = TVGenreFilter.allCases.filter({tvGenres.contains($0.rawValue)})
            }
            .onAppear{
//                guard let movieGenres = vmAuth.profileInfo.movieGenre else {return}
//                movieCollection = MovieGenreFilter.allCases.filter({movieGenres.contains($0.rawValue)})
            }
            .onReceive(vm.tokenExpired) { messages in
                tokenExpired = (true,messages)
            }
            .alert(isPresented: $tokenExpired.0) {
                Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
//                    vmAuth.loginMode = false
                })
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ReviewViewModel(reviewList: CustomData.instance.reviewDetail))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension ProfileView{
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    var movieGenre:some View{
        ZStack{
            if movieCollection.isEmpty{
                Text("관심있는 영화 장르가 없습니다")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .padding(.top,5)
            }else{
                FlowLayout(mode: .scrollable, items: movieCollection) { item in
                    HStack{
                        Text(item.name)
                        Text(item.image)
                    }
                    .font(.subheadline)
                    .bold()
                    .padding(8)
                    .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                }.foregroundColor(.customIndigo.opacity(0.5))
            }
        }
    }
    var tvGenre:some View{
        ZStack{
            if tvCollection.isEmpty{
                Text("관심있는 시리즈 장르가 없습니다")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .padding(.top,5)
            }else{
                FlowLayout(mode: .scrollable, items: tvCollection) { item in
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.subheadline)
                        .bold()
                        .padding(8)
                        .padding(.horizontal)
                        .background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                    
                }.foregroundColor(.customIndigo.opacity(0.5))
                
            }
        }
        
    }
    var movieList:some View{
        ZStack{
            if  vmWork.myBookmarkList.isEmpty{
                Text("찜한 작품이 존재하지 않습니다")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .padding(.top,5)
            }else{
                LazyVGrid(columns: genreColumns) {
                    ForEach(vmWork.myBookmarkList.prefix(6),id:\.self){ item in
                        NavigationLink {
                            WorkView(contentsId: item.contentsID)
                                .environmentObject(vmAuth)
                        } label: {
                            VStack{
                                KFImage(URL(string: item.contentsPosterPath.getImadImage()))
                                    .resizable()
                                    .frame(height: 170)
                                    .cornerRadius(10)
                                Text(item.contentsTitle)
                                    .font(.caption)
                                    .frame(width: 200)
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
    }
    var movieGenreSelect:some View{
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("내 장르 수정").bold()
                    .padding(.leading)
                FlowLayout(mode: .scrollable, items: movieCollection) { item in
                    Button {
                        movieCollection = movieCollection.filter({$0 != item})
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                           
                        }
                        .font(.subheadline)
                        .bold()
                        .padding(8)
                        .padding(.trailing)
                        .overlay(alignment:.trailing) {
                            Image(systemName: "xmark").font(.caption)
                        }
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1))
                        .foregroundColor(.customIndigo)
                    }
                }
                .padding()
                
                Divider()
                    .padding(.vertical)
                FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases) { item in
                    Button {
                        if movieCollection.contains(item){
                            movieCollection = movieCollection.filter({$0 != item})
                        }else{
                            movieCollection.append(item)
                        }
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.subheadline)
                        .bold()
                        .padding(8)
                       
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                        
                    }
                    
                }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                Button {
                    movie = false
//                    vmAuth.patchUser(gender: vmAuth.profileInfo.gender ?? "", ageRange: vmAuth.profileInfo.ageRange, image: vmAuth.profileInfo.profileImage, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre: vmAuth.profileInfo.tvGenre, movieGenre: movieCollection.map({$0.rawValue}))
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }
                .padding()
                
            }
        }.foregroundColor(.customIndigo)
        
    }
    var tvGenreSelect:some View{
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("내 장르 수정").bold()
                    .padding(.leading)
                FlowLayout(mode: .scrollable, items: tvCollection) { item in
                    Button {
                        tvCollection = tvCollection.filter({$0 != item})
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.subheadline)
                        .bold()
                        .padding(8)
                        .padding(.trailing)
                        .overlay(alignment:.trailing) {
                            Image(systemName: "xmark").font(.caption)
                        }
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1))
                        .foregroundColor(.customIndigo)
                    }
                }
                .padding()
                
                Divider()
                    .padding(.vertical)
                FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                    Button {
                        if tvCollection.contains(item){
                            tvCollection = tvCollection.filter({$0 != item})
                        }else{
                            tvCollection.append(item)
                        }
                        
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.subheadline)
                        .bold()
                        .padding(8)
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                    }
                    
                }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                Button {
                    tv = false
//                    vmAuth.patchUser(gender: vmAuth.profileInfo.gender ?? "", ageRange: vmAuth.profileInfo.ageRange, image: vmAuth.profileInfo.profileImage, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre: tvCollection.map({$0.rawValue}), movieGenre: vmAuth.profileInfo.movieGenre)
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }
                .padding()
            }
        }.foregroundColor(.customIndigo)
    }
}
