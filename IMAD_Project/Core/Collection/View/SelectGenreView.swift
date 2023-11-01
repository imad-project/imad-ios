//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import SwiftUIFlowLayout

struct SelectGenreView: View {
    
    @State var movieList:[Int] = []
    @State var tvList:[Int] = []
    
    @EnvironmentObject var vm:AuthViewModel
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("2. 관심있는 장르를 선택해 주세요")
                    .bold()
                    .padding(.top,30)
                    .padding(.vertical,30)
                    .padding(.leading)
                HStack{
                    Spacer()
                    Button {
                        vm.selection = .profile
                        vm.profileInfo.movieGenre = nil
                        vm.profileInfo.tvGenre = nil
                    } label: {
                        Text("건너뛰기 > ")
                            .bold()
                            .font(.caption)
                    }
                }.padding(.trailing)
               
                    
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("영화")
                            .padding(.leading)
                            .bold()
                        FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases){ item in
                            Button {
                                guard !movieList.contains(item.rawValue) else { return movieList = movieList.filter({$0 != item.rawValue})}
                                movieList.append(item.rawValue)
                                vm.profileInfo.movieGenre = movieList
                            } label: {
                                HStack{
                                    Text(item.name)
                                    Text(item.image)
                                }
                                .foregroundColor(!movieList.contains(item.rawValue) ? .customIndigo : .white)
                                .font(.subheadline)
                                .bold()
                                .padding(8)
                                .padding(.horizontal)
                                .background{
                                    if !movieList.contains(item.rawValue){
                                        Capsule().stroke(lineWidth: 1)
                                    }else{
                                        Capsule()
                                    }
                                }
                            }
                        }
                        .foregroundColor(.customIndigo)
                        .padding(.horizontal)
                        
                        Text("시리즈/TV")
                            .padding(.leading)
                            .bold()
                            .padding(.top)
                        FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                            Button {
                                guard !tvList.contains(item.rawValue) else { return tvList = tvList.filter({$0 != item.rawValue})}
                                tvList.append(item.rawValue)
                                vm.profileInfo.tvGenre = tvList
                            } label: {
                                HStack{
                                    Text(item.name)
                                    Text(item.image)
                                }
                                .foregroundColor(!tvList.contains(item.rawValue) ? .customIndigo : .white)
                                .font(.subheadline)
                                .bold()
                                .padding(8)
                                .padding(.horizontal)
                                .background{
                                    if !tvList.contains(item.rawValue){
                                        Capsule().stroke(lineWidth: 1)
                                    }else{
                                        Capsule()
                                    }
                                }
                            }
                        }
                        .foregroundColor(.customIndigo)
                        .padding(.horizontal)
                        Button {
                            withAnimation(.linear){
                                vm.selection = .profile
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 60)
                                .foregroundColor(.customIndigo.opacity(0.5))
                                .overlay {
                                    Text("다음")
                                        .bold()
                                        .foregroundColor(.white)
                                        .shadow(radius: 20)
                                }
                        }.padding(.horizontal)
                            .padding(.vertical,50)

                    }
                }
                
            }
        }.foregroundColor(.customIndigo)
    }
}

struct SelectGenreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenreView()
            .environmentObject(AuthViewModel())
    }
}
