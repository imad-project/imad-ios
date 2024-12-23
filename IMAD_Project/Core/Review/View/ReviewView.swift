//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/14.
//

import SwiftUI

struct ReviewView: View {
    
    let id:Int
    
    @State var sort:SortPostCategory = .createdDate //정렬기준
    @State var order:OrderPostCategory = .ascending   //오름차순 - 0,내림차순 - 1
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ReviewViewModel(review: nil, reviewList: [])
    
    var body: some View {
        VStack(spacing:0){
            filterHeader
            ScrollView {
                ForEach(vm.reviewList,id:\.self){ review in
                    NavigationLink {
                        ReviewDetailsView(goWork: false, reviewId: review.reviewID, reported: review.reported)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ReviewListRowView(review: review,my:false)
                            .background(Color.white)
                    }
                    if vm.reviewList.last == review,vm.maxPage > vm.currentPage{
                        ProgressView()
                            .environment(\.colorScheme, .light)
                            .onAppear{
                                vm.readReviewList(id: id, page: vm.currentPage + 1, sort: sort.rawValue, order: order.rawValue)
                            }
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
        }
        .foregroundColor(.black)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            vm.readReviewList(id: id, page: vm.currentPage, sort: sort.rawValue, order: order.rawValue)
        }
        .onChange(of: sort){ newValue in    //정렬기준 바뀔 시
            initializingArr()
            vm.readReviewList(id: id, page: vm.currentPage, sort: newValue.rawValue, order: order.rawValue)
        }
        .onChange(of: order){ newValue in   //오름/내림차순 바뀔 시
            initializingArr()
            vm.readReviewList(id: id, page: vm.currentPage, sort: sort.rawValue, order: newValue.rawValue)
        }
        .onDisappear{
           initializingArr()
        }
    }
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(id: 1,vm: ReviewViewModel(review:CustomData.review,reviewList: CustomData.reviewDetailList))
           
    }
}

extension ReviewView{
    
    func initializingArr(){
        vm.reviewList.removeAll()
        vm.maxPage = 0
        vm.currentPage = 1
    }
    var filterHeader:some View{
        VStack{
            VStack(spacing:10){
                HeaderView(backIcon: "chevron.left", text: "모든 리뷰"){
                    dismiss()
                }
                HStack{
                    Group{
                        Picker("", selection: $sort) {
                            ForEach(SortPostCategory.allCases,id:\.self){
                                Text($0.name).font(.system(size: 20))
                                
                            }
                        }
                        .padding(.horizontal,7)
                        .overlay{
                            HStack{
                                Text(sort.name)
                                Image(systemName: "chevron.up.chevron.down")
                            }
                            .modifier(CustomDatePicker())
                            
                        }
                        Picker("", selection: $order) {
                            ForEach(OrderPostCategory.allCases,id:\.self){
                                Text($0.name)
                            }
                        }
                        .padding(.horizontal,5)
                        .overlay{
                            HStack{
                                Text(order.name)
                                Image(systemName: "chevron.up.chevron.down")
                            }
                            .modifier(CustomDatePicker())
                        }
                    }
                    Spacer()
                }
            }.padding([.horizontal,.top],10)
            Divider()
        }
        .background(Color.white)
    }
    
}

struct CustomDatePicker:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.GmarketSansTTFMedium(12))
            .padding(5)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 2)
            .allowsHitTesting(false)
        
    }
}
