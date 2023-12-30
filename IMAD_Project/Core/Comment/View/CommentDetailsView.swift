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
            VStack(alignment: .leading){
               header
                Divider()
                parentComment
                ScrollView{
                    if !vm.replys.isEmpty{
                        VStack{
                            ForEach(vm.replys,id:\.self) { item in
                                CommentRowView(filter: .detailsComment, postingId: postingId, deleted: item.removed, comment: item,reply:$replyWrite,commentFocus: $reply)
                                    .environmentObject(vmAuth)
                                    .padding(.leading)
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
                .background(Color.gray.opacity(0.1))
                .padding(.bottom,replyWrite != nil ? 140:100)
            }
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
        CommentDetailsView(postingId: 1, parentsId: 12,vm: CommentViewModel(comment: CustomData.instance.comment, replys: CustomData.instance.commentList))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension CommentDetailsView{
    var header:some View{
        Button {
            dismiss()
        } label: {
            HStack{
                Image(systemName: "chevron.left")
                Text("답글")
            }
            .font(.title3)
            .bold()
            .foregroundColor(.black)
        }.padding(.leading)
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
                ProfileImageView(imageCode: vmAuth.user?.data?.profileImage ?? 0, widthHeigt: 30)
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
        VStack{
            HStack(alignment: .top){
                ProfileImageView(imageCode: vm.comment?.userProfileImage ?? 0, widthHeigt: 30)
                VStack(alignment: .leading) {
                    HStack{
                        Text(vm.comment?.userNickname ?? "").bold()
                        if vm.comment?.modifiedAt != vm.comment?.createdAt{
                            Text("수정됨  •  " + (vm.comment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                        }else{
                            Text("•  " + (vm.comment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                        }
                        Spacer()
                    }.padding(.bottom)
                    ExtandView(text: vm.comment?.content)
                }
            }
            HStack{
                Spacer()
                Button {
                    like()
                } label: {
                    Image(systemName: (vm.comment?.likeStatus ?? 0) > 0 ? "heart.fill" : "heart").foregroundColor(.red)
                    Text("\(vm.comment?.likeCnt ?? 0)").foregroundColor(.black)
                }
                .padding(.trailing)
                .foregroundColor(vm.comment?.likeStatus == 1 ? .red : .gray)
                Button {
                   disLike()
                } label: {
                    HStack{
                        Image(systemName:(vm.comment?.likeStatus ?? 0) < 0 ? "heart.slash.fill" : "heart.slash").foregroundColor(.blue)
                        Text("\( vm.comment?.dislikeCnt ?? 0)").foregroundColor(.black)
                    }
                }
                .foregroundColor(vm.comment?.likeStatus == -1 ? .blue : .gray)
                
            }
            Divider()
            HStack{
                ForEach(SortFilter.allCases,id:\.self){ sort in
                    if sort != .score{
                        Button {
                            self.sort = sort
                            vm.currentPage = 1
                            vm.replys.removeAll()
                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: parentsId)
                        } label: {
                            Capsule()
                                .foregroundColor(.customIndigo.opacity(sort == self.sort ? 1.0:0.5 ))
                                .frame(width: 70,height: 25)
                                .overlay {
                                    Text(sort.name).font(.caption).foregroundColor(.white)
                                }
                        }
                    }
                }
                Spacer()
                Button {
                    if order == .ascending{
                        withAnimation{
                            order = .descending
                            vm.currentPage = 1
                            vm.replys = []
                        }
                    }else{
                        withAnimation{
                            order = .ascending
                            vm.currentPage = 1
                            vm.replys = []
                        }
                    }
                } label: {
                    HStack{
                        Text(order.name)
                        Image(systemName: order == .ascending ? "chevron.up" : "chevron.down")
                    } .font(.caption)
                }
                
            }.padding(.vertical,5)
        }
        .padding(.horizontal)
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
