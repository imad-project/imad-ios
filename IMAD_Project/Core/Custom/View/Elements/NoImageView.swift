//
//  NoImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import SwiftUI

struct NoImageView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.1))
            .overlay {
                VStack{
                    Image(systemName: "photo")
                        .font(.title)
                    Text("NO")
                        .bold()
                        .font(.subheadline)
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
