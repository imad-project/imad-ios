//
//  MyReviewView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/19.
//

import SwiftUI

struct MyReviewView: View {
    
    @State var page = 1
    @StateObject var vm = ReviewViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            header
            ScrollView {
                item
            }
            
        }
        .foregroundColor(.black)
        .background(Color.white)
        .onAppear{
            vm.myReviewList(page: page)
        }
    }
}

struct MyReviewView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewView()
    }
}

extension MyReviewView{
    var header:some View{
        ZStack{
            HStack{
                Button {
                   dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding()
                        
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .bold()
                        .padding()
                }
            }
            Text("내 리뷰")
                .font(.title3)
                .bold()
        }
    }
    var item:some View{
        ForEach(vm.myReviewList,id:\.self){ item in
            Divider().padding(.vertical)
            NavigationLink {
                ReviewDetailsView(reviewId: item.reviewID)
                    .environmentObject(vmAuth)
                    .navigationBarBackButtonHidden()
            } label: {
                MyReviewListRowView(review: item)
                    .padding(.horizontal)
            }
            if vm.myReviewList.count > 10{
                ProgressView()
                    .onAppear{
                        page += 1
                        vm.myReviewList(page: page)
                    }
            }
        }
    }
}
