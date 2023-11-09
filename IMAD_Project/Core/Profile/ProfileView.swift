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
    //    @State var authProvider = ""
    //    @State var tokenExpired = (false,"")
    
    @State var profileSelect = false
    //    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var vm = ReviewViewModel(review:nil,reviewList: [])
    @StateObject var vmWork = WorkViewModel(workInfo: nil)
//    @Environment(\.dismiss)
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var tv = false
//    @State var tvCollection:[TVGenreFilter] = []
    @State var movie = false
//    @State var movieCollection:[MovieGenreFilter] = []
    
    @State var review = false
    @State var posting = false
    @State var bookmark = false
    
//    @State var qna = false
//    @State var notice = false
//    @State var setting = false
    
    var authProvider:String{
        if let user = vmAuth.user?.data{
            
            switch user.authProvider{
            case "IMAD":
                return "아이매드 회원"
            case "KAKAO":
                return "카카오 회원"
            case "APPLE":
                return "애플 회원"
            case "NAVER":
                return "네이버 회원"
            case "GOOGLE":
                return "구글 회원"
            default:
                return ""
            }
        }else{
            return ""
        }
    }
    
    var body: some View {
        NavigationView {
            if let user = vmAuth.user?.data{
                ScrollView(showsIndicators: false){
                    LazyVStack(pinnedViews: [.sectionHeaders]){
                        Section {
                            VStack(spacing: 0){
                                profileImageView(user: user)
                                Divider()
                                HStack{
                                    myInfoView(view:  MyReviewView(mode:0),
                                               image: "star.bubble",
                                               color: .customIndigo.opacity(0.5),
                                               text: "내 리뷰", count: vm.myReviewCnt)
                                    myInfoView(view:  MyReviewView(mode:1),
                                               image:  "text.word.spacing",
                                               color: .customIndigo.opacity(0.5),
                                               text: "내 게시물", count: vm.myReviewCnt)
                                    myInfoView(view: MyReviewView(mode:1), image: "scroll", color: .customIndigo.opacity(0.5), text: "내 스크랩", count: vm.myLikeReviewCnt)
                                }
                                VStack{
                                    VStack(alignment: .leading) {
                                        Text("내 반응").bold()
                                        navigationListRowView(view: MyReviewView(mode:1), image: "star.leadinghalf.filled", text: "리뷰")
                                        navigationListRowView(view: MyReviewView(mode:1), image: "note.text", text: "게시물")
                                    }.padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding([.horizontal,.top],10)
                                    VStack(alignment: .leading) {
                                        Text("내 장르").bold()
                                        buttonListRowView(action: {movie  = true}, image: "popcorn", text: "영화")
                                        buttonListRowView(action: {tv  = true} , image: "tv", text: "TV/시리즈")
                                    }.padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding([.horizontal,.bottom],10)
                                    
                                }
                                .foregroundColor(.black)
                                    .background(Color.gray.opacity(0.1))
                                movieList
                            }
                        } header: {
                            header
                        }

                        
                    }
                }
                .ignoresSafeArea()
                .sheet(isPresented: $profileSelect) {
                    profileSelectView(user: user)
                }
                
                .foregroundColor(.customIndigo)
                
            }
            
        }.colorScheme(.light)
            
        
            
            .sheet(isPresented: $tv) {
                GenreSelectView(movieMode: true, dismiss: $movie)
                    .environmentObject(vmAuth)
                    .presentationDetents([.fraction(0.8)])
            }
            .sheet(isPresented: $movie) {
                GenreSelectView(movieMode: false, dismiss: $tv)
                    .environmentObject(vmAuth)
                    .presentationDetents([.fraction(0.7)])
            }
            .onAppear{
//                vm.myReviewList(page: vm.currentPage)
//                vm.myLikeReviewList(page: vm.currentPage)
//                vmWork.page = 1
//                vmWork.myBookmarkList = []
                vmWork.getBookmark(page: vmWork.page)
                //                guard let tvGenres = vmAuth.profileInfo.tvGenre else {return}
                //                tvCollection = TVGenreFilter.allCases.filter({tvGenres.contains($0.rawValue)})
            }
//            .onAppear{
                //                guard let movieGenres = vmAuth.profileInfo.movieGenre else {return}
                //                movieCollection = MovieGenreFilter.allCases.filter({movieGenres.contains($0.rawValue)})
//            }
        //            .onReceive(vm.tokenExpired) { messages in
        //                tokenExpired = (true,messages)
        //            }
        //            .alert(isPresented: $tokenExpired.0) {
        //                Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
        ////                    vmAuth.loginMode = false
        //                })
        //            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension ProfileView{
    var header:some View{
        HStack{
            Text("프로필")
                .font(.title2)
                .bold()
            Spacer()
            NavigationLink {
                ProfileChangeView()
                    .environmentObject(vmAuth)
                    .navigationBarBackButtonHidden()
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title3)
            }
        }
        .padding(.horizontal)
        .padding(.top,60)
        .background(Color.white)
    }
    func profileImageView(user:UserResponse) -> some View{
        VStack(spacing:0){
            Button {
                profileSelect = true
            } label: {
                ProfileImageView(imageCode: user.profileImage,widthHeigt: 100)
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
            Text(user.nickname ?? "")
                .font(.title3)
                .bold()
                .padding(.top)
            Text(authProvider)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top,2)
        }.padding(.vertical)
        .frame(maxWidth: .infinity)
        
    }
    func myInfoView(view:some View,image:String,color:Color,text:String,count:Int) -> some View{
        NavigationLink {
            view
                .environmentObject(vm)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        } label: {
            VStack(spacing:10){
                HStack{
                    Image(systemName: image)
                        .foregroundColor(color)
                    Text(text).font(.caption)
                }
                
                Text("\(count)개").bold()
                
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
    }
    func navigationListRowView(view:some View,image:String,text:String) -> some View{
        VStack{
            Divider()
            NavigationLink {
                view
                .navigationBarBackButtonHidden()
            } label: {
                HStack{
                    Image(systemName: image)
                    Text(text)
                    Spacer()
                    Image(systemName: "chevron.right")
                }.padding(.vertical,5)
            }
        }
    }
    func buttonListRowView(action: @escaping ()->(),image:String,text:String) -> some View{
        VStack{
            Divider()
            Button (action:action){
                HStack{
                    Image(systemName: image)
                    Text(text)
                    Spacer()
                }.padding(.vertical,5)
            }
        }
    }

    var movieList:some View{
        VStack(alignment: .leading) {
            HStack{
                Text("내가 찜한 작품").padding(.top,5).bold()
                Spacer()
            }
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
                                    KFImageView(image: item.contentsPosterPath.getImadImage(),height: 170)
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
        }.padding(.horizontal)
    }
    func profileSelectView(user:UserResponse) ->some View{
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                Text("프로필 선택")
                    .font(.title3)
                    .bold()
                    .padding()
                    .padding(.bottom,50)
                    .foregroundColor(.black)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(ProfileFilter.allCases,id:\.rawValue){ item in
                            if item != .none{
                                Button {
                                    vmAuth.patchUser.profileImageCode = item.num
                                    vmAuth.patchUserInfo()
                                    profileSelect = false
                                } label: {
                                    VStack{
                                        ProfileImageView(imageCode: item.num, widthHeigt: 80)
                                            .overlay {
                                                if user.profileImage == item.num{
                                                    Circle().foregroundColor(.black.opacity(0.5))
                                                }
                                            }
                                        if user.profileImage == item.num{
                                            Text("현재").bold()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 20)
                .padding(.bottom,30)
            }
        }
        .presentationDetents([.fraction(0.2)])
    }
    
}
