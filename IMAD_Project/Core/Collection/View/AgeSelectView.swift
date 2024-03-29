//
//  AgeSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct AgeSelectView: View {
    @EnvironmentObject var vm:AuthViewModel
    
    var currentDate :Int{
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        return components.year!
    }
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
               guideView
               pickerView
                CustomNextButton(action: {
                    withAnimation(.linear){
                        vm.selection = .genre
                    }
                }, color: .customIndigo.opacity(0.5))
            }.padding()
        }
        .onAppear{
            vm.patchUser.age = currentDate
        }
        .foregroundColor(.customIndigo)
    }
}

struct AgeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSelectView()
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
    }
}
extension AgeSelectView{
    var guideView:some View{
        VStack(alignment: .leading,spacing: 5){
            
            Text("나이를 설정해주세요")
                .font(.title3)
                .bold()
            Text("설정된 나이는 언제든지 바꾸실수 있습니다. ")
                .font(.callout)
                
        }.padding(.leading)
    }
    var pickerView:some View{
        HStack{
            Spacer()
            Picker("", selection: $vm.patchUser.age) {
                ForEach(1900...currentDate, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(InlinePickerStyle())
            .colorScheme(.light)
            .overlay(alignment:.trailing){
                Text("년").offset(x:20)
            }
            .frame(width:150,height: 150)
            Spacer()
        }
    }
}
