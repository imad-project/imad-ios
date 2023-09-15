//
//  WorkView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkView: View {
    
    let id:Int
    let type:String
    @State var anima = false
    @State var writeReview = false
    @State var writeCommunity = false
    @Environment(\.dismiss) var dismiss
    @StateObject var tab = CommunityTabViewModel()
    @StateObject var vm = WorkViewModel()
    
    var returnType:Bool{
        switch type{
        case "movie":
            return false
        case "tv":
            return true
        default:
            return true
        }
    }
    
    var body: some View {
            VStack{
                ZStack(alignment: .topLeading){
                    Color.white.ignoresSafeArea()
                ScrollView(showsIndicators: false){
                        VStack{
                            MovieBackgroundView(url: vm.workInfo?.posterPath?.getImadImage() ?? "", height: 3)
                            VStack(spacing:10){
                                Text(returnType ? vm.workInfo?.name ?? "" : vm.workInfo?.title ?? "")
                                    .padding(.top)
                                    .bold()
                                Text(returnType ? vm.workInfo?.originalName ?? "" : vm.workInfo?.originalTitle ?? "")
                                    .font(.subheadline)
                                
                                poster
                                
                                   
                            }
                            .padding(.bottom,30)
                            category
                            if tab.workTab == .work{
                                WorkInfoView(work: vm.workInfo ?? CustomData.instance.workInfo, type: type)
                                    .padding(.vertical).padding(.top,30)
                            }
                            else{
                                ReviewView(id:vm.workInfo?.contentsId ?? 0)
                                    .padding(.vertical,20)
                            }

                        }
                    Spacer()
                }
                collection
                    header
                }
                
            }
        
        .foregroundColor(.white)
        .onAppear {
            vm.getWorkInfo(id: id, type: type)
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
        .navigationDestination(isPresented: $writeReview) {
            WriteReviewView(id:vm.workInfo?.contentsId ?? 0, image: ("https://image.tmdb.org/t/p" + "/original" + (vm.workInfo?.posterPath ?? "")), gradeAvg: 4)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CommunityWriteView(image: ("https://image.tmdb.org/t/p" + "/original" + (vm.workInfo?.posterPath ?? "")))
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden()    
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(id: 1396, type: "tv")
    }
}


extension WorkView{
    var header: some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(10)
                    .font(.caption)
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 20)
                    .padding(.leading)
                    
            }
            Spacer()
            Button {
              
            } label: {
                Image(systemName: "star")
                    .foregroundColor(.black)
                    .padding(7.5)
                    .font(.caption)
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 20)
                    .padding(.trailing)
                    
            }
        }
    }
    var poster:some View{
        KFImage(URL(string: vm.workInfo?.posterPath?.getImadImage() ?? ""))
            .resizable()
            .placeholder{
                NoImageView()
            }
            .frame(width: 200,height: 300)
            .cornerRadius(20)
            .shadow(radius: 20)
            .overlay(alignment:.bottomTrailing) {
                Circle()
                    .trim(from: 0.0, to: anima ? 4 * 0.1 : 0)
                    .stroke(lineWidth: 3)
                    .rotation(Angle(degrees: 270))
                    .frame(width: 80,height: 80)
                    .overlay{
                        VStack{
                            Image(systemName: "star.fill")
                            Text(String(format: "%0.1f", 4))
                        }
                    }
                    .background(Circle().foregroundColor(.black.opacity(0.7)))
                    .shadow(radius: 20)
                    .offset(x: 20,y: 20)
                    
            }
    }
    var category:some View{
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing:0){
                ForEach(WorkFilter.allCases,id:\.self){ item in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            tab.workTab = item
                        }
                    } label: {
                        Text(item.name)
                            .font(.callout)
                            .bold()
                            .foregroundColor(tab.workTab == item ? .customIndigo : .gray)

                    }.frame(maxWidth: .infinity)
                }
            }
            .overlay(alignment: .leading){
                    Capsule()
                        .frame(width: geo.size.width/2,height: 3)
                        .offset(x:tab.indicatorReviewOffset(width: width)).padding(.top,45)

            }
            .background{
                Divider().padding(.top,45)
            }
        }
        .foregroundColor(.customIndigo)
    }
    var collection:some View{
        HStack(spacing:0){
            
            Button {
                writeReview = true
            } label: {
                Text("리뷰작성")
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background{
                        Color.white.ignoresSafeArea()
                        Color.customIndigo.opacity(0.5).ignoresSafeArea()
                    }
            }
            Button {
                writeCommunity = true
            } label: {
                Text("게시물 작성")
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(Color.customIndigo)
            }
        }.foregroundColor(.white)
            .bold()
            .frame(maxHeight: .infinity,alignment: .bottom)
    }
}
