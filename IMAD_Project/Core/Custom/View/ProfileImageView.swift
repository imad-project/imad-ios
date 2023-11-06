//
//  ProfileImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/06.
//

import SwiftUI

struct ProfileImageView: View {
    let imageCode:Int
    var body: some View {
        Image("\(ProfileFilter.allCases.first(where: {$0.num == imageCode})?.rawValue ?? "")")
            .resizable()
            .scaledToFill()
            .frame(width: 30,height: 30)
            .clipShape(Circle())
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imageCode: 3)
    }
}
