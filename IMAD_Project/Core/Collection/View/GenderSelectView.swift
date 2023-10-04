//
//  RegisterGenderView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/12.
//

import SwiftUI

struct GenderSelectView: View {

    @State var gender = ""
   //@Binding var next:Bool

    @EnvironmentObject var vm:AuthViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                Text("성별을 설정해주세요")
                    .font(.title3)
                    .bold()
                    .padding(.leading)
                Text("설정된 성별 언제든지 바꾸실수 있습니다. ")
                    .font(.callout)
                .padding(.leading)
                   
                    HStack(spacing: 30){
                        VStack{
                            Button {
                                vm.profileInfo.gender = "MALE"
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150,height: 150)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .overlay {
                                        if vm.profileInfo.gender == "MALE"{
                                            RoundedRectangle(cornerRadius: 20).foregroundColor(.black.opacity(0.3))
                                                .frame(width: 150,height: 150)
                                        }
                                        Image("MALE")
                                                .resizable()
                                                .frame(width: 90,height: 100)
                                    }
                                    .shadow(radius: 20)
                            }
                            Text("남성")
                                .fontWeight(vm.profileInfo.gender == "MALE" ? .bold:.none)
                        }
                        //Spacer().frame(width: 50)
                        VStack{
                            Button {
                                vm.profileInfo.gender = "FEMALE"
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150,height: 150)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .overlay {
                                        if vm.profileInfo.gender == "FEMALE"{
                                            RoundedRectangle(cornerRadius: 20).foregroundColor(.black.opacity(0.3))
                                                .frame(width: 150,height: 150)
                                        }
                                        Image("FEMALE")
                                                .resizable()
                                                .frame(width: 90,height: 100)
                                    }
                                    .shadow(radius: 20)
                            }
                            Text("여성")
                                .fontWeight(vm.profileInfo.gender == "FEMALE" ? .bold:.none)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                Button {
                    withAnimation(.linear){
                        vm.selection = .age
                    }
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
                

            }.foregroundColor(.customIndigo).padding()
           
        }
    }
}

struct GenderSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectView()
            .environmentObject(AuthViewModel())
    }
}
