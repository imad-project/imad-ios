//
//  InfoChangeView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/18.
//

import SwiftUI

struct InfoChangeView: View {
    let title:String
    let password:Bool
    @State var passwordConfirm:String = ""
    @State var text:String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            ZStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("변경")
                            .bold()
                    }
                }
                Text(title + " 변경")
                    .bold()
            }.foregroundColor(.primary)
            .padding(.top,20)
           .padding(.bottom,50)
            CustomTextField(password: password, image: nil, placeholder: title + " ..", color: .primary, text: $text)
                .padding(.bottom,10)
            Divider()
                .background(Color.primary)
                .padding(.bottom)
            if password{
                CustomTextField(password: password, image: nil, placeholder: title + " 확인 ..", color: .primary, text: $passwordConfirm)
                    .padding(.bottom,10)
                Divider()
                    .background(Color.primary)
               
            }
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding()
        .background{
            ZStack{
                Color.antiPrimary
                ProfileView()
                    .blur(radius: 20)
                    .opacity(0.1)

            }.ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct InfoChangeView_Previews: PreviewProvider {
    static var previews: some View {
        InfoChangeView(title: "아이디", password: true, text: "quarang")
    }
}
