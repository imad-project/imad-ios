//
//  ExpandableTextView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/18.
//

import SwiftUI

struct ExpandableTextView: View {
    
    let text: String
    let maxLines: Int
    let font:UIFont.TextStyle
    let paddingTop:CGFloat
    
    @State private var expanded = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if expanded {
                    Text(text)
                        .lineLimit(nil)
                } else {
                    Text(text)
                        .lineLimit(maxLines)
                }
                Spacer()
            }
            .font(Font(UIFont.preferredFont(forTextStyle: font)))
            if shouldShowMoreButton{
                Button(action: {
                    withAnimation(.linear){
                        expanded.toggle()
                    }
                }, label: {
                    HStack{
                        Text(expanded ? "접기" : "더보기")
                        Image(systemName: expanded ? "chevron.up" : "chevron.down")
                    }.foregroundColor(.gray)
                        .font(.caption)
                   
                })
                .padding(.top,paddingTop)
            }
        }
    
    }
    private var shouldShowMoreButton:Bool {

        let textHeight = getHeightForText(text)
        let lineHeight = UIFont.preferredFont(forTextStyle: font).lineHeight
        let maxTextHeight = CGFloat(maxLines) * lineHeight
        return textHeight > maxTextHeight
    }

    private func getHeightForText(_ text: String) -> CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}

struct ExpandableTextView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableTextView(text: CustomData.instance.dummyString, maxLines: 5, font: .body, paddingTop: 20)
    }
}
