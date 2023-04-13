//
//  ProfileSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct ProfileSelectView: View {
    @Binding var register:Bool
    var body: some View {
        ZStack{
            BackgroundView(height: 0.83, height1: 0.9)
            VStack{
                Spacer()
                Text("3. 프로필 사진을 설정해주세요")
                    .bold()
                    .padding(.bottom,50)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom,50)
                Circle().stroke(lineWidth: 5)
                    .frame(width: 200,height: 200)
                    .overlay{
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100,height: 100)
                        
                    }
                Button{
                    register.toggle()
                }label:{
                    Capsule()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.customIndigo)
                                .shadow(radius: 20)
                        }
                }
                .padding(50)
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectView(register: .constant(false))
    }
}
