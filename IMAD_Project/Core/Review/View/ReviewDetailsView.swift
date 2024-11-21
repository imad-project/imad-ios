//
//  ReviewDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import SwiftUI
import Kingfisher

struct ReviewDetailsView: View {
    
    let goWork:Bool                     //작품상세정보표시 유무
    let reviewId:Int                    //리뷰ID
    
    @State var reportSuccess = false    //신고 성공
    //알림
    @State var message = ""             //알림 메세지
    @State var reported = false         //신고 유무
    //메뉴버튼
    @State var report = false           //신고하기
    @State var menu = false             //수정 및 삭제하기
    @State var delete = false           //삭제하기
    //뷰
    @State var sheetReport = false      //신고화면 표시
    @State var sheetProfile = false     //유저프로필 화면 표시
    //클래스 인스턴스
    @StateObject var user = UserInfoManager.instance
    @StateObject var view = ViewManager.instance
    @StateObject var vmReview = ReviewViewModel(review: nil, reviewList: [])
    @StateObject var vmReport = ReportViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            if let review = vmReview.review{
                header(review: review)
                ScrollView{
                    VStack{
                        Divider()
                        reviewInfoView(review: review)
                        contentAndLikeView(review: review)
                        Divider()
                    }
                    .background(Color.white)
                    .padding(.top,10)
                }
                .background(Color.gray.opacity(0.1))
            }
        }
        .progress(vmReview.review != nil)
        .sheet(isPresented:$sheetProfile){ OtherUsersProfileView(id:vmReview.review?.userID ?? 0) }
        .fullScreenCover(isPresented:$sheetReport){ ReportView(id: reviewId,mode:"review")}
        .foregroundColor(.black)
        .background(Color.white1)
        .onAppear{ vmReview.readReview(id:reviewId) }
        .environmentObject(vmReport)
        .alert(isPresented:$reported){ alert }
        .onReceive(vmReview.reportedReview){ reported = true }
        .onReceive(vmReport.success){ message in
            reportSuccess = true
            reported = true
            self.message = message
        }
    }
}

struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ReviewDetailsView(goWork:true,reviewId:1,reported:false,vmReview:ReviewViewModel(review:CustomData.review,reviewList:[]))
        }
    }
}

extension ReviewDetailsView{
    @ViewBuilder
    func menuConfirmationDialog(review:ReviewResponse)->some View{
        Button {
            view.move(type:.createReviewView(id: review.contentsID, image:review.contentsPosterPath.getImadImage(), workName: review.contentsTitle, gradeAvg: review.score,reviewId : review.reviewID, title: review.title,text:review.content,spoiler: review.spoiler,rating:review.score))
        } label: {
            Text("수정하기")
        }
        Button("삭제하기",role:.destructive){
            delete = true
        }
    }
    @ViewBuilder
    var reportedConfirmationDialog:some View{
        Button("신고하기") {
            if let report = vmReview.review?.reported,report{
                message = "이미 신고된 리뷰입니다."
                reportSuccess = true
                reported = true
            }else{
                sheetReport = true
            }
        }
    }
    @ViewBuilder
    var deleteConfirmationDialog:some View{
        Button("삭제",role:.destructive){
            vmReview.deleteReview(id: reviewId)
            view.back()
        }
        Button("취소",role:.cancel){}
    }
    func header(review:ReviewResponse)->some View{
        HStack{
            HeaderView(backIcon: "chevron.left", text: "리뷰"){view.back()}
            Spacer()
            Button {
                review.author ? menu.toggle():report.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
            }
            .confirmationDialog("",isPresented:$report,actions:{reportedConfirmationDialog}){
                Text("리뷰를 신고하시겠습니까?")
            }
            .confirmationDialog("",isPresented:$menu,actions:{menuConfirmationDialog(review:review)}){
                Text("리뷰 수정하거나 삭제하시겠습니까?")
            }
            .confirmationDialog("",isPresented:$delete,actions:{deleteConfirmationDialog}){
                Text("리뷰를 삭제하시겠습니까?")
            }
        }
        .padding(10)
        .background(Color.white)
    }
    func reviewInfoView(review:ReviewResponse)->some View{
        VStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        Button {
                            guard review.userNickname == user.cache?.nickname else {return sheetProfile = true}
                        } label: {
                            ProfileImageView(imagePath:review.userProfileImage,widthHeigt:40)
                        }
                        VStack(alignment: .leading){
                            Text(review.userNickname)
                                .font(.GmarketSansTTFMedium(13))
                                .fontWeight(.semibold)
                            Group{
                                if review.createdAt != review.modifiedAt{
                                    Text("수정됨").bold()
                                    Text(review.modifiedAt.relativeTime())
                                }else{
                                    Text(review.createdAt.relativeTime())
                                }
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                            .font(.subheadline)
                        }
                    }
                    Text(vmReview.review?.title ?? "")
                        .font(.GmarketSansTTFMedium(20))
                        .fontWeight(.semibold)
                        .padding(.top,5)
                }
                Spacer()
                ScoreView(score: review.score,color:.black,font:.subheadline,widthHeight:70)
            }
        }
        .padding(10)
    }
    func contentAndLikeView(review:ReviewResponse) -> some View{
        VStack(alignment: .leading){
            Text(review.content)
                .font(.subheadline)
                .padding(.bottom)
            if goWork{
                Button {
                    view.move(type:.workViewC(contentsId:review.contentsID))
                } label: {
                    HStack{
                        KFImageView(image: review.contentsPosterPath.getImadImage(),width: 30,height:40)
                        Text(review.contentsTitle)
                            .font(.GmarketSansTTFMedium(15))
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding(.trailing)
                    }
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius:5)
                }
            }
            likeStatusView(review: review)
        }
        .padding(.horizontal,10)
    }
    func likeStatusView(review:ReviewResponse) -> some View{
        HStack{
            Button {
                vmReview.like(review: review)
            } label: {
                HStack{
                    Image(systemName:"arrowshape.up.fill")
                        .foregroundColor(.white)
                    Text("추천")
                        .font(.GmarketSansTTFMedium(15))
                    Text("\(vmReview.review?.likeCnt ?? 0)")
                }
                .foregroundColor(.white)
                .frame(height:35)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.customIndigo.opacity(vmReview.review?.likeStatus == 1 ? 1 : 0.5))
                }
            }
            Spacer()
            Button {
                vmReview.disLike(review: review)
            } label: {
                HStack{
                    Image(systemName:"arrowshape.down.fill")
                        .foregroundColor(.white)
                    Text("비추천")
                        .font(.GmarketSansTTFMedium(15))
                    Text("\(vmReview.review?.dislikeCnt ?? 0)")
                }
                .foregroundColor(.white)
                .frame(height:35)
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.customIndigo.opacity(vmReview.review?.likeStatus == -1 ? 1 : 0.5))
                }
            }
        }
        .padding(.vertical)
    }
    var alert:Alert{
        if reportSuccess{
            let messages = message == "정상적으로 신고 접수가 완료되었습니다." ? Text("최대 24시간 이내로 검토가 진행될 예정입니다.") : nil
            let action = {
                if "정상적으로 신고 접수가 완료되었습니다." == message{ view.back() }
            }
            return Alert(title:Text(message),message:messages,dismissButton:.cancel(Text("확인"),action:action))
        }else{
            let confirm = Alert.Button.cancel(Text("확인하기")){
                reported = false
                vmReview.review?.reported = true
            }
            let out = Alert.Button.default(Text("나가기")){ view.back() }
            let message = Text("이 게시물은 \(user.cache?.nickname ?? "")님이 이미 신고한 게시물입니다. 계속하시겠습니까?")
            return Alert(title:Text("경고"),message:message,primaryButton:confirm,secondaryButton:out)
        }
    }
}
