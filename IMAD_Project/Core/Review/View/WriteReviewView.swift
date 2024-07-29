//
//  WriteReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct WriteReviewView: View {
    
    let id:Int
    let image:String
    let workName:String
    let gradeAvg:Double
    let reviewId:Int?   //리뷰ID가 있을 경우 수정모드
    
    let maximumRating: Double = 5.0
    
    @State var title = ""
    @State var text = ""
    @State var spoiler = false
    @State var rating: Double = 0.0
    @State var animation = false
    @State var animation1 = true
    @State var error = false
    
    @StateObject var vm = ReviewViewModel(review:nil,reviewList: [])
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    
    var body: some View {
        
        ZStack{
            Color.gray.opacity(0.1)
            ScrollView(showsIndicators: false){
                VStack(spacing:0){
                    header
                    workView
                    Divider()
                    sliderView
                    titleView
                    writeView
                }
                
            }
        }
        .onAppear{
            DispatchQueue.main.async{
                withAnimation(.easeInOut(duration: 1.0)){
                    animation = true
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                withAnimation(.easeInOut(duration: 1.0)){
                    animation = false
                }
            }
            DispatchQueue.main.async{
                withAnimation(.easeInOut(duration: 1.5)){
                    animation1 = false
                }
            }
        }
        .onReceive(vm.success){
            dismiss()
        }
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .foregroundColor(.white).ignoresSafeArea(edges:.bottom)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct WriteReviewView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewView(id: 1, image: CustomData.instance.movieList.first!, workName: "카지노", gradeAvg: 9.5, reviewId: nil,vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}


extension WriteReviewView{
    var header:some View{
        HStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                Text("리뷰쓰기")
                    .font(.GmarketSansTTFMedium(20))
                Spacer()
            }
            Button {
                if let reviewId{
                    vm.updateReview(reviewId: reviewId, title: title, content: text, score: rating, spoiler: spoiler)
                }else{
                    vm.writeReview(contentsId: id, title: title, content: text, score: rating, spoiler: spoiler)
                }
            } label: {
                Text(reviewId != nil ? "수정" : "등록")
                    .font(.GmarketSansTTFMedium(15))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(5)
                    .background(Capsule().foregroundColor(.customIndigo.opacity(text != "" && title != "" && rating > 0 ? 1 : 0.5)))
                    
            }
        }
        .foregroundColor(.black)
        .padding(10)
        .background(Color.white)
    }
    var sliderView:some View{
        HStack{
            VStack(alignment: .leading,spacing: 5){
                    Text("별점주기")
                        .font(.GmarketSansTTFMedium(15))
                    HStack(spacing:5){
                        ForEach(0..<Int(maximumRating), id: \.self) { star in
                            Image(systemName: "star.fill")
                                .foregroundColor(getStarColor(star: star, rating: rating/2))
                                .overlay {
                                    Image(systemName: "star")
                                        .foregroundColor(.customIndigo)
                                }
                                .font(.GmarketSansTTFMedium(15))
                        }
                    }
                    .frame(width:120)
                    .overlay(alignment: .trailing){
                        if animation{
                            HStack{
                                Image(systemName:"hand.draw.fill")
                                    .foregroundColor(.customIndigo)
                                    .offset(y:15)
                                    .font(.largeTitle)
                                Spacer().frame(width:animation1 ? nil:0)
                            }
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                // 범위 내에서 rating 값을 제한하는 코드
                                self.rating = min(max(Double(value.location.x / 120) * maximumRating * 2, 0), maximumRating*2)
                            }
                    )
                }
            Spacer()
            VStack(spacing:5){
                ScoreView(score: rating, color: .customIndigo,font:.caption,widthHeight:40)
                Text("내 평점")
                    .font(.GmarketSansTTFMedium(10))
            }
            VStack(spacing:5){
                ScoreView(score: gradeAvg, color: .customIndigo,font:.caption,widthHeight:40)
                Text("전체 평점")
                    .font(.GmarketSansTTFMedium(10))
            }
           
        }
        .padding(10)
        .foregroundColor(.customIndigo)
        .background(Color.white)
            
    }
    func getStarColor(star: Int, rating: Double) -> Color {
        let fillAmount = getFillAmount(star: star, rating: rating)
        let color: Color = fillAmount > 0.0 ? .customIndigo : .white
        return color.opacity(fillAmount)
    }
    
    func getFillAmount(star: Int, rating: Double) -> Double {
        let fillAmount: Double
        let integerPart = Int(rating)
        let decimalPart = rating - Double(integerPart)
        print("integerPart\(integerPart)")
        print("decimalPart\(decimalPart)")
        if star < integerPart {
            fillAmount = 1.0
        } else if star == integerPart {
            fillAmount = decimalPart
        } else {
            fillAmount = 0.0
        }
        return fillAmount
    }
    var workView:some View{
        HStack{
            KFImageView(image: image, width: 30, height: 30)
                .cornerRadius(10)
            Text(workName).foregroundColor(.black)
            Spacer()
            spoilerView
        }
        .foregroundColor(.customIndigo)
        .padding(10)
        .background(Color.white)
    }
    var titleView:some View{
        HStack{
            CustomTextField(password: false, image: "", placeholder: "제목..", color: .customIndigo.opacity(0.5),textLimit: 15, text: $title)
            Text("\(title.count)/25")
                .foregroundStyle(.black)
                .font(.subheadline)
        }
        .padding(.leading,5)
        .padding([.trailing,.vertical],10)
        .background(Color.white)
    }
    var saveView:some View{
        HStack{
            CustomConfirmButton(text: "취소", color: .gray.opacity(0.2), textColor: .black) {
                dismiss()
            }
            .padding([.leading,.vertical],10)
            CustomConfirmButton(text:reviewId != nil ? "수정" : "등록", color: .customIndigo.opacity(text != "" && title != "" && rating > 0 ? 1 : 0.5), textColor: .white) {
                if let reviewId{
                    vm.updateReview(reviewId: reviewId, title: title, content: text, score: rating, spoiler: spoiler)
                }else{
                    vm.writeReview(contentsId: id, title: title, content: text, score: rating, spoiler: spoiler)
                }
            }
            .padding([.trailing,.vertical],10)
        }
    }
    var writeView:some View{
        VStack{
            CustomTextEditor(placeholder: "내용을 입력해주세요..", color: .customIndigo, textLimit: 2500, text: $text)
            saveView
        }
        .background(Color.white)
        .padding(.top,10)
    }
    var spoilerView:some View{
        VStack{
            HStack(alignment: .bottom){
                Spacer()
                Label("스포일러", systemImage: "checkmark.circle")
                    .foregroundColor(spoiler ? .customIndigo : .gray)
                    .font(.caption)
                    .onTapGesture {
                        withAnimation {
                            spoiler.toggle()
                        }
                    }
            }
        }
    }
}
