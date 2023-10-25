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
    @State var like = 0
    @State var reviewText = ""
    @State var seeMore = false
    @State var menu = false
    @State var modify = false
    
    @State var parentName:String? = nil
    @State var parentId:Int? = nil
    
    @FocusState var reply:Bool
    
    @StateObject var vm = CommunityViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack(spacing: 0){
                header
                Divider()
                ScrollView {
                    posting
                }
            }.foregroundColor(.black)
                .padding(.bottom,100)
            VStack{
                if let parentName{
                    Divider()
                    HStack{
                        Text(parentName).bold()
                        Text("님에게 댓글 취소")
                        Spacer()
                        Button {
                            self.parentName = nil
                            self.parentId = nil
                        } label: {
                            Image(systemName: "xmark").bold()
                        }
                    }.font(.footnote).foregroundColor(.black).padding(.horizontal)
                }
                Divider()
                HStack{
                    KFImage(URL(string: CustomData.instance.movieList.first!))
                        .resizable()
                        .frame(width: 40, height: 40)
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
                        vm.addReply(postingId: postingId, parentId: parentId, content: reviewText)
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
            .background(Color.white)
            .offset(y:-25)
        }
        .onAppear{
            vm.readDetailCommunity(postingId: postingId)
        }
        .onReceive(vm.success) {
            like = vm.communityDetail?.likeStatus ?? 0
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .confirmationDialog("일정 수정", isPresented: $menu, actions: {
            Button(role:.none){
                modify = true
            } label: {
                Text("수정하기")
            }
            Button(role:.destructive){
                vm.deleteCommunity(postingId: postingId)
            } label: {
                Text("삭제하기")
            }
        },message: {
            Text("게시물을 수정하거나 삭제하시겠습니까?")
        })
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $modify) {
            if let community = vm.communityDetail{
                CommunityWriteView(contentsId: community.contentsID, postingId: vm.communityDetail?.postingID ?? 0, image: community.contentsPosterPath.getImadImage(),category:CommunityFilter.allCases.first(where: {$0.num == community.category})!, spoiler: community.spoiler, text:community.content, title: community.title)
                    .navigationBarBackButtonHidden()
            }
        }
        .onReceive(vm.deleteSuccess) {
            dismiss()
        }
        .onReceive(vm.modifyComment) { commentStatus in
            reply = true
            parentName = commentStatus.0
            parentId = commentStatus.1
        }
    }
}

struct ComminityPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommunityPostView(postingId: 1)
                .environmentObject(AuthViewModel())
        }
    }
}

extension CommunityPostView{
    var header:some View{
        ZStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                }
                Spacer()
                if let userName = vmAuth.getUserRes?.data?.nickname,userName == vm.communityDetail?.userNickname{
                    Button {
                        menu.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .bold()
                            .padding()
                    }
                }
            }
            
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == vm.communityDetail?.userProfileImage ?? 1})!.rawValue)
                    .resizable()
                    .frame(width: 30,height: 30)
                    .clipShape(Circle())
                Text(vm.communityDetail?.userNickname ?? "a")
                    .font(.caption)
                    .bold()
            }.padding(.top,5)
            
        }.padding(.bottom,10)
    }
    var posting:some View{
        VStack(alignment: .leading) {
            Group{
                HStack(alignment: .top){
                    KFImage(URL(string: vm.communityDetail?.contentsPosterPath.getImadImage() ?? ""))
                        .resizable()
                        .frame(width: 100,height: 100)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    VStack(alignment: .leading,spacing: 5){
                        Text("#" + (vm.communityDetail?.contentsTitle ?? ""))
                            .font(.footnote)
                        HStack{
                            Text(CommunityFilter.allCases.first(where:{$0.num == vm.communityDetail?.category ?? 1})!.name).font(.caption2)
                                .foregroundColor(.white)
                                .padding(3)
                                .padding(.horizontal,5)
                                .background(Capsule().foregroundColor(.customIndigo))
                            Text((vm.communityDetail?.spoiler ?? false) ? "스포일러" : "클린")
                                .font(.caption2)
                                .padding(2)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                        }
                        Text(vm.communityDetail?.title ?? "")
                            .bold()
                        
                    }.padding([.leading,.bottom])
                    Spacer()
                    if vm.communityDetail?.modifiedAt != vm.communityDetail?.createdAt{
                        Text("수정됨 •").foregroundColor(.gray).font(.caption)
                    }
                    Text(vm.communityDetail?.modifiedAt.relativeTime() ?? "").font(.caption).foregroundColor(.gray)
                    
                }
                .padding(.horizontal)
                Text(vm.communityDetail?.content ?? "")
                    .padding(.horizontal)
                collection
            }.padding(.top)
            Divider()
                .padding(.horizontal)
            comment
        }
    }
    var collection:some View{
        VStack{
            HStack{
                Group{
                    HStack(spacing: 2){
                        Image(systemName: "eye.fill")
                        Text("\(vm.communityDetail?.viewCnt ?? 0)")
                    }
                    HStack(spacing: 2){
                        Image(systemName: "message.fill")
                        Text("\(vm.communityDetail?.commentCnt ?? 0)")
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
                        Text("\(vm.communityDetail?.likeCnt ?? 0)")
                    }
                    HStack(spacing: 2){
                        Image(systemName: "heart.slash.fill")
                            .foregroundColor(.blue)
                        Text("\(vm.communityDetail?.dislikeCnt ?? 0)")
                    }
                }.font(.subheadline)
            }
            VStack(alignment: .trailing){
                Divider()
                HStack{
                    Group{
                        Button {
                            if like < 1{
                                vm.communityDetail?.likeCnt += 1
                                if like < 0{
                                    vm.communityDetail?.dislikeCnt -= 1
                                }
                                like = 1
                                vm.like(postingId: vm.communityDetail?.postingID ?? 0, status: like)
                            }else{
                                like = 0
                                vm.communityDetail?.likeCnt -= 1
                                vm.like(postingId: vm.communityDetail?.postingID ?? 0, status: like)
                            }
                        } label: {
                            Image(systemName: like == 1 ? "heart.fill":"heart")
                            Text("좋아요")
                        }
                        .foregroundColor(like == 1 ? .red : .gray)
                        Button {
                            if like > -1{
                                vm.communityDetail?.dislikeCnt += 1
                                if like > 0{
                                    vm.communityDetail?.likeCnt -= 1
                                }
                                like = -1
                                vm.like(postingId: vm.communityDetail?.postingID ?? 0, status: like)
                            }else{
                                like = 0
                                vm.communityDetail?.dislikeCnt -= 1
                                vm.like(postingId: vm.communityDetail?.postingID ?? 0, status: like)
                            }
                        } label: {
                            HStack{
                                Image(systemName: like == -1 ? "heart.slash.fill" : "heart.slash")
                                Text("싫어요")
                            }
                        }
                        .foregroundColor(like == -1 ? .blue : .gray)
                    }
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                }
            }
        } .padding(.horizontal)
    }
    var comment:some View{
        ForEach(vm.communityDetail?.commentListResponse.commentDetailsResponseList ?? [],id: \.self){ comment in
            if !comment.removed{
                CommentRowView(comment: comment)
                    .environmentObject(vmAuth)
                    .environmentObject(vm)
                    .onReceive(vm.commentDeleteSuccess) { deleteComment in
                        vm.communityDetail?.commentListResponse.commentDetailsResponseList = vm.communityDetail?.commentListResponse.commentDetailsResponseList.filter{$0 != deleteComment} ?? []
                    }
            }else{
                VStack(alignment: .leading){
                    HStack{
                        Text("작성자에 의해 삭제된 댓글입니다.")
                        Spacer()
                        Text(comment.modifiedAt.relativeTime()).foregroundColor(.gray)
                    }
                    
                    Button {
                        vm.modifyComment.send((comment.userNickname,comment.commentID))
                    } label: {
                        Text("댓글작성").foregroundColor(.gray)
                    }.padding(.top)
                    Divider()
                }
                .font(.caption)
                    .padding(.horizontal)
            }
        }
    }
}
