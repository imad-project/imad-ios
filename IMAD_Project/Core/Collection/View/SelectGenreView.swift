//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI
import SwiftUIFlowLayout

struct SelectGenreView: View {
    
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
                                guard !(vm.profileInfo.movieGenre ?? []).contains(item.rawValue) else { return vm.profileInfo.movieGenre = (vm.profileInfo.movieGenre ?? []).filter{$0 != item.rawValue}}
                                vm.profileInfo.movieGenre?.append(item.rawValue)
                            } label: {
                                HStack{
                                    Text(item.name)
                                    Text(item.image)
                                }
                                .foregroundColor(!(vm.profileInfo.movieGenre ?? []).contains(item.rawValue) ? .customIndigo : .white)
                                .font(.subheadline)
                                .bold()
                                .padding(8)
                                .padding(.horizontal)
                                .background{
                                    if !(vm.profileInfo.movieGenre ?? []).contains(item.rawValue){
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
                                guard !(vm.profileInfo.tvGenre ?? []).contains(item.rawValue) else { return vm.profileInfo.tvGenre = vm.profileInfo.tvGenre?.filter{$0 != item.rawValue}}
                                vm.profileInfo.tvGenre?.append(item.rawValue)
                            } label: {
                                HStack{
                                    Text(item.name)
                                    Text(item.image)
                                }
                                .foregroundColor(!(vm.profileInfo.tvGenre ?? []).contains(item.rawValue) ? .customIndigo : .white)
                                .font(.subheadline)
                                .bold()
                                .padding(8)
                                .padding(.horizontal)
                                .background{
                                    if !(vm.profileInfo.tvGenre ?? []).contains(item.rawValue){
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
        //SelectGenreView(preveous: .constant(true))
        SelectGenreView()
            .environmentObject(AuthViewModel())
//            .background(Color.customIndigo)
    }
}
