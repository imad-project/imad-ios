//
//  KFImage.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/06.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    let image:String
    var width:CGFloat?
    var height:CGFloat?
    
    var body: some View {
        Group{
            if !image.isEmpty{
                KFImage(URL(string:image.getImadImage()))
                    .resizable()
                    .cancelOnDisappear(true)
                    .cacheMemoryOnly(false)
                    .fade(duration: 0.1)
                    .setProcessor(processor)
                    .placeholder{
                        NoImageView()
                    }
            }else{
                VStack(spacing:0){
                    Image("brown")
                        .resizable()
                    Text("이미지를 불러올 수 없습니다.")
                        .font(.GmarketSansTTFMedium(13))
                }
                .padding(.bottom)
                .background(.gray.opacity(0.1))
            }
        }
        .frame(width: width,height: height)
        .shadow(radius: 1)
    }
    var processor:ImageProcessor{
        width != nil && height != nil
                      ? ResizingImageProcessor(referenceSize: CGSize(width: width!, height: height!))
                      : DefaultImageProcessor()
    }
    
}

struct KFImageView_Previews: PreviewProvider {
    static var previews: some View {
        KFImageView(image: CustomData.workInfo?.posterPath ?? "",width: 200,height: 300)
    }
}

