//
//  CommentRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommentRowView: View {
    let comment:CommentResponse
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == comment.userProfileImage})?.rawValue ?? "soso")
                    .resizable()
                  .frame(width: 40, height: 40)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
                  .shadow(radius: 10)
                  .padding(.trailing,7)
                Text(comment.userNickname).bold()
                Spacer()
                Text(comment.modifiedAt.relativeTime())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.bottom,10)
            Text(comment.content).padding(.leading).font(.footnote)
            Divider()
        }.padding(.horizontal)
            .padding(.vertical,3)
        
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: CustomData.instance.comment)
    }
}
