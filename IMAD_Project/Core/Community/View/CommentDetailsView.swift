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
    @State var modify = false
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
                ScrollView{
//                    ForEach(vm)
                }
                .background(Color.gray.opacity(0.1))
            }
            commentInputView
        }
        .foregroundColor(.black)
        .onAppear{
            vm.readComment(commentId: commentId)
        }
        .confirmationDialog("일정 수정", isPresented: $modify, actions: {
            Button(role:.none){
                modify = true
            } label: {
                Text("수정하기")
            }
            Button(role:.destructive){
//                vm.deleteCommunity(postingId: postingId)
            } label: {
                Text("삭제하기")
            }
        },message: {
            Text("게시물을 수정하거나 삭제하시겠습니까?")
        })
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
        HStack(alignment: .top){
            Image(ProfileFilter.allCases.first(where: {$0.num == vm.parentComment?.userProfileImage})?.rawValue ?? "")
                .resizable()
                .frame(width: 30,height: 30)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                HStack{
                    Text(vm.parentComment?.userNickname ?? "aa").bold()
                    Text("• " + (vm.parentComment?.modifiedAt.relativeTime() ?? "")).font(.caption)
                    Spacer()
                    Button {
                        modify = true
                    } label: {
                        Image(systemName: "ellipsis").foregroundColor(.black)
                    }
                }.padding(.bottom)
                Text(vm.parentComment?.content ?? "")
            }
        }.padding(.horizontal)
    }
}
