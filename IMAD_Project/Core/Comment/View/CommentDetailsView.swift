//
//  CommentDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/26.
//

import SwiftUI

struct CommentDetailsView: View {
    
    let postingId:Int
    let parentsId:Int
    @FocusState var reply:Bool
    
    let reported:Bool
    @State var reviewText = ""
    
    
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    @State var replyWrite:CommentResponse?
    
    @StateObject var vm = CommentViewModel(comment: nil, replys: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 0){
               header
                Divider()
                    parentComment
                ScrollView{
                    if !vm.replys.isEmpty{
                        VStack{
                            ForEach(vm.replys,id:\.self) { item in
                                CommentRowView(filter: .detailsComment, postingId: postingId, reported: item.reported, deleted: item.removed, comment: item,reply:$replyWrite,commentFocus: $reply)
                                    .environmentObject(vmAuth)
                                if vm.replys.last == item,vm.maxPage > vm.currentPage{
                                    ProgressView()
                                        .onAppear{
                                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage + 1, sort: sort.rawValue, order: order.rawValue, parentId: parentsId)
                                        }
                                }
                            }.padding(.top)
                        }
                        .padding(.bottom)
                    }
                }
                
                .padding(.bottom,replyWrite != nil ? 140:100)
            }
            .background(Color.gray.opacity(0.1))
            commentInputView
        }
        .foregroundColor(.black)
        .onAppear{
            vm.readComment(commentId: parentsId)
            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: parentsId)
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .onReceive(vm.success){
            vm.replys.removeAll()
            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: parentsId)
        }
    }
}

struct CommentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetailsView(postingId: 1, parentsId: 12,reported: true, vm: CommentViewModel(comment: CustomData.instance.comment, replys: CustomData.instance.commentList))
            .environmentObject(AuthViewModel())
    }
}

extension CommentDetailsView{
    var header:some View{
        HeaderView(backIcon:"chevron.left",text: "답글"){
            dismiss()
        }
        .padding(10)
        .background(Color.white)
    }
    var commentInputView:some View{
        VStack{
            if let replyWrite{
                HStack{
                    Text("\(replyWrite.userNickname)님에게 답글")
                    Spacer()
                    Button {
                        self.replyWrite = nil
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .padding(.vertical,7.5)
                .padding(.horizontal)
                .font(.subheadline)
            }
            Divider()
            HStack{
                ProfileImageView(imagePath: UserInfoCache.instance.user?.data?.profileImage ?? "", widthHeigt: 30)
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black, text: $reviewText)
                    .focused($reply)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.customIndigo)
                        
                    }
                Button {
                    if let replyWrite{
                        vm.addReply(postingId: postingId, parentId: replyWrite.commentID, content: reviewText,commentMode: true)
                    }else{
                        vm.addReply(postingId: postingId, parentId: parentsId, content: reviewText,commentMode: true)
                    }
                    
                    reviewText = ""
                    replyWrite = nil
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
    var parentComment:some View{
        VStack(alignment: .leading,spacing: 5){
            if !reported{
                HStack{
                    ProfileImageView(imagePath: vm.comment?.userProfileImage ?? "", widthHeigt: 30)
                    Text(vm.comment?.userNickname ?? "").bold()
                    if vm.comment?.modifiedAt != vm.comment?.createdAt{
                        Text("수정됨  •  " + (vm.comment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                    }else{
                        Text("•  " + (vm.comment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                    }
                    Spacer()
                }
                .padding(.bottom,10)
                ExtandView(text: vm.comment?.content)
                HStack{
                    Spacer()
                    Button {
                        like()
                    } label: {
                        HStack(spacing:2){
                            Image(systemName: (vm.comment?.likeStatus ?? 0) > 0 ? "arrowshape.up.fill" : "arrowshape.up").foregroundColor(.customIndigo)
                            Text("\(vm.comment?.likeCnt ?? 0)").foregroundColor(.black)
                        }
                    }
                    .padding(.trailing)
                    .foregroundColor(vm.comment?.likeStatus == 1 ? .red : .gray)
                    Button {
                       disLike()
                    } label: {
                        HStack(spacing:2){
                            Image(systemName:(vm.comment?.likeStatus ?? 0) < 0 ? "arrowshape.down.fill" : "arrowshape.down").foregroundColor(.customIndigo)
                            Text("\( vm.comment?.dislikeCnt ?? 0)").foregroundColor(.black)
                        }
                    }
                    .foregroundColor(vm.comment?.likeStatus == -1 ? .blue : .gray)
                    
                }
                Divider()
                    .padding(.vertical,5)
                HStack{
                    ForEach(SortFilter.allCases,id:\.self){ sort in
                        if sort != .score{
                            Button {
                                self.sort = sort
                                vm.currentPage = 1
                                vm.replys.removeAll()
                                vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: parentsId)
                            } label: {
                                Text(sort.name).font(.GmarketSansTTFMedium(12)).foregroundColor(.customIndigo)
                                    .overlay {
                                        if sort == self.sort{
                                            Capsule()
                                                .frame(width: 40,height: 2)
                                                .offset(y:22)
                                        }
                                    }
                            }
                            .padding(.trailing)
                        }
                    }
                    Spacer()
                    Button {
                        if order == .ascending{
                            withAnimation{
                                order = .descending
                                
                            }
                        }else{
                            withAnimation{
                                order = .ascending
                            }
                        }
                        vm.currentPage = 1
                        vm.replys = []
                        vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: self.sort.rawValue, order: self.order.rawValue, parentId: parentsId)
                        
                    } label: {
                        HStack{
                            Text(order.name)
                            Image(systemName: order == .ascending ? "chevron.up" : "chevron.down")
                        }.font(.GmarketSansTTFMedium(10))
                    }
                }.padding(.vertical,5)
            }else{
                
                HStack{
                    Text("신고가 접수되어 차단된 댓/답글입니다.")
                        .font(.GmarketSansTTFMedium(15))
                        .padding(.vertical)
                    Spacer()
                }
            }
            
        }
        .padding(10)
        .background(Color.white)
        .padding(.top,10)
    }
    func like(){
        guard let comment = vm.comment else {return}
        if comment.likeStatus < 1 {
            if comment.likeStatus < 0{
                vm.comment?.dislikeCnt -= 1
                vm.comment?.likeStatus = 1
            }else{
                vm.comment?.likeStatus = 1
            }
            vm.comment?.likeCnt += 1
        }
        else{
            vm.comment?.likeCnt -= 1
            vm.comment?.likeStatus = 0
        }
        vm.commentLike(commentId: vm.comment?.commentID ?? 0, likeStatus: vm.comment?.likeStatus ?? 0)
    }
    func disLike(){
        guard let comment = vm.comment else {return}
        if comment.likeStatus > -1{
            if comment.likeStatus > 0{
                vm.comment?.likeCnt -= 1
                vm.comment?.likeStatus = -1
            }else{
                vm.comment?.likeStatus = -1
            }
            vm.comment?.dislikeCnt += 1
        }
        else{
            vm.comment?.dislikeCnt -= 1
            vm.comment?.likeStatus = 0
        }
        vm.commentLike(commentId: vm.comment?.commentID ?? 0, likeStatus: vm.comment?.likeStatus ?? 0)
    }
}
