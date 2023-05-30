//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    @State var text = ""
    let title:String
    @Binding var back:Bool
    var body: some View {
        VStack{
            header
            CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요 .. ", color: .gray, text: $text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.bottom,5)
            ScrollView{
                ForEach(MovieGenreFilter.allCases,id:\.self){ genre in
                    Section(header:genreHeader(name: genre.generName)){
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 0){
                                ForEach(CustomData.instance.reviewList.shuffled(),id:\.self){ item in
                                    Button {
                                        
                                    } label: {
                                        KFImage(URL(string: item.thumbnail)!)
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
        }.foregroundColor(.black)
            .background(Color.white)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(title: "내 작품", back: .constant(false))
    }
}
extension MovieListView{
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .bold()
                .padding(.leading)
                .padding(.top)
            Spacer()
        }
    }
    var header:some View{
        ZStack{
            HStack{
                Button {
                    back = false
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                        
                }
                Spacer()

            }
            Text(title)
                .bold()
        }
    }
}
