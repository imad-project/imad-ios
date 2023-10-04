//
//  WorkView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkView: View {
    
    let id:Int
    let type:String
    @State var width:Bool = false
    @State var anima = false
    @State var writeReview = false
    @State var writeCommunity = false
    @Environment(\.dismiss) var dismiss
    @StateObject var vmAuth = AuthViewModel()
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
                            WorkInfoView(work: work, type: type)
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
            vm.getWorkInfo(id: id, type: type)
            vmAuth.getUser()
            vm.getBookmark(page: 1)
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
        .onReceive(vm.success){
            vmReview.readReviewList(id: vm.workInfo?.contentsId ?? 0, page: 0, sort: ReviewSortFilter.createdDate.rawValue, order: 0)
        }
        .navigationDestination(isPresented: $writeReview) {
            WriteReviewView(id:vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0,reviewId: nil)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CommunityWriteView(image: vm.workInfo?.posterPath?.getImadImage() ?? "")
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden()
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(id: 1396, type: "tv")
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
                        writeReview = true
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
                        vm.addBookmark(id: vm.workInfo?.contentsId ?? 0)
                    } label: {
                        VStack(spacing:5){
                            Image(systemName: "bookmark")
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
                if let my = vmReview.reviewList.first(where: {$0.userNickname == vmAuth.profileInfo.nickname}){
                    ForEach(vmReview.reviewList,id:\.self){ review in
                        if review == my{
                            NavigationLink {
                                ReviewDetailsView(reviewId: review.reviewID)
                                    .environmentObject(vmAuth)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ReviewListRowView(review: review).padding([.top,.horizontal],10).background(Color.white).cornerRadius(10)
                            }
                        }
                    }
                }else{
                    VStack{
                        Text("내 리뷰가 존재하지 않습니다.")
                            .font(.subheadline)
                        NavigationLink {
                            WriteReviewView(id: vm.workInfo?.contentsId ?? 0, image: vm.workInfo?.posterPath?.getImadImage() ?? "", gradeAvg: vm.workInfo?.imadScore ?? 0, reviewId: nil)
                                .navigationBarBackButtonHidden()
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
                    ReviewDetailsView(reviewId: review.reviewID)
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
