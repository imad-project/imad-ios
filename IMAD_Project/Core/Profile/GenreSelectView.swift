//
//  GenreSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/15/23.
//

import SwiftUI
import SwiftUIFlowLayout

enum GenreType{
    case tv,movie
}
protocol Genre{
    var genreType:GenreType { get }
    func selectName() -> String
    func selectImage() -> String
    func selectCode() -> Int
}
class TVGenre:Genre{
    var genreType: GenreType = .tv
    var tvGenre:TVGenreFilter
    required init(tvGenre:TVGenreFilter) {
        self.tvGenre = tvGenre
    }
    func selectName() -> String {
        return tvGenre.name
    }
    func selectImage() -> String {
        return tvGenre.image
    }
    func selectCode() -> Int {
        return tvGenre.rawValue
    }
}
class MovieGenre:Genre{
    var genreType: GenreType = .movie
    var movieGenre:MovieGenreFilter
    required init(movieGenre:MovieGenreFilter) {
        self.movieGenre = movieGenre
    }
    func selectName() -> String {
        return movieGenre.name
    }
    func selectImage() -> String {
        return movieGenre.image
    }
    func selectCode() -> Int {
        return movieGenre.rawValue
    }
}

struct GenreSelectView: View {
    let genreType:GenreType
    @State var collection:[Genre] = []
    @Binding var dismiss:Bool
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var genreList:[Genre]{
        switch genreType {
        case .tv:
            var tvGenres:[Genre] = []
            for genre in TVGenreFilter.allCases {
                tvGenres.append(TVGenre(tvGenre: genre))
            }
            return tvGenres
        case .movie:
            var movieGenres:[Genre] = []
            for genre in MovieGenreFilter.allCases {
                movieGenres.append(MovieGenre(movieGenre: genre))
            }
            return movieGenres
        }
    }
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                Text("내 장르 수정").bold()
                    .padding([.leading,.top])
                Spacer()
                FlowLayout(mode: .vstack, items: collection) { genre in
                    Button {
                        withAnimation {
                            collection = collection.filter{$0.selectCode() != genre.selectCode()}
                        }
                    } label: {
                        HStack{
                            Text(genre.selectImage())
                            Text(genre.selectName())
                        }
                        .font(.caption)
                        .bold()
                        .padding(5)
                        .padding(.trailing)
                        .overlay(alignment:.trailing) {
                            Image(systemName: "xmark").font(.caption)
                        }
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1))
                        .foregroundColor(.customIndigo)
                    }
                }
                .padding()
                
                Divider()
                    .padding(.vertical)
                FlowLayout(mode: .scrollable, items: genreList) { genre in
                    Button {
                        withAnimation {
                            if (collection.first(where: {$0.selectCode() == genre.selectCode()}) != nil){
                                collection = collection.filter({$0.selectCode() != genre.selectCode()})
                            }else{
                                collection.append(genre)
                            }
                        }
                    } label: {
                        HStack{
                            Text(genre.selectName())
                            Text(genre.selectImage())
                        }
                        .font(.caption)
                        .bold()
                        .padding(5)
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                    }
                    
                }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                
                
                
                Button {
                    switch genreType {
                    case .tv:
                        vmAuth.patchUser.tvGenre = collection.map({$0.selectCode()})
                    case .movie:
                        vmAuth.patchUser.movieGenre = collection.map({$0.selectCode()})
                    }
                    vmAuth.patchUserInfo()
                    dismiss = false
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }
                .padding()
            }
        }
        .onAppear{
            guard let data = vmAuth.user?.data else {return}
            switch genreType {
            case .tv:
                for genre in data.tvGenre {
                    if let tvGenre = TVGenreFilter(rawValue: genre){
                        collection.append(TVGenre(tvGenre: tvGenre))
                    }
                }
            case .movie:
                for genre in data.movieGenre {
                    if let movieGenre = MovieGenreFilter(rawValue: genre) {
                        collection.append(MovieGenre(movieGenre: movieGenre))
                    }
                }
            }
        }
        .foregroundColor(.customIndigo)
    }
}

#Preview {
    GenreSelectView(genreType: .tv, dismiss: .constant(false))
        .environmentObject(AuthViewModel(user: UserInfo(status: 1,data: CustomData.instance.user, message: "")))
}
