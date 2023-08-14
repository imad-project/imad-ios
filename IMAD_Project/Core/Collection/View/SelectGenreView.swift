//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import SwiftUIFlowLayout

struct SelectGenreView: View {
    //@Binding var preveous:Bool
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        ZStack{
            BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
           
            VStack(alignment: .leading){
                Text("2. 관심있는 장르를 선택해 주세요")
                    .bold()
                    .padding(.vertical,50)
                    .padding(.top,30)
                    .padding(.leading)
                
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("영화")
                            .padding(.leading)
                            .bold()
                        FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases) { item in
                            HStack{
                                Text(item.name)
                                Text(item.image)
                            }
                            .font(.subheadline)
                            .bold()
                            .padding(8)
                            .padding(.horizontal)
                            .background(Capsule()
                            .stroke(lineWidth: 1))
                            
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        
                        Text("시리즈/TV")
                            .padding(.leading)
                            .bold()
                            .padding(.top)
                        FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                            HStack{
                                Text(item.name)
                                Text(item.image)
                            }
                            .font(.subheadline)
                            .bold()
                            .padding(8)
                            .padding(.horizontal)
                            .background(Capsule()
                            .stroke(lineWidth: 1))
                            
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    }
                }
                
            }
        }.foregroundColor(.white)
    }
}

struct SelectGenreView_Previews: PreviewProvider {
    static var previews: some View {
        //SelectGenreView(preveous: .constant(true))
        SelectGenreView()
    }
}
