//
//  AllRankingView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/9/24.
//

import SwiftUI

struct AllRankingView: View {
    @State var filter:RankingCategory
    @State var type:WorkTypeCategory = .all
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = RankingViewModel(ranking: nil, popular: nil)
    
    var body: some View {
        VStack(spacing: 0){
            header
            ScrollView{
                typeFilterView
                contentsView
            }
        }
        .onAppear{
            vm.getRanking(ranking: RankingCache(id: filter.rawValue + type.rawValue, rankingType: filter, mediaType: type, maxPage: 1, currentPage: 1, list: []))
        }
        .foregroundColor(.black)
    }
}

#Preview {
    AllRankingView(filter: .all,vm:RankingViewModel(ranking: nil, popular: nil))
       
}

extension AllRankingView{
    var header:some View{
        VStack(spacing:0){
            HeaderView(backIcon: "chevron.left", text: "아이매드 차트"){
                dismiss()
            }
            .padding(10)
            .background(Color.white)
            filterView
            Divider()
        }
    }
    var filterView:some View{
        HStack{
            ForEach(RankingCategory.allCases,id:\.self) { ranking in
                Button {
                    self.filter = ranking
                    let ranking = RankingCache(id: ranking.rawValue + type.rawValue, rankingType: ranking, mediaType: type, maxPage: 1, currentPage: 1, list: [])
                    vm.getRanking(ranking: ranking)
                } label: {
                    Text(ranking.name)
                        .font(.GmarketSansTTFMedium(17))
                }
                .padding(.vertical,10)
                .frame(maxWidth:.infinity)
                .overlay{
                    if filter == ranking{
                        Capsule()
                            .frame(width:50,height: 2)
                            .offset(y:19)
                    }
                }
            }
        }
    }
    var typeFilterView:some View{
        ScrollView(.horizontal){
                HStack{
                    ForEach(WorkTypeCategory.allCases,id:\.self){ type in
                        Button {
                            self.type = type
                            let ranking = RankingCache(id: filter.rawValue + type.rawValue, rankingType: filter, mediaType: type, maxPage: 1, currentPage: 1, list: [])
                            vm.getRanking(ranking: ranking)
                        } label: {
                            Text(type.name)
                                .font(.GmarketSansTTFMedium(12))
                                .padding(7.5)
                                .padding(.horizontal)
                                .foregroundColor(self.type == type ? .white:.customIndigo)
                                .background {
                                    if self.type == type{
                                        Capsule()
                                            .foregroundColor(.customIndigo)
                                    }else{
                                        Capsule()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.customIndigo)
                                    }
                                }
                        }
                    }
                }
                .padding(10)
        }
    }
    @ViewBuilder
    var contentsView:some View{
        if let list = vm.ranking?.list{
            ForEach(list,id:\.self){ rank in
                NavigationLink {
                    WorkView(contentsId: rank.contentsID)
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing:0){
                        KFImageView(image: rank.posterPath.getImadImage(),width: 60,height: 75).cornerRadius(5)
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
                                Text(WorkTypeCategory.allCases.first(where: {$0.query == rank.contentsType})?.name ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .padding(.horizontal,10)
                        Spacer()
                        ScoreView(score: rank.imadScore ?? 0, color: .customIndigo, font: .caption, widthHeight: 50)
                            .padding(.trailing)
                    }
                }
                .cornerRadius(5)
                .padding(.leading,10)
                if list.last == rank,let ranking = vm.ranking, ranking.maxPage > ranking.currentPage{
                    ProgressView()
                        .onAppear{
                            vm.getRankingNextPage(nextPage: ranking.currentPage + 1, ranking: ranking)
                        }
                }
            }
        }
        
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
}
