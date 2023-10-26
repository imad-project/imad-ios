//
//  CommentRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommentRowView: View {
    let commentMode:Bool
    @State var comment:CommentResponse
    @State var statingOffsetY:CGFloat = 0
    @State var currentDragOffstY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    @State var modify = false
    @State var delete = false
    
    @FocusState var focus:Bool
    @State private var text = ""
    @State var input = false
    @EnvironmentObject var vm:CommunityViewModel
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == comment.userProfileImage})?.rawValue ?? "soso")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .padding(.trailing,7)
                Text(comment.userNickname).bold()
                
                Text("•  " + comment.modifiedAt.relativeTime())
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                
            }
            .padding(.bottom,10)
            Group{
                if input{
                    HStack{
                        CustomTextField(password: false, image: nil, placeholder: "댓글입력..", color: .black, text: $text)
                            .focused($focus)
                        Button {
                            if text.isEmpty{
                                input = false
                            }else{
                                vm.modifyReply(commentId: comment.commentID, content: text)
                                comment.content = text
                            }
                        } label: {
                            Text("수정")
                                .padding(.vertical,3)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(Color.customIndigo.opacity(0.5))
                                .cornerRadius(10)
                        }
                        Button {
                            input = false
                        } label: {
                            Text("취소")
                                .padding(.vertical,3)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(Color.customIndigo)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom,5)
                }else{
                    Text(comment.content ?? "")
                        .padding(.bottom)
                    if commentMode{
                        Button {
                            vm.modifyComment.send((vm.communityDetail?.postingID ?? 0,comment.commentID))
                        } label: {
                            Text("답글작성").font(.caption2).foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding(.leading).font(.footnote)
            
        }.padding(.horizontal)
            .padding(.vertical,3)
            .overlay(alignment: .trailing){
                HStack{
                    if let nickname = vmAuth.getUserRes?.data?.nickname,nickname == comment.userNickname{
                        Button {
                            withAnimation(.spring()){
                                statingOffsetY = 0
                                focus = true
                                input = true
                                text = comment.content ?? ""
                            }
                        } label: {
                            VStack{
                                Image(systemName: "square.and.pencil")
                                    .font(.title3)
                                Text("수정")
                            }
                            .padding(15)
                            .padding(.horizontal,10)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.customIndigo.opacity(0.6))
                            .cornerRadius(10)
                            
                        }
                        .offset(x:200)
                        Button {
                            vm.deleteyReply(commentId: comment.commentID)
                            vm.commentDeleteSuccess.send(comment)
                        } label: {
                            VStack{
                                Image(systemName: "trash")
                                    .font(.title3)
                                Text("삭제")
                                
                            }
                            .padding(15)
                            .padding(.horizontal,10)
                            .font(.caption)
                            .bold()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                           
                        }
                        .offset(x:195)
                        
                    }else {
                        VStack{
                            Image(systemName: "exclamationmark.square")
                                .font(.title3)
                            Text("신고")

                        }
                        .padding(15)
                        .padding(.horizontal,10)
                        .font(.caption)
                        .bold()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(x:90)
                    }
                    
                }
            }
            .background(Color.white.opacity(0.1))
            .offset(x:statingOffsetY)
            .offset(x:currentDragOffstY )
            .offset(x:endingOffsetY )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()){
                            currentDragOffstY = value.translation.width
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.spring()){
                            if let nickname = vmAuth.getUserRes?.data?.nickname,nickname == comment.userNickname{
                                if currentDragOffstY < -100{
                                    statingOffsetY = -200
                                }else if currentDragOffstY > 100{
                                    statingOffsetY = 0
                                }
                                currentDragOffstY = 0
                            }else{
                                if currentDragOffstY < -50{
                                    statingOffsetY = -100
                                }else if currentDragOffstY > 50{
                                    statingOffsetY = 0
                                }
                                currentDragOffstY = 0
                            }
                            
                        }
                    }
            )
            .onReceive(vm.modifySuccess) {
                input = false
            }
        
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommentRowView(commentMode: true, comment: CustomData.instance.comment)
                .environmentObject(AuthViewModel())
                .environmentObject(CommunityViewModel())
        }
        
    }
}
