//
//  CommentRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommentRowView: View {
    let replyMode:Bool
    var replyOfReply:Bool
    @State var comment:CommentResponse
    
    @State var replys = false
    
    @State var statingOffsetY:CGFloat = 0
    @State var currentDragOffstY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    @State var modify = false
    @State var delete = false
    
    @FocusState var focus:Bool
    @State private var text = ""
    @State var input = false
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            profileView
            Group{
                if input{
                    modifyView
                }else{
                    ExtandView(text: comment.content)
                        .padding(.bottom)
                    commentStatusView
                }
            }
            .padding(.leading).font(.footnote)
            replysView
        }.padding(.horizontal)
            .padding(.vertical,3)
            .overlay(alignment: .trailing){
                HStack{
                    if let nickname = vmAuth.user?.data?.nickname,nickname == comment.userNickname{
                        infoChangeView(action:
                                        {withAnimation(.spring()){
                            statingOffsetY = 0
                            focus = true
                            input = true
                            text = comment.content ?? ""
                        }}, image: "square.and.pencil", text: "수정", color: Color.customIndigo.opacity(0.6), x: 200)
                        
                        infoChangeView(action:
                                        {withAnimation(.spring()){
                            vmComment.deleteyReply(commentId: comment.commentID)
                            vmComment.commentDeleteSuccess.send(comment)
                        }}, image: "trash", text: "삭제", color: .red, x: 195)
                    }else {
                        infoChangeView(action:
                                        {withAnimation(.spring()){
                            //추후 추가
                        }}, image:"exclamationmark.square", text: "신고", color: .yellow, x: 90)
                    }
                }
            }
            .background(Color.white.opacity(0.1))
            .offset(x:statingOffsetY)
            .offset(x:currentDragOffstY)
            .offset(x:endingOffsetY)
            .gesture(dragAction())
        
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommentRowView(replyMode: true, replyOfReply: false, comment: CustomData.instance.comment,vmComment: CommentViewModel(comment: nil, replys: CustomData.instance.commentList))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
        
    }
}

extension CommentRowView{
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
    var modifyView:some View{
        HStack{
            CustomTextField(password: false, image: nil, placeholder: "댓글입력..", color: .black, text: $text)
                .focused($focus)
            Button {
                if text.isEmpty{
                    input = false
                }else{
                    vmComment.modifyReply(commentId: comment.commentID, content: text)
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
            .padding(.bottom,5)
        }
    }
    var commentStatusView:some View{
        HStack{
            if replyMode{
                if !replyOfReply{
                    Button {
                        replys.toggle()
                        if replys{
                            vmComment.readComments(postingId: comment.postingId, commentType: 1, page: vm.currentPage, sort: "createdDate", order: 1, parentId: comment.commentID)
                        }else{
                            vmComment.replys.removeAll()
                        }
                    } label: {
                        Text("답글 \(comment.childCnt)개").font(.caption2).foregroundColor(.customIndigo.opacity(0.6)).bold()
                    }
                    Divider().frame(height: 10).bold()
                    Button {
                        
                    } label: {
                        Text("답글작성").font(.caption2).foregroundColor(.customIndigo.opacity(0.6)).bold()
                    }
                }
            }else{
                NavigationLink {
                    CommentDetailsView(postingId:comment.postingId,parentsId: comment.commentID)
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    if comment.childCnt > 0 {
                        Text("답글 \(comment.childCnt)개").font(.caption2).foregroundColor(.customIndigo.opacity(0.6)).bold()
                    }else{
                        Text("답글작성").font(.caption2).foregroundColor(.customIndigo.opacity(0.6)).bold()
                    }
                }
            }
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
    var replysView:some View{
        ForEach(vmComment.replys,id:\.self) { reply in
            CommentRowView(replyMode: true, replyOfReply: true,comment: reply)
                .padding(.top,5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
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
    
    func infoChangeView(action:@escaping ()->(),image:String,text:String,color:Color,x:CGFloat) -> some View{
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
}
