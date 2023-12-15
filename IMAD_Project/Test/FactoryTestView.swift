//
//  FactoryTestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/15/23.
//

import SwiftUI



protocol genre{
    var genre:GenreType { get }
    func selectNamve() -> String
    func selectImage() -> String
}

class tvGen:genre{
    let genre: GenreType = .tv
    
    var tvgenre:TVGenreFilter
    required init(tvGenre:TVGenreFilter) {
        self.tvgenre = tvGenre
    }
    
    func selectNamve() -> String{
        return tvgenre.name
    }
    func selectImage() -> String{
        return tvgenre.image
    }
}
class movieGen:genre{
    func selectNamve() -> String {
        return ""
    }
    func selectImage() -> String{
        return ""
    }
    
    let genre: GenreType = .movie
    enum mvg:Int{
        case horror = 12
    }
}
class savegenre{
    func select(genre:GenreType,tvGenre:TVGenreFilter) -> genre{
        switch genre{
        case .tv:
            return tvGen(tvGenre:tvGenre)
        case .movie:
            return movieGen()
        }
    }
}


struct FactoryTestView: View {
    let instance = savegenre()
    @State var list:[genre] = []
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("asda"){
            list.append(instance.select(genre: .tv,tvGenre: .drama))
        }
        ForEach(0..<list.count,id: \.self){ item in
            Text("\(list[item].selectNamve())")
            Text("\(list[item].selectImage())")
        }
    }
}

#Preview {
    FactoryTestView()
}
