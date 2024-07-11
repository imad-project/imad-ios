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
    
    var main:Bool?
    @Binding var back:Bool
    @Environment(\.dismiss) var dismiss
    @FocusState var reply:Bool
    
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @StateObject var vmScrap = ScrapViewModel(scrapList: [])
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @StateObject var vmAuth = AuthViewModel(user: nil)
    
    let startingOffset: CGFloat = UIScreen.main.bounds.height/2
    @State private var currentOffset:CGFloat = 0
    @State private var endOffset:CGFloat = UIScreen.main.bounds.height/2
    
    var body: some View {
        VStack{
            if let community = vm.community{
                ZStack(alignment: .bottom){
                    Color.white.ignoresSafeArea()
                    VStack(spacing: 0){
                        header(community: community)
                        Divider()
                        ScrollView{
                            workInfoView(community: community)
                            communityinfoView(community: community)
                            likeStatusView(community: community)
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.bottom,100)
                    
                    commentView(community: community)
                }
                commentInputView(community: community)
            }else{
                ProgressView().environment(\.colorScheme,.light)
            }
        }
        .onAppear{
            vmAuth.getUser()
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
                let category = CommunityFilter.allCases.first(where: {$0.num == community.category})!
                CommunityWriteView(contentsId: community.contentsID, postingId: community.postingID, contents: (community.contentsPosterPath.getImadImage(),community.contentsTitle) ,category:category, spoiler: community.spoiler, text:community.content, title: community.title, goMain: .constant(true))
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
    func header(community:CommunityResponse) ->some View{
        ZStack{
            HStack(spacing:0){
                Button {
                    if let main {
                        if main{
                            dismiss()
                        }
                    }else{
                        self.back = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                }
                Spacer()
                Group{
                    Button {
                        vm.community?.scrapStatus = !community.scrapStatus
                        community.scrapStatus ? vmScrap.deleteScrap(scrapId: vm.community?.scrapId ?? 0) : vmScrap.writeScrap(postingId: vm.community?.postingID ?? 0)
                    } label: {
                        Image(systemName:community.scrapStatus ? "bookmark.fill" : "bookmark")
                    }
                    if community.author{
                        Button {
                            menu.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .bold()
                        }
                        .confirmationDialog("", isPresented: $menu,actions: {
                            Button(role:.none){
                                modify = true
                            } label: {
                                Text("수정하기")
                            }
                            Button(role:.destructive){
                                if let main {
                                    if main{
                                        dismiss()
                                    }
                                }else{
                                    self.back = false
                                }
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
            Text(community.contentsTitle)
                .bold()
            
            
        }.padding(.bottom,10)
    }
    func workInfoView(community:CommunityResponse) ->some View{
        HStack(alignment: .top){
            VStack(alignment: .leading){
                HStack{
                    ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 25)
                    Text(community.userNickname ?? "")
                        .font(.subheadline)
                        .bold()
                    HStack(spacing: 2){
                        Text(CommunityFilter.allCases.first(where:{$0.num == community.category})!.image)
                            .font(.caption2)
                        Text(CommunityFilter.allCases.first(where:{$0.num == community.category})!.name)
                            .font(.caption)
                        
                    }
                    .foregroundColor(.white)
                    .bold()
                    .padding(4)
                    .padding(.horizontal,5)
                    .background(Capsule().foregroundColor(.customIndigo))
                }
                HStack{
                    if community.modifiedAt != community.createdAt{
                        Text("수정됨 •").foregroundColor(.gray).font(.caption)
                    }
                    Text(community.modifiedAt.relativeTime()).font(.caption).foregroundColor(.gray)
                    Group{
                        HStack(spacing: 2){
                            Image(systemName: "eye.fill")
                            Text("\(community.viewCnt)")
                        }
                        HStack(spacing: 2){
                            Image(systemName: "message.fill")
                            Text("\(community.commentCnt)")
                        }
                    }
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding(2)
                    .padding(.horizontal,7)
                    .background(Color.gray.opacity(0.1).cornerRadius(50))
                }
                Text(community.title)
                    .bold()
                
            }
            Spacer()
            
            NavigationLink {
                WorkView(contentsId:community.contentsID)
                    .navigationBarBackButtonHidden()
            } label: {
                KFImageView(image: community.contentsPosterPath.getImadImage(),width:90,height:110)
            }
        } .padding(.top)
            .padding(.horizontal)
    }
    func communityinfoView(community:CommunityResponse) ->some View{
        HStack{
            Text(community.content)
                .padding(.horizontal)
                .font(.subheadline)
                .padding(.bottom)
            Spacer()
        }
        .padding(.bottom)
    }
    func likeStatusView(community:CommunityResponse) ->some View{
        VStack{
            HStack{
                Spacer()
                
                
                Button {
                    likePosting(community: community)
                } label: {
                    VStack{
                        Image(systemName:"poweroutlet.type.b.fill")
                            .resizable()
                            .foregroundColor(community.likeStatus == 1 ? .pink: .pink.opacity(0.3))
                            .frame(width: 30,height: 30)
                        Text("좋아요")
                            .font(.GmarketSansTTFMedium(10))
                    }
                    
                }
                
                Text("\(community.likeCnt)")
                Spacer().frame(width: 20)
                Button {
                    disLikePosting(community: community)
                } label: {
                    VStack{
                    Image(systemName:"poweroutlet.type.i.fill")
                        .resizable()
                        .foregroundColor(community.likeStatus == -1 ? .blue.opacity(0.7): .blue.opacity(0.3))
                        .frame(width: 30,height: 30)
                        Text("싫어요")
                            .font(.GmarketSansTTFMedium(10))
                    }
                }
                Text("\(community.dislikeCnt)")
            }
            .padding(.trailing)
            .font(.title3)
            if endOffset == startingOffset {
                Button {
                    withAnimation(.spring()){
                        endOffset = -startingOffset + 100
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

                Text("댓글창 열기 (\((community.commentCnt)))")
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
    func commentView(community:CommunityResponse) ->some View{
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
                if let comments = community.commentListResponse?.commentDetailsResponseList,comments.isEmpty{
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
    func commentInputView(community:CommunityResponse) ->some View{
        VStack{
            Divider()
            HStack{
                ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 40)
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black,textLimit: 400, text: $reviewText)
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
                Text("댓글은 최대 400글자까지 작성할 수 있으며, 비방이나 욕설은 삼가해주세요.😃😊")
                    .font(.caption2)
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.leading)
                Spacer()
            }
        }
        .padding(.bottom,25)
        .background(Color.white)
    }
    func likePosting(community:CommunityResponse){
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
    func disLikePosting(community:CommunityResponse){
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
