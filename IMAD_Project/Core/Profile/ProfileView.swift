//
//  ProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/08.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State var phase:CGFloat = 0.0
    @State var change = false
    @State var delete = false
    @State var logout = false
    
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    @EnvironmentObject var vmAuth:AuthViewModel
    @State var review = false
    @State var posting = false
    @State var bookmark = false
    @State var qna = false
    @State var notice = false
    @State var setting = false
    
    @State var profileImage = ""
    
    var body: some View {
            VStack(alignment: .leading,spacing: 0){
                VStack(alignment: .leading,spacing: 0){
                    header
                        .padding(.bottom)
                    Text("내정보")
                        .font(.caption)
                        .bold()
                        .padding(.leading,20)
                        .padding(5)
                        .padding(.bottom,5)
                    Button {
                        change = true
                    } label: {
                        HStack{
                            ZStack{
                                Circle()
                                     .frame(width: 70,height: 70)
                                     .clipShape(Circle())
                                     .foregroundColor(.white)
                                Image(profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70,height: 70)
                                    .clipShape(Circle())
                                Image(vmAuth.getUserRes?.data?.gender ?? "")
                                    .resizable()
                                    .frame(width: 50,height: 40)
                            }
                            VStack(alignment: .leading,spacing:10){
                                Text("\(vmAuth.getUserRes?.data?.nickname ?? "    ")님")
                                    .bold()
                                Text(verbatim: "\(vmAuth.getUserRes?.data?.email ?? "")")//이메일 색깔 변경 무시
                                    .font(.caption)
                                
                            }
                            Spacer()
                            Group{
                                Text("변경")
                                    .font(.caption)
                                
                            }
                            .padding(.horizontal,10)
                            .padding(5)
                            .overlay {
                                Capsule()
                                    .stroke(style: .init(lineWidth: 1.0))
                            }
                            
                        }.padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(20)
                            .padding([.bottom,.horizontal])
                    }
                    
                }
                .sheet(isPresented: $change){
                    ProfileChangeView()
                        .environmentObject(vmAuth)
                }
                .background{
                        BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
                            .rotationEffect(Angle(degrees: 180))
                    
                    
                }
                Text("관심도")
                    .font(.caption)
                    .bold()
                    .padding(.leading,20)
                    .foregroundColor(.customIndigo)
                    .padding(.top,10)
                genre
                Divider()
                    .padding(.horizontal)
                ScrollView(showsIndicators: false){
                    menu
                }
                Spacer()
            }.onAppear{
                for image in ProfileFilter.allCases{
                    if let imageCode = vmAuth.getUserRes?.data?.profileImage,imageCode == image.num{
                        profileImage = image.rawValue
                    }
                }
            }
            .background{
                Color.white
            }
            .foregroundColor(.white)
            .ignoresSafeArea()
        
            
            
        
    }
    func getPercentage(geo:GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width * 0.4
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX/maxDistance))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}

extension ProfileView{
    var header:some View{
        VStack{
            HStack{
                Text("프로필")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                Spacer()
                
            }
            
        }
        .padding(.vertical)
        .padding(.top,30)
        
    }
    var menu:some View{
        VStack{
            LazyVGrid(columns: columns,alignment: .center) {
                ForEach(SettingFilter.allCases,id:\.self){ item in
                    Button {
                        switch item{
                        case .review:
                            return review = true
                        case .posting:
                            return posting = true
                        case .bookmark:
                            return bookmark = true
                        case .qna:
                            return qna = true
                        case .notice:
                            return notice = true
                        case .setting:
                            return setting = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100,height: 100)
                            .foregroundColor(.white)
                            .shadow(radius: 7.5)
                            .overlay{
                                VStack{
                                    Image(systemName: item.image)
                                        .font(.largeTitle)
                                        .padding(5)
                                    Text(item.name)
                                        .font(.caption)
                                    
                                }
                                .bold()
                            }
                    }
                    .padding()
                    .navigationDestination(isPresented: $review){
                        MyReviewView(title: "리뷰", back: $review)
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationDestination(isPresented: $posting){
                        MyReviewView(title: "게시물", back: $posting)
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationDestination(isPresented: $bookmark){
                        MovieListView(title: "내 찜목록", back: $bookmark)
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationDestination(isPresented: $qna){
                        
                    }
                    .navigationDestination(isPresented: $notice){
                        
                    }
                    .navigationDestination(isPresented: $setting){
                        
                    }
                }
            }
            .foregroundColor(.customIndigo)
            .padding(.horizontal)
            .padding(.top)
            HStack{
                Group{
                    Text("로그아웃")
                        .onTapGesture {
                            logout = true
                            delete = false
                        }
                    Text("회원탈퇴")
                        .foregroundColor(.red)
                        .onTapGesture {
                            logout = true
                            delete = true
                        }
                }
                .font(.callout)
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 10)
                    
            }
            .padding(.horizontal)
            .foregroundColor(Color.black.opacity(0.8))
            .bold()
            
        }
        .alert(isPresented: $logout) {
                    Alert(
                        title: delete ? Text("회원탈퇴"): Text("로그아웃"),
                        message: delete ? Text("정말로 회원을 탈퇴하시겠습니까? 한번 탈퇴하면 돌이킬 수 없습니다. 그래도 하시겠습니까?") : Text("정말로 로그아웃하시겠습니까?"),
                        primaryButton: .cancel(Text("취소")),
                        secondaryButton: .destructive(delete ? Text("탈퇴") : Text("로그아웃"), action: {
                            if delete{
                                vmAuth.delete()
                            }else{
                                vmAuth.logout()
                            }
                        })
                    )
                }
       
        
        
    }
    var genre:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(GenreFilter.allCases,id:\.self){ item in
                    VStack{
                        Image(item.rawValue)
                            .resizable()
                            .frame(width:200,height:150)
                            .overlay{
                                Color.black.opacity(0.5)
                                VStack(spacing:0){
                                    HStack{
                                        Text(item.generName)
                                            .font(.caption)
                                            .bold()
                                            .padding([.top,.leading])
                                        Spacer()
                                    }
                                    Circle()
                                        .trim(from: 0.0, to: 0.78)
                                        .stroke(lineWidth: 2)
                                        .rotation(Angle(degrees: 270))
                                        .foregroundColor(.white)
                                        .padding(20)
                                        .overlay{
                                            Text("78°")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                }
                            }
                            .shadow(radius:5)
                            .clipShape(RoundedRectangle(cornerRadius:20))
                    }
                    .padding(.leading,20)
                    .padding(.bottom)
                }
            }
            .padding(.vertical,10)
            .padding(.trailing,20)
        }
        .bold()
    }
}
