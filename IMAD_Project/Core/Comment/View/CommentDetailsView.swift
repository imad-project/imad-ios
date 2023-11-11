//
//  CommentDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/26.
//

import SwiftUI

struct CommentDetailsView: View {
    
    let postingId:Int
    let commentId:Int
    @FocusState var reply:Bool
    
    @State var reviewText = ""
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    
    @StateObject var vm = CommentViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("답글")
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black )
                }.padding(.leading)
                Divider()
                parentComment
                ScrollView{
                    if !vm.replys.isEmpty{
                        ForEach(vm.replys,id:\.self) { item in
                            if !item.removed{
                                CommentRowView(commentMode:false,comment: item)
                                    .environmentObject(vm)
                                    .environmentObject(vmAuth)
                                    .padding(.leading)
                                    .onReceive(vm.commentDeleteSuccess){ comment in
                                        vm.replys = vm.replys.filter({$0 != comment})
                                    }
                                if vm.replys.last == item,vm.replys.count % 10 == 0{
                                    ProgressView()
                                        .onAppear{
                                            vm.currentPage += 1
                                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: SortFilter.createdDate.rawValue, order: 1, parentId: commentId)
                                        }
                                }
                            }
                        }.padding(.top)
                    }
                }
                .padding(.bottom,25)
                .background(Color.gray.opacity(0.1))
            }
            commentInputView
        }
        
        .foregroundColor(.black)
        .onAppear{
            vm.readComment(commentId: commentId)
            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: commentId)
        }
    }
    
    
}

struct CommentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetailsView(postingId: 0, commentId: 0)
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension CommentDetailsView{
    var commentInputView:some View{
        VStack{
            Divider()
            HStack{
//                Image(ProfileFilter.allCases.first(where: {$0.num == vmAuth.getUserRes?.data?.profileImage ?? 1})!.rawValue)
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                    .clipShape(Circle())
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black, text: $reviewText)
                    .focused($reply)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.customIndigo)
                        
                    }
                Button {
                    vm.addReply(postingId: postingId, parentId: commentId, content: reviewText)
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
    var parentComment:some View{
        VStack{
            HStack(alignment: .top){
                Image(ProfileFilter.allCases.first(where: {$0.num == vm.parentComment?.userProfileImage})?.rawValue ?? "")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack{
                        Text(vm.parentComment?.userNickname ?? "").bold()
                        if vm.parentComment?.modifiedAt != vm.parentComment?.createdAt{
                            Text("수정됨  •  " + (vm.parentComment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                        }else{
                            Text("•  " + (vm.parentComment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                        }
                        Spacer()
                    }.padding(.bottom)
                    Text(vm.parentComment?.content ?? "")
                }
            }
            HStack{
                Spacer()
                Button {
                    guard let comment = vm.parentComment else {return}
                    if comment.likeStatus < 1 {
                        if comment.likeStatus < 0{
                            vm.parentComment?.dislikeCnt -= 1
                            vm.parentComment?.likeStatus = 1
                        }else{
                            vm.parentComment?.likeStatus = 1
                        }
                        vm.parentComment?.likeCnt += 1
                    }
                    else{
                        vm.parentComment?.likeCnt -= 1
                        vm.parentComment?.likeStatus = 0
                    }
                    vm.commentLike(commentId: vm.parentComment?.commentID ?? 0, likeStatus: vm.parentComment?.likeStatus ?? 0)
                } label: {
                    Image(systemName: (vm.parentComment?.likeStatus ?? 0) > 0 ? "heart.fill" : "heart").foregroundColor(.red)
                    Text("\(vm.parentComment?.likeCnt ?? 0)").foregroundColor(.black)
                }
                .padding(.trailing)
                .foregroundColor(vm.parentComment?.likeStatus == 1 ? .red : .gray)
                Button {
                    guard let comment = vm.parentComment else {return}
                    if comment.likeStatus > -1{
                        if comment.likeStatus > 0{
                            vm.parentComment?.likeCnt -= 1
                            vm.parentComment?.likeStatus = -1
                        }else{
                            vm.parentComment?.likeStatus = -1
                        }
                        vm.parentComment?.dislikeCnt += 1
                    }
                    else{
                        vm.parentComment?.dislikeCnt -= 1
                        vm.parentComment?.likeStatus = 0
                    }
                    vm.commentLike(commentId: vm.parentComment?.commentID ?? 0, likeStatus: vm.parentComment?.likeStatus ?? 0)
                } label: {
                    HStack{
                        Image(systemName:(vm.parentComment?.likeStatus ?? 0) < 0 ? "heart.slash.fill" : "heart.slash").foregroundColor(.blue)
                        Text("\( vm.parentComment?.dislikeCnt ?? 0)").foregroundColor(.black)
                    }
                }
                .foregroundColor(vm.parentComment?.likeStatus == -1 ? .blue : .gray)
                
            }
            Divider()
            HStack{
                ForEach(SortFilter.allCases,id:\.self){ sort in
                    if sort != .score{
                        Button {
                            self.sort = sort
                            vm.currentPage = 1
                            vm.replys = []
                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: commentId)
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
                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: commentId)
                        }
                    }else{
                        withAnimation{
                            order = .ascending
                            vm.currentPage = 1
                            vm.replys = []
                            vm.readComments(postingId: postingId, commentType: 1, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: commentId)
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
}
