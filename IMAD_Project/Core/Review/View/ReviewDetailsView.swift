//
//  ReviewDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import SwiftUI

struct ReviewDetailsView: View {
    let review:UserReview
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
//            MovieBackgroundView(url: review, height: <#T##CGFloat#>)
            header
        }
        .background(Color.white)
        .foregroundColor(.black )
        
    }
}

struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsView(review: CustomData.instance.userReiveList.first!)
    }
}

extension ReviewDetailsView{
    var header:some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
            }
            Spacer()
                
        }.padding(.horizontal)
    }
}
