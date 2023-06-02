//
//  WriteReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct WriteReviewView: View {
    
    let image:String
    let gradeAvg:Double
    let maximumRating: Double = 5.0
    
    @State var text = ""
    @State var animation = false
    @State var animation1 = false
    @State private var rating: Double = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        ZStack{
            Color.white.ignoresSafeArea()
            ScrollView(showsIndicators: false){
            
            VStack{
                
                ZStack(alignment: .top){
                    ZStack{
                        KFImage(URL(string:image)!)
                            .resizable()
                            .frame(height: 1000)
                            .frame(maxWidth: .infinity)
                        Color.black.opacity(0.2)
                        Color.clear
                            .background(Material.thin)
                            .environment(\.colorScheme, .dark)
                    }.frame(height: 300)
                        .offset(y:-300)
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
                                
                                Text("현제 이 작품의 평점")
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
                                Text("콰랑님의 평점")
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
                    HStack{
                        Spacer()
                        Label("스포일러", systemImage: "checkmark")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }.padding(.horizontal,35)
                    
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
                if text != ""{
                    Button {
                      
                    } label: {
                        Text("완료")
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
        
        .foregroundColor(.white)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        
    }
    
}

struct WriteReviewView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewView(image: CustomData.instance.movieList.first!, gradeAvg: 9.5)
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
