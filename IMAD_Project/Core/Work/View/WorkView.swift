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
    @State var writeReview = false//리뷰작성
    @State var writeCommunity = false
    @State var showMyRevie = false
    
    
//    @Environment(\.dismiss) var dismiss
    @StateObject var view = ViewManager.instance
    @StateObject var user = UserInfoManager.instance
    @StateObject var vmReview = ReviewViewModel(review:nil,reviewList:nil)
    @StateObject var vm = WorkViewModel(workInfo: nil,bookmarkList: [])
//    @EnvironmentObject var vmNavigation:NavigationViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            if vm.workInfo == nil{
                CustomProgressView()
            }else{
                Color.gray.opacity(0.1).ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    MovieBackgroundView(url: vm.workInfo?.backdropPath?.getImadImage() ?? "", height: 3)
                    poster
                    collection
                    VStack{
                        if let work = vm.workInfo{
                            WorkDetailsView(work: work)
                        }
                        reviewList
                    }
                }
                header
            }
        }
        .transition(.move(edge: .trailing))
        .foregroundColor(.white)
        .onAppear {
            if let contentsId{
                vm.getWorkInfo(contentsId: contentsId)
            }else if let id, let type{
                vm.getWorkInfo(id: id, type: type)
            }
        }
        .onDisappear{
            vmReview.reviewList?.list.removeAll()
        }
        .onReceive(vm.success){ contentsId in
            guard let contentsId else {return}
            vmReview.getReviewList(id:contentsId,page:1,sort:"createdDate",order:0,review:ReviewCache(list:[]))
        }
        .alert(isPresented: $written) {
            let no = Alert.Button.default(Text("아니오")){}
            let yes = Alert.Button.cancel(Text("예")){ showMyRevie = true }
            return Alert(title:Text("리뷰 작성함"),message:Text("이미 작성한 리뷰가 존재합니다!\n리뷰를 확인하시겠습니까?"),primaryButton:no,secondaryButton:yes)
        }
        .navigationDestination(isPresented: $writeReview) {
            CreateReviewView(id:vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", workName: vm.workInfo?.title ??  vm.workInfo?.name ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0,reviewId: nil)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CreatePostingView(contentsId: vm.workInfo?.contentsId ?? 0,contents:(vm.workInfo?.posterPath?.getImadImage() ?? "", vm.workInfo?.name ?? vm.workInfo?.title ?? "") , goMain: $writeCommunity)
                .navigationBarBackButtonHidden(true)
        }
        
        .navigationDestination(isPresented: $showMyRevie) {
            ReviewDetailsView(goWork: false, reviewId: vm.workInfo?.reviewId ?? 0, reported: false)
                .navigationBarBackButtonHidden()
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkView(vmReview: ReviewViewModel(review:CustomData.review,reviewList:ReviewCache(id:1,maxPage:1,currentPage:1,list: CustomData.reviewDetailList)), vm: WorkViewModel(workInfo: CustomData.workInfo,bookmarkList: CustomData.bookmarkList))
               
        }
    }
}


extension WorkView{
    var header: some View{
        ZStack{
            if width{
                Text(vm.workInfo?.name ?? vm.workInfo?.title ?? "")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .background(Material.regular)
                    .environment(\.colorScheme,.dark)
            }
            HStack{
                Button {
                    view.back()
//                    dismiss()
//                    withAnimation{
//                        vmNavigation.view = nil
//                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                }
                .padding([.leading])
                Spacer()
            }
            .padding(.vertical,20)
        }
    }
    var poster:some View{
        VStack(alignment: .leading){
            Text("작품정보")
                .bold()
                .font(.GmarketSansTTFMedium(25))
                .padding(.leading,35)
            HStack{
                KFImageView(image: vm.workInfo?.posterPath?.getImadImage() ?? "",width: 140,height: 180)
                    .cornerRadius(10)
                    .padding(.leading)
                VStack(alignment: .leading){
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading) {
                            Text(WorkTypeCategory.allCases.first(where:{$0.query == vm.workInfo?.contentsType ?? ""})?.name ?? "")
                                .padding(2)
                                .padding(.horizontal,7)
                                .background(RoundedRectangle(cornerRadius: 2)
                                    .stroke(lineWidth: 2)).bold()
                            Text(vm.workInfo?.releaseDate != nil ? "최초개봉일" : "최초공개일")
                                .bold()
                            if let work = vm.workInfo{
                                Text(work.releaseDate ?? work.firstAirDate ?? "")
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.subheadline)
                            }
                        }.font(.caption)
                        Spacer()
                        ScoreView(score: CGFloat(vm.workInfo?.imadScore ?? 0.0), color: .white,font:.body,widthHeight:70)
                            .padding(.leading)
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
        }
        .padding(.bottom,30)
    }
    var title:some View{
        VStack(alignment: .leading){
            Text(vm.workInfo?.name ??  vm.workInfo?.title ?? "")
                .padding(.top)
                .bold()
                .font(.title3)
            Text(vm.workInfo?.originalName ?? vm.workInfo?.originalTitle ?? "")
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
                                .font(.custom("GmarketSansTTFLight", size: 11))
                                .fontWeight(.medium)
                        }.foregroundColor(.customIndigo)
                        
                    }
                    Button {
                        writeCommunity = true
                    } label: {
                        VStack(spacing:5){
                            Image(systemName: "ellipsis.message")
                            Text("게시물작성")
                                .font(.custom("GmarketSansTTFLight", size: 11))
                                .fontWeight(.medium)
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
                                .font(.custom("GmarketSansTTFLight", size: 11))
                                .fontWeight(.medium)
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
                .font(.custom("GmarketSansTTFLight", size: 16))
                .fontWeight(.medium)
            VStack{
                if let myReviewId = vm.workInfo?.reviewId{
                    NavigationLink {
                        ReviewView(id:vm.workInfo?.contentsId ?? 0)
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 0){
                            Text(user.cache?.nickname ?? "")
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
                                CreateReviewView(id: work.contentsId, image: work.posterPath?.getImadImage() ?? "", workName: work.title ?? work.name ?? "", gradeAvg: work.imadScore ?? 0, reviewId: nil)
                                    .navigationBarBackButtonHidden()
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
            if let list = vmReview.reviewList?.list,!list.isEmpty{
                Text("리뷰 보기")
                    .padding(.top)
                    .font(.custom("GmarketSansTTFLight", size: 16))
                    .fontWeight(.medium)
            }
            ForEach((vmReview.reviewList?.list ?? []).prefix(2),id:\.self){ review in
                Button {
                    view.move(type:.reviewDetailsView(goWork:false,reviewId:review.reviewID))
                } label: {
                    ReviewListRowView(review: review, my: false)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            if vmReview.reviewList?.list.count ?? 0 > 2 {
                Button {
                    view.move(type:.reviewView(id:vm.workInfo?.contentsId ?? 0))
                } label: {
                    HStack{
                        Text("리뷰 \(vm.workInfo?.reviewCnt ?? 0)개 모두보기")
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
        .padding(.bottom)
        .foregroundColor(.black)
    }
}
