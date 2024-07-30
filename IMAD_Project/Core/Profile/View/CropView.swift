//
//  CropView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/5/24.
//

import SwiftUI
struct CropView: View {
    
    
    @State var endOffset = CGSize.zero
    @State var currentOffset = CGSize.zero
    
    @State var currentScale:CGFloat = 0
    @State var endScale:CGFloat = 0
    
    @State var appearGrid = false
    @GestureState var changed = false
    
    @Binding var image:UIImage?
    var onCrop:(UIImage?,Bool)->()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.white.ignoresSafeArea()
            Color.black.opacity(0.9).ignoresSafeArea()
            imageView()
            header
        }
    }
    
    var header: some View{
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
                        Task{
                            await dismissEvent()
                        }
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
    @ViewBuilder
    func imageView(_ hideGrids:Bool = false)->some View{
        ZStack{
            Color.black.opacity(0.7).ignoresSafeArea()
            GeometryReader{ geo in
                let g = geo.frame(in: .named("G"))
                if let image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxHeight: .infinity)
                        .onChange(of: changed) { change in
                            withAnimation(.easeIn(duration: 0.1)){
                                if g.minX > 0{
                                    currentOffset.width = currentOffset.width - g.minX
                                }
                                if g.minY > 0{
                                    currentOffset.height = currentOffset.height - g.minY
                                }
                                if g.maxX < mainWidth{
                                    currentOffset.width = g.minX - currentOffset.width
                                }
                                if g.maxY < mainWidth{
                                    currentOffset.height = g.minY - currentOffset.height
                                }
                                if !change{
                                    endOffset = currentOffset
                                }
                                withAnimation(.easeInOut(duration: 0.5)){
                                    appearGrid.toggle()
                                }
                            }
                        }
                }
                
            }
            .scaleEffect(currentScale + 1)
            .offset(currentOffset)
            .gesture(drag)
            .gesture(pinch)
            .frame(width: mainWidth,height: mainWidth)
            .coordinateSpace(name: "G")
            .mask{
                ZStack {
                    Rectangle()
                        .opacity(0.5)
                    Circle()
                }
            }
            .overlay {
                if appearGrid{
                    Grids()
                }
            }
            
        }
    }
    var drag:some Gesture{
        DragGesture()
            .updating($changed){ _,changed,_ in
                changed = true
            }
            .onChanged{ gesture in
                currentOffset = endOffset + gesture.translation
            }
    }
    var pinch:some Gesture{
        MagnificationGesture()
            .updating($changed){ _,changed,_ in
                changed = true
            }
            .onChanged { gesture in
                currentScale = gesture + endScale - 1
            }
            .onEnded { gesture in
                withAnimation(.easeIn(duration: 0.1)){
                    endScale = endScale + gesture - 1
                    if endScale + 1 < 1 || endScale + 1 > 3{
                        currentScale = 0
                        endScale = 0
                    }
                }
            }
        
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
    @MainActor
    func dismissEvent(){
        let renderer = ImageRenderer(content: imageView(true))
        renderer.proposedSize = .init(CGSize(width: isPad() ? 500 : mainWidth, height: isPad() ? 500 : mainWidth))
        if let image = renderer.uiImage{
            onCrop(image,true)
        }else{
            onCrop(nil,false)
        }
        dismiss()
    }
}

#Preview {
    CropView(image:.constant(UIImage(named: "indigo"))){ _,_ in
        
    }
}
