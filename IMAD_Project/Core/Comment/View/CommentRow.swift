//
//  CommentRow.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/30/23.
//

import SwiftUI

struct CommentRow: View {
    
   
    let filter:CommentFilter
    let postingId:Int
    @State var comment:CommentResponse
    @State var statingOffsetY:CGFloat = 0
    @State var currentDragOffstY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    
    //댓글 수정
    @State var modifyingComment = false
    @State var text = ""
    @FocusState var focus:Bool
    @FocusState.Binding var commentFocus:Bool
    
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            profileView
            if modifyingComment{
                modifyView
            }else{
                ExtandView(text: comment.content)
                    .font(.subheadline)
                    .padding(.bottom)
            }
           buttonCollection
            
        }
        .background(Color.white.opacity(0.1))
        .overlay(alignment: .trailing){
            settingView
        }
        .padding(.horizontal)
        .offset(x:statingOffsetY)
        .offset(x:currentDragOffstY)
        .offset(x:endingOffsetY)
        .gesture(dragAction())
        
    }
    
}

#Preview {
    CommentRow(filter: .detailsComment ,postingId:0, comment:CustomData.instance.comment,commentFocus: FocusState<Bool>().projectedValue)
        .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
}

extension CommentRow{
    var profileView:some View{
        HStack{
            ProfileImageView(imageCode: comment.userProfileImage, widthHeigt: 20)
            Text(comment.userNickname).bold()
            Text(comment.modifiedAt != comment.createdAt ? "수정됨  •  " : "•  " + comment.modifiedAt.relativeTime())
                .foregroundColor(.gray)
                .font(.caption)
            
            Spacer()
            
        }
        .padding(.bottom,10)
    }
    func dragAction()->some Gesture{
        DragGesture()
            .onChanged { value in
                withAnimation(.spring()){
                    currentDragOffstY = value.translation.width
                }
            }
            .onEnded{ value in
                withAnimation(.spring()){
                    if let nickname = vmAuth.user?.data?.nickname,nickname == comment.userNickname{
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
    }
    func infoChangeView(image:String,text:String,color:Color,x:CGFloat,action:@escaping ()->()) -> some View{
        Button(action: action){
            VStack{
                Image(systemName: image)
                    .font(.title3)
                Text(text)
            }
            .padding(15)
            .padding(.horizontal,10)
            .font(.caption)
            .bold()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
        }
        .offset(x:x)
    }
    var settingView:some View{
        HStack{
            if let nickname = vmAuth.user?.data?.nickname,nickname == comment.userNickname{
                infoChangeView(image: "square.and.pencil", text: "수정", color: .customIndigo.opacity(0.6), x: 200){
                    withAnimation(.spring()){
                        statingOffsetY = 0
                        focus = true
                        modifyingComment = true
                        text = comment.content ?? ""
                    }
                }
                infoChangeView(image: "trash", text: "삭제", color: .red, x: 195) {
                    withAnimation(.spring()){
                        vmComment.deleteyReply(commentId: comment.commentID)
                        vmComment.commentDeleteSuccess.send(comment)
                    }
                }
            }else {
                infoChangeView(image: "exclamationmark.square", text: "신고", color: .yellow, x: 90) {
                    //추후 추가
                }
            }
        }
    }
    var buttonCollection:some View{
        HStack{
            Group{
                switch filter {
                case .postComment:
                    NavigationLink {
                        CommentDetailsView(postingId: postingId, parentsId: comment.commentID)
                            .navigationBarBackButtonHidden()
                            .environmentObject(vmAuth)
                    } label: {
                        Text("댓글 \(comment.childCnt)개 보기")
                    }

                case .detailsComment:
                    HStack{
                        Button {
                            
                        } label: {
                            Text("댓글 \(comment.childCnt)개 보기")
                        }.padding(.trailing)
                        Button {
//                            commentFocus = true
                        } label: {
                            Text("답글작성")
                        }
                    }
                case .detailsReply:
                    Text("")
                }
            }
            .foregroundStyle(.gray)
            likeView
        }
        .font(.caption)
    }
    var likeView:some View{
        HStack{
            Spacer()
            Button {
                like()
            } label: {
                Image(systemName: comment.likeStatus > 0 ? "heart.fill" : "heart").foregroundColor(.red)
                Text("\(comment.likeCnt)").foregroundColor(.black)
            }
            Button {
                disLike()
            } label: {
                Image(systemName: comment.likeStatus < 0 ? "heart.slash.fill" : "heart.slash").foregroundColor(.blue)
                Text("\(comment.dislikeCnt)").foregroundColor(.black)
            }
        }
    }
    var modifyView:some View{
        HStack{
            CustomTextField(password: false, image: nil, placeholder: "댓글입력..", color: .black, text: $text)
                .focused($focus)
            Button {
                if text.isEmpty{
                    modifyingComment = false
                }else{
                    vmComment.modifyReply(commentId: comment.commentID, content: text)
                    comment.content = text
                }
            } label: {
                Text("수정")
                    .padding(.vertical,2)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.customIndigo.opacity(0.5))
                    .cornerRadius(10)
            }
            Button {
                modifyingComment = false
            } label: {
                Text("취소")
                    .padding(.vertical,2)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.customIndigo)
                    .cornerRadius(10)
            }
        }
        .font(.subheadline)
        .padding(.bottom)
    }
    func like(){
        if comment.likeStatus < 1 {
            if comment.likeStatus < 0{
                comment.dislikeCnt -= 1
                comment.likeStatus = 1
            }else{
                comment.likeStatus = 1
            }
            comment.likeCnt += 1
        }
        else{
            comment.likeCnt -= 1
            comment.likeStatus = 0
        }
        vmComment.commentLike(commentId: comment.commentID, likeStatus: comment.likeStatus)
    }
    func disLike(){
        if comment.likeStatus > -1{
            if comment.likeStatus > 0{
                comment.likeCnt -= 1
                comment.likeStatus = -1
            }else{
                comment.likeStatus = -1
            }
            comment.dislikeCnt += 1
        }
        else{
            comment.dislikeCnt -= 1
            comment.likeStatus = 0
        }
        vmComment.commentLike(commentId: comment.commentID, likeStatus: comment.likeStatus)
    }
}
