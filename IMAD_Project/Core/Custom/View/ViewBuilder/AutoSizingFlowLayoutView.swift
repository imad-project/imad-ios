//
//  AutoSizingFlowLayoutView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 8/1/24.
//

import SwiftUI

public struct AutoSizingFlowLayoutView<Data, Content: View>: View {
    
    let items: [Data]
    @ViewBuilder private var content: (Data) -> Content
    @State private var totalHeight: CGFloat = .zero
    
    var itemCount:Int{
        return items.count
    }
    
    public init(items: [Data], @ViewBuilder content: @escaping (Data) -> Content) {
        self.items = items
        self.content = content
    }
    
    
    public var body: some View {
        var width:CGFloat = .zero
        var height:CGFloat = .zero
        var lastHeight:CGFloat = .zero
        GeometryReader { g in
            ZStack(alignment: .topLeading) {
                ForEach(Array(items.enumerated()), id: \.offset) { index , item in
                    content(item)
                        .padding(5)
                        .alignmentGuide(.leading, computeValue: { leadingGuide(width: &width, height: &height, lastHeight: &lastHeight, g: g, d: $0, index: index) })
                        .alignmentGuide(.top, computeValue: { d in
                           topGuide(height: &height, index: index)
                        })
                        
                }
            }
            .background(background)
            
        }
        .frame(height: totalHeight)
    }
    private var background:some View{
        GeometryReader{ geometry in
            Color.clear
                .preference(key:HeightPreferenceKey.self,value: geometry.frame(in: .local).height)
        }.onPreferenceChange(HeightPreferenceKey.self) { totalHeight = $0 }
    }
    private func leadingGuide(width:inout CGFloat,height:inout CGFloat,lastHeight:inout CGFloat,g:GeometryProxy,d: ViewDimensions,index:Int)->CGFloat{
        if (abs(width - d.width) > g.size.width) {
            width = 0
            height -= lastHeight
        }
        
        lastHeight = d.height
        let result = width
        
        guard index < itemCount - 1 else {
            width = 0
            return result
        }
        width -= d.width
        
        return result
    }
    private func topGuide(height:inout CGFloat,index:Int)->CGFloat{
        let result = height
        guard index < itemCount - 1 else{
            height = 0
            return result
        }
        return result
    }
}



#Preview {
    struct A{
        var name:String
        var age:Int
    }
    let array = [
        A(name: "철수", age: 12),
        A(name: "짱짱짱짱짱구", age: 25),
        A(name: "철수", age: 12),
        A(name: "훈훈훈훈훈훈훈이", age: 25),
        A(name: "유유유유리", age: 25),
        A(name: "철수", age: 12),
        A(name: "훈훈훈훈훈훈훈이", age: 25),
        A(name: "유유유유리", age: 25),
        A(name: "짱짱짱짱짱구", age: 25),
        A(name: "철수", age: 12),
        A(name: "철수", age: 12),
        A(name: "철수", age: 12)
    ]
    return AutoSizingFlowLayoutView(items: array){ a in
        HStack{
            Text(a.name)
            Text("\(a.age)")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
