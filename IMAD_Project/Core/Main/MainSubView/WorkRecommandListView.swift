//
//  WorkRecommandListView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/15/24.
//

import SwiftUI
import Kingfisher

struct WorkRecommandListView: View {
    @State var draggedOffset:CGFloat = 0
    @State var endOffset:CGFloat = 0
    let filter:RecommendFilter
    let workItems = [ GridItem(.fixed(220)), GridItem(.fixed(220))]
    @StateObject var view = ViewManager.instance
    @EnvironmentObject var vmRecommend:RecommendViewModel
    
    var list:[RecommendResponse]{
        vmRecommend.workList(filter).list
    }
    var body: some View {
        VStack{
            if !list.isEmpty{
                HStack(alignment:.bottom){
                    textTitleView(filter.title)
                    allView(AllRecommendView(type: filter))
                }
                .padding(.horizontal,10)
                workListView
            }
        }
        .padding(.bottom,10)
    }
}
#Preview {
    NavigationView{
        ScrollView(showsIndicators: false){
            WorkRecommandListView(filter: .genreTv)
                .environmentObject(RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: nil))
        }
    }
}

extension WorkRecommandListView{
    func workView(_ work:RecommendResponse)->some View{
        Button{
            view.move(id: work.id,type: filter.type.rawValue)
        } label: {
            VStack(spacing:5){
                KFImageView(image: work.posterPath?.getImadImage() ?? "",width: isPad ? 200:130,height: isPad ? 260:180)
                    .cornerRadius(5)
                Group{
                    Text((filter.type == .tv ? work.name : work.title) ?? "")
                        .font(.GmarketSansTTFMedium(isPad ? 20:12))
                        .foregroundColor(.black)
                    Text(work.genreType == .tv ? work.genreIds?.transTvGenreCode() ?? "" : work.genreIds?.transMovieGenreCode() ?? "")
                        .font(.GmarketSansTTFMedium(isPad ? 15:9))
                        .foregroundColor(.gray)
                }
                .lineLimit(1)
                .frame(width: isPad ? 200:130)
            }
        }
    }
    var workListView:some View{
        ScrollView(.horizontal,showsIndicators: false){
            LazyHGrid(rows: [GridItem(),GridItem()]){
                ForEach(0..<list.count,id: \.self) { index in
                    workView(list[index])
                }
            }
            .padding(.horizontal,10)
        }
    }
}
