//
//  CropView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI

struct CropView: View {
    var image:UIImage?
    var onCrop:(UIImage?,Bool)->()
    var body: some View {
        VStack{
            Text("asdashdasd")
        }
    }
}

#Preview {
    CropView(image:UIImage(named: "happy")){ _,_ in
        
    }
}
