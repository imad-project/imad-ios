//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/23.
//

import SwiftUI
import SwiftUIWave

struct TestView: View {
    var body: some View {
        WaveImage(color: .red, height: .low, speed: .slow, amplitude: .low)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
