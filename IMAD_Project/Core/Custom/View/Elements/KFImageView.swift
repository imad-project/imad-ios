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
        
        KFImage(URL(string: image))
            .resizable()
            .placeholder{
                NoImageView()
            }
            .frame(width: width,height: height)
            .shadow(radius: 1)
    }
}

struct KFImageView_Previews: PreviewProvider {
    static var previews: some View {
        KFImageView(image: CustomData.instance.review.contentsPosterPath.getImadImage(),width: 200,height: 300)
    }
}

