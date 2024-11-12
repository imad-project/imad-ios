//
//  ComminityPostView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/14.
//

import SwiftUI
import Kingfisher

struct PostingDetailsView: View {
    
    @State var reported:Bool = false
    let postingId:Int
    @State var reviewText = ""
    
    @State var menu = false
    @State var modify = false
    @State var commentSheet = true
    @State var sort:SortPostCategory = .createdDate
    @State var order:OrderPostCategory = .ascending
    
    @StateObject var vmReport = ReportViewModel()
    @State var noReport = false
    @State var reportSuccess = false
    @State var message = ""
    @State var report = false
    @State var goReport = false
    @State var profile = false
    
    var main:Bool?
    @Binding var back:Bool
    @Environment(\.dismiss) var dismiss
    @FocusState var reply:Bool
    
    
    @StateObject var vm = CommunityViewModel(community: nil, communityList: [])
    @StateObject var vmScrap = ScrapViewModel(scrapList: [])
    @StateObject var vmComment = CommentViewModel(comment: nil, replys: [])
    @StateObject var user = UserInfoManager.instance
    
    let startingOffset: CGFloat = UIScreen.main.bounds.height/2
    @State private var currentOffset:CGFloat = 0
    @State private var endOffset:CGFloat = UIScreen.main.bounds.height/2
    
    var body: some View {
        VStack(spacing: 0){
            
            if let community = vm.community{
                ZStack(alignment: .bottom){
                    Color.white.ignoresSafeArea()
                    VStack(spacing: 0){
                        if !reported{
                            header(community: community)
                            Divider()
                            
                            ScrollView{
                                VStack{
                                    Divider()
                                    workInfoView(community: community)
                                    communityinfoView(community: community)
                                    likeStatusView(community: community)
                                    Divider()
                                }
                                .background(Color.white)
                                .padding(.top,10)
                            }
                            .frame(height:endOffset == 0 ?  UIScreen.main.bounds.height/2 - 140:nil)
                            .background(Color.gray.opacity(0.1))
                            .fullScreenCover(isPresented: $goReport){
                                ReportView(id: postingId,mode:"posting")
                                    .environmentObject(vmReport)
                            }
                            .onReceive(vmReport.success){ message in
                                reportSuccess = true
                                reported = true
                                self.message = message
                            }
                        }
                        if endOffset == 0{
                            Spacer()
                        }
                        
                    }
                    .foregroundColor(.black)
                    .alert(isPresented: $reported){
                        if reportSuccess{
                            return Alert(title: Text(message),message:message == "정상적으로 신고 접수가 완료되었습니다." ? Text("최대 24시간 이내로 검토가 진행될 예정입니다.") : nil, dismissButton:  .cancel(Text("확인"), action: {
                                if let main {
                                    if main{
                                        dismiss()
                                    }
                                }else{
                                    self.back = false
                                }
                            }))
                        }else{
                            let confim = Alert.Button.cancel(Text("확인하기")){
                                reported = false
                                noReport = true
                            }
                            let out = Alert.Button.default(Text("나가기")){
                                if let main {
                                    if main{
                                        dismiss()
                                    }
                                }else{
                                    self.back = false
                                }
                            }
                            return Alert(title: Text("경고"),message: Text("이 게시물은 \(user.cache?.nickname ?? "")님이 이미 신고한 게시물입니다. 계속하시겠습니까?"),primaryButton: confim, secondaryButton: out)
                        }
                        
                    }
                    if !reported{
                        commentView(community: community)
                        
                    }
                }
                if !reported{
                    commentInputView()
                        .sheet(isPresented: $profile){
                            ZStack{
                                Color.white.ignoresSafeArea()
                                OtherUsersProfileView(id: community.userID)
                                   
                            }
                            
                        }
                }
            }
        }
        .progress(vm.community != nil)
        .onAppear{
            vm.readDetailCommunity(postingId: postingId)
            vmComment.readComments(postingId: postingId, commentType: 0, page: vmComment.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: 0)
        }
        .onDisappear{
            vmComment.replys.removeAll()
            vmComment.currentPage = 1
        }
        .onChange(of: endOffset){ value in
            if endOffset == UIScreen.main.bounds.height/2{
                UIApplication.shared.endEditing()
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vmComment.success) { //무언가 할때마다 커뮤니티 업데이트
            vmComment.readComments(postingId: postingId, commentType: 0, page: vmComment.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: 0)
            vm.readDetailCommunity(postingId: postingId)
        }
        .navigationDestination(isPresented: $modify) {
            if let community = vm.community{
                let category = CommunityCategory.allCases.first(where: {$0.num == community.category})!
                CreatePostingView(contentsId: community.contentsID, postingId: community.postingID, contents: (community.contentsPosterPath.getImadImage(),community.contentsTitle) ,category:category, spoiler: community.spoiler, text:community.content ?? "", title: community.title, goMain: .constant(true))
                   
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

struct PostingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PostingDetailsView(reported: true, postingId: 1,back: .constant(true), vm: CommunityViewModel(community: CustomData.community, communityList: []))
               
        }
    }
}

extension PostingDetailsView{
    func header(community:PostingResponse) ->some View{
        HStack{
            HeaderView(backIcon: "chevron.left", text:CommunityCategory.allCases.first(where:{$0.num == community.category})!.name){
                if let main,main {
                    dismiss()
                }else{
                    self.back = false
                }
            }
            Spacer()
            Group{
                Button {
                    vm.community?.scrapStatus = !community.scrapStatus
                    community.scrapStatus ? vmScrap.deleteScrap(scrapId: vm.community?.scrapID ?? 0) : vmScrap.writeScrap(postingId: vm.community?.postingID ?? 0)
                } label: {
                    Image(systemName:community.scrapStatus ? "bookmark.fill" : "bookmark")
                }
                .padding(.horizontal,10)
                
                Button {
                    if let author = community.author,author{
                        menu.toggle()
                    }else{
                        report.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .bold()
                }
                .confirmationDialog("",
                                    isPresented: $report,
                                    actions: {
                    Button("신고하기") {
                        if noReport{
                            message = "이미 신고된 게시물입니다."
                            reported = true
                            reportSuccess = true
                        }else{
                            goReport = true
                        }
                    }
                }
                )
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
        }.padding(10)
    }
    func workInfoView(community:PostingResponse) ->some View{
        HStack(alignment: .top){
            VStack(alignment: .leading){
                HStack{
                    if community.userNickname != user.cache?.nickname{
                        Button {
                            profile = true
                        } label: {
                            ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 40)
                        }
                    }else{
                        ProfileImageView(imagePath: community.userProfileImage, widthHeigt: 40)
                    }
                    VStack(alignment: .leading,spacing: 0){
                        Text(community.userNickname ?? "")
                            .font(.subheadline)
                            .bold()
                        HStack{
                            if community.modifiedAt != community.createdAt{
                                Text("수정됨 •").foregroundColor(.gray).font(.caption)
                            }
                            Text(community.modifiedAt.relativeTime()).font(.caption).foregroundColor(.gray)
                            HStack(spacing: 2){
                                Image(systemName: "eye.fill")
                                Text("\(community.viewCnt)")
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(2)
                            .padding(.horizontal,7)
                            .background(Color.gray.opacity(0.1).cornerRadius(50))
                        }
                    }
                }
                Text(community.title)
                    .font(.GmarketSansTTFMedium(20))
                    .padding(.vertical,5)
            }
            Spacer()
        }
        .padding(.top,10)
        .padding(.horizontal,10)
    }
    func communityinfoView(community:PostingResponse) ->some View{
        VStack{
            HStack{
                Text(community.content ?? "")
                    .font(.subheadline)
                    .padding(.bottom)
                Spacer()
            }
            NavigationLink {
                WorkView(contentsId:community.contentsID)
                   
                    .navigationBarBackButtonHidden()
            } label: {
                HStack{
                    KFImageView(image: community.contentsPosterPath.getImadImage(),width: 30,height:40)
                    Text(community.contentsTitle)
                        .font(.GmarketSansTTFMedium(15))
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing)
                }
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 1)
            }
        }
        .padding(.horizontal,10)
        .padding(.bottom)
    }
    func likeStatusView(community:PostingResponse) ->some View{
        VStack{
            HStack{
                Button {
                    withAnimation(.spring()){
                        if endOffset == UIScreen.main.bounds.height/2{
                            endOffset = 0
                        }else{
                            endOffset = UIScreen.main.bounds.height/2
                        }
                    }
                } label: {
                    Text(endOffset == UIScreen.main.bounds.height/2 ? "댓글[\((community.commentCnt))]" : "접기")
                        .font(.GmarketSansTTFMedium(15))
                        .bold()
                }
                .padding(.leading,10)
                Spacer()
                Button {
                    likePosting(community: community)
                } label: {
                    HStack{
                        Image(systemName:"arrowshape.up.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 15,height: 15)
                        Text("추천")
                        Text("\(community.likeCnt)")
                    }
                    .foregroundColor(.white)
                    .font(.GmarketSansTTFMedium(10))
                    .padding(7.5)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.customIndigo.opacity(community.likeStatus == 1 ? 1:0.5)))
                }
                Button {
                    disLikePosting(community: community)
                } label: {
                    HStack{
                        Image(systemName:"arrowshape.down.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 15,height: 15)
                        Text("비추천")
                        Text("\(community.dislikeCnt)")
                    }
                    .foregroundColor(.white)
                    .font(.GmarketSansTTFMedium(10))
                    .padding(7.5)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.customIndigo.opacity(community.likeStatus == -1 ? 1:0.5)))
                }
            }
            .padding(.trailing,10)
            .font(.title3)
        }
        .padding(.bottom)
    }
    var collection:some View{
        VStack(alignment: .leading){
            HStack{
                ForEach(SortPostCategory.allCases.filter({$0 != .score}),id:\.self){ sort in
                    Button {
                        guard self.sort != sort else { return }
                        self.sort = sort
                        readCommunity()
                    } label: {
                        Text(sort.name)
                            .font(.GmarketSansTTFMedium(12))
                            .foregroundColor(.customIndigo)
                            .overlay {
                                if sort == self.sort{
                                    Capsule()
                                        .frame(width: 50,height: 2)
                                        .offset(y:15)
                                        .foregroundColor(.customIndigo)
                                }
                            }
                    }
                    .padding(.trailing)
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
                    .font(.GmarketSansTTFMedium(10))
                    .foregroundColor(.black)
                }
                
            }.padding(.vertical,10)
        }.padding(.horizontal,10)
        
    }
    func commentView(community:PostingResponse) ->some View{
        VStack{
            Capsule()
                .frame(width: 100,height: 5)
                .opacity(0.3)
                .padding(.vertical)
            HStack{
                Text("댓글 \(community.commentCnt)개")
                    .bold()
                    .font(.GmarketSansTTFMedium(20))
                Spacer()
            }
            .padding([.leading,.bottom],10)
            ScrollView{
                if endOffset == -startingOffset + 100{
                    collection
                }
                if let comments = community.commentListResponse?.detailList,comments.isEmpty{
                    Group{
                        Image(systemName: "ellipsis.message")
                            .font(.largeTitle)
                            .padding(.bottom,10)
                        Text("아직 댓글이 없습니다.")
                            .font(.GmarketSansTTFMedium(20))
                    }.foregroundStyle(.gray)
                    
                }else{
                    comment
                        .padding(.bottom,40)
                }
                Spacer()
            }
            .padding(.bottom,endOffset == 0 ? 300 : 0)
            .padding(.bottom,25)
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
        ForEach(vmComment.replys,id: \.self){ comment in
            CommentRowView(filter: .postComment, postingId: postingId, reported: comment.reported, deleted: comment.removed, comment: comment,reply:.constant(nil), commentFocus: $reply)
               
            if vmComment.replys.last == comment,vmComment.maxPage > vmComment.currentPage{
                ProgressView()
                    .onAppear{
                        vmComment.currentPage += 1
                        vmComment.readComments(postingId: postingId, commentType: 0, page: vmComment.currentPage, sort: sort.rawValue, order: order.rawValue, parentId: 0)
                    }
            }
        }
        
    }
    func commentInputView() ->some View{
        VStack{
            Divider()
            HStack{
                ProfileImageView(imagePath: user.cache?.profileImage ?? "", widthHeigt: 40)
                CustomTextField(password: false, image: nil, placeholder: "댓글을 달아주세요 .. ", color: .black,style: .capsule, textLimit: 400, font:.GmarketSansTTFMedium(14), text: $reviewText)
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
                        .font(.GmarketSansTTFMedium(15))
                        .foregroundColor(.customIndigo)
                }
                .padding(.leading,5)
            }
            .padding(.vertical,2)
            .padding(.horizontal,10)
            HStack{
                Text("댓글은 최대 400글자까지 작성할 수 있으며, 비방이나 욕설은 삼가해주세요.😃😊")
                    .font(.GmarketSansTTFMedium(10))
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.horizontal,10)
                Spacer()
            }
        }
        .padding(.bottom,25)
        .background(Color.white)
    }
    func likePosting(community:PostingResponse){
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
    func disLikePosting(community:PostingResponse){
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
