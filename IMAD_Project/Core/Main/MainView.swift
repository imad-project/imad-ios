//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher



struct MainView: View {
    
    @State private var rotationAngle: Angle = .zero
    @State var movieIndex = 0
    @State var poster:WorkInfo = CustomData.instance.workInfo
    @State var isReview = false
    @State var select = 0
    @State var anima = false
    @Binding var search:Bool
    @Binding var filterSelect:Bool
    
    var body: some View {
        ZStack{
            Color.white
            ScrollView(showsIndicators: false){
                VStack(spacing:10){
                    VStack(spacing: 0){
                        header
                        filer
                            .foregroundColor(.white)
                            .padding(.bottom)
                        thumnail
                            .padding(.bottom)
                        
                    }.background {
                        ZStack{
                            KFImage(URL(string: CustomData.instance.movieList[movieIndex])!)
                                .resizable()
                                .frame(height: 1000)
                            Color.black.opacity(0.2)
                            Color.clear
                                .background(Material.thin)
                                .environment(\.colorScheme, .dark)
                        }
                        
                        .padding(.bottom,500)
                    }.ignoresSafeArea()
                    CustomTextField(password: false, image: "magnifyingglass", placeholder: "작품을 검색해주세요..", color: .gray, text: .constant(""))
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        .padding()
                        .onTapGesture {
                            search = true
                        }
                    reviewPosting
                    movieList
                    Spacer().frame(height: 100).foregroundColor(.white)
                }
            }
            
            
        }
        
        .navigationDestination(isPresented: $isReview){
//            ReviewView(isReview: $isReview, review: poster)
//                .navigationBarBackButtonHidden(true)
//            WorkView(id: poster.id, type: poster.)
        }
        .navigationBarItems(leading: Text("리뷰").font(.title).bold().padding(.bottom,20),trailing: Button {
            search = true
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.title3)
        })
        .ignoresSafeArea()
        .navigationDestination(isPresented: $search) {
            WorkListView(title: "검색", writeCommunity: false, back: $search)
                .navigationBarBackButtonHidden(true)
        }.foregroundColor(.white)
            .onAppear {
                startTimer()
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
        //        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        //  NavigationStack{
        MainView(search: .constant(false), filterSelect: .constant(false))
        //.environment(\.colorScheme, .dark)
        //   }
    }
}

extension MainView{
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            // 반복적으로 실행되는 코드
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 3.0)){
                    movieIndex = (movieIndex + 1) % CustomData.instance.movieList.count
                    
                }
                withAnimation(Animation.linear(duration: 0.5)) {
                    rotationAngle += .degrees(180)
                }
                
            }
        }
    }
    var header:some View{
        HStack{
            HStack{
                Text("TOP100")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                Image("trophy")
                    .resizable()
                    .frame(width: 25,height: 20)
                    .rotation3DEffect(rotationAngle, axis: (x: 0, y: 1, z: 0))
            }
            
            
            Spacer()
            Button {
                //                search = true
            } label: {
                Image(systemName: "bell.fill")
                    .font(.title3)
                    .padding(.trailing)
            }
        }
        .padding(.vertical)
        .padding(.top,30)
    }
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .font(.title3)
                .bold()
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
        }
    }
    var reviewPosting:some View{
        VStack(alignment: .leading){
            Text("오늘의 리뷰&게시물")
                .font(.title3)
                .bold()
                .padding(.leading)
                .padding(.bottom)
            HStack(spacing: 10){
                VStack(alignment: .leading,spacing: 10){
                    Text("- 리뷰 -")
                        .font(.caption)
                        .bold()
                    VStack(alignment: .leading,spacing: 8){
                        
                        Text("#어벤져스")
                            .font(.caption)
                            .bold()
                        Text(CustomData.instance.dummyString)
                            .font(.caption2)
                    }
                    .frame(height: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                VStack(alignment: .leading,spacing: 10){
                    Text("- 커뮤니티 -")
                        .font(.caption)
                        .bold()
                    VStack(alignment: .leading,spacing: 8){
                        HStack{
                            VStack(alignment: .leading,spacing: 8){
                                Text("아 이영화;;")
                                    .font(.system(size: 15))
                                
                                Text("#어벤져스")
                                    .font(.caption)
                                    .bold()
                            }
                            Spacer()
                            KFImage(URL(string: CustomData.instance.movieList[2]))
                                .resizable()
                                .frame(width: 50,height: 50)
                                .cornerRadius(10)
                        }
                        Text(CustomData.instance.dummyString)
                            .font(.caption2)
                    }.overlay(alignment: .topTrailing) {
                       
                    }
                    .frame(height: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                
                
            }
            .padding(.horizontal)
            
        }.foregroundColor(.black)
    }
    
    var thumnail:some View{
        
        TabView{
            ForEach(CustomData.instance.reviewList.chunks(ofCount: 3),id:\.self){ item in
                HStack{
                    ForEach(Array(item.enumerated()),id:\.0){ (index,element) in
                        VStack(spacing: 15){
                            Text("\(index + 1). \(element.title)")
                                .font(.caption)
                            KFImage(URL(string: element.thumbnail)!)
                                .resizable()
                                .frame(width: 120,height:180)
                                .cornerRadius(20)
                            Circle()
                                .trim(from: 0.0, to: anima ? element.gradeAvg * 0.1 : 0)
                                .stroke(lineWidth: 3)
                                .rotation(Angle(degrees: 270))
                                .frame(width: 50,height: 50)
                                .overlay{
                                    VStack{
                                        Image(systemName: "star.fill")
                                            .font(.caption)
                                        Text(String(format: "%0.1f", element.gradeAvg))
                                            .font(.caption)
                                    }
                                }
                        }.padding(.horizontal,5)
                    }
                }
            }
        }
        .frame(height: 300)
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
    var filer:some View{
        VStack(spacing: 0){
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    Capsule()
                        .stroke(lineWidth: 1)
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text("전체")
                        }
                    Capsule()
                        .stroke(lineWidth: 1)
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text("이번달")
                            Spacer()
                        }
                }.padding(.leading)
            }
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    Capsule()
                        .stroke(lineWidth: 1)
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text("영화")
                        }
                    Capsule()
                        .stroke(lineWidth: 1)
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text("시리즈")
                        }
                    Capsule()
                        .stroke(lineWidth: 1)
                        .frame(width: 80,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text("애니메이션")
                        }
                    Spacer()
                    Text("전체보기 >")
                        .font(.caption)
                        .padding(.horizontal)
                    
                }.padding(.leading)
            }
        }.font(.caption)
    }
    var movieList:some View{
        VStack{
            
            ForEach(MovieGenreFilter.allCases,id:\.self){ genre in
                // Section(header:){
                ScrollView(.horizontal,showsIndicators: false){
                    genreHeader(name: genre.name).padding(.top)
                    HStack(spacing: 0){
                        ForEach(CustomData.instance.workList){ work in
                            Button {
//                                poster = work
                                isReview = true
                            } label: {
                                KFImage(URL(string: ("https://image.tmdb.org/t/p" + "/original" + (work.posterPath ?? "")))!)
                                    .resizable()
                                    .frame(width: 150,height: 200)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .padding(.leading)
                                    .overlay(alignment:.topTrailing) {
                                        Circle()
                                            .trim(from: 0.0, to: anima ? 4 * 0.1 : 0)
                                            .stroke(lineWidth: 3)
                                            .rotation(Angle(degrees: 270))
                                            .frame(width: 40,height: 40)
                                            .overlay{
                                                VStack{
                                                    Image(systemName: "star.fill")
                                                        .font(.caption)
                                                    Text(String(format: "%0.1f", 4))
                                                        .font(.caption)
                                                }
                                            }
                                            .background{
                                                Circle().foregroundColor(.black.opacity(0.7))
                                            }
                                            .padding(5)
                                            
                                    }
                            }
                            
                        }
                        
                    }
                }.padding(.bottom,5)
            }
            
            
        }
    }
    
}
