//
//  CustomTextField.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI
import Combine

struct CustomTextField: View {
    
    let password:Bool
    let image:String?
    let placeholder:String
    let color:Color
    var textLimit:Int?
    var font:Font?
    
    @Binding var text:String
    
    
    var body: some View {
        HStack{
            if let image = image{
                Image(systemName: image).bold()
            }
            if password{
                SecureField("", text: $text)
                    .bold()
                    .background(alignment:.leading){
                        Text(placeholder)
                            .font(font)
                            .foregroundColor(color.opacity(text != "" ? 0.0:0.8))
                    }
            }else{
                TextField("", text: $text)
                    .bold()
                    .background(alignment:.leading){
                        Text(placeholder)
                            .font(font)
                            .foregroundColor(color.opacity(text != "" ? 0.0:0.8))
                            .onReceive(Just(text)) { _ in
                                if let textLimit{
                                    limitText(textLimit)
                                }
                            }
                    }
            }
            if text != ""{
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }.foregroundColor(color)
    }
    func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(password: false, image: "heart", placeholder: "입력..",color: .customIndigo, text: .constant(""))
    }
}
