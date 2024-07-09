//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/14.
//

import SwiftUI

struct ReviewView: View {
    
    let id:Int
    
    @State var sort:SortFilter = .createdDate //정렬기준
    @State var order:OrderFilter = .ascending   //오름차순 - 0,내림차순 - 1
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = ReviewViewModel(review: nil, reviewList: [])
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(vm.reviewList,id:\.self){ review in
                        NavigationLink {
                            ReviewDetailsView(goWork: false, reviewId: review.reviewID)
                                .environmentObject(vmAuth)
                                .navigationBarBackButtonHidden()
                        } label: {
                            ReviewListRowView(review: review,my:false)
                                .padding(.horizontal)
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
                    .padding(.bottom)
                    .background(Color.gray.opacity(0.1))
                } header: {
                    filterHeader
                }
                
            }
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
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
        .onReceive(vm.refreschTokenExpired){
            vmAuth.logout(tokenExpired: true)
        }
        .onDisappear{
           initializingArr()
        }
    }
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(id: 1,vm: ReviewViewModel(review:CustomData.instance.review,reviewList: CustomData.instance.reviewDetail))
            .environmentObject(AuthViewModel(user:UserInfo(status: 1,data: CustomData.instance.user, message: "")))
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
            Text("모든 리뷰")
                .frame(maxWidth: .infinity)
                .bold()
                .overlay(alignment: .leading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                }
            HStack{
                HStack{
                    Image(systemName: "slider.horizontal.3")
                    Text("정렬기준 :")
                }.bold().padding(.trailing,5).font(.caption)
                
                Group{
                    Picker("", selection: $sort) {
                        ForEach(SortFilter.allCases,id:\.self){
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
                        ForEach(OrderFilter.allCases,id:\.self){
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
            }.padding(.vertical,5)
            Divider()
        }
        .padding(.horizontal)
        .padding(.top,60)
        .background(Color.white)
    }
    
}

struct CustomDatePicker:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(7)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 2)
            .allowsHitTesting(false)
        
    }
}
