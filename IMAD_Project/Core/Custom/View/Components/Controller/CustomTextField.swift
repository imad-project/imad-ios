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
    var image:String?
    let placeholder:String
    let color:Color
    var style:TextFieldStyle
    var textLimit:Int?
    var font:Font?
    @Binding var text:String
    
    var body: some View {
        VStack{
            switch style {
            case .line:
                HStack{
                    imageView
                    fieldView
                    xmarkView
                }
                .padding(.bottom,5)
                Divider()
                    .frame(height: 1.5)
                    .background(color)
            case .capsule:
                HStack{
                    imageView
                    fieldView
                    xmarkView
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(50)
            case .rounded:
                HStack{
                    imageView
                    fieldView
                    xmarkView
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(20)
            case .none: EmptyView()
            }
        }
        .foregroundColor(.black)
        
    }
    func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    enum TextFieldStyle{
        case line
        case capsule
        case rounded
        case none
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(password: false, image: "heart", placeholder: "입력..",color: .customIndigo, style: .line, text: .constant(""))
    }
}

extension CustomTextField{
    @ViewBuilder
    var imageView:some View{
        if let image{
            Image(systemName: image).bold()
        }
    }
    @ViewBuilder
    var fieldView:some View{
        if password{
            SecureField("", text: $text)
                .bold()
                .background(alignment:.leading){
                    Text(placeholder)
                        .font(font)
                        .foregroundColor(color.opacity(text != "" ? 0.0:1))
                }
        }else{
            TextField("", text: $text)
                .bold()
                .background(alignment:.leading){
                    Text(placeholder)
                        .font(font)
                        .foregroundColor(color.opacity(text != "" ? 0.0:1))
                        .onReceive(Just(text)) { _ in
                            if let textLimit{
                                limitText(textLimit)
                            }
                        }
                }
        }
    }
    @ViewBuilder
    var xmarkView:some View{
        if !text.isEmpty{
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
        }
    }
}
