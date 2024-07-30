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
    func onAppearOnDisAppear(_ appear:@escaping()->(),_ disAppear:@escaping()->()) -> some View{
        self
            .onAppear(perform: appear)
            .onDisappear(perform: disAppear)
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
