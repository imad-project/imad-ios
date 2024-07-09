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
    
    @State var imageCode:ProfileFilter = .indigo
    
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var vmProfile = ProfileImageViewModel()
    @StateObject var vm = ReviewViewModel(review:nil,reviewList: [])
    @StateObject var vmWork = WorkViewModel(workInfo: nil,bookmarkList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @State var profileSelect = false
    @State var gallery = false
    @State var basic = false
    @State var croppedImage:UIImage?
    
    
    @State var loading = false
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
        VStack{
            if loading{
                CustomProgressView()
            }
            else{
                header
                ScrollView(showsIndicators: false){
                    if let user = vmAuth.user?.data{
                        LazyVStack(pinnedViews: [.sectionHeaders]){
                            VStack(spacing: 0){
                                profileImageView
                                Divider()
                                HStack{
                                    myInfoView(view:
                                                MyReviewView(writeType: .myself)
                                        .environmentObject(vmAuth),
                                               image: "star.bubble",
                                               text: "내 리뷰", count: vmWork.profileInfo?.myReviewCnt ?? 0)
                                    myInfoView(view:  MyCommunityListView(writeType: .myself)
                                        .environmentObject(vmAuth),
                                               image:  "text.word.spacing",
                                               text: "내 게시물", count: vmWork.profileInfo?.myPostingCnt ?? 0)
                                    myInfoView(view: MyScrapListView(), image: "scroll", text: "내 스크랩", count: vmWork.profileInfo?.myScrapCnt ?? 0)
                                }
                                VStack{
                                    VStack(alignment: .leading) {
                                        Text("내 반응").font(.custom("GmarketSansTTFMedium", size: 15))
                                        navigationListRowView(view: MyReviewView(writeType: .myselfLike).environmentObject(vmAuth), image: "star.leadinghalf.filled", text: "리뷰")
                                        navigationListRowView(view: MyCommunityListView(writeType: .myselfLike).environmentObject(vmAuth), image: "note.text", text: "게시물")
                                    }.padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding([.horizontal,.top],10)
                                    VStack(alignment: .leading) {
                                        Text("내 장르").font(.custom("GmarketSansTTFMedium", size: 15))
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
                            
                            
                        }
                        .sheet(isPresented: $basic) {
                            profileSelectView(user: user)
                        }
                    }
                }
            }
        }
        
        .foregroundColor(.customIndigo)
        .colorScheme(.light)
        .sheet(isPresented: $tv) {
            GenreSelectView(genreType: .tv, dismiss: $tv)
                .environmentObject(vmAuth)
                .presentationDetents([.fraction(0.7)])
        }
        .sheet(isPresented: $movie) {
            GenreSelectView(genreType: .movie, dismiss: $movie)
                .environmentObject(vmAuth)
                .presentationDetents([.fraction(0.7)])
        }
        .onAppear{
            vmWork.getProfile(page: 1)
        }
        .onDisappear{
            vmWork.bookmarkList.removeAll()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .onReceive(vmProfile.profileChanged) {
            vmAuth.user?.data?.profileImage = vmProfile.url
            loading = false
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
                .font(.custom("GmarketSansTTFMedium", size: 25)).bold()
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
        .padding(.horizontal,10)
        .padding(.top,10)
        .background(Color.white)
    }
    var profileImageView:some View{
        HStack(spacing:0){
            Button {
                profileSelect = true
            } label: {
                ProfileImageView(imagePath: vmAuth.user?.data?.profileImage ?? "",widthHeigt: 60)
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
            .confirmationDialog("", isPresented: $profileSelect,actions: {
                Button(role:.none){
                    basic = true
                } label: {
                    Text("기본 프로필 이미지")
                }
                Button(role:.none){
                    gallery = true
                } label: {
                    Text("갤러리")
                }
            },message: {
                Text("어떤 프로필로 선택하시겠습니까?")
            })
            .cropImagePicker(show: $gallery, croppedImage: $croppedImage)
            .onChange(of: croppedImage) { value in
                if let value{
                    vmProfile.defaultImage = .none
                    let image = value.resize(targetSize: CGSize(width: 128, height: 128))
                    let renderer = ImageRenderer(content: Image(uiImage: image))
                    if let imageData = renderer.uiImage?.jpegData(compressionQuality: 1.0) {
                        vmProfile.fetchProfileImageCustom(image: imageData)
                        vmProfile.defaultImage = .indigo
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
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top,2)
                Text("\(vmAuth.user?.data?.birthYear ?? 0)년생")
                    .font(.subheadline)
                
                
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
                    Text(text).font(.custom("GmarketSansTTFMedium", size: 12))
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
                    Text(text).font(.custom("GmarketSansTTFMedium", size: 15))
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
                    Text(text).font(.custom("GmarketSansTTFMedium", size: 15))
                    Spacer()
                }.padding(.vertical,5)
            }
        }
    }
    
    var movieList:some View{
        VStack(alignment: .leading) {
            HStack{
                Text("내가 찜한 작품")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .padding(.vertical,10)
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
                                        KFImageView(image: item.contentsPosterPath.getImadImage(),height: (UIScreen.main.bounds.width/3)*1.25)
                                            .cornerRadius(5)
                                            .shadow(radius: 1)
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
                                        .font(.custom("GmarketSansTTFMedium", size: 15))
                                    Image(systemName: "chevron.right")
                                    Spacer()
                                }
                                .font(.subheadline)
                                .padding(.vertical,8)
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
                        ForEach(ProfileFilter.allCases,id: \.rawValue){ profile in
                            if profile != .none{
                                Button {
                                    if !isCondition(profile:profile){
                                        loading = true
                                        vmProfile.fetchProfileImageDefault(image: profile.num.getImageValue())
                                        profileSelect = false
                                        basic = false
                                    }
                                } label: {
                                    ZStack{
                                        Circle()
                                            .frame(width: 100,height: 100)
                                            .shadow(color:profile.color,radius: 1)
                                            .foregroundColor(.white)
                                        Image(profile.rawValue)
                                            .resizable()
                                            .frame(width: 100,height: 100)
                                        Circle()
                                            .frame(width: 100,height: 100)
                                            .foregroundColor(isCondition(profile: profile) ? .black.opacity(0.5) : .clear)
                                        
                                    }
                                    .padding(.vertical,25)
                                    .padding(.horizontal,5)
                                }
                                
                            }
                        }
                    }.padding(.leading)
                }
                
                .frame(height: 20)
                .padding(.bottom,30)
            }
        }
        .presentationDetents([.fraction(0.3)])
    }
    func isCondition(profile:ProfileFilter)->Bool{
        guard let profileImage = vmAuth.user?.data?.profileImage else {return false}
        guard profileImage.contains("default_profile_image") else {return false}
        return ProfileFilter.allCases.first(where: {$0.num == profileImage.getImageCode()}) == profile
    }
}
