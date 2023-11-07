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
    let gradeAvg:Double
    let reviewId:Int?
    
    let maximumRating: Double = 5.0
    
    
    @State var title = ""
    @State var text = ""
    @State var spoiler = false
    @State var animation = false
    @State var animation1 = false
    @State var rating: Double = 0.0
    
    @State var error = false
    
    @StateObject var vm = ReviewViewModel(reviewList: [])
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    
    var body: some View {
        
        ZStack{
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false){
                
                VStack{
                    
                    ZStack(alignment: .top){
                        MovieBackgroundView(url: image,height: 2.7)
                        Text("이 작품 어떠셨나요?")
                            .bold()
                        HStack(alignment: .center){
                            KFImage(URL(string: image))
                                .resizable()
                                .frame(width: 200,height: 250)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                            if animation{
                                VStack{
                                    Text("현재 이 작품의 평점")
                                    Circle()
                                        .trim(from: 0.0, to: animation1 ? gradeAvg * 0.1 : 0)
                                        .stroke(lineWidth: 3)
                                        .rotation(Angle(degrees: 270))
                                        .frame(width: 80,height: 80)
                                        .overlay{
                                            VStack{
                                                Image(systemName: "star.fill")
                                                Text(String(format: "%0.1f", gradeAvg))
                                                    .font(.title2)
                                            }
                                        }
//                                    Text("\(vmAuth.getUserRes?.data?.nickname ?? "")님의 평점")
                                    Circle()
                                        .trim(from: 0.0, to: rating * 0.1)
                                        .stroke(lineWidth: 3)
                                        .rotation(Angle(degrees: 270))
                                        .frame(width: 80,height: 80)
                                        .overlay{
                                            VStack{
                                                Image(systemName: "star.fill")
                                                Text(String(format: "%0.1f", rating))
                                                    .font(.title2)
                                            }
                                        }
                                }
                                .padding(.leading,20)
                                
                            }
                            
                        }.padding(.top,70)
                        
                    }.padding(.top,20)
                    
                    if animation1{
                        Text("별점주기")
                            .padding(.top,40)
                            .bold()
                            .font(.title3)
                            .foregroundColor(.black)
                        sliderView
                            .padding(.bottom,10)
                        HStack(alignment: .bottom){
                            if spoiler{
                                Text("이 리뷰는 스포일러성 리뷰입니다.")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Label("스포일러", systemImage: "checkmark")
                                .foregroundColor(spoiler ? .customIndigo : .gray)
                            
                                .bold()
                                .onTapGesture {
                                    withAnimation {
                                        spoiler.toggle()
                                    }
                                }
                        }.padding(.horizontal,35).font(.subheadline)
                        CustomTextField(password: false, image: "pencil", placeholder: "제목..", color: .customIndigo, text: $title)
                            .padding(15)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth:2)
                                    .foregroundColor(.customIndigo)
                            }
                            .padding(.horizontal,30)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customIndigo, lineWidth: 2)
                                .frame(height: 360)
                                .overlay(
                                    TextEditor(text: $text)
                                        .background(Color.clear)
                                        .padding(8)
                                        .overlay(alignment: .topLeading){
                                            if text == ""{
                                                Text("리뷰를 작성해주세요..")
                                                    .allowsHitTesting(false)
                                                    .opacity(0.5)
                                                    .padding()
                                            }
                                        }
                                        .scrollContentBackground(.hidden)
                                        .foregroundColor(.black)
                                    
                                )
                                .padding()
                                .padding(.horizontal)
                        }
                    }
                    
                }
                
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    withAnimation(.easeIn(duration: 0.3)){
                        animation = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation(.easeIn(duration: 0.3)){
                        animation1 = true
                    }
                }
            }
            HStack{
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
                if text != "",title != "",rating > 0{
                    Button {
                        if let reviewId{
                            vm.updateReview(reviewId: reviewId, title: title, content: text, score: rating, spoiler: spoiler)
                        }else{
                            vm.writeReview(contentsId: id, title: title, content: text, score: rating, spoiler: spoiler)
                        }
                    } label: {
                        Text(reviewId != nil ? "수정" : "완료")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(5)
                            .background(Capsule().foregroundColor(.white))
                            .shadow(radius: 10)
                    }
                }
            }
            .frame(maxHeight: .infinity,alignment: .top)
            .padding()
        }
        .onReceive(vm.success){
            dismiss()
        }
        .foregroundColor(.white)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onReceive(vm.reviewWriteError){
            error = true
        }
        .alert(vm.error,isPresented: $error) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
    
}

struct WriteReviewView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewView(id: 1, image: CustomData.instance.movieList.first!, gradeAvg: 9.5, reviewId: nil)
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension WriteReviewView{
    var sliderView:some View{
        ZStack{
            HStack {
                ForEach(0..<Int(maximumRating), id: \.self) { star in
                    Image(systemName: "star.fill")
                        .font(.title3)
                        .foregroundColor(getStarColor(star: star, rating: rating/2))
                        .overlay {
                            Image(systemName: "star")
                                .font(.title3)
                                .foregroundColor(.customIndigo)
                        }
                }
                .frame(maxWidth: .infinity)
            }.frame(width: 200)
            Slider(value: $rating, in: 0...maximumRating*2, step: 0.1)
                .frame(width: 200)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // 범위 내에서 rating 값을 제한하는 코드
                            self.rating = min(max(Double(value.location.x / 200) * maximumRating*2, 0), maximumRating*2)
                        }
                )
                .accentColor(.clear)
                .opacity(0.1)
        }
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
        
        if star < integerPart {
            fillAmount = 1.0
        } else if star == integerPart {
            fillAmount = decimalPart
        } else {
            fillAmount = 0.0
        }
        
        return fillAmount
    }
}
