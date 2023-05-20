//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher

extension UINavigationController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor(Color.clear
            .background(.ultraThinMaterial)
            .background(Color.black.opacity(0.6))
            .environment(\.colorScheme, .dark) as? Color ?? Color(""))

        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = UIColor(red: 66/255, green: 116/255, blue: 147/255, alpha: 1.0)

        navigationBar.standardAppearance = standardAppearance
       // navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = compactAppearance

        navigationBar.tintColor = UIColor.white
    }
}

struct MainView: View {
    
    @State var movieIndex = 0
    @State var poster:Review = CustomData.instance.reviewList.first!
    @State var isReview = false
    @Binding var search:Bool
    @Binding var filterSelect:Bool
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing:10){
                        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                            Spacer().frame(height: 100)
                            filer
                                .foregroundColor(.white)
                                .padding(.bottom)
                            thumnail
                                .padding(.bottom)
                            movieList
                            Spacer().frame(height: 100).foregroundColor(.white)
                        }
                    }
                }
            }
            .background {
               
                KFImage(URL(string: CustomData.instance.movieList[movieIndex])!)
                    .resizable()
                Color.black.opacity(0.5)
                Color.clear
                    .background(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
            }
            .navigationDestination(isPresented: $isReview){
                ReviewView(isReview: $isReview, review: poster)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationBarItems(leading: Text("리뷰").font(.title).bold().padding(.bottom,20),trailing: Button {
                search = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
            })
            .ignoresSafeArea()
            .navigationDestination(isPresented: $search) {
                MovieListView(title: "검색", back: $search)
                    .navigationBarBackButtonHidden(true)
            }.foregroundColor(.white)
                .onAppear {
                    
                    startTimer()
                    
                    
                    
                }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      //  NavigationStack{
            MainView(search: .constant(false), filterSelect: .constant(false))
            .environment(\.colorScheme, .dark)
     //   }
    }
}

extension MainView{
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            // 반복적으로 실행되는 코드
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 3.0)){
                    movieIndex = (movieIndex + 1) % CustomData.instance.movieList.count
                }
            }
        }
    }
    var header:some View{
        HStack{
            Text("리뷰")
                .font(.title)
                .bold()
                .padding(.leading)
            
            Spacer()
            Button {
                search = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .padding(.trailing)
            }
            .navigationDestination(isPresented: $search) {
                MovieListView(title: "검색", back: $search)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .padding(.vertical)
        .padding(.top,30)
        .background(Color.black.opacity(0.5))
    }
    func genreHeader(name:String) ->some View{
        HStack{
            Text(name)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.leading)
            Spacer()
        }
    }
    var thumnail:some View{
        VStack{
            HStack{
                Text("카지노")
                Text("(2023)")
                    .font(.caption)
                Spacer()
            }
            .bold()
            .padding(.leading)
            .padding(.top)
            HStack{
                KFImage(URL(string: CustomData.instance.movieList.first!)!)
                    .resizable()
                    .frame(width: 250,height: 350)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        VStack{
                            Circle()
                                .stroke(style: .init(lineWidth: 2))
                                .shadow(radius: 20)
                                .frame(width: 80,height: 80)
                                .overlay {
                                    HStack(spacing:5){
                                        Image(systemName: "star.fill")
                                            .font(.caption)
                                        Text("9.3")
                                            .bold()
                                    }
                                }
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.bottom,30)
                    HStack{
                        Spacer()
                        Text("감독 ").bold()
                        Text("데이비드 핀처")
                        Spacer()
                        
                    }.font(.caption)
                    HStack{
                        Spacer()
                        Text(CustomData.instance.community.content)
                            .font(.caption)
                            .frame(height: 120)
                        Spacer()
                    }
                    
                }.padding(3)
            }.padding(.leading)
        }
    }
    var filer:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                Group{
                    Text("시리즈")
                    Text("영화")
                    
                }
                .padding(.horizontal)
                .padding(5)
                .overlay {
                    Capsule()
                        .stroke(style: .init(lineWidth: 1.0))
                }
                Spacer()
                Button {
                    withAnimation(.easeIn(duration: 0.05)){
                        filterSelect.toggle()
                    }
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3)
                        .padding(.trailing)
                }
                
            }.padding(.leading)
        }
    }
    var movieList:some View{
        VStack{
            
            ForEach(GenreFilter.allCases,id:\.self){ genre in
                // Section(header:){
                ScrollView(.horizontal,showsIndicators: false){
                    genreHeader(name: genre.generName).padding(.top)
                    HStack(spacing: 0){
                        ForEach(CustomData.instance.reviewList,id:\.self){ item in
                            Button {
                                poster = item
                                isReview = true
                            } label: {
                                KFImage(URL(string: item.thumbnail)!)
                                    .resizable()
                                    .frame(width: 150,height: 200)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .padding(.leading)
                            }
                            
                        }
                        
                    }
                }.padding(.bottom,5)
            }
            
            
        }//.background(Color.black.opacity(0.3))
    }
    
}
