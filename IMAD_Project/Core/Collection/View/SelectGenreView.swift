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
    
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView(showsIndicators: false){
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section(header:guideView){
                            VStack(alignment: .leading){
                                movieGenreView
                                tvGenreView
                            } .padding(.top)
                             
                        }
                    }
                    
                }   .frame(height: UIScreen.main.bounds.height/1.5)
                CustomNextButton(action: {
                    withAnimation(.linear){
                        vm.selection = .profile
                    }
                }, color: .customIndigo.opacity(0.5))
                Spacer()
            }
        }
        .foregroundColor(.customIndigo)
        
    }
}

struct SelectGenreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenreView()
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}

extension SelectGenreView{
    var guideView:some View{
        HStack{
            Text("2. 관심있는 장르를 선택해 주세요")
                .bold()
            Spacer()
            Button {
                withAnimation(.linear){
                    vm.patchUser.movieGenre = []
                    vm.patchUser.tvGenre = []
                    vm.selection = .profile
                }
            } label: {
                Text("건너뛰기 > ")
                    .bold()
                    .font(.caption)
            }
        }.padding(.horizontal)
            .padding(.top,60)
            .padding(.vertical,20)
            .background(Color.white)
    }
    var movieGenreView:some View{
        VStack(alignment: .leading) {
            Text("영화")
                .padding(.leading)
                .bold()
            FlowLayout(mode: .scrollable, items: MovieGenreFilter.allCases){ item in
                Button {
                   movieAppend(item: item)
                } label: {
                    HStack{
                        Text(item.name)
                        Text(item.image)
                    }
                    .foregroundColor(!vm.patchUser.movieGenre.contains(item.rawValue) ? .customIndigo : .white)
                    .font(.caption2)
                    .bold()
                    .padding(5)
                    .padding(.horizontal)
                    .background{
                        if !vm.patchUser.movieGenre.contains(item.rawValue){
                            Capsule().stroke(lineWidth: 1)
                        }else{
                            Capsule()
                        }
                    }
                }
            }
            .foregroundColor(.customIndigo)
            .padding(.horizontal)
        }
    }
    var tvGenreView:some View{
        VStack(alignment: .leading) {
            Text("시리즈/TV")
                .padding(.leading)
                .bold()
                .padding(.top)
            FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                Button {
                    tvAppend(item: item)
                } label: {
                    HStack{
                        Text(item.name)
                        Text(item.image)
                    }
                    .foregroundColor(!vm.patchUser.tvGenre.contains(item.rawValue) ? .customIndigo : .white)
                    .font(.caption2)
                    .bold()
                    .padding(5)
                    .padding(.horizontal)
                    .background{
                        if !vm.patchUser.tvGenre.contains(item.rawValue){
                            Capsule().stroke(lineWidth: 1)
                        }else{
                            Capsule()
                        }
                    }
                }
            }
            .foregroundColor(.customIndigo)
            .padding(.horizontal)
        }
    }
    func movieAppend(item:MovieGenreFilter){
        guard !vm.patchUser.movieGenre.contains(item.rawValue) else { return vm.patchUser.movieGenre = vm.patchUser.movieGenre.filter({$0 != item.rawValue})}
        vm.patchUser.movieGenre.append(item.rawValue)
    }
    func tvAppend(item:TVGenreFilter){
        guard !vm.patchUser.tvGenre.contains(item.rawValue) else { return vm.patchUser.tvGenre = vm.patchUser.tvGenre.filter({$0 != item.rawValue})}
        vm.patchUser.tvGenre.append(item.rawValue)
    }
}
