//
//  ComminityPostView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import SwiftUI
import Kingfisher

struct CommunityPostView: View {
    
    let postingId:Int
    @State var reviewText = ""
    
    @State var menu = false
    @State var modify = false
    
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    
    @Binding var back:Bool
    
    @FocusState var reply:Bool
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack(spacing: 0){
                header
                Divider()
                ScrollView {
                    workInfoView
                    communityinfoView
                    communityStatusView
                    likeStatusView
                    collection
                    comment
                }
            }
            .foregroundColor(.black)
            .padding(.bottom,100)
            commentInputView
        }
        .onAppear{
            vm.readDetailCommunity(postingId: postingId)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vmComment.success) { //무언가 할때마다 커뮤니티 업데이트
            vm.readDetailCommunity(postingId: postingId)
        }
        .navigationDestination(isPresented: $modify) {
            if let community = vm.community{
                CommunityWriteView(contentsId: community.contentsID, postingId: community.postingID, image: community.contentsPosterPath.getImadImage(),category:CommunityFilter.allCases.first(where: {$0.num == community.category})!, spoiler: community.spoiler, text:community.content, title: community.title, goMain: .constant(true))
                    .environmentObject(vmAuth)
                    .navigationBarBackButtonHidden()
            }
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
    }
}

struct ComminityPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommunityPostView(postingId: 1,back: .constant(true), vm: CommunityViewModel(community: CustomData.instance.community, communityList: []))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension CommunityPostView{
    var header:some View{
        ZStack{
            HStack(spacing:0){
                Button {
                    back = false
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                }

                if let userName = vmAuth.user?.data?.nickname,userName == vm.community?.userNickname{
                    Button {
                        menu.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .bold()
                            .padding()
                    }
                    .confirmationDialog("일정 수정", isPresented: $menu,actions: {
                        Button(role:.none){
                            modify = true
                        } label: {
                            Text("수정하기")
                        }
                        Button(role:.destructive){
                            back = true
                            vm.deleteCommunity(postingId: postingId)
                        } label: {
                            Text("삭제하기")
                        }
                    },message: {
                        Text("게시물을 수정하거나 삭제하시겠습니까?")
                    })
                }
            }
            HStack{
                ProfileImageView(imageCode: vm.community?.userProfileImage ?? 90, widthHeigt: 25)
                Text(vm.community?.userNickname ?? "")
                    .font(.caption)
                    .bold()
            }.padding(.top,5)
            
        }.padding(.bottom,10)
    }
    var workInfoView:some View{
        HStack(alignment: .top){
            KFImageView(image: vm.community?.contentsPosterPath.getImadImage() ?? "",width:90,height:110)
            VStack(alignment: .leading,spacing: 5){
                Text("#" + (vm.community?.contentsTitle ?? ""))
                    .font(.footnote)
                HStack{
                    Text(CommunityFilter.allCases.first(where:{$0.num == vm.community?.category ?? 1})!.name).font(.caption2)
                        .foregroundColor(.white)
                        .padding(3)
                        .padding(.horizontal,5)
                        .background(Capsule().foregroundColor(.customIndigo))
                    Text((vm.community?.spoiler ?? false) ? "스포일러" : "클린")
                        .font(.caption2)
                        .padding(2)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                }
                Text(vm.community?.title ?? "")
                    .bold()
                
            }.padding([.leading,.bottom])
            Spacer()
            if vm.community?.modifiedAt != vm.community?.createdAt{
                Text("수정됨 •").foregroundColor(.gray).font(.caption)
            }
            Text(vm.community?.modifiedAt.relativeTime() ?? "").font(.caption).foregroundColor(.gray)
            
        } .padding(.top)
            .padding(.horizontal)
    }
    var communityStatusView:some View{
        HStack{
            Group{
                HStack(spacing: 2){
                    Image(systemName: "eye.fill")
                    Text("\(vm.community?.viewCnt ?? 0)")
                }
                HStack(spacing: 2){
                    Image(systemName: "message.fill")
                    Text("\(vm.community?.commentCnt ?? 0)")
                }
            }
            .foregroundColor(.gray)
            .font(.footnote)
            .padding(2)
            .padding(.horizontal,7)
            .background(Color.gray.opacity(0.3).cornerRadius(50))
            Spacer()
            Group{
                HStack(spacing: 2){
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(vm.community?.likeCnt ?? 0)")
                }
                HStack(spacing: 2){
                    Image(systemName: "heart.slash.fill")
                        .foregroundColor(.blue)
                    Text("\(vm.community?.dislikeCnt ?? 0)")
                }
            }.font(.subheadline)
        }.padding(.horizontal)
    }
    var communityinfoView:some View{
        VStack(alignment: .leading){
            NavigationLink {
                WorkView(contentsId:vm.community?.contentsID ?? 0)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vmAuth)
            } label: {
                HStack(spacing:1){
                    Text(vm.community?.contentsTitle ?? "").bold()
                    Text("의 상세정보 보러가기")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.font(.caption)
                    .padding(10)
                    .background(Color.white).cornerRadius(10).shadow(radius: 1)
                    .padding(.horizontal)
            }
            Text(vm.community?.content ?? "")
                .padding(.horizontal)
                .font(.subheadline)
                .padding(.bottom)
        }
        .padding(.bottom)
    }
    var likeStatusView:some View{
        VStack{
            Divider()
            HStack{
                Group{
                    Button {
                        likePosting()
                    } label: {
                        Image(systemName: vm.community?.likeStatus == 1 ? "heart.fill":"heart")
                        Text("좋아요")
                    }
                    .foregroundColor(vm.community?.likeStatus == 1 ? .red : .gray)
                    Button {
                        disLikePosting()
                    } label: {
                        HStack{
                            Image(systemName: vm.community?.likeStatus == -1 ? "heart.slash.fill" : "heart.slash")
                            Text("싫어요")
                        }
                    }
                    .foregroundColor(vm.community?.likeStatus == -1 ? .blue : .gray)
                }
                .font(.subheadline)
                .frame(maxWidth: .infinity)
            }
            Divider()
        }
    }
    var collection:some View{
        VStack(alignment: .leading){
            HStack{
                ForEach(SortFilter.allCases.filter({$0 != .score}),id:\.self){ sort in
                    Button {
                        guard self.sort != sort else { return}
                        self.sort = sort
                        readCommunity()
                    } label: {
                        Capsule()
                            .foregroundColor(.customIndigo.opacity(sort == self.sort ? 1.0:0.5 ))
                            .frame(width: 70,height: 25)
                            .overlay {
                                Text(sort.name).font(.caption).foregroundColor(.white)
                            }
                    }
                }
                Spacer()
                Button {
                    if order == .ascending{
                        withAnimation{
                            order = .descending
                            readCommunity()
                        }
                    }else{
                        withAnimation{
                            order = .ascending
                            readCommunity()
                        }
                    }
                } label: {
                    HStack{
                        Text(order.name)
                        Image(systemName: order == .ascending ? "chevron.up" : "chevron.down")
                    } .font(.caption)
                }
                
            }.padding(.vertical,5)
        }.padding(.horizontal)
        
    }
    var comment:some View{
        ForEach(vm.community?.commentListResponse?.commentDetailsResponseList ?? [],id: \.self){ comment in
            CommentRowView(replyMode: false, replyOfReply: false, comment: comment)
                .environmentObject(vmAuth)
                .onReceive(vmComment.commentDeleteSuccess) { deleteComment in
                    vm.community?.commentListResponse?.commentDetailsResponseList = vm.community?.commentListResponse?.commentDetailsResponseList.filter{$0 != deleteComment} ?? []
                }
        }
    }
    var commentInputView:some View{
        VStack{
            Divider()
            HStack{
                ProfileImageView(imageCode: vm.community?.userProfileImage ?? 0, widthHeigt: 40)
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black, text: $reviewText)
                    .focused($reply)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.customIndigo)
                    }
                Button {
                    vmComment.addReply(postingId: postingId, parentId: nil, content: reviewText)
                    reviewText = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Text("전송")
                        .foregroundColor(.customIndigo)
                }
                .padding(.leading,5)
                
            }
            .padding(.horizontal)
            HStack{
                Text("비방이나 욕설은 삼가해주세요.😃😊")
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.leading)
                Spacer()
            }
        }
        .padding(.bottom,25)
        .background(Color.white)
    }
    func likePosting(){
        guard let like = vm.community?.likeStatus else {return}
        if like < 1{
            vm.community?.likeCnt += 1
            if like < 0{
                vm.community?.dislikeCnt -= 1
            }
            vm.community?.likeStatus = 1
        }else{
            vm.community?.likeStatus = 0
            vm.community?.likeCnt -= 1
        }
        vm.like(postingId: vm.community?.postingID ?? 0, status: like)
    }
    func disLikePosting(){
        guard let like = vm.community?.likeStatus else {return}
        if like > -1{
            vm.community?.dislikeCnt += 1
            if like > 0{
                vm.community?.likeCnt -= 1
            }
            vm.community?.likeStatus = -1
            
        }else{
            vm.community?.likeStatus = 0
            vm.community?.dislikeCnt -= 1
        }
        vm.like(postingId: vm.community?.postingID ?? 0, status: like)
    }
    func readCommunity(){
        vm.currentPage = 1
        vmComment.replys = []
        vmComment.readComments(postingId: postingId, commentType: 0, page: vm.currentPage, sort: self.sort.rawValue, order: order.rawValue, parentId:0)
    }
}
