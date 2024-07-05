//
//  CustomImagePicker.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI
import PhotosUI

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
    @State var showCropView = false
    @State var photosItem:PhotosPickerItem?
    @State var selected:UIImage?
    var body: some View {
        content
            .photosPicker(isPresented: $show, selection: $photosItem)
            .onChange(of: photosItem) { newValue in
                if let newValue{
                    Task{
                        guard let imageData = try? await newValue.loadTransferable(type: Data.self),let image = UIImage(data: imageData) else {return}
                        await MainActor.run {
                            self.selected = image
                            showCropView.toggle()
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showCropView){
                selected = nil
            } content: {
                CropView(image: selected){ croppedImage, status in
                    
                }
            }
    }
}

//#Preview {
//    CustomImagePicker()
//}
