//
//  RankingView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/16/24.
//

import SwiftUI

struct RankingView: View {
    @State var draggedOffset:CGFloat = 0
    @State var endOffset:CGFloat = 0
    @State var ranking:RankingCategory = .all
    @State private var screenSize: CGSize = UIScreen.main.bounds.size
    @StateObject var view = ViewManager.instance
    @EnvironmentObject var vmRanking:RankingViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment:.leading,spacing:5){
                if let list = vmRanking.ranking?.list.maintenanceChunks(ofCount: 3){
                    filter
                    rankingView(list)
                }
            }
            .onChange(of: geometry.size) { screenSize = $0 }
        }
        .frame(height: isPad ? 420:300)
    }
    var drag:some Gesture{
        DragGesture()
            .onChanged { gesture in
                draggedOffset = endOffset + gesture.translation.width/2
            }
            .onEnded { gesture in
                let cell:CGFloat = isPad ? 577.5:327.5
                withAnimation {
                    if gesture.translation.width < -50{
                        if endOffset > -cell{
                            endOffset -= cell
                        }else if endOffset == -cell{
                            endOffset -= cell
                            endOffset += (mainWidth-cell)+5
                        }
                    }
                    if gesture.translation.width > 50{
                        if endOffset < 0{
                            if endOffset == (-cell*2)+mainWidth-cell+5{
                                endOffset -= mainWidth-cell+5
                            }
                            endOffset += cell
                        }
                    }
                    draggedOffset = endOffset
                }
            }
    }
    
    var filter:some View{
        VStack(alignment: .leading,spacing: 0){
            textTitleView("아이매드 차트")
            HStack(spacing: 5){
                ForEach(RankingCategory.allCases,id:\.self){ ranking in
                    Button {
                        self.ranking = ranking
                        vmRanking.ranking?.id = ranking.rawValue + "all"
                        vmRanking.ranking?.rankingType = ranking
                        guard let ranking  = vmRanking.ranking else { return }
                        vmRanking.getRanking(ranking: ranking)
                    } label: {
                        Group{
                            if self.ranking == ranking{
                                Capsule()
                            }else{
                                Capsule()
                                    .stroke(lineWidth: 1)
                            }
                        }
                        .foregroundColor(.customIndigo)
                        .frame(width:isPad ? 120:60,height:isPad ? 35: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text(ranking.name)
                                .font(.GmarketSansTTFMedium(isPad ? 17:11))
                                .foregroundColor(self.ranking == ranking ? .white : .customIndigo)
                        }
                    }
                }
                Spacer()
                allView(AllRankingView(filter: ranking))
            }
        }
        .font(.caption)
        .padding(.horizontal,10)
    }
    func rankUpdateView(rank:Int?) -> some View{
        HStack(spacing:2){
            if let rank,rank != 0{
                Group{
                    Image(systemName:rank > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    Text(rank > 0 ? "\(rank)":"\(abs(rank))")
                }
                .font(.caption2)
                .foregroundStyle(rank > 0 ? .green : .red)
            }else{
                Text("-").foregroundColor(.gray)
            }
        }
    }
    func rankingView(_ list:[[RankingResponse]])->some View{
        HStack{
            ForEach(list.prefix(3),id:\.self){ columns in
                VStack{
                    ForEach(columns,id:\.self){ rank in
                        Button {
                            view.move(type: .workViewC(contentsId: rank.contentsID))
                        } label: {
                            HStack(spacing:0){
                                KFImageView(image: rank.posterPath.getImadImage(),width: isPad ? 80:60,height:isPad ? 110:75).cornerRadius(5)
                                    .shadow(radius: 1)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("\(rank.ranking)")
                                            .font(.GmarketSansTTFMedium(isPad ? 20:15))
                                            .bold()
                                        Text(rank.title)
                                            .frame(width: 100,alignment: .leading)
                                            .lineLimit(1)
                                            .font(.GmarketSansTTFMedium(isPad ? 18:12))
                                    }
                                    .foregroundColor(.black)
                                    .padding(.bottom,3)
                                    HStack{
                                        rankUpdateView(rank: rank.rankingChanged)
                                        Text(WorkTypeCategory.allCases.first(where: {$0.query == rank.contentsType})?.name ?? "")
                                            .font(isPad ? .subheadline:.caption)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                .padding(.horizontal,10)
                                Spacer()
                                ScoreView(score: rank.imadScore ?? 0, color: .customIndigo, font: isPad ? .subheadline:.caption, widthHeight: isPad ? 70:50)
                                    .padding(.trailing)
                            }
                            .frame(width:isPad ? (isWidth ? mainWidth/3 - 25 : 550):300,height: isPad ? 110:75)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            .padding(.horizontal,10)
                        }
                    }
                }
                
            }
        }
        .frame(width:screenSize.width,alignment: .leading)
        .offset(x:draggedOffset)
        .highPriorityGesture(isWidth ? nil : drag)
    }
}

#Preview {
    let ranking = RankingCache(id: "", rankingType: .all, mediaType: .all, maxPage: 1, currentPage: 1, list: CustomData.rankingList)
    return RankingView()
        .background(.white)
        .environmentObject(RankingViewModel(ranking:ranking, popular: nil))
}
