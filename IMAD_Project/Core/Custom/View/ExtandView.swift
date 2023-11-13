//
//  ExtandView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/13.
//

import SwiftUI

struct ExtandView: View {
    
    let text:String?
    @State var extand = false
    
    var body: some View {
        VStack(alignment: .leading){
            if let textLength = text,textLength.count > 100{
                if let text{
                    Text(extand ? text : (text.prefix(100) + ".."))
                        .padding(.trailing)
                    Button {
                        withAnimation {
                            extand.toggle()
                        }
                    } label: {
                        Text(extand ? "닫기":"더보기")
                            .underline()
                    }
                    .padding(.top,10)
                    .foregroundColor(.gray)
                    .font(.caption)
                }
            }else{
                Text(text ?? "")
                    .padding(.trailing)
            }
        }
        
    }
}

struct ExtandView_Previews: PreviewProvider {
    static var previews: some View {
        ExtandView(text: CustomData.instance.dummyString)
    }
}
