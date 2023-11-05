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
    @State var type:String?
    @State var contentsId:Int?
    
    @State var tokenExpired = (false,"")
    @State var width:Bool = false
    @State var anima = false
    @State var writeReview = false
    @State var writeCommunity = false
    @State var message = ""
    @State var showMyRevie = false
    @State var goPosting = (false,0)
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    @StateObject var vmReview = ReviewViewModel()
    @StateObject var tab = CommunityTabViewModel()
    @StateObject var vm = WorkViewModel()
    
    
    var returnType:Bool{
        switch type{
        case "movie":
            return false
        case "tv":
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
                    MovieBackgroundView(url: vm.workInfo?.posterPath?.getImadImage() ?? "", height: 3)
                    poster
                    collection
                    VStack{
                        if let work = vm.workInfo{
                            WorkInfoView(work: work, type: type ?? "")
                        }
                        reviewList
                    }
                    
                }
                
                if width{
                    Text(returnType ? vm.workInfo?.name ?? "" : vm.workInfo?.title ?? "")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(Material.regular)
                        .environment(\.colorScheme,.dark)
                }
                header
            }
        }
        .foregroundColor(.white)
        .onAppear {
//            vmAuth.getUser()
            vm.getBookmark(page: vm.page)
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
            guard let contentsId else {return}
            vm.getWorkInfo(contentsId: contentsId)
        }
        .onReceive(vm.success){
            self.contentsId = vm.workInfo?.contentsId ?? 0
            vmReview.readReviewList(id: vm.workInfo?.contentsId ?? 0, page: vmReview.page, sort: SortFilter.createdDate.rawValue, order: 0)
        }
        .navigationDestination(isPresented: $writeReview) {
            WriteReviewView(id:vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0,reviewId: nil)
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CommunityWriteView(contentsId: vm.workInfo?.contentsId ?? 0,image: vm.workInfo?.posterPath?.getImadImage() ?? "")
                .environmentObject(vmAuth)
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden()
        .onReceive(vmReview.tokenExpired) { messages in
            tokenExpired = (true,messages)
            message = "토큰 만료됨"
        }
        .alert(isPresented: $tokenExpired.0) {
            Alert(title: Text(message),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
                if message == "토큰 만료됨"{
//                    vmAuth.loginMode = false
                }else{
                    showMyRevie = true
                }
            })
        }
//        .onReceive(vmAuth.postingSuccess){ postingId in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                goPosting = (true,postingId)
//            }
//
//        }
        .navigationDestination(isPresented: $goPosting.0){
            CommunityPostView(postingId:goPosting.1)
                .environmentObject(vmAuth)
        }
        .navigationDestination(isPresented: $showMyRevie) {
//            if let my = vmReview.reviewList.first(where: {$0.userNickname == vmAuth.profileInfo.nickname}),let review = vmReview.reviewList.first(where: {$0 == my}){
//                ReviewDetailsView(goWork: false, reviewId: review.reviewID)
//                    .environmentObject(vmAuth)
//                    .navigationBarBackButtonHidden()
//
//            }
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(id: 1396, type: "tv")
            .environmentObject(AuthViewModel())
    }
}


extension WorkView{
    var header: some View{
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
    var poster:some View{
        HStack{
            KFImage(URL(string: vm.workInfo?.posterPath?.getImadImage() ?? ""))
                .resizable()
                .placeholder{
                    NoImageView()
                }
                .frame(width: 140,height: 180)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(.leading)
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    VStack(alignment: .leading) {
                        Text(returnType ? "TV" : "영화").padding(2).padding(.horizontal,7).background(RoundedRectangle(cornerRadius: 2).stroke(lineWidth: 2)).bold()
                        
                        Text(!returnType ? "최초개봉일" : "최초공개일")
                            .bold()
                        if let work = vm.workInfo{
                            Text(!returnType ? work.releaseDate ?? "" : work.firstAirDate ?? "")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                    }.font(.caption)
                    Spacer()
                    if let work = vm.workInfo{
                        Circle()
                            .trim(from: 0.0, to: anima ? CGFloat(work.imadScore as Double? ?? 0.0) * 0.1 : 0)
                            .stroke(lineWidth: 3)
                            .rotation(Angle(degrees: 270))
                            .frame(width: 70,height: 70)
                            .overlay{
                                VStack(spacing:5){
                                    Image(systemName: "star.fill")
                                    Text(String(format: "%0.1f",CGFloat(work.imadScore as Double? ?? 0.0)))
                                }
                                .font(.subheadline)
                            }
                            .background(Circle().stroke(lineWidth:0.5).foregroundColor(.black.opacity(0.7)))
                    }
                    
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
//                        if vmReview.reviewList.first(where: {$0.userNickname == vmAuth.profileInfo.nickname}) != nil{
//                            message = "리뷰 작성함"
//                            tokenExpired = (true,"이미 작성한 리뷰가 존재합니다!")
//                        }else{
//                            writeReview = true
//                        }
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
//                if let my = vmReview.reviewList.first(where: {$0.userNickname == vmAuth.profileInfo.nickname}),let review = vmReview.reviewList.first(where: {$0 == my}){
//                            NavigationLink {
//                                ReviewDetailsView(goWork: false, reviewId: review.reviewID)
//                                    .environmentObject(vmAuth)
//                                    .navigationBarBackButtonHidden()
//                            } label: {
//                                HStack(spacing: 0){
//                                    Text(vmAuth.getUserRes?.data?.nickname ?? "")
//                                        .bold()
//                                        .padding(.leading)
//                                        .font(.subheadline)
//                                    Text("님이 작성한 리뷰가 있네요?")
//                                        .font(.subheadline)
//                                    Spacer()
//                                    Text("리뷰 확인하기 >").foregroundColor(.gray).font(.caption).padding(.trailing)
//                                }
//                                .padding(5)
//                                .padding(.vertical)
//                                .background(Color.white).cornerRadius(5)
//                            }
//
//                }else{
//                    VStack{
//                        Text("내 리뷰가 존재하지 않습니다.")
//                            .font(.subheadline)
//                        NavigationLink {
//                            WriteReviewView(id: vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0, reviewId: nil)
//                                .navigationBarBackButtonHidden()
//                                .environmentObject(vmAuth)
//                        } label: {
//                            Text("리뷰작성")
//                                .foregroundColor(.white)
//                                .font(.caption)
//                                .padding(.horizontal)
//                                .padding(10)
//                                .background(Color.customIndigo)
//                                .cornerRadius(10)
//                        }
//
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
//                    .padding(.vertical,20)
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.customIndigo))
//                }
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
                        Text("리뷰 \(vmReview.reviewDetailsInfo?.numberOfElements ?? 0)개 모두보기")
                        Image(systemName: "chevron.right")
                    }.font(.caption).frame(maxWidth: .infinity)
                        .padding(.vertical,10)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray).background(Color.white))
                    
                }
                
                
                
            }
            
        }
        .padding(.horizontal)
        .foregroundColor(.black)
        .padding(.bottom,30)
        .background(Color.gray.opacity(0.1))
    }
}
