//
//  MenuTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import SwiftUI
import Kingfisher

struct MenuTabView: View {
    
    @State var mode:Tab = .home
    @State var selectFilter = false //필터 선택
    
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            ZStack(alignment: .bottom){
                TabView(selection: $mode){
                    MainView(filterSelect: $selectFilter)
                        .tag(Tab.home)
                    Text("sada")
                        .tag(Tab.community)
                    Text("dasd")
                        .tag(Tab.notification)
                    Text("asd")
                        .tag(Tab.profile)
                    
                }
                menu
                
            }
            .blur(radius: selectFilter ? 20:0, opaque: false) //블러처리
            //.blur(radius: selectFilter ? 10:0)
            .allowsHitTesting(selectFilter ? false : true)  //터치 비활성화
            if selectFilter{
                filterSelectView
            }
        }
        .onAppear{
            UITabBar.appearance().isHidden = true   //탭바 숨김
        }
        
    }
}

struct MenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTabView()
    }
}



extension MenuTabView{
    var menu: some View {
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id:\.self){ tab in
                    VStack{
                        if tab.name != ""{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    mode = tab
                                }
                            } label: {
                                Image(systemName: tab.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity)
                            }.frame(height: 30)
                        }else{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    mode = tab
                                }
                            } label: {
                                KFImage(URL(string: CustomData.instance.moviePoster))
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .clipShape(Circle())
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(height: 30)
                        }
                        Text(tab.menu)
                            .font(.caption)
                        
                    }
                    
                }
            }
            .frame(maxWidth:.infinity)
            .overlay(alignment:.leading){
                Capsule()
                    .frame(width: 30,height: 3)
                    .padding(.leading,35)
                    .padding(.bottom,65)
                    .offset(x:indicatorOffset(width: width)+3)
            }
            
        }
        
        .frame(height: 20)
        .padding(.top,8)
        .padding(.bottom,20)
        .background(.regularMaterial)
        .foregroundColor(.indigoPrimary)
        
        
        
    }
    func indicatorOffset(width:CGFloat)->CGFloat{
        let index = CGFloat(getIndex())
        if index == 0{return 0}
        let buttonWidth = width/CGFloat(Tab.allCases.count)
        
        return index * buttonWidth
        
    }
    func getIndex() ->Int{
        switch mode {
        case .home:
            return 0
        case .community:
            return 1
        case .notification:
            return 2
        case .profile:
            return 3
        }
    }
    var filterSelectView:some View{
        VStack{
            Text("장르")
                .font(.title3)
                .bold().padding(.top,70)
            
                .padding(.bottom,50)
            ScrollView {
                LazyVStack{
                    ForEach(GenerFilter.allCases,id:\.self){
                        Text($0.generName)
                            .padding(10)
                    }
                }
                
            }
            .foregroundColor(.white)
            
            Button {
                withAnimation(.easeIn(duration: 0.05)){
                    selectFilter = false
                }
            } label: {
                Image(systemName: "xmark")
                    .background(Color.white.clipShape(Circle()).frame(width: 50,height: 50).shadow(radius: 10))
                    .padding(.bottom,100)
                    .foregroundColor(.black)
                
            }
            
        }.foregroundColor(.white)
            .ignoresSafeArea()
    }
}

