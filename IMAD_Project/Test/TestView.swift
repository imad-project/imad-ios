//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI
import WebKit

class BB:ObservableObject{
    @Published var on = false
}
struct TestView: View {
    
    @StateObject var vm = BB()
    
    var body: some View{
        NavigationStack{
            if vm.on{
                Text("aasd")
            }else{
                Test1View()
                    .environmentObject(vm)
            }
        }
    }
}
struct Test1View: View {
    
    @State var a = false
    @EnvironmentObject var vm:BB
    
    var body: some View{
        Button {
            a = true
        } label: {
            Text("2")
        }
        .navigationDestination(isPresented: $a) {
            Test2View(a: $a).environmentObject(vm)
        }
    }
}
struct Test2View: View {
    
    @Binding var a :Bool
    @EnvironmentObject var vm:BB
    
    var body: some View{
        Button {
            //a = false
            vm.on = true
            print(vm.on)
        } label: {
            Text("3")
        }
    }
}




struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
