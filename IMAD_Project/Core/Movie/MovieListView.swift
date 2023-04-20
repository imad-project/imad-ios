//
//  MovieListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    let title:String
    @Binding var back:Bool
    var body: some View {
        VStack{
            header
            ScrollView{
                ForEach(GenreFilter.allCases,id:\.self){ genre in
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
                .font(.title3)
                .bold()
                .padding(.leading)
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
                        .font(.title2)
                        .bold()
                        .padding()
                        
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .bold()
                        .padding()
                }

            }
            Text(title)
                .font(.title2)
                .bold()
        }
    }
}
