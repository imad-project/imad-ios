//
//  SelectGenreView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI


struct SelectGenreView: View {
    
    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section(header:guideView){
                        VStack(alignment: .leading){
                            movieGenreView
                            tvGenreView
                        } 
                        .padding(.top)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height/1.5)
            CustomConfirmButton(text: "다음", color: .customIndigo.opacity(0.5),textColor:.white) {
                withAnimation(.linear){ vm.selection = .profile }
            }
            .padding(.horizontal)
            .padding(.top,30)
            Spacer()
        }
        .foregroundColor(.customIndigo)
        .ignoresSafeArea()
    }
}

struct SelectGenreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenreView()
            .environmentObject(AuthViewModel(user: CustomData.user))
    }
}

extension SelectGenreView{
    var guideView:some View{
        HStack{
            Text("관심있는 장르를 선택해 주세요")
                .font(.GmarketSansTTFMedium(20))
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
                    .font(.GmarketSansTTFMedium(12))
            }
        }
        .padding(.horizontal)
            .padding(.top,100)
            .padding(.vertical,20)
            .background(Color.white)
    }
    var movieGenreView:some View{
        VStack(alignment: .leading) {
            Text("영화")
                .font(.GmarketSansTTFMedium(15))
                .padding(.leading)
            AutoSizingFlowLayoutView(items: MovieGenreFilter.allCases){ item in
                Button {
                    movieAppend(item: item)
                } label: {
                    HStack{
                        Text(item.name)
                        Text(item.image)
                    }
                    .foregroundColor(!vm.patchUser.movieGenre.contains(item.rawValue) ? .customIndigo : .white)
                    .font(.GmarketSansTTFMedium(10))
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
                .font(.GmarketSansTTFMedium(15))
                .padding(.top)
            AutoSizingFlowLayoutView(items: TVGenreFilter.allCases) { item in
                Button {
                    tvAppend(item: item)
                } label: {
                    HStack{
                        Text(item.name)
                        Text(item.image)
                    }
                    .foregroundColor(!vm.patchUser.tvGenre.contains(item.rawValue) ? .customIndigo : .white)
                    .font(.GmarketSansTTFMedium(10))
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
