//
//  RegisterGenderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct RegisterGenderView: View {

    @State var phase:CGFloat = 0.0
    @State private var date = 2000
   //@Binding var next:Bool
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
            VStack(alignment: .leading,spacing: 30){
                Group{
                    
                    Spacer()
                    
                    
                    Text("1. 성별과 출생연도를 설정해주세요")
                        .bold()
                        .padding(.bottom,50)
                    HStack{
                        VStack{
                            Button {
                                
                            } label: {
                                Circle()
                                    .foregroundColor(.black.opacity(0.3))
                                    .frame(width: 150,height: 150)
                                    .overlay {
                                        Image("man")
                                                .resizable()
                                                .frame(width: 100,height: 80)
                                                .shadow(radius: 20)
                                    }
                            }
                            Text("남성")
                        }
                        Spacer().frame(width: 50)
                        VStack{
                            Button {
                                
                            } label: {
                                Circle()
                                    .foregroundColor(.black.opacity(0.3))
                                    .frame(width: 150,height: 150)
                                    .overlay {
                                        Image("women")
                                                .resizable()
                                                .frame(width: 100,height: 75)
                                                .shadow(radius: 20)
                                    }
                            }
                            Text("여성")
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Picker("", selection: $date) {
                        ForEach(1900...2023, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    .colorScheme(.dark)
                    .frame(height: 150)
                }
                Spacer()

            }.foregroundColor(.white)
                .padding()
        }
    }
}

struct RegisterGenderView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterGenderView()
        //RegisterGenderView(next: .constant(false))
    }
}
