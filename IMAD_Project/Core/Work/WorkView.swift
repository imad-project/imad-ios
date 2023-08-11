//
//  WorkView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkView: View {
    
    let work:WorkResults
    @State var anima = false
    @State var writeReview = false
    @State var writeCommunity = false
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CommunityTabViewModel()
    
    var body: some View {
            VStack{
                ZStack(alignment: .topLeading){
                    Color.white.ignoresSafeArea()
                ScrollView(showsIndicators: false){
                        VStack(spacing:10){
                            Text(work.title ?? "")
                                .padding(.top)
                                .bold()
                            Text("(2023)").bold()
                                .font(.caption)
                            KFImage(URL(string: "https://image.tmdb.org/t/p" + "/original" + (work.posterPath ?? ""))!)
                                .resizable()
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
                            Section(header:category) {
                                TabView(selection: $vm.workTab) {
                                    WorkInfoView(work: work)
                                        .tag(WorkFilter.work)
                                    ReviewView(work: work)
                                        .tag(WorkFilter.review)
                                }.frame(height: 800)
                            }
                            .padding(.top,30)

                        }.background{
                            ZStack{
                                KFImage(URL(string: "https://image.tmdb.org/t/p" + "/original" + (work.posterPath ?? ""))!)
                                    .resizable()
                                    .frame(height: 1000)
//                                    .frame(maxWidth: .infinity)
                                Color.black.opacity(0.2)
                                Color.clear
                                    .background(Material.thin)
                                    .environment(\.colorScheme, .dark)
                            }.frame(height: 300)
                                .offset(y:-850)
                        }
                       
                    
                }
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
            }
        
        .foregroundColor(.white)
        .onAppear {
            withAnimation(.linear(duration: 0.5)){
                anima = true
            }
        }
        .navigationDestination(isPresented: $writeReview) {
            WriteReviewView(image: ("https://image.tmdb.org/t/p" + "/original" + (work.posterPath ?? "")), gradeAvg: 4)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $writeCommunity) {
            CommunityWriteView(image: ("https://image.tmdb.org/t/p" + "/original" + (work.posterPath ?? "")))
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden()    
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(work: CustomData.instance.workList.first!)
    }
}


extension WorkView{
    var category:some View{
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing:0){
                ForEach(WorkFilter.allCases,id:\.self){ item in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)){
                            vm.workTab = item
                        }
                    } label: {
                        Text(item.name)
                            .font(.callout)
                            .bold()
                            .foregroundColor(vm.workTab == item ? .customIndigo : .gray)
                            
                    }.frame(maxWidth: .infinity)
                }
            }
            .overlay(alignment: .leading){
                    Capsule()
                        .frame(width: geo.size.width/2,height: 3)
                        .offset(x:vm.indicatorReviewOffset(width: width)).padding(.top,45)
                
            }
            .background{
                Divider().padding(.top,45)
            }
        }
        .foregroundColor(.customIndigo)
    }
}
