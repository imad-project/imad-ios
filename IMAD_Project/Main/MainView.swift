//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    
    @Binding var filterSelect:Bool 
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing:0){
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section(header: header) {
                            filer
                            thumnail
                            movieList
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .background{
            LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(filterSelect: .constant(false))
    }
}

extension MainView{
    var header:some View{
        HStack{
            Text("리뷰")
                .font(.title)
                .bold()
                .padding(.leading)
                
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
                .padding(.trailing)
        }
        .padding(.vertical)
        .padding(.top,30)
        .background(Color.black.opacity(0.5))
    }
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.leading)
            Spacer()
        }
    }
    var thumnail:some View{
        VStack{
            HStack{
                Text("벤자민 버튼의 시간은 거꾸로 간다")
                Text("(2008)")
                    .font(.caption)
                Spacer()
            }
            .bold()
            .padding(.leading)
            HStack{
                KFImage(URL(string: CustomData.instance.moviePoster)!)
                    .resizable()
                    .frame(width: 250,height: 250)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Circle()
                            .stroke(style: .init(lineWidth: 2))
                            .shadow(radius: 20)
                            .frame(width: 80,height: 80)
                            .overlay {
                                HStack(spacing:5){
                                    Image(systemName: "star.fill")
                                        .font(.caption)
                                    Text("9.3")
                                        .bold()
                                }
                            }
                            
                        Spacer()
                    }
                    .padding(.bottom,30)
                    HStack{
                        Text("감독 ").bold()
                        Text("데이비드 핀처")
                            
                            
                    }.font(.caption)
                    Text("1918년 제1차 세계 대전 말 뉴올리언즈. 80세의 외모를 가진 사내 아이가 태어난다. 그의 이름은 벤자민 버튼. 생김새때문에 양로원에 버려져 노인들과 함께 지내던 그는 시간이 지날수록 젊어진다는 것을 알게 된다. 12살이 되며 60대의 외모를 가지게 된 어느 날, 5살 소녀 데이지를 만난 후 그녀의 푸른 눈동자를 잊지 못하게 된다. 점차 중년이 되어 세상으로 나간 벤자민은 숙녀가 된 데이지와 만나 만남과 헤어짐을 반복하다 비로소 둘은 사랑에 빠지게 된다. 하지만 벤자민은 날마다 젊어지고 데이지는 점점 늙어가는데…")
                        .font(.caption)
                        .frame(height: 70)
                }.padding(3)
            }.padding(.leading)
        }
    }
    var filer:some View{
        ScrollView(.horizontal){
            HStack{
                Group{
                    Text("시리즈")
                    Text("영화")
                    
                }
                .padding(.horizontal)
                .padding(5)
                .overlay {
                    Capsule()
                        .stroke(style: .init(lineWidth: 1.0))
                }
                Spacer()
                Button {
                    withAnimation(.easeIn(duration: 0.05)){
                        filterSelect.toggle()
                    }
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3)
                        .padding(.trailing)
                }
                    
            }.padding(.leading)
        }
    }
    var movieList:some View{
        ForEach(GenerFilter.allCases,id:\.self){ item in
            Section(header:genreHeader(name: item.generName)){
                ScrollView(.horizontal){
                    HStack(spacing: 0){
                    ForEach(0...10,id:\.self){ item in
                            KFImage(URL(string: CustomData.instance.movieList.first!)!)
                                .resizable()
                                .frame(width: 150,height: 200)
                                .cornerRadius(15)
                                .padding(.leading)
                        }
                       
                    }
                }
            }
            
        }
    }
    
}
