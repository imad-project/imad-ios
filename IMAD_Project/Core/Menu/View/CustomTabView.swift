//
//  CustomTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/05.
//

import SwiftUI
import Kingfisher

struct CustomTabView: View {
    @Binding var currentTab:Tab
    var body: some View {
        GeometryReader{ geo in
            let width = geo.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id:\.self){ tab in
                    VStack{
                        if tab.name != ""{
                            Button {
                                withAnimation(.easeIn(duration: 0.2)){
                                    currentTab = tab
                                }
                            } label: {
                                Image(systemName: tab.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity)
                            }.frame(height: 30)
                        }else{
                            Button {
                                currentTab = tab
                            } label: {
                                KFImage(URL(string: CustomData.instance.community.image))
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
                    .offset(x:indicatorOffset(width: width))
            }
            
        }
        .frame(height: 20)
        .padding(.bottom,20)
        .padding([.horizontal])
        .foregroundColor(.white)
        .padding(.vertical,20)
        .background(Color.black.opacity(0.7))
        
    }
    func indicatorOffset(width:CGFloat)->CGFloat{
        let index = CGFloat(getIndex())
        if index == 0{return 0}
        let buttonWidth = width/CGFloat(Tab.allCases.count)
        
        return index * buttonWidth
        
    }
    func getIndex() ->Int{
        switch currentTab {
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
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(currentTab: .constant(Tab.home))
    }
}
