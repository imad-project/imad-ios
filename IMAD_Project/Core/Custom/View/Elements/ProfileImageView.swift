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
                        .shadow(color:ProfileFilter.allCases.first(where: {$0.num == getImageCode(image: imagePath)})?.color ?? .clear,radius: 1)
                }
            }
    }
    func getImageCode(image:String)->Int{
            let index = image.index(image.endIndex, offsetBy: -5)
            let character = image[index]
            let number = Int(String(character))!
            return number
           
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imagePath: CustomData.instance.profileImage,widthHeigt: 30)
    }
}
