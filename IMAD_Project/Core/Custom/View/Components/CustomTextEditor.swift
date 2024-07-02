//
//  CustomTextEditor.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import SwiftUI
import Combine

struct CustomTextEditor: View {
    
    let placeholder:String
    let color:Color
    var textLimit:Int
    
    @Binding var text:String
    
    var body: some View {
        VStack(alignment: .trailing){
            RoundedRectangle(cornerRadius: 10)
                .stroke(color, lineWidth: 1.5)
                .frame(height: 360)
                .overlay(
                    TextEditor(text: $text)
                        .background(Color.clear)
                        .padding(8)
                        .overlay(alignment: .topLeading){
                            if text == ""{
                                Text(placeholder)
                                    .allowsHitTesting(false)
                                    .opacity(0.5)
                                    .padding()
                                    .onReceive(Just(text)) { _ in
                                        limitText(textLimit)
                                    }
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black)
                    
                ).padding(.top,5)
            Text("\(text.count)/2500글자")
                .foregroundStyle(.gray)
                .font(.subheadline)
        }
       
    }
    func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

#Preview {
    CustomTextEditor(placeholder: "안녕", color: .customIndigo, textLimit: 500, text: .constant(""))
}
