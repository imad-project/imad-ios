//
//  CropView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI

struct CropView: View {
    var image:UIImage?
    var onCrop:(UIImage?,Bool)->()
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.black.opacity(0.8).ignoresSafeArea()
            Image(systemName: "xmark")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding()
            imageView()
                .mask(alignment: .center) {
                    ZStack{
                        Rectangle().opacity(0.5)
                        Circle()
                    }
                }
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
            
            
            
            
        }
    }
    
    @ViewBuilder
    func imageView()->some View{
        let cropSize:CGSize = CGSize(width: 300, height: 300)
        GeometryReader{ geo in
            let size = geo.size
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(size)
            }
        }
        .frame(cropSize)
    }
}

#Preview {
    CropView(image:UIImage(named: "happy")){ _,_ in
        
    }
}
