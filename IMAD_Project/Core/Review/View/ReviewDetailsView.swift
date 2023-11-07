//
//  ReviewDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import SwiftUI
import Kingfisher

struct ReviewDetailsView: View {
    
    let goWork:Bool
    let reviewId:Int
    @State var like = 0
    @State var anima = false
    @State var menu = false
    @State var delete = false
    @State var tokenExpired = (false,"")
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ReviewViewModel(reviewList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading,pinnedViews: [.sectionHeaders]) {
                Section {
                    HStack{
                        Image(ProfileFilter.allCases.first(where: {$0.num == vm.reviewInfo?.userProfileImage })?.rawValue ?? "soso")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30,height: 30)
                            .clipShape(Circle())
                        Text(vm.reviewInfo?.userNickname ?? "11")
                        Spacer()
                        Group{
                            if vm.reviewInfo?.createdAt ?? "" != vm.reviewInfo?.modifiedAt ?? ""{
                                Text("수정됨 ·").bold()
                                Text(vm.reviewInfo?.modifiedAt.relativeTime() ?? "")
                            }else{
                                Text(vm.reviewInfo?.createdAt.relativeTime() ?? "")
                            }
                        }.foregroundColor(.gray)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    
                    
                    HStack(alignment: .top) {
                        KFImage(URL(string: vm.reviewInfo?.contentsPosterPath.getImadImage() ?? CustomData.instance.movieList.first!))
                            .resizable()
                            .frame(width: 100,height: 120)
                            .scaledToFill()
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text("#" + (vm.reviewInfo?.contentsTitle ?? "")).bold().font(.subheadline)
                            Text((vm.reviewInfo?.spoiler ?? false) ? "스포일러" : "클린")
                                .font(.caption)
                                .padding(2)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                            Text(vm.reviewInfo?.title ?? "")
                                .font(.subheadline).bold()
                            
                        }
                        Spacer()
                        Circle()
                            .trim(from: 0.0, to: anima ? (vm.reviewInfo?.score ?? 0) * 0.1 : 0)
                            .stroke(lineWidth: 3)
                            .rotation(Angle(degrees: 270))
                            .frame(width: 50,height: 50)
                            .overlay{
                                VStack{
                                    Image(systemName: "star.fill")
                                    Text(String(format: "%0.1f", (vm.reviewInfo?.score ?? 0)))
                                }
                                .font(.caption)
                                Circle().stroke(lineWidth:0.1)
                            }
                            .shadow(radius: 20)
                            .padding(.bottom)
                    }.padding(.horizontal)
                    if goWork{
                        NavigationLink {
                            WorkView(contentsId:vm.reviewInfo?.contentsID ?? 0)
                                .environmentObject(vmAuth)
                        } label: {
                            HStack(spacing:1){
                                Text(vm.reviewInfo?.contentsTitle ?? "").bold()
                                Text("의 상세정보 보러가기")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.font(.caption)
                                .padding(10)
                                .background(Color.white).cornerRadius(10).shadow(radius: 1)
                                .padding(.horizontal)
                        }.padding(.vertical,7.5)
                    }
                    Text(vm.reviewInfo?.content ?? "")
                        .font(.subheadline).padding(.horizontal)
                    VStack(alignment: .leading){
                        VStack(alignment: .trailing){
                            Divider()
                            HStack{
                                Group{
                                    Button {
                                        if like < 1{
                                            like = 1
                                            vm.likeReview(id: vm.reviewInfo?.reviewID ?? 0, status: like)
                                        }else{
                                            like = 0
                                            vm.likeReview(id: vm.reviewInfo?.reviewID ?? 0, status: like)
                                        }
                                    } label: {
                                        Image(systemName: like == 1 ? "heart.fill":"heart")
                                        Text("좋아요")
                                    }
                                    .foregroundColor(like == 1 ? .red : .gray)
                                    Button {
                                        if like > -1{
                                            like = -1
                                            vm.likeReview(id: vm.reviewInfo?.reviewID ?? 0, status: like)
                                        }else{
                                            like = 0
                                            vm.likeReview(id: vm.reviewInfo?.reviewID ?? 0, status: like)
                                        }
                                    } label: {
                                        HStack{
                                            Image(systemName: like == -1 ? "heart.slash.fill" : "heart.slash")
                                            Text("싫어요")
                                        }
                                    }
                                    .foregroundColor(like == -1 ? .blue : .gray)
                                }
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                            }
                            Divider()
                            HStack(spacing: 2){
                                Image(systemName: "heart.fill").foregroundColor(.red)
                                Text("\((vm.reviewInfo?.likeCnt ?? 0))개")
                                    .padding(.trailing)
                                Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                                Text("\((vm.reviewInfo?.dislikeCnt ?? 0))개")
                            }
                            .font(.subheadline)
                        }.padding(.vertical)
                    }.padding()
                } header: {
                    header
                }
            }
        }
        .onTapGesture {
            menu = false
        }
        .confirmationDialog("ㅇㅇㅇ", isPresented: $delete){
            Button(role:.destructive){
                vm.deleteReview(id: reviewId)
                dismiss()
            } label: {
                Text("삭제")
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("리뷰를 삭제하시겠습니까?")
          }
        .ignoresSafeArea()
        .background(Color.white)
        .foregroundColor(.black)
        .onAppear{
            vm.readReview(id: reviewId)
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
        }
        .onReceive(vm.success) {
            like = vm.reviewInfo?.likeStatus ?? 0
        }
        .onDisappear{
            menu = false
        }
        .onReceive(vm.tokenExpired) { messages in
            tokenExpired = (true,messages)
        }
        .alert(isPresented: $tokenExpired.0) {
            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
//                vmAuth.loginMode = false
            })
        }
    }
}

struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ReviewDetailsView(goWork: true, reviewId: 1,vm: ReviewViewModel(reviewList: CustomData.instance.reviewDetail))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension ReviewDetailsView{
    var header:some View{
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                Spacer()
//                if vm.reviewInfo?.userNickname == vmAuth.profileInfo.nickname{
//                    ZStack{
//                        Button {
//                            withAnimation {
//                                menu.toggle()
//                            }
//                        } label: {
//                            Image(systemName: "ellipsis")
//                                .font(.title3)
//                        }
//                        
//                    }
//                    
//                }
            }
            .overlay{
                Text("리뷰").bold()
            }
            .padding(.bottom,10)
            .padding(.horizontal)
            Divider()
        }
        .padding(.top,60)
        .background(Color.white)
        .overlay(alignment: .bottomTrailing) {
            if menu{
                VStack{
                    NavigationLink {
                        WriteReviewView(id: vm.reviewInfo?.contentsID ?? 0, image:vm.reviewInfo?.contentsPosterPath.getImadImage() ?? "", gradeAvg: vm.reviewInfo?.score ?? 0,reviewId : vm.reviewInfo?.reviewID ?? 0, title: vm.reviewInfo?.title ?? "",text: vm.reviewInfo?.content ?? "",spoiler: vm.reviewInfo?.spoiler ?? false,rating: vm.reviewInfo?.score ?? 0)
                            .navigationBarBackButtonHidden()
                            .environmentObject(vmAuth)
                    } label: {
                        Text("수정하기")
                    }
                    Divider()
                    Button {
                        delete = true
                    } label: {
                        Text("삭제하기")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical)
                .font(.subheadline)
                .background(Color.white)
                .frame(width: 100,height: 80)
                .cornerRadius(5)
                .shadow(radius: 10)
                .offset(y:80)
                .padding(.trailing)
            }
        }
        
    }
}
