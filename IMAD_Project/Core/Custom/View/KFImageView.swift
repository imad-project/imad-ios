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
                emptyPoster
            }
            .frame(width: width,height: height)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct KFImageView_Previews: PreviewProvider {
    static var previews: some View {
        KFImageView(image: CustomData.instance.review.contentsPosterPath?.getImadImage() ?? "",width: 200,height: 300)
    }
}

extension KFImageView{
    var emptyPoster:some View{
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.gray.opacity(0.4))
            .overlay {
                VStack{
                    Image(systemName: "xmark.app.fill")
                        .font(.title)
                        .padding(.bottom)
                    Text("포스터 없음")
                }
                .bold()
                .foregroundColor(.white)
            }
    }

}
