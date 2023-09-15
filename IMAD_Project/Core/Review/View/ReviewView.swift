//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/14.
//

import SwiftUI

struct ReviewView: View {
    let work:WorkInfo
    var body: some View {
//        ForEach()
        VStack{
            Text("여긴 개망 다시 개발해야함")
            Text("리뷰 리스트")
            Text("이제 될dassdadsasdsd")
        }
       
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(work: CustomData.instance.workInfo)
    }
}
