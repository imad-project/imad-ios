//
//  CustomTextField.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/11.
//

import SwiftUI

struct CustomTextField: View {
    
    let password:Bool
    let image:String?
    let placeholder:String
    let color:Color
    
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
                        Text(placeholder).foregroundColor(color.opacity(text != "" ? 0.0:0.8))
                    }
            }else{
                TextField("", text: $text)
                    .bold()
                    .background(alignment:.leading){
                        Text(placeholder).foregroundColor(color.opacity(text != "" ? 0.0:0.8))
                    }
            }
        }.foregroundColor(color)
            
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(password: false, image: "heart", placeholder: "입력..",color: .customIndigo, text: .constant(""))
    }
}
