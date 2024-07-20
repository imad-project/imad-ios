//
//  OtherProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/20/24.
//

import SwiftUI

struct OtherProfileView: View {
    
    let id:Int
    let genreColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var vmUser = UserViewModel()
    @StateObject var vmReport = ReportViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State var noReport = false
    @State var reportSuccess = false
    @State var message = ""
    @State var report = false
    @State var goReport = false
    @State var profile = false
    
    var body: some View {
        VStack(spacing:0){
            VStack{
                Text("프로필")
                    .bold()
                    .font(.GmarketSansTTFMedium(25))
                    .padding(.top,30)
                ProfileImageView(imagePath: vmUser.profile?.userProfileImage ?? "", widthHeigt: 100)
                    .padding(.top,5)
                Text(vmUser.profile?.userNickname ?? "")
                    .font(.GmarketSansTTFMedium(15))
                    .padding(.top,5)
                Button {
                    report = true
                } label: {
                    Text("신고")
                        .foregroundColor(.white)
                        .padding(5)
                        .padding(.horizontal)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.customIndigo)
                        }
                }
                .padding(.vertical,5)
                Divider()
                HStack{
                    myInfoView(image:"star.bubble", text: "리뷰", count: vmUser.profile?.myReviewCnt ?? 0)
                    myInfoView(image:"text.word.spacing", text: "게시물", count: vmUser.profile?.myPostingCnt ?? 0)
                    myInfoView(image:"scroll", text: "스크랩", count: vmUser.profile?.myScrapCnt ?? 0)
                }
                Divider()
            }
            .background(Color.white)
            movieList.padding(.top,10)
            Spacer()
        }
        .background{
            Color.white.ignoresSafeArea()
            Color.gray.opacity(0.1).ignoresSafeArea()
        }
        .foregroundColor(.black)
        .onAppear{
            vmUser.fetchProfile(id: id, page: 1)
        }
        .fullScreenCover(isPresented: $report){
            ReportView(id: id, mode: "user")
                .environmentObject(vmReport)
        }
        .onReceive(vmReport.success){ message in
            reportSuccess = true
            self.message = message
        }
        .alert(isPresented: $reportSuccess){
            Alert(title: Text(message),message:message == "정상적으로 신고 접수가 완료되었습니다." ? Text("최대 24시간 이내로 검토가 진행될 예정입니다.") : nil, dismissButton:  .cancel(Text("확인"), action: {
                dismiss()
            }))
        }
    }
}

#Preview {
    OtherProfileView(id: 1)
        .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
}

extension OtherProfileView{
    func myInfoView(image:String,text:String,count:Int) -> some View{
        VStack(spacing:10){
            HStack{
                Image(systemName: image)
                    .foregroundColor(.customIndigo.opacity(0.5))
                Text(text).font(.custom("GmarketSansTTFMedium", size: 12))
            }
            
            Text("\(count)개").bold()
            
        }
        
        .padding(.vertical,20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
    var movieList:some View{
        VStack(alignment: .leading) {
            HStack{
                Text("\(vmUser.profile?.userNickname ?? "")님이 찜한 작품")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .padding(.vertical,10)
                Spacer()
            }
            ZStack{
                if  vmUser.bookmarkList.isEmpty{
                    Text("찜한 작품이 존재하지 않습니다")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top,5)
                }else{
                    VStack{
                        LazyVGrid(columns: genreColumns) {
                            ForEach(vmUser.bookmarkList.prefix(6),id:\.self){ item in
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
                                            .font(.GmarketSansTTFMedium(15))
                                            .frame(width: (UIScreen.main.bounds.width/3) - 20)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color.white)
    }
}
