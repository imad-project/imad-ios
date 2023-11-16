//
//  GenreSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/09.
//

import SwiftUI
import SwiftUIFlowLayout

struct MovieGenreSelectView: View {
    
    @State var movieCollection:[MovieGenreFilter] = []
    @Binding var dismiss:Bool
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                Text("내 장르 수정").bold()
                    .padding([.leading,.top])
                Spacer()
                FlowLayout(mode: .vstack, items: movieCollection) { item in
                    Button {
                        withAnimation {
                            movieCollection = movieCollection.filter({$0 != item})
                        }
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
                
                Divider()
                    .padding(.vertical)
                FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases) { item in
                    Button {
                        withAnimation {
                            if movieCollection.contains(item){
                                movieCollection = movieCollection.filter({$0 != item})
                            }else{
                                movieCollection.append(item)
                            }
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
                
                
                
                Button {
                    vmAuth.patchUser.movieGenre = movieCollection.map{$0.rawValue}
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
            if let movies = vmAuth.user?.data?.movieGenre{
                for movie in movies {
                    if let m = MovieGenreFilter(rawValue: movie){
                        self.movieCollection.append(m)
                    }
                }
            }
        }
        .foregroundColor(.customIndigo)
    }
}

struct MovieGenreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGenreSelectView(dismiss: .constant(false))
            .environmentObject(AuthViewModel(user: UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
