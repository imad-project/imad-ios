//
//  UserActivityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/16/24.
//

import SwiftUI

struct UserActivityView: View {
    let list:[RecommendListType] = [.activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie]
    @EnvironmentObject var vmRecommend:RecommendViewModel
    @EnvironmentObject var vmAuth:AuthViewModel
    var listIsEmpty:Bool{
        !vmRecommend.workList(.activityMovie).list.isEmpty ||
        !vmRecommend.workList(.activityTv).list.isEmpty ||
        !vmRecommend.workList(.activityAnimationTv).list.isEmpty ||
        !vmRecommend.workList(.activityAnimationMovie).list.isEmpty
    }
    var body: some View {
        VStack(alignment: .leading){
            if listIsEmpty{
                titleView
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ListView(items:list){ posterView($0) }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    UserActivityView()
        .background(.white)
        .environmentObject(RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: []))
        .environmentObject(AuthViewModel(user: CustomData.user))
}

extension UserActivityView{
    var titleView:some View{
        HStack{
            Text("\(vmAuth.user?.nickname ?? "")님을 위한 작품")
                .fontWeight(.black)
                .font(.custom("GmarketSansTTFMedium", size: 20))
                .foregroundColor(.customIndigo)
            Spacer()
        }
        .padding(.bottom,5)
        .padding(.horizontal)
    }
    @ViewBuilder
    func posterView(_ work:RecommendListType) -> some View{
        let list = vmRecommend.workList(work).list
        let contentsId = vmRecommend.workList(work).contentsId
        if !list.isEmpty{
            VStack(alignment: .leading){
                Text("\(work.name)")
                NavigationLink {
                    RecommendAllView(contentsId:contentsId,title: work.name, type: work)
                        .environmentObject(vmAuth)
                        .navigationBarBackButtonHidden()
                } label: {
                    GridView(room: 2, imageList: list.prefix(4).map{$0.posterPath ?? ""})
                        .frame(width: 180,height: 240)
                        .overlay{
                            Color.black.opacity(0.3)
                            HStack{
                                Text("전체보기")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .frame(maxHeight: .infinity,alignment: .bottom)
                            .padding(5)
                        }
                        .cornerRadius(10)
                }
            }
            .shadow(radius: 1)
            .font(.GmarketSansTTFBold(isPad() ? 22.5 : 17.5))
            .foregroundColor(.black)
            .padding(.vertical,1)
        }
        
    }
}
