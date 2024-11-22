//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/14.
//

import SwiftUI

struct ReviewView: View {
    let id:Int  //직품ID
    @State var sort:SortPostCategory = .createdDate //정렬기준 - 평점/날짜/좋아요/싫어요
    @State var order:OrderPostCategory = .ascending //오름차순 - 0,내림차순 - 1
    @StateObject var vmReview = ReviewViewModel(review:nil,reviewList:nil)
    @StateObject var view = ViewManager.instance
    
    var body: some View {
        VStack(spacing:0){
            headerView
            listView
        }
        .foregroundColor(.black)
        .background(Color.white.ignoresSafeArea())
        .onAppear{ vmReview.getReviewList(id:id,page:1,sort:sort.rawValue,order:order.rawValue,review:ReviewCache()) }
        .onChange(of:sort){ vmReview.getReviewList(id:id,page:1,sort:$0.rawValue,order:order.rawValue,review:ReviewCache()) }
        .onChange(of:order){ vmReview.getReviewList(id:id,page:1,sort:sort.rawValue,order:$0.rawValue,review:ReviewCache()) }
    }
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        return ReviewView(id:1,vmReview:ReviewViewModel(review:CustomData.review,reviewList:ReviewCache(list:CustomData.reviewDetailList)))
    }
}

extension ReviewView{
    var headerView:some View{
        VStack(spacing:10){
            HeaderView(backIcon: "chevron.left", text: "모든 리뷰"){ view.back() }
            HStack{
                pickerView(items:$sort,list:SortPostCategory.allCases,text:sort.name)
                pickerView(items:$order,list:OrderPostCategory.allCases,text:order.name)
                Spacer()
            }
        }
        .padding([.horizontal,.top],10)
        .background(Color.white)
    }
    var listView:some View{
        ScrollView{
            if let list = vmReview.reviewList{
                VStack(spacing: 0){
                    ForEach(list.list,id:\.self){ review in
                        Divider()
                        Button {
                            view.move(type:.reviewDetailsView(goWork:false,reviewId:review.reviewID))
                        } label: {
                            ReviewListRowView(review: review,my:false)
                                .background(Color.white)
                        }
                        if list.list.last == review,list.maxPage > list.currentPage{
                            ProgressView()
                                .onAppear{
                                    vmReview.getReviewListNextPage(nextPage:list.currentPage+1,id:list.id,sort:sort.rawValue,order:order.rawValue,review:list)
                                }
                        }
                    }
                }
            }
        }
        .background(Color.white1)
    }
    func pickerView<T:Hashable>(items:Binding<T>,list:[any CaseIterable],text:String)->some View{
        Picker("", selection:items) {
            if let sortList = list as? [SortPostCategory]{
                ForEach(sortList,id:\.self){
                    Text($0.name).font(.system(size: 20))
                }
            }
            if let orderList = list as? [OrderPostCategory]{
                ForEach(orderList,id:\.self){
                    Text($0.name).font(.system(size: 20))
                }
            }
        }
        .padding(.horizontal,7)
        .overlay {
            HStack{
                Text(text)
                Image(systemName: "chevron.up.chevron.down")
            }
            .modifier(CustomPicker())
        }
    }
}

struct CustomPicker:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.GmarketSansTTFMedium(12))
            .padding(1)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 2)
            .allowsHitTesting(false)
    }
}
