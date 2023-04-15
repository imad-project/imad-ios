//
//  MainView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    
    @State var poster:Review = CustomData.instance.reviewList.first!
    @State var isReview = false
    @Binding var filterSelect:Bool 
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing:0){
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header: header) {
                                filer
                                thumnail
                                movieList
                                Spacer().frame(height: 100)
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
            }.background{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        }
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(filterSelect: .constant(false))
    }
}

extension MainView{
    var header:some View{
        HStack{
            Text("리뷰")
                .font(.title)
                .bold()
                .padding(.leading)
                
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
                .padding(.trailing)
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
                Text("벤자민 버튼의 시간은 거꾸로 간다")
                Text("(2008)")
                    .font(.caption)
                Spacer()
            }
            .bold()
            .padding(.leading)
            HStack{
                KFImage(URL(string: CustomData.instance.community.image)!)
                    .resizable()
                    .frame(width: 250,height: 250)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
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
                            
                        Spacer()
                    }
                    .padding(.bottom,30)
                    HStack{
                        Text("감독 ").bold()
                        Text("데이비드 핀처")
                            
                            
                    }.font(.caption)
                    Text(CustomData.instance.community.content)
                        .font(.caption)
                        .frame(height: 70)
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
        ForEach(GenreFilter.allCases,id:\.self){ genre in
            Section(header:genreHeader(name: genre.generName)){
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing: 0){
                        ForEach(CustomData.instance.reviewList.shuffled(),id:\.self){ item in
                            Button {
                                poster = item
                                isReview = true
                            } label: {
                                KFImage(URL(string: item.thumbnail)!)
                                    .resizable()
                                    .frame(width: 150,height: 200)
                                    .cornerRadius(15)
                                    .padding(.leading)
                            }
                            .navigationDestination(isPresented: $isReview){
                                ReviewView(isReview: $isReview, review: poster)
                                    .navigationBarBackButtonHidden(true)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}
