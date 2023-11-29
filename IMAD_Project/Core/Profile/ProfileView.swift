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
    @State var profileSelect = false
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var vm = ReviewViewModel(review:nil,reviewList: [])
    @StateObject var vmWork = WorkViewModel(workInfo: nil,bookmarkList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var tv = false
    @State var movie = false
    
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
        ScrollView(showsIndicators: false){
            if let user = vmAuth.user?.data{
                LazyVStack(pinnedViews: [.sectionHeaders]){
                    Section {
                        VStack(spacing: 0){
                            profileImageView
                            Divider()
                            HStack{
                                myInfoView(view:
                                            MyReviewView(writeType: .myself)
                                    .environmentObject(vmAuth),
                                           image: "star.bubble",
                                           text: "내 리뷰", count: 0)
                                myInfoView(view:  MyCommunityListView(writeType: .myself)
                                    .environmentObject(vmAuth),
                                           image:  "text.word.spacing",
                                           text: "내 게시물", count: 0)
                                myInfoView(view: MyScrapListView(), image: "scroll", text: "내 스크랩", count: 0)
                            }
                            VStack{
                                VStack(alignment: .leading) {
                                    Text("내 반응").bold()
                                    navigationListRowView(view: MyReviewView(writeType: .myselfLike).environmentObject(vmAuth), image: "star.leadinghalf.filled", text: "리뷰")
                                    navigationListRowView(view: MyCommunityListView(writeType: .myselfLike).environmentObject(vmAuth), image: "note.text", text: "게시물")
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
                .sheet(isPresented: $profileSelect) {
                    profileSelectView(user: user)
                }
            }
        }
        .ignoresSafeArea()
        .foregroundColor(.customIndigo)
        .colorScheme(.light)
        .sheet(isPresented: $tv) {
            TvGenreSelectView(dismiss: $tv)
                .environmentObject(vmAuth)
                .presentationDetents([.fraction(0.7)])
        }
        .sheet(isPresented: $movie) {
            MovieGenreSelectView(dismiss: $movie)
                .environmentObject(vmAuth)
                .presentationDetents([.fraction(0.7)])
        }
        .onAppear{
            vmWork.getBookmark(page: 1)
        }
        .onDisappear{
            vmWork.bookmarkList.removeAll()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ProfileView(vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail),vmWork:WorkViewModel(workInfo: nil, bookmarkList: CustomData.instance.bookmarkList))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
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
    var profileImageView:some View{
        HStack(spacing:0){
            Button {
                profileSelect = true
            } label: {
                ProfileImageView(imageCode: vmAuth.user?.data?.profileImage ?? 0,widthHeigt: 60)
                    .overlay(alignment:.bottomTrailing){
                        Circle()
                            .foregroundColor(.black.opacity(0.7))
                            .frame(width: 25)
                            .overlay {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                                    .font(.caption2)
                            }
                    }
            }
            VStack(alignment: .leading,spacing: 0) {
                HStack(spacing:0){
                    Text(vmAuth.user?.data?.nickname ?? "")
                        .font(.title3)
                        .bold()
                    Image(vmAuth.user?.data?.gender ?? "")
                        .resizable()
                        .frame(width: 20,height: 25)
                }
                Text(authProvider)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top,2)
                Text("만 \(vmAuth.user?.data?.ageRange ?? 0)세")
                    .font(.caption)
                
                
            }.padding(.leading)
        }.padding(.vertical)
            .frame(maxWidth: .infinity)
        
    }
    func myInfoView(view:some View,image:String,text:String,count:Int) -> some View{
        NavigationLink {
            view
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        } label: {
            VStack(spacing:10){
                HStack{
                    Image(systemName: image)
                        .foregroundColor(.customIndigo.opacity(0.5))
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
                    .environmentObject(vmAuth)
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
                if  vmWork.bookmarkList.isEmpty{
                    Text("찜한 작품이 존재하지 않습니다")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top,5)
                }else{
                    VStack{
                        LazyVGrid(columns: genreColumns) {
                            ForEach(vmWork.bookmarkList.prefix(6),id:\.self){ item in
                                NavigationLink {
                                    WorkView(contentsId: item.contentsID)
                                        .environmentObject(vmAuth)
                                        .navigationBarBackButtonHidden()
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
                        if vmWork.bookmarkList.count > 6{
                            NavigationLink {
                                MyBookmarkListView()
                                    .environmentObject(vmWork)
                                    .environmentObject(vmAuth)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack{
                                    Spacer()
                                    Text("찜한 작품 더보기")
                                        .bold()
                                        .font(.subheadline)
                                    Image(systemName: "chevron.right")
                                    Spacer()
                                }
                                .padding(.vertical,5)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                            }
                        }
                    }
                }
            }
        }.padding(.horizontal).padding(.bottom)
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
        .presentationDetents([.fraction(0.3)])
    }
    
}
