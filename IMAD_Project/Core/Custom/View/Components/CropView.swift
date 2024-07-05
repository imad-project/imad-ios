//
//  CropView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI
struct CropView: View {
    @Binding var image:UIImage?
    @Environment(\.dismiss) var dismiss
    var onCrop:(UIImage?,Bool)->()
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            Color.black.opacity(0.9).ignoresSafeArea()
            imageView()
            ZStack{
                Group{
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                    Text("사진 자르기")
                    
                }
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth:.infinity)
                .padding()
            }
            .background{
                Color.white.ignoresSafeArea()
                Color.black.opacity(0.9).ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    func imageView()->some View{
        GeometryReader { geometry in
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .overlay {
                        Grids()
                    }
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .aspectRatio(image.size, contentMode: .fit)
                    .mask(alignment: .center) {
                        ZStack {
                            Rectangle()
                                .opacity(0.5)
                            Circle()
                                .frame(width: 300, height: 300)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
    @ViewBuilder
    func Grids()->some View{
        ZStack{
            HStack{
                ForEach(1...4,id: \.self){ _ in
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 1)
                        .frame(maxWidth:.infinity)
                    
                }
            }
            VStack{
                ForEach(1...4,id: \.self){ _ in
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 1)
                        .frame(maxHeight:.infinity)
                    
                }
            }
            
        }
    }
}

#Preview {
    CropView(image:.constant(UIImage(named: "happy"))){ _,_ in
        
    }
}
