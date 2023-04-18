//
//  NotificationView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/06.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                Section(header:header){
                    List(0..<3,id: \.self){ item in
                        HStack{
                            Image(systemName: CustomData.instance.notification[item].icon)
                                .bold()
                            Text(CustomData.instance.notification[item].content)
                               
                        }
                        .foregroundColor(.primary)
                        .listRowBackground(Color.clear)
                    }
                    .background{
                        if colorScheme == .dark {
                            LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
                        }else{
                            Color.white
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)   //리스트 배경 없음
                    .padding(.bottom,50)
                }
            }
            .ignoresSafeArea()
            .background{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
extension NotificationView{
    var header:some View{
        VStack{
            HStack{
                Text("알림")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.indigoNotPrimary)
                Spacer()
            }
            
        }
        .foregroundColor(.white)
        .padding(.vertical)
        .padding(.top,30)
        .background{
            if colorScheme == .dark {
                Color.white
            }else{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
            }
        }
    }
}
