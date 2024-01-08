//
//  WorkView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkView: View {
    
    var id:Int?
    var type:String?
    var contentsId:Int?
    
    @State var width:Bool = false   //작품 제목 섹션 생성
    @State var written = false  //리뷰가 작성되있을 경우
    //    @State var anima = false
    @State var writeReview = false//리뷰작성
    @State var writeCommunity = false
    //    @State var message = ""
    @State var showMyRevie = false
    //    @State var goPosting = (false,0)
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel//
    @StateObject var vmReview = ReviewViewModel(review:nil,reviewList: [])
    @StateObject var tab = CommunityTabManager()
    @StateObject var vm = WorkViewModel(workInfo: nil,bookmarkList: [])
    
    
    var returnType:Bool{
        switch vm.workInfo?.tmdbType{ //mediaType으로 교체될 예정
        case "MOVIE":
            return false
        case "TV":
            return true
        default:
            return true
        }
    }
    
    var body: some View {
        VStack{
            ZStack(alignment: .topLeading){
                Color.white.ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    MovieBackgroundView(url: vm.workInfo?.posterPath?.getImadImage() ?? "", height: 3, isBottomTransparency: true)
                    poster
                    collection
                    VStack{
                        if let work = vm.workInfo{
                            WorkInfoView(work: work)
                        }
                        reviewList
                    }
                }
                header
            }
        }
        .foregroundColor(.white)
        .onAppear {
            vm.getBookmark(page: vm.currentPage)
            if let contentsId{
                vm.getWorkInfo(contentsId: contentsId)
            }else if let id, let type{
                vm.getWorkInfo(id: id, type: type)
            }
        }
        .onDisappear{
            vmReview.reviewList.removeAll()
        }
        .onReceive(vm.success){ contentsId in
            guard let contentsId else {return}
            vmReview.readReviewList(id: contentsId, page: 1, sort: "createdDate", order: 0)
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .alert(isPresented: $written) {
            let no = Alert.Button.default(Text("아니오")) {}
            let yes = Alert.Button.cancel(Text("예")) {
                showMyRevie = true
            }
            return Alert(title: Text("리뷰 작성함"),
                         message: Text("이미 작성한 리뷰가 존재합니다!\n리뷰를 확인하시겠습니까?"),
                         primaryButton: no, secondaryButton: yes)
        }
        .navigationDestination(isPresented: $writeReview) {
            WriteReviewView(id:vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0,reviewId: nil)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CommunityWriteView(contentsId: vm.workInfo?.contentsId ?? 0,image: vm.workInfo?.posterPath?.getImadImage() ?? "", goMain: $writeCommunity)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        
        .navigationDestination(isPresented: $showMyRevie) {
            ReviewDetailsView(goWork: false, reviewId: vm.workInfo?.reviewId ?? 0)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden()
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkView(vmReview: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail), vm: WorkViewModel(workInfo: CustomData.instance.workInfo,bookmarkList: CustomData.instance.bookmarkList))
                .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
        }
    }
}


extension WorkView{
    var header: some View{
        ZStack{
            if width{
                Text(returnType ? vm.workInfo?.name ?? "" : vm.workInfo?.title ?? "")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Material.regular)
                    .environment(\.colorScheme,.dark)
            }
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(10)
                        .font(.caption)
                        .background(Circle().foregroundColor(.white))
                        .shadow(radius: 20)
                        .padding(.leading)
                    
                }
                Spacer()
            }
        }
    }
    var poster:some View{
        HStack{
            KFImageView(image: vm.workInfo?.posterPath?.getImadImage() ?? "",width: 140,height: 180)
                .padding(.leading)
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    VStack(alignment: .leading) {
                        Text(returnType ? "TV" : "영화")
                            .padding(2)
                            .padding(.horizontal,7)
                            .background(RoundedRectangle(cornerRadius: 2)
                                .stroke(lineWidth: 2)).bold()
                        Text(!returnType ? "최초개봉일" : "최초공개일")
                            .bold()
                        if let work = vm.workInfo{
                            Text(!returnType ? work.releaseDate ?? "" : work.firstAirDate ?? "")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                    }.font(.caption)
                    Spacer()
                    ScoreView(score: CGFloat(vm.workInfo?.imadScore ?? 0.0), color: .white,font:.body,widthHeight:70)
                    Spacer()
                }
                GeometryReader { geo -> AnyView in
                    let offset = geo.frame(in: .global).minY
                    DispatchQueue.main.async {
                        withAnimation {
                            -offset >= 0 ? (width = true) : (width = false)
                        }
                    }
                    return AnyView(title)
                }
            }
            .padding(.leading,20)
            Spacer()
        }
        .padding(.vertical,30)
    }
    var title:some View{
        VStack(alignment: .leading){
            Text(returnType ? vm.workInfo?.name ?? "" : vm.workInfo?.title ?? "")
                .padding(.top)
                .bold()
                .padding(.bottom,5)
            Text(returnType ? vm.workInfo?.originalName ?? "" : vm.workInfo?.originalTitle ?? "")
                .font(.subheadline)
        }
    }
    var collection:some View{
        VStack(spacing:0){
            Divider()
            HStack(spacing:0){
                Group{
                    Button {
                        if let writtenReview = vm.workInfo?.reviewStatus,writtenReview{
                            written = true
                        }else{
                            writeReview = true
                        }
                    } label: {
                        VStack(spacing:5){
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            Text("리뷰작성")
                                .font(.caption)
                        }.foregroundColor(.customIndigo)
                        
                    }
                    Button {
                        writeCommunity = true
                    } label: {
                        VStack(spacing:5){
                            Image(systemName: "ellipsis.message")
                            Text("게시물작성")
                                .font(.caption)
                        }.foregroundColor(.customIndigo)
                    }
                    Button {
                        guard let bookmark = vm.workInfo?.bookmark else { return }
                        if bookmark{
                            vm.deleteBookmark(id: vm.workInfo?.bookmarkId ?? 0)
                        }else{
                            vm.addBookmark(id: vm.workInfo?.contentsId ?? 0)
                        }
                        vm.workInfo?.bookmark.toggle()
                    } label: {
                        VStack(spacing:5){
                            if let bookmark = vm.workInfo?.bookmark{
                                Image(systemName: bookmark ? "bookmark.fill" :  "bookmark")
                            }
                            Text("찜")
                                .font(.caption)
                        }.foregroundColor(.customIndigo)
                    }
                }.frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .background(Color.white)
            Divider()
        }
        
    }
    var reviewList:some View{
        VStack(alignment: .leading) {
            Text("내 리뷰")
                .padding(.top)
                .bold()
            VStack{
                //                if let review = vmReview.reviewList.first{
                if let myReviewId = vm.workInfo?.reviewId{
                    //                if let my = vmReview.reviewList.first(where: {$0.userNickname == vmAuth.profileInfo.nickname}),let review = vmReview.reviewList.first(where: {$0 == my}){
                    NavigationLink {
                        ReviewDetailsView(goWork: false, reviewId: myReviewId)
                            .environmentObject(vmAuth)
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 0){
                            Text(vmAuth.user?.data?.nickname ?? "")
                                .bold()
                                .padding(.leading)
                                .font(.subheadline)
                            Text("님이 작성한 리뷰가 있네요?")
                                .font(.subheadline)
                            Spacer()
                            Text("리뷰 확인하기 >").foregroundColor(.gray).font(.caption).padding(.trailing)
                        }
                        .padding(5)
                        .padding(.vertical)
                        .background(Color.white).cornerRadius(5)
                    }
                    
                }
                else{
                    VStack{
                        Text("내 리뷰가 존재하지 않습니다.")
                            .font(.subheadline)
                        NavigationLink {
                            if let work = vm.workInfo{
                                WriteReviewView(id: work.contentsId, image: work.posterPath?.getImadImage() ?? "", gradeAvg: work.imadScore ?? 0, reviewId: nil)
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(vmAuth)
                            }
                            
                        } label: {
                            Text("리뷰작성")
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(.horizontal)
                                .padding(10)
                                .background(Color.customIndigo)
                                .cornerRadius(10)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.customIndigo))
                }
            }
            Text("리뷰 보기")
                .padding(.top)
                .bold()
            ForEach(vmReview.reviewList.prefix(2),id:\.self){ review in
                NavigationLink {
                    ReviewDetailsView(goWork: false, reviewId: review.reviewID)
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    ReviewListRowView(review: review).padding([.top,.horizontal],10).background(Color.white).cornerRadius(10)
                }
            }
            if vmReview.reviewList.count > 2 {
                NavigationLink {
                    ReviewView(id: vm.workInfo?.contentsId ?? 0)
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack{
                        Text("리뷰 \(0)개 모두보기")
                        Image(systemName: "chevron.right")
                    }
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,10)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.gray)
                        .background(Color.white)
                    )
                }
            }
        }
        .padding(.horizontal)
        .foregroundColor(.black)
        .padding(.bottom,30)
        .background(Color.gray.opacity(0.1))
    }
}
