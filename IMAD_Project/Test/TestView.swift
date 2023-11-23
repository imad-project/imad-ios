//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                ForEach(0...10,id:\.self) { _ in
                    Button {
                        print("안녕")
                    } label: {
                        Text("안뇽하세용")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
