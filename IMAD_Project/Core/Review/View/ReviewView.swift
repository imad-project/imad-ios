//
//  ReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/14.
//

import SwiftUI

struct ReviewView: View {
    
    let id:Int
    
    @State var tokenExpired = (false,"")
    @State var sort:ReviewSortFilter = .createdDate //정렬기준
    @State var order:ReviewOrderFilter = .ascending   //오름차순 - 0,내림차순 - 1
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ReviewViewModel()
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(vm.reviewList,id:\.self){ review in
                        NavigationLink {
                            ReviewDetailsView(reviewId: review.reviewID)
                                .environmentObject(vmAuth)
                                .navigationBarBackButtonHidden()
                        } label: {
                            ReviewListRowView(review: review)
                                .padding(.horizontal)
                                .background(Color.white)
                        }
                        if vm.reviewList.last == review,vm.reviewDetailsInfo?.totalElements != vm.reviewList.count{
                            ProgressView()
                                .environment(\.colorScheme, .light)
                                .onAppear{
                                    vm.readReviewList(id: id, page: (vm.reviewDetailsInfo?.pageNumber ?? 0) + 1, sort: sort.rawValue, order: order.rawValue)
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
        .onReceive(vm.tokenExpired) { messages in
            tokenExpired = (true,messages)
        }
        .alert(isPresented: $tokenExpired.0) {
            Alert(title: Text("토큰 만료됨"),message: Text(tokenExpired.1),dismissButton:.cancel(Text("확인")){
                vmAuth.loginMode = false
            })
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            vm.readReviewList(id: id, page: 0, sort: sort.rawValue, order: order.rawValue)
        }
        .onChange(of: sort){ newValue in    //정렬기준 바뀔 시
            vm.reviewList.removeAll()
            vm.readReviewList(id: id, page: 0, sort: newValue.rawValue, order: order.rawValue)
        }
        .onChange(of: order){ newValue in   //오름/내림차순 바뀔 시
            vm.reviewList.removeAll()
            vm.readReviewList(id: id, page: 0, sort: sort.rawValue, order: newValue.rawValue)
        }
        .onDisappear{
            vm.reviewList.removeAll()
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(id: 1)
            .environmentObject(AuthViewModel())
    }
}

extension ReviewView{
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
                        ForEach(ReviewSortFilter.allCases,id:\.self){
                            Text($0.name).font(.system(size: 20))
                            
                        }
                    }
                    .padding(.horizontal,7)
                    .overlay{
                        HStack{
                            Text(sort.name)
                            Image(systemName: "chevron.up.chevron.down")
                        }
                        .font(.caption2)
                        .padding(7)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                        .allowsHitTesting(false)
                        
                        
                    }
                    Picker("", selection: $order) {
                        ForEach(ReviewOrderFilter.allCases,id:\.self){
                            Text($0.name)
                        }
                    }
                    .padding(.horizontal,5)
                    .overlay{
                        HStack{
                            Text(order.name)
                            Image(systemName: "chevron.up.chevron.down")
                        }
                        .font(.caption2)
                        .padding(7)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                        .allowsHitTesting(false)
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
