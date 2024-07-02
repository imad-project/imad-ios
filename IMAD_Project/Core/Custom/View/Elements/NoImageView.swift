//
//  NoImageView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import SwiftUI

struct NoImageView: View {
    @State var colors = [Color.white,Color.gray.opacity(0.1)]
    var body: some View {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .onAppear{
                startTimer()
            }
    }
        func startTimer() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 1)){
                        colors.swapAt(0, 1)
                    }
                }
            }
        }
}

struct NoImageView_Previews: PreviewProvider {
    static var previews: some View {
        NoImageView()
    }
}
