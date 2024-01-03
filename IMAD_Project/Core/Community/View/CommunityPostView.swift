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
    @State var reviewText = ""
    
    @State var menu = false
    @State var modify = false
    @State var commentSheet = true
    @State var sort:SortFilter = .createdDate
    @State var order:OrderFilter = .ascending
    
    @Binding var back:Bool
    
    @FocusState var reply:Bool
    
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @StateObject var vmScrap = ScrapViewModel(scrapList: [])
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    let startingOffset: CGFloat = UIScreen.main.bounds.height/2
    @State private var currentOffset:CGFloat = 0
    @State private var endOffset:CGFloat = UIScreen.main.bounds.height/2
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                Color.white.ignoresSafeArea()
                VStack(spacing: 0){
                    header
                    Divider()
                    ScrollView{
                        workInfoView
                        communityinfoView
                        likeStatusView
                    }
                }
                .foregroundColor(.black)
                .padding(.bottom,100)
                
                commentView
            }
            commentInputView
        }
        .onAppear{
            vm.readDetailCommunity(postingId: postingId)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vmComment.success) { //무언가 할때마다 커뮤니티 업데이트
            vm.readDetailCommunity(postingId: postingId)
        }
        .navigationDestination(isPresented: $modify) {
            if let community = vm.community{
                CommunityWriteView(contentsId: community.contentsID, postingId: community.postingID, image: community.contentsPosterPath.getImadImage(),category:CommunityFilter.allCases.first(where: {$0.num == community.category})!, spoiler: community.spoiler, text:community.content, title: community.title, goMain: .constant(true))
                    .environmentObject(vmAuth)
                    .navigationBarBackButtonHidden()
            }
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .onReceive(vmComment.commentLoadSuccess){ commentList in
            vm.community?.commentListResponse?.commentDetailsResponseList = commentList
        }
    }
}

struct ComminityPostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CommunityPostView(postingId: 1,back: .constant(true), vm: CommunityViewModel(community: CustomData.instance.community, communityList: []))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}

extension CommunityPostView{
    var header:some View{
        ZStack{
            HStack(spacing:0){
                Button {
                    back = false
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                }
                Spacer()
                Group{
                    if let scrapStatus = vm.community?.scrapStatus{
                        Button {
                            if scrapStatus{
                                vm.community?.scrapStatus = false
                                vmScrap.deleteScrap(scrapId: vm.community?.scrapId ?? 0)
                            }else{
                                vm.community?.scrapStatus = true
                                vmScrap.writeScrap(postingId: vm.community?.postingID ?? 0)
                            }
                        } label: {
                            Image(systemName:scrapStatus ? "bookmark.fill" : "bookmark")
                        }
                    }
                    if let userName = vmAuth.user?.data?.nickname,userName == vm.community?.userNickname{
                        Button {
                            menu.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .bold()
                        }
                        .confirmationDialog("일정 수정", isPresented: $menu,actions: {
                            Button(role:.none){
                                modify = true
                            } label: {
                                Text("수정하기")
                            }
                            Button(role:.destructive){
                                back = true
                                vm.deleteCommunity(postingId: postingId)
                            } label: {
                                Text("삭제하기")
                            }
                        },message: {
                            Text("게시물을 수정하거나 삭제하시겠습니까?")
                        })
                    }
                }
                .padding(.trailing)
                
            }
            Text(vm.community?.contentsTitle ?? "")
                .bold()
            
            
        }.padding(.bottom,10)
    }
    var workInfoView:some View{
        HStack(alignment: .top){
            VStack(alignment: .leading){
                HStack{
                    ProfileImageView(imageCode: vm.community?.userProfileImage ?? 90, widthHeigt: 25)
                    Text(vm.community?.userNickname ?? "")
                        .font(.subheadline)
                        .bold()
                    HStack(spacing: 2){
                        Text(CommunityFilter.allCases.first(where:{$0.num == vm.community?.category ?? 1})!.image)
                            .font(.caption2)
                        Text(CommunityFilter.allCases.first(where:{$0.num == vm.community?.category ?? 1})!.name)
                            .font(.caption)
                        
                    }
                    .foregroundColor(.white)
                    .bold()
                    .padding(4)
                    .padding(.horizontal,5)
                    .background(Capsule().foregroundColor(.customIndigo))
                }
                HStack{
                    if vm.community?.modifiedAt != vm.community?.createdAt{
                        Text("수정됨 •").foregroundColor(.gray).font(.caption)
                    }
                    Text(vm.community?.modifiedAt.relativeTime() ?? "").font(.caption).foregroundColor(.gray)
                    Group{
                        HStack(spacing: 2){
                            Image(systemName: "eye.fill")
                            Text("\(vm.community?.viewCnt ?? 0)")
                        }
                        HStack(spacing: 2){
                            Image(systemName: "message.fill")
                            Text("\(vm.community?.commentCnt ?? 0)")
                        }
                    }
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding(2)
                    .padding(.horizontal,7)
                    .background(Color.gray.opacity(0.1).cornerRadius(50))
                }
                Text(vm.community?.title ?? "")
                    .bold()
                
            }
            Spacer()
            
            NavigationLink {
                WorkView(contentsId:vm.community?.contentsID ?? 0)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vmAuth)
            } label: {
                KFImageView(image: vm.community?.contentsPosterPath.getImadImage() ?? "",width:90,height:110)
            }
        } .padding(.top)
            .padding(.horizontal)
    }
    var communityinfoView:some View{
        HStack{
            Text(vm.community?.content ?? "")
                .padding(.horizontal)
                .font(.subheadline)
                .padding(.bottom)
            Spacer()
        }
        .padding(.bottom)
    }
    var likeStatusView:some View{
        VStack{
            HStack{
                Text("\(vm.community?.likeCnt ?? 0)")
                Button {
                    likePosting()
                } label: {
                    Circle()
                        .foregroundColor(vm.community?.likeStatus == 1 ? .red.opacity(0.7): .red.opacity(0.3))
                        .frame(width: 50)
                        .overlay {
                            Image(systemName:"heart.fill")
                                .foregroundColor(.white)
                        }
                }
                Spacer().frame(width: 20)
                Button {
                    disLikePosting()
                } label: {
                    Circle()
                        .foregroundColor(vm.community?.likeStatus == -1 ? .blue.opacity(0.7): .blue.opacity(0.3))
                        .frame(width: 50)
                        .overlay {
                            Image(systemName:"hand.thumbsdown.fill")
                                .foregroundColor(.white)
                        }
                }
                Text("\(vm.community?.dislikeCnt ?? 0)")
            }
            .font(.title3)
            .frame(maxWidth: .infinity)
            if endOffset == startingOffset {
                Button {
                    withAnimation(.spring()){
                        endOffset = 0
                    }
                } label: {
                    Circle()
                        .foregroundColor(.customIndigo)
                        .frame(width: 50)
                        .overlay {
                            Image(systemName:"message.fill")
                                .foregroundColor(.white)
                        }
                }

                Text("댓글창 열기 (\((vm.community?.commentCnt ?? 0)))")
                    .font(.caption)
            }
        }
        
    }
    var collection:some View{
        VStack(alignment: .leading){
            HStack{
                ForEach(SortFilter.allCases.filter({$0 != .score}),id:\.self){ sort in
                    Button {
                        guard self.sort != sort else { return }
                        self.sort = sort
                        readCommunity()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.customIndigo.opacity(sort == self.sort ? 1.0:0.5 ))
                            .frame(width: 60,height: 30)
                            .overlay {
                                Text(sort.name).font(.caption).foregroundColor(.white)
                            }
                    }
                }
                Spacer()
                Button {
                    if order == .ascending{
                        withAnimation{
                            order = .descending
                            readCommunity()
                        }
                    }else{
                        withAnimation{
                            order = .ascending
                            readCommunity()
                        }
                    }
                } label: {
                    HStack{
                        Text(order.name)
                        Image(systemName: order == .ascending ? "chevron.up" : "chevron.down")
                    } 
                    .font(.caption)
                    .foregroundColor(.black)
                }
                
            }.padding(.vertical,5)
        }.padding(.horizontal)
        
    }
    var commentView:some View{
        VStack{
            Capsule()
                .frame(width: 100,height: 5)
                .opacity(0.3)
                .padding(.vertical)
            HStack{
                Text("댓글")
                    .bold()
                    .font(.title2)
                Spacer()
            }
            .padding([.leading,.bottom])
            ScrollView{
                if endOffset == -startingOffset + 100{
                    collection
                }
                if let comments = vm.community?.commentListResponse?.commentDetailsResponseList,comments.isEmpty{
                    Group{
                        Image(systemName: "ellipsis.message")
                            .font(.largeTitle)
                            .padding(.bottom,10)
                        Text("아직 댓글이 없습니다.")
                    }.foregroundStyle(.gray)
                    
                }else{
                    comment
                        .padding(.top)
                }
                Spacer()
            }
            .padding(.bottom,endOffset == 0 ? 300 : 0)
        }
        
        .background{
            RoundedRectangle(cornerRadius: 10)
                .shadow(radius: 1)
                .foregroundStyle(.white)
        }
        .offset(y:startingOffset - 100)
        .offset(y:currentOffset)
        .offset(y:endOffset)
        .gesture(
            DragGesture()
                .onChanged{ value in
                    withAnimation(.spring()){
                        currentOffset = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()){
                       offsetSetting()
                    }
                }
        )

    }
    var comment:some View{
        ForEach(vm.community?.commentListResponse?.commentDetailsResponseList ?? [],id: \.self){ comment in
            CommentRowView(filter: .postComment, postingId: postingId, deleted: comment.removed, comment: comment,reply:.constant(nil), commentFocus: $reply)
                .environmentObject(vmAuth)
        }
        .padding(.bottom,25)
    }
    var commentInputView:some View{
        VStack{
            Divider()
            HStack{
                ProfileImageView(imageCode: vm.community?.userProfileImage ?? 0, widthHeigt: 40)
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black, text: $reviewText)
                    .focused($reply)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.customIndigo)
                    }
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            withAnimation(.spring()){
                                endOffset = -startingOffset + 100
                            }
                        }
                    }
                Button {
                    vmComment.addReply(postingId: postingId, parentId: nil, content: reviewText,commentMode: true)
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
    func likePosting(){
        guard let like = vm.community?.likeStatus else {return}
        if like < 1{
            if like < 0{
                vm.community?.dislikeCnt -= 1
            }
            vm.community?.likeCnt += 1
            
            vm.community?.likeStatus = 1
            vm.like(postingId: vm.community?.postingID ?? 0, status: 1)
        }else{
            vm.community?.likeCnt -= 1
            vm.community?.likeStatus = 0
            vm.like(postingId: vm.community?.postingID ?? 0, status: 0)
        }
    }
    func disLikePosting(){
        guard let like = vm.community?.likeStatus else {return}
        if like > -1{
            if like > 0{
                vm.community?.likeCnt -= 1
            }
            vm.community?.dislikeCnt += 1
            vm.community?.likeStatus = -1
            vm.like(postingId: vm.community?.postingID ?? 0, status: -1)
        }else{
            vm.community?.likeStatus = 0
            vm.community?.dislikeCnt -= 1
            vm.like(postingId: vm.community?.postingID ?? 0, status: 0)
        }
    }
    
    func readCommunity(){
        vmComment.currentPage = 1
        vmComment.replys.removeAll()
        vmComment.readComments(postingId: postingId, commentType: 0, page: vm.currentPage, sort: self.sort.rawValue, order: order.rawValue, parentId:0)
    }
    func offsetSetting(){
        if currentOffset < -50{
            if currentOffset < -startingOffset{
                endOffset = -startingOffset + 100
            }else if endOffset == 0{
                 endOffset = -startingOffset + 100
             }
        }
         else if currentOffset > 50 {
             if currentOffset > startingOffset/2{
                 endOffset = startingOffset
             }
             else if endOffset < 0{
                 endOffset = 0
             }else if endOffset == 0{
                 endOffset = startingOffset
             }
         }
         currentOffset = 0
    }
}
