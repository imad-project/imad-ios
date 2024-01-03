//
//  ActorProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/3/24.
//

import SwiftUI
import Kingfisher

struct ActorProfileView: View {
    let image:String
    var body: some View {
        KFImage(URL(string: image))
            .resizable()
            .placeholder{
                Circle()
                    .foregroundColor(.gray.opacity(0.1))
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
            }
            .scaledToFill()
            .frame(width: 80,height: 80)
            .clipShape(Circle())
    }
}

#Preview {
    ActorProfileView(image: CustomData.instance.movieList.first!)
}
