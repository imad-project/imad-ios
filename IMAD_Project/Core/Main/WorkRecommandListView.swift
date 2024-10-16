//
//  WorkRecommandListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/15/24.
//

import SwiftUI

struct WorkRecommandListView: View {
    @State var draggedOffset:CGFloat = 0
    @State var endOffset:CGFloat = 0
    let title:String
    let filter:RecommendListType
    let workItems = [ GridItem(.fixed(220)), GridItem(.fixed(220))]
    @EnvironmentObject var vmAuth:AuthViewModel
    @EnvironmentObject var vmRecommend:RecommendViewModel
    
    var body: some View {
        VStack{
            let list = vmRecommend.workList(filter).list
            if !list.isEmpty{
                HStack(alignment:.bottom){
                    textTitleView(title)
                    allView(RecommendAllView(title: title, type: filter))
                }
                .padding(.horizontal,10)
                
                VStack{
                    HStack{
                        ForEach(0..<list.count/2,id: \.self) { index in
                            workView(list[index])
                        }
                    }
                    HStack{
                        ForEach(list.count/2..<list.count,id: \.self) { index in
                            workView(list[index])
                        }
                    }
                }
                .highPriorityGesture(drag)
                .offset(x:draggedOffset)
                .padding(.horizontal,10)
                .frame(width: mainWidth,alignment: .leading)
            }
        }
    }
}
#Preview {
    NavigationView{
        ScrollView(showsIndicators: false){
            WorkRecommandListView(title: "ㅇㅇㅇㅇ", filter: .imadTv)
                .environmentObject(RecommendViewModel(recommendAll: CustomData.recommandAll))
                .environmentObject(AuthViewModel(user: CustomData.user))
        }
    }
}

extension WorkRecommandListView{
    var drag:some Gesture{
        DragGesture()
            .onChanged { gesture in
                draggedOffset = endOffset + gesture.translation.width/2
            }
            .onEnded { gesture in
                let cell = 137.5
                withAnimation {
                    if gesture.translation.width < -50{
                        if endOffset > -cell * 7{
                            endOffset -= cell
                        }
                    }
                    if gesture.translation.width > 50{
                        if endOffset < 0{
                            endOffset += cell
                        }
                    }
                    draggedOffset = endOffset
                }
            }
    }
    func workView(_ work:WorkGenre)->some View{
        NavigationLink {
            WorkView(id: work.id(),type: filter.type.rawValue)
                .navigationBarBackButtonHidden()
        } label: {
            VStack(spacing:5){
                KFImageView(image: work.posterPath()?.getImadImage() ?? "",width: 130,height: 180)
                    .cornerRadius(5)
                Group{
                    Text((filter.type == .tv ? work.name() : work.title()) ?? "")
                        .font(.GmarketSansTTFMedium(12))
                        .foregroundColor(.black)
                    Text(work.genreType == .tv ? work.genreId()?.transTvGenreCode() ?? "" : work.genreId()?.transMovieGenreCode() ?? "")
                        .font(.GmarketSansTTFMedium(9))
                        .foregroundColor(.gray)
                }
                .lineLimit(1)
                .frame(width: 130)
            }
        }
    }
    func textTitleView(_ text:String) -> some View{
        HStack{
            Text(text)
                .fontWeight(.black)
                .font(.custom("GmarketSansTTFMedium", size: 20))
                .foregroundColor(.customIndigo)
            Spacer()
        }
        .padding(.bottom,5)
    }
}
