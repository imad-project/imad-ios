//
//  SwiftUIView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/31.
//

import SwiftUI
import Kingfisher

struct ExploreView: View {
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                Section(header:header){
                    ScrollView{
                        LazyVGrid(columns: columns,spacing: 0) {
                            ForEach(CustomData.instance.reviewList.shuffled(),id:\.self){ item in
                                VStack(spacing: 0){
                                    KFImage(URL(string: item.thumbnail))
                                        .resizable()
                                        .frame(height: 250)
                                        .cornerRadius(10)
                                        .padding(7.5)
                                    Text(item.title)
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
//                            }.padding(.top,10)
                        }
                    }
                    HStack{
                        Button {
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(lineWidth: 1)
                                .frame(height: 30)
                                .foregroundColor(.customIndigo)
                                .overlay {
                                    Label("필터", systemImage: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                        }
                        Button {
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .frame(height: 30)
                                .foregroundColor(.customIndigo)
                                .overlay {
                                    Label("정렬", systemImage: "arrow.up.arrow.down")
                                }
                        }
                    }.font(.caption).padding(.horizontal).padding(.top).background(Color.white)
                }
            } .padding(.bottom,100).background(Color.white).ignoresSafeArea()
        }.foregroundColor(.black)
           
       
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

extension ExploreView{
    var header:some View{
        VStack(spacing: 5){
            HStack{
                Text("작품 찾기")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                    
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .padding(.trailing)
                
            }
            HStack{
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 60,height: 25)
                    .padding(.vertical,5)
                    .overlay {
                        Text("영화")
                    }
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 60,height: 25)
                    .padding(.vertical,5)
                    .overlay {
                        Text("시리즈")
                    }
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 80,height: 25)
                    .padding(.vertical,5)
                    .overlay {
                        Text("애니메이션")
                    }
                Spacer()
            }.padding(.leading).font(.caption)
            Divider().padding(.horizontal)
            HStack{
                Text("⭐ 평점순").bold()
                Spacer()
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        Label("한국", systemImage: "checkmark")
                        Label("평점 9.0 이상", systemImage: "checkmark")
                        Label("공포", systemImage: "checkmark")
                    }.foregroundColor(.black)
                }
                .frame(height: 10)
            }.font(.subheadline).padding(.vertical,5).padding(.horizontal)
//            Divider().padding(.horizontal)
        }
        
        .foregroundColor(.customIndigo)
        .padding(.vertical)
        .padding(.top,30)
        .background{
            Color.white
        }
       
        
    }
}
