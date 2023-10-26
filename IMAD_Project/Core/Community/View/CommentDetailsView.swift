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
    @StateObject var vm = CommunityViewModel()
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
                Group{
                    if !vm.replys.isEmpty{
                        ScrollView{
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
                                                vm.page += 1
                                                vm.readComments(postingId: postingId, commentType: 1, page: vm.page, sort: SortFilter.createdDate.rawValue, order: 1, parentId: commentId)
                                            }
                                    }
                                }
                            }.padding(.top)
                        }.padding(.bottom,25)
                    }else{
                        VStack(spacing:5){
                            Image(systemName: "pencil.slash").font(.largeTitle)
                            Text("댓글이 없습니다").font(.callout)
                        }
                        .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                    }
                }
                .background(Color.gray.opacity(0.1))
            }
            commentInputView
        }
        
        .foregroundColor(.black)
        .onAppear{
            vm.readComment(commentId: commentId)
            vm.readComments(postingId: postingId, commentType: 1, page: vm.page, sort: SortFilter.createdDate.rawValue, order: 1, parentId: commentId)
        }
    }
    
    
}

struct CommentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetailsView(postingId: 0, commentId: 0)
            .environmentObject(AuthViewModel())
    }
}

extension CommentDetailsView{
    var commentInputView:some View{
        VStack{
            Divider()
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == vm.parentComment?.userProfileImage ?? 1})!.rawValue)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
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
                        Text("•  " + (vm.parentComment?.modifiedAt.relativeTime() ?? "")).font(.caption)
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
            
        }
        .padding(.horizontal)
    }
}
