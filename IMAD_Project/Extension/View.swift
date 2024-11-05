//
//  View.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import Foundation
import SwiftUI

extension View{
    @ViewBuilder
    func cropImagePicker(show:Binding<Bool>,croppedImage:Binding<UIImage?>)->some View{
        CustomImagePicker(show: show, croppedImage: croppedImage) {
            self
        }
    }
    @ViewBuilder
    func frame(_ size:CGSize)-> some View{
        self
            .frame(width:size.width,height: size.height)
    }
    @ViewBuilder
    func progress(_ condition:Bool)-> some View{
        if condition {
            self
        }
        else{
            CustomProgressView()
        }
    }
    @ViewBuilder
    func conditionAppear(_ condition:Bool)-> some View{
        if condition {
            self
        }
    }
    @ViewBuilder
    func onAppearOnDisAppear(_ appear:@escaping()->(),_ disAppear:@escaping()->()) -> some View{
        self
            .onAppear(perform: appear)
            .onDisappear(perform: disAppear)
    }
    @ViewBuilder
    func backgroundColor(_ color:Color) ->some View{
        ZStack{
            color.ignoresSafeArea()
            self
        }
    }
    @ViewBuilder
    func backgroundColor(_ view:()->(some View)) ->some View{
        ZStack{
            view()
            self
        }
    }
    @ViewBuilder
    func textTitleView(_ text:String) -> some View{
        HStack{
            Text(text)
                .fontWeight(.black)
                .font(.GmarketSansTTFMedium(isPad() ? 30 : 20))
                .foregroundColor(.customIndigo)
            Spacer()
        }
        .padding(.bottom,5)
    }
    @ViewBuilder
    func allView(_ view: some View) -> some View{
        NavigationLink {
            view
                .navigationBarBackButtonHidden()
        } label: {
            Text("전체보기")
                .font(.GmarketSansTTFMedium(isPad() ? 18 : 14))
                .fontWeight(.regular)
                .foregroundColor(.customIndigo)
        }
    }
    func isWidth()->Bool{
        UIDevice.current.orientation.isLandscape
    }
    
    var mainWidth:CGFloat{
        UIScreen.main.bounds.width
    }
    var mainHeight:CGFloat{
        UIScreen.main.bounds.height
    }
    func isPad()->Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    func haptics(_ style:UIImpactFeedbackGenerator.FeedbackStyle){
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
   
}
