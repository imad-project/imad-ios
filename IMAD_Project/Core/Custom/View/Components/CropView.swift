//
//  CropView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI
struct CropView: View {
    
    
    @State var scale:CGFloat = 1
    @State var lastScale:CGFloat = 0
    @State var offset:CGSize = .zero
    @State var lastStoreOffset:CGSize = .zero
    @State var appearGrid = false
    @GestureState var isInteracting:Bool = false
    
    @Binding var image:UIImage?
    var onCrop:(UIImage?,Bool)->()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            Color.black.opacity(0.9).ignoresSafeArea()
            imageView()
                .mask(alignment: .center) {
                        ZStack {
                            Rectangle()
                                .opacity(0.5)
                            Circle()
                        }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            ZStack{
                Group{
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        Spacer()
                        Button {
                            let renderer = ImageRenderer(content: imageView(true).clipShape(Circle()))
                            renderer.proposedSize = .init(CGSize(width: isPad() ? 500 : mainWidth, height: isPad() ? 500 : mainWidth))
                            if let image = renderer.uiImage{
                                onCrop(image,true)
                            }else{
                                onCrop(nil,false)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                    Text("사진 자르기")
                    
                }
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth:.infinity)
                .padding()
            }
            .background{
                Color.white.ignoresSafeArea()
                Color.black.opacity(0.9).ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    func imageView(_ hideGrids:Bool = false)->some View{
        let cropSize = CGSize(width: isPad() ? 500 : mainWidth, height: isPad() ? 500 : mainWidth)
        GeometryReader { geometry in
            let size = geometry.size
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .overlay{
                        GeometryReader{ proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            Color.clear
                                .onChange(of: isInteracting){ newValue in
                                    withAnimation(.easeInOut(duration: 0.2)){
                                        if rect.minX > 0{
                                            offset.width = (offset.width - rect.minX)
                                            haptics(.medium)
                                        }
                                        if rect.minY > 0{
                                            offset.height = (offset.height-rect.minY)
                                            haptics(.medium)
                                        }
                                        if rect.maxX < size.width{
                                            offset.width = (rect.minX - offset.width)
                                            haptics(.medium)
                                        }
                                        if rect.maxY < size.height{
                                            offset.height = (rect.minY - offset.height)
                                            haptics(.medium)
                                        }
                                    }
                                    if !newValue{
                                        lastStoreOffset = offset
                                    }
                                    withAnimation(.easeInOut(duration: 0.5)){
                                        appearGrid.toggle()
                                    }
                                    
                                }
                        }
                    }
                    .frame(size)
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        
        .overlay {
            if !hideGrids{
                if appearGrid{
                    Grids()
                }
            }
        }
        .coordinateSpace(name:"CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting){_,out,_ in
                    out = true
                }
                .onChanged{ value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoreOffset.width, height: translation.height + lastStoreOffset.height)
                }
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting){_,out,_ in
                    out = true
                }.onChanged{ value in
                    let updatedScale = value + lastScale
                    scale = (updatedScale < 1 ? 1:updatedScale)
                }
                .onEnded{ value in
                    withAnimation(.default){
                        if scale < 1{
                            scale = 1
                            lastScale = 0
                        }else{
                            lastScale = scale-1
                        }
                    }
                }
        )
        .frame(cropSize)
        
       
    }
    @ViewBuilder
    func Grids()->some View{
        ZStack{
            HStack{
                ForEach(1...4,id: \.self){ _ in
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 1)
                        .frame(maxWidth:.infinity)
                    
                }
            }
            VStack{
                ForEach(1...4,id: \.self){ _ in
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 1)
                        .frame(maxHeight:.infinity)
                    
                }
            }
        }
    }
}

#Preview {
    CropView(image:.constant(UIImage(named: "happy"))){ _,_ in
        
    }
}
