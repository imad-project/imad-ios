//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 12/15/23.
//

import SwiftUI


struct UpdateGenreView: View {
    let genreType:GenreType
    @State var collection:[Genre] = []
    @Binding var dismiss:Bool
    @StateObject var vmAuth = AuthViewModel(user:nil)
    @StateObject var user = UserInfoManager.instance
    
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
                    .font(.GmarketSansTTFMedium(25))
                    .padding(.leading)
                Spacer()
                AutoSizingFlowLayoutView(items: collection) { genre in
                    Button {
                        withAnimation {
                            collection = collection.filter{$0.selectCode != genre.selectCode}
                        }
                    } label: {
                        HStack{
                            Text(genre.selectImage)
                            Text(genre.selectName)
                        }
                        .font(.GmarketSansTTFMedium(12))
                        .padding(7.5)
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
                AutoSizingFlowLayoutView(items: genreList) { genre in
                    Button {
                        withAnimation {
                            if (collection.first(where: {$0.selectCode == genre.selectCode}) != nil){
                                collection = collection.filter({$0.selectCode != genre.selectCode})
                            }else{
                                collection.append(genre)
                            }
                        }
                    } label: {
                        HStack{
                            Text(genre.selectImage)
                            Text(genre.selectName)
                            
                        }
                        .font(.GmarketSansTTFMedium(12))
                        .padding(7.5)
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                    }
                    
                }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                
                
                CustomConfirmButton(text: "완료", color: .customIndigo, textColor: .white) {
                    switch genreType {
                    case .tv:
                        vmAuth.patchUser.tvGenre = collection.map({$0.selectCode})
                    case .movie:
                        vmAuth.patchUser.movieGenre = collection.map({$0.selectCode})
                    }
                    vmAuth.patchUserInfo()
                    dismiss = false
                }
                .padding()
            }
        }
        .onAppear{
            switch genreType {
            case .tv:
                for genre in user.cache?.tvGenre ?? []{
                    if let tvGenre = TVGenreFilter(rawValue: genre){
                        collection.append(TVGenre(tvGenre: tvGenre))
                    }
                }
            case .movie:
                for genre in user.cache?.movieGenre ?? []{
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
    UpdateGenreView(genreType: .tv, dismiss: .constant(false))
       
}
