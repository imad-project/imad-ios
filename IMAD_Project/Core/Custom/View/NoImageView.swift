//
//  NoImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import SwiftUI

struct NoImageView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.white.opacity(0.9))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth:2)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(5)
                
                VStack{
                    Image(systemName: "photo")
                        .font(.title3)
                    Text("사진없음")
                        .bold()
                        .font(.caption)
                }
                .foregroundColor(.gray)
            }
    }
}

struct NoImageView_Previews: PreviewProvider {
    static var previews: some View {
        NoImageView()
    }
}
