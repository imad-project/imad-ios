//
//  TodayPopularView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/16/24.
//

import SwiftUI

struct TodayPopularView: View {
    
    let review:ReadReviewResponse?
    let posting:CommunityResponse?
    
    @State var currentOffset:CGFloat = .zero
    @State var endOffset:CGFloat = .zero
    @State private var viewSize: CGFloat = UIScreen.main.bounds.size.width
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                if let review,let posting {
                    HStack(spacing:10){
                        reviewView(review)
                        postingView(posting)
                    }
                    .padding(.horizontal,10)
                    .padding(.vertical)
                }
            }
            .onChange(of: geo.size) { viewSize = $0.width }
        }
        .offset(x:isWidth() ? 0:currentOffset)
        .highPriorityGesture(isWidth() ? nil:gesture)
        .frame(width: viewSize,height: isPad() ? 170 : 120,alignment: .leading)
        .environmentObject(vmAuth)
    }
}

#Preview {
    TodayPopularView(review: CustomData.review, posting: CustomData.community)
        .background(.white)
        .environmentObject(AuthViewModel(user: CustomData.user))
}

extension TodayPopularView{
    var gesture:some Gesture{
        DragGesture()
            .onChanged { gesture in
                currentOffset = endOffset + gesture.translation.width/2
            }.onEnded { gesture in
                let width:CGFloat = viewSize < 400 ? viewSize - 35 : viewSize - viewSize/1.5
                withAnimation {
                    if gesture.translation.width < -50{
                        if endOffset > -width{
                            endOffset -= width
                        }
                    }
                    if gesture.translation.width > 50{
                        if endOffset < 0{
                            endOffset += width
                        }
                    }
                    currentOffset = endOffset
                }
            }
    }
    func reviewView(_ review:ReadReviewResponse)->some View{
        NavigationLink {
            ReviewDetailsView(goWork: true, reviewId: review.reviewID, reported: review.reported)
                .navigationBarBackButtonHidden()
        } label: {
            PopularView(review: review)
                .shadow(radius: 1)
        }
    }
    func postingView(_ posting:CommunityResponse)->some View{
        NavigationLink {
            CommunityPostView(reported: posting.reported, postingId:posting.postingID,main: true,back: .constant(false))
                .navigationBarBackButtonHidden()
        } label: {
            PopularView(posting: posting)
                .shadow(radius: 1)
        }
    }
}
