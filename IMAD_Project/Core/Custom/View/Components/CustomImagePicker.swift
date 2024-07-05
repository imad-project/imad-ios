//
//  CustomImagePicker.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI

extension View{
    @ViewBuilder
    func cropImagePicker(show:Binding<Bool>,croppedImage:Binding<UIImage?>)->some View{
        CustomImagePicker(show: show, croppedImage: croppedImage) {
            self
        }
    }
}
struct CustomImagePicker<Content:View>: View {
    var content:Content
    @Binding var show:Bool
    @Binding var croppedImage:UIImage?
    init(show:Binding<Bool>,croppedImage:Binding<UIImage?>,@ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._show = show
        self._croppedImage = croppedImage
    }
    var body: some View {
        content
    }
}

//#Preview {
//    CustomImagePicker()
//}
