//
//  NavigationTestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/11/24.
//

import SwiftUI

struct NavigationTestView: View {
    @State var path = [String]()
    var body: some View {
        NavigationStack(path: $path) {
            Button {
                path.append("A1")
            } label: {
                Text("A")
            }
            .navigationDestination(for: String.self) { value in
                switch value{
                case "A1" : A1(id: value)
                default: Text("h")
                }
            }
        }
    }
}

struct A1: View {
    let id:String
    var body: some View{
        Text("asdasd")
    }
}
#Preview {
    NavigationTestView()
}
