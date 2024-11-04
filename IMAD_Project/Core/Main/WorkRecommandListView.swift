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
    let title:String
    let filter:RecommendListType
    let workItems = [ GridItem(.fixed(220)), GridItem(.fixed(220))]
    @EnvironmentObject var vmAuth:AuthViewModel
    @EnvironmentObject var vmRecommend:RecommendViewModel
    
    var list:[WorkGenre]{
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
            WorkRecommandListView(title: "ㅇㅇㅇㅇ", filter: .genreTv)
                .environmentObject(RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: []))
                .environmentObject(AuthViewModel(user: CustomData.user))
        }
    }
}

extension WorkRecommandListView{
    func workView(_ work:WorkGenre)->some View{
        NavigationLink {
            WorkView(id: work.id,type: filter.type.rawValue)
                .navigationBarBackButtonHidden()
        } label: {
            VStack(spacing:5){
                KFImageView(image: work.posterPath?.getImadImage() ?? "",width: 130,height: 180)
                    .cornerRadius(5)
                Group{
                    Text((filter.type == .tv ? work.name : work.title) ?? "")
                        .font(.GmarketSansTTFMedium(12))
                        .foregroundColor(.black)
                    Text(work.genreType == .tv ? work.genreId?.transTvGenreCode() ?? "" : work.genreId?.transMovieGenreCode() ?? "")
                        .font(.GmarketSansTTFMedium(9))
                        .foregroundColor(.gray)
                }
                .lineLimit(1)
                .frame(width: 130)
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
