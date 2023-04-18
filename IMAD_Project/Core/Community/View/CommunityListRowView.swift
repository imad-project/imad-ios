//
//  CommunityListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI
import Kingfisher

struct CommunityListRowView: View {
    let image:String
    let community:Community
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(community.title)
                    .bold()
                Spacer()
                HStack{
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(community.like)")
                    Image(systemName: "hand.thumbsdown.fill")
                    Text("\(community.hate)")
                    Image(systemName: "message.fill")
                    Text("\(community.reply)")
                        .padding(.trailing,30)
                    Text(community.date).bold()
                }.font(.caption)
                
            }
            Spacer()
            KFImage(URL(string: image))
                .resizable()
                .frame(width: 100,height: 100)
                .cornerRadius(20)
        }
        .frame(maxHeight: 100)
        .foregroundColor(.primary)
    }
}

struct CommunityListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListRowView(image: CustomData.instance.community.image, community:CustomData.instance.community)
    }
}
