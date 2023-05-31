//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI
import WebKit
import SwiftUIFlowLayout

struct TextGridView: View {
    
    var body: some View {
        FlowLayout(mode: .scrollable,
                   items: ["Some long item here", "And then some longer one",
                           "Short", "Items", "Here", "And", "A", "Few", "More",
                           "And then a very very very long one"],
                   itemSpacing: 4) {
            Text($0)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4)
                    .border(Color.gray)
                    .foregroundColor(Color.gray))
        }.padding()
    }
    
    
}










struct TextGridView_Previews: PreviewProvider {
    static var previews: some View {
        TextGridView()
    }
}

