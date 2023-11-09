//
//  GenreSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/09.
//

import SwiftUI
import SwiftUIFlowLayout

struct GenreSelectView: View {
    let movieMode:Bool
    @State var movieCollection:[MovieGenreFilter] = []
    @State var tvCollection:[TVGenreFilter] = []
    
    @Binding var dismiss:Bool
    @EnvironmentObject var vmAuth:AuthViewModel
//    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("내 장르 수정").bold()
                    .padding([.leading,.top])
                Spacer()
                if movieMode{
                    FlowLayout(mode: .scrollable, items: movieCollection) { item in
                        Button {
                            movieCollection = movieCollection.filter({$0 != item})
                        } label: {
                            HStack{
                                Text(item.name)
                                Text(item.image)
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
                    Spacer()
                    FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases) { item in
                        Button {
                            if movieCollection.contains(item){
                                movieCollection = movieCollection.filter({$0 != item})
                            }else{
                                movieCollection.append(item)
                            }
                        } label: {
                            HStack{
                                Text(item.name)
                                Text(item.image)
                            }
                            .font(.caption)
                            .bold()
                            .padding(5)
                            .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                        }
                        
                    }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                }else{
                    
                    FlowLayout(mode: .scrollable, items: tvCollection) { item in
                        Button {
                            tvCollection = tvCollection.filter({$0 != item})
                        } label: {
                            HStack{
                                Text(item.name)
                                Text(item.image)
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
                    Spacer()
                    FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                        Button {
                            if tvCollection.contains(item){
                                tvCollection = tvCollection.filter({$0 != item})
                            }else{
                                tvCollection.append(item)
                            }
                            
                        } label: {
                            HStack{
                                Text(item.name)
                                Text(item.image)
                            }
                            .font(.caption)
                            .bold()
                            .padding(5)
                            .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                        }
                        
                    }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                }
               
                
                
                Button {
                    dismiss = false
                    if movieMode{
                        vmAuth.patchUser.movieGenre = movieCollection.map{$0.rawValue}
                    }else{
                        vmAuth.patchUser.tvGenre = tvCollection.map{$0.rawValue}
                    }
                    vmAuth.patchUserInfo()
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
           
        }.foregroundColor(.customIndigo)
    }
}

struct GenreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectView(movieMode: false,dismiss: .constant(false))
            .environmentObject(AuthViewModel(user: UserInfo(status: 1, message: "")))
    }
}
