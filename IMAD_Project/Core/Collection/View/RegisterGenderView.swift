//
//  RegisterGenderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct RegisterGenderView: View {

    @State var phase:CGFloat = 0.0
    @State var gender = ""
   //@Binding var next:Bool

    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            BackgroundView(height: 0.83, height1: 0.87,height2: 0.85,height3: 0.86)
            VStack(alignment: .leading,spacing: 30){
                Group{
                    Spacer()
                    Text("1. 성별과 출생연도를 설정해주세요")
                        .bold()
                        .padding(.bottom,50)
                    Text("• 성별을 선택해 주세요")
                        .padding(.leading)
                    HStack{
                        VStack{
                            Button {
                                vm.gender = "MALE"
                            } label: {
                                Circle()
                                    .foregroundColor(.black.opacity(0.3))
                                    .frame(width: 150,height: 150)
                                    .overlay {
                                        if vm.gender == "MALE"{
                                            Circle().foregroundColor(.black.opacity(0.5))
                                        }
                                        Image("MALE")
                                                .resizable()
                                                .frame(width: 100,height: 80)
                                                .shadow(radius: 20)
                                                .opacity(vm.gender == "MALE" ? 1.0 :0.5)
                                    }
                            }
                            Text("남성")
                                .fontWeight(vm.gender == "MALE" ? .bold:.none)
                        }
                        Spacer().frame(width: 50)
                        VStack{
                            Button {
                                vm.gender = "FEMALE"
                            } label: {
                                Circle()
                                    .foregroundColor(.black.opacity(0.3))
                                    .frame(width: 150,height: 150)
                                    .overlay {
                                        if vm.gender == "FEMALE"{
                                            Circle().foregroundColor(.black.opacity(0.5))
                                        }
                                        Image("FEMALE")
                                                .resizable()
                                                .frame(width: 100,height: 75)
                                                .shadow(radius: 20)
                                                .opacity(vm.gender == "FEMALE" ? 1.0 :0.5)
                                        
                                    }
                            }
                            Text("여성")
                                .fontWeight(vm.gender == "FEMALE" ? .bold:.none)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    Text("• 나이를 선택해주세요")
                        .padding(.leading)
                    HStack{
                        Spacer()
                        
                        Picker("", selection: $vm.age) {
                            ForEach(0...100, id: \.self) {
                                Text("\($0) 세")
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .colorScheme(.dark)
                        .frame(width:150,height: 150)
                        .overlay(alignment:.leading){
                            Text("만").offset(x:-20)
                        }
                        Spacer()
                    }
                   
                    
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
            .environmentObject(AuthViewModel())
        //RegisterGenderView(next: .constant(false))
    }
}
