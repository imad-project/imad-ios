//
//  ProfileImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/06.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let imagePath:String
    let widthHeigt:CGFloat
    var body: some View {
        KFImage(URL(string: imagePath))
            .resizable()
            .scaledToFill()
            .frame(width: widthHeigt,height: widthHeigt)
            .clipShape(Circle())
            .background{
                if imagePath.contains("default_profile_image"){
                    Circle()
                        .foregroundColor(.white)
                        .shadow(color:ProfileFilter.allCases.first(where: {$0.num == imagePath.getImageCode()})?.color ?? .clear,radius: 1)
                }
            }
    }
   
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imagePath: CustomData.instance.profileImage,widthHeigt: 30)
    }
}
