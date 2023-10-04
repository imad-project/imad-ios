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
    
    
    @State var profileSelect = false
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
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
                                    ForEach(ProfileFilter.allCases.filter({$0.num == vmAuth.getUserRes?.data?.profileImage ?? 0}),id:\.self){ image in
                                        Image("\(image)")
                                            .resizable()
                                            .frame(width:80,height:80)
                                            .cornerRadius(15)
                                    }
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
                    Text(vmAuth.getUserRes?.data?.nickname ?? "콰랑")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                    Text(authProvider)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .onAppear{
                            switch vmAuth.getUserRes?.data?.authProvider{
                            case "IMAD":
                                authProvider = "아이매드 회원"
                            case "KAKAO":
                                authProvider = "카카오 회원"
                            case "APPLE":
                                authProvider = "애플 회원"
                            case "NAVER":
                                authProvider = "네이버 회원"
                            case "GOOGLE":
                                authProvider = "구글 회원"
                            case .none:
                                return
                            case .some(_):
                                return
                            }
                        }
                    VStack(alignment: .leading) {
                        Text("내 활동").bold()
                            .padding(.top)
                        HStack{
                            Group{
                                VStack(spacing:10){
                                    Image(systemName: "star.bubble")
                                        .font(.title)
                                        .foregroundColor(.yellow)
                                    Text("내 리뷰").font(.caption)
                                    Text("12").bold()
                                    
                                }
                                VStack(spacing:10){
                                    Image(systemName: "text.word.spacing")
                                        .font(.title)
                                    Text("내 게시물")
                                        .font(.caption)
                                    Text("3").bold()
                                    
                                }
                                VStack(spacing:10){
                                    Image(systemName: "heart.fill")
                                        .font(.title)
                                        .foregroundColor(.red)
                                    Text("내 좋아요")
                                        .font(.caption)
                                    Text(numberFormatter(number: 1203)).bold()
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
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
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
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            }
                        }
                        .padding(.top)
                        movieGenre
                        Text("찜 작품 목록").bold()
                            .padding(.top)
                        movieList
                            .padding(.bottom,50)
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
                vmAuth.patchUser(gender: vmAuth.profileInfo.gender, ageRange: vmAuth.profileInfo.ageRange, image:imageCode.num, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre:vmAuth.profileInfo.tvGenre ?? [],movieGenre:vmAuth.profileInfo.movieGenre ?? [])
            }
            .sheet(isPresented: $tv) {
                tvGenreSelect
            }
            .sheet(isPresented: $movie) {
                movieGenreSelect
            }
            .onAppear{
                guard let tvGenres = vmAuth.profileInfo.tvGenre else {return}
                tvCollection = TVGenreFilter.allCases.filter({tvGenres.contains($0.rawValue)})
            }
            .onAppear{
                guard let movieGenres = vmAuth.profileInfo.movieGenre else {return}
                movieCollection = MovieGenreFilter.allCases.filter({movieGenres.contains($0.rawValue)})
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}

extension ProfileView{
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    var movieGenre:some View{
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
    var tvGenre:some View{
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
    var movieList:some View{
        LazyVGrid(columns: genreColumns) {
            //            ForEach(CustomData.instance.reviewList.shuffled(),id:\.self){ item in
            //                VStack{
            //                    KFImage(URL(string: item.thumbnail))
            //                        .resizable()
            //                        .frame(height: 200)
            //                        .cornerRadius(10)
            //                    Text(item.title)
            //                        .font(.caption)
            //                        .frame(width: 200)
            //                        .bold()
            //                }
            //
            //            }
        }
    }
    var movieGenreSelect:some View{
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("내 장르").bold()
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
                    vmAuth.patchUser(gender: vmAuth.profileInfo.gender ?? "", ageRange: vmAuth.profileInfo.ageRange, image: vmAuth.profileInfo.profileImage, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre: vmAuth.profileInfo.tvGenre, movieGenre: movieCollection.map({$0.rawValue}))
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
                Text("내 장르").bold()
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
                    vmAuth.patchUser(gender: vmAuth.profileInfo.gender ?? "", ageRange: vmAuth.profileInfo.ageRange, image: vmAuth.profileInfo.profileImage, nickname: vmAuth.profileInfo.nickname ?? "", tvGenre: tvCollection.map({$0.rawValue}), movieGenre: vmAuth.profileInfo.movieGenre)
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
