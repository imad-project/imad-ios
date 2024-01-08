//
//  CommentRow.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/30/23.
//

import SwiftUI

struct CommentRowView: View {
    
    
    let filter:CommentFilter
    let postingId:Int
    @State var deleted:Bool
    
    @State var comment:CommentResponse
    @State var statingOffsetY:CGFloat = 0
    @State var currentDragOffstY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    
    //답글 관련
    //    @State var replyView = false
    @Binding var reply:CommentResponse?
    
    //댓글 수정
    @State var modifyingComment = false
    @State var text = ""
    @FocusState var focus:Bool
    @FocusState.Binding var commentFocus:Bool
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                if deleted{
                    Text("삭제된 댓/답글입니다.")
                        .font(.subheadline)
                        .padding(.vertical)
                }else{
                    profileView
                    if modifyingComment{
                        modifyView
                    }else{
                        ExtandView(text: comment.content)
                            .font(.subheadline)
                            .padding(.bottom)
                    }
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
            if !vmComment.replys.isEmpty{
                replysView
                    .padding(.top)
            }
        }
    }
    
}

#Preview {
    CommentRowView(filter: .detailsComment ,postingId:0, deleted: false, comment:CustomData.instance.comment,reply: .constant(CustomData.instance.comment), commentFocus: FocusState<Bool>().projectedValue,vmComment: CommentViewModel(comment: nil, replys: CustomData.instance.commentList))
        .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
}

extension CommentRowView{
    var profileView:some View{
        HStack{
            ProfileImageView(imageCode: comment.userProfileImage, widthHeigt: 20)
            Text(comment.userNickname).bold()
            Text((comment.modifiedAt != comment.createdAt ? "수정됨  •  " : "•  " ) + comment.modifiedAt.relativeTime())
                .foregroundColor(.gray)
                .font(.caption)
            
            Spacer()
            
        }
        .padding(.bottom,10)
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
            if comment.author{
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
                        self.deleted = true
                        statingOffsetY = 0
                        vmComment.deleteyReply(commentId: comment.commentID)
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
                            if vmComment.replys.isEmpty{
                                withAnimation(.easeIn){
                                    vmComment.readComments(postingId: postingId, commentType: 1, page: vmComment.currentPage, sort: "createdDate", order: 1, parentId: comment.commentID)
                                }
                            }else{
                                vmComment.replys.removeAll()
                            }
                        } label: {
                            Text(vmComment.replys.isEmpty ? "댓글 \(comment.childCnt)개 보기" : "닫기")
                        }.padding(.trailing)
                        Button {
                            reply = comment
                        } label: {
                            Text("답글작성")
                        }
                    }
                case .detailsReply:
                    Text("")
                }
            }
            .foregroundStyle(.gray)
            Spacer()
            if !deleted{
                likeView
            }
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
            CustomTextField(password: false, image: nil, placeholder: "댓글입력..", color: .black, textLimit: 400, text: $text)
                .focused($focus)
            Button {
                if text.isEmpty{
                    modifyingComment = false
                }else{
                    vmComment.modifyReply(commentId: comment.commentID, content: text)
                    comment.content = text
                    modifyingComment = false
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
    var replysView:some View{
        ForEach(vmComment.replys,id:\.self) { reply in
            HStack{
                Image(systemName: "arrow.turn.down.right")
                    .bold()
                    .foregroundStyle(.gray)
                CommentRowView(filter: .detailsReply, postingId: postingId, deleted: reply.removed, comment: reply, reply: .constant(nil), commentFocus: $focus)
                    .padding(.vertical,5)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(10)
            }
            
            if vmComment.replys.last == reply,vmComment.currentPage < vmComment.maxPage{
                Button {
                    vmComment.readComments(postingId: comment.postingId, commentType: 1, page: vm.currentPage + 1, sort: "createdDate", order: 1, parentId: comment.commentID)
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.gray)
                        .frame(height: 25)
                        .overlay {
                            HStack{
                                Text("더보기")
                                Image(systemName: "chevron.down")
                            }
                            .font(.caption)
                        }.foregroundColor(.black)
                }
            }
        }
        
        .padding(.horizontal)
        
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
    func dragAction()->some Gesture{
        DragGesture()
            .onChanged { value in
                withAnimation(.spring()){
                    if !deleted{
                        currentDragOffstY = value.translation.width
                    }
                }
            }
            .onEnded{ _ in
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
}
