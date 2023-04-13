//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct SelectGenreView: View {
    //@Binding var preveous:Bool
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        ZStack{
            BackgroundView(height: 0.83, height1: 0.9)
            VStack(alignment: .leading){
                Text("2. 관심있는 장르를 선택해 주세요")
                    .bold()
                    .padding(.vertical,50)
                    .padding(.leading)
                LazyVGrid(columns: columns) {
                    ForEach(GenerFilter.allCases,id: \.self){ item in
                        VStack{
                            Image(item.rawValue)
                                .resizable()
                                .frame(width:100,height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 20)
                            Text(item.generName)
                                .font(.caption)
                                .bold()
                        }.padding(.bottom,15)
                        
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
