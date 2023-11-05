//
//  AgeSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct AgeSelectView: View {
    @EnvironmentObject var vm:AuthViewModel
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                
                Text("나이를 설정해주세요")
                    .font(.title3)
                    .bold()
                    .padding(.leading)
                Text("설정된 나이는 언제든지 바꾸실수 있습니다. ")
                    .font(.callout)
                .padding(.leading)
                HStack{
                    Spacer()
//                    Picker("", selection: $vm.profileInfo.ageRange) {
//                        ForEach(0...100, id: \.self) {
//                            Text("\($0) 세")
//                        }
//                    }
//                    .pickerStyle(InlinePickerStyle())
//                    .colorScheme(.light)
//                    .frame(width:150,height: 150)
//                    .overlay(alignment:.leading){
//                        Text("만").offset(x:-20)
//                    }
                    Spacer()
                }
                
                Button {
//                    withAnimation(.linear){
//                        vm.selection = .genre
//                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo.opacity(0.5))
                        .overlay {
                            Text("다음")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }.padding(.horizontal)
                    .padding(.bottom,50)
            }.padding()
            
            
        }.foregroundColor(.customIndigo)
            
        
        
    }
}

struct AgeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSelectView()
            .environmentObject(AuthViewModel())
    }
}
