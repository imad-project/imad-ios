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
    @State var ranking:RankingFilter = .all
    @EnvironmentObject var vmRanking:RankingViewModel
    
    var body: some View {
        VStack(alignment:.leading,spacing:5){
            if let list = vmRanking.ranking?.list.chunks(ofCount: 3){
                filter
                rankingView(list)
            }
        }
    }
    var drag:some Gesture{
        DragGesture()
            .onChanged { gesture in
                draggedOffset = endOffset + gesture.translation.width/2
            }
            .onEnded { gesture in
                let cell:CGFloat = isWidth() ? 627.5 : 327.5
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
                ForEach(RankingFilter.allCases,id:\.self){ ranking in
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
                        .frame(width: 60,height: 25)
                        .padding(.vertical,5)
                        .overlay {
                            Text(ranking.name)
                                .font(.custom("GmarketSansTTFMedium", size: 11))
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
    func rankingView(_ list:[[RankingResponseList]])->some View{
        HStack{
            ForEach(list.prefix(3),id:\.self){ columns in
                VStack{
                    ForEach(columns,id:\.self){ rank in
                        NavigationLink {
                            WorkView(contentsId:rank.contentsID)
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack(spacing:0){
                                KFImageView(image: rank.posterPath.getImadImage(),width: 60,height: 75).cornerRadius(5)
                                    .shadow(radius: 1)
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("\(rank.ranking)")
                                            .font(.GmarketSansTTFMedium(15))
                                            .bold()
                                        Text(rank.title)
                                            .frame(width: 100,alignment: .leading)
                                            .lineLimit(1)
                                            .font(.GmarketSansTTFMedium(12))
                                    }
                                    .foregroundColor(.black)
                                    .padding(.bottom,3)
                                    HStack{
                                        rankUpdateView(rank: rank.rankingChanged)
                                        Text(TypeFilter.allCases.first(where: {$0.query == rank.contentsType})?.name ?? "")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                .padding(.horizontal,10)
                                Spacer()
                                ScoreView(score: rank.imadScore ?? 0, color: .customIndigo, font: .caption, widthHeight: 50)
                                    .padding(.trailing)
                            }
                            .frame(width: isWidth() ? 600 : 300,height: 75)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            .padding(.horizontal,10)
                        }
                    }
                }
                
            }
        }
        .frame(width: mainWidth,alignment: .leading)
        .offset(x:draggedOffset)
        .highPriorityGesture(drag)
    }
}

#Preview {
    let ranking = RankingCache(id: "", rankingType: .all, mediaType: .all, maxPage: 1, currentPage: 1, list: CustomData.rankingList)
    return RankingView()
        .background(.white)
        .environmentObject(RankingViewModel(ranking:ranking, popular: nil))
}
