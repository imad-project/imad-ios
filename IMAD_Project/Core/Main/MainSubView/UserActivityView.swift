//
//  UserActivityView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/16/24.
//

import SwiftUI

struct UserActivityView: View {
    let list:[RecommendCategory] = [.activityTv,.activityMovie,.activityAnimationTv,.activityAnimationMovie]
    @StateObject var user = UserInfoManager.instance
    @EnvironmentObject var vmRecommend:RecommendViewModel
    
    var listIsEmpty:Bool{
        !vmRecommend.workList(.activityMovie).list.isEmpty ||
        !vmRecommend.workList(.activityTv).list.isEmpty ||
        !vmRecommend.workList(.activityAnimationTv).list.isEmpty ||
        !vmRecommend.workList(.activityAnimationMovie).list.isEmpty
    }
    var body: some View {
        VStack(alignment: .leading){
            if listIsEmpty{
                textTitleView("\(user.cache?.nickname ?? "")님을 위한 작품")
                    .padding(.leading,10)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ListView(items:list){ posterView($0) }
                    }
                    .padding(.horizontal,10)
                }
            }
        }
        .padding(.vertical)
        .padding(.top)
    }
}

#Preview {
    UserActivityView()
        .background(.white)
        .environmentObject(RecommendViewModel(recommendAll: CustomData.recommandAll, recommendList: nil))
}

extension UserActivityView{
    @ViewBuilder
    func posterView(_ work:RecommendCategory) -> some View{
        let list = vmRecommend.workList(work).list
        let contentsId = vmRecommend.workList(work).contentsId
        if !list.isEmpty{
            VStack(alignment: .leading){
                Text("\(work.name)")
                NavigationLink {
                    AllRecommendView(contentsId:contentsId,title: work.name, type: work)
                        .navigationBarBackButtonHidden()
                } label: {
                    GridView(maintenanceRate:!isPad, room:isPad ? 4:2, imageList: list.prefix(isPad ? 8 : 4).map{$0.posterPath ?? ""})
                        .frame(width:isPad ? 360:180,height: 240)
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
            .font(.GmarketSansTTFBold(isPad ? 22.5 : 17.5))
            .foregroundColor(.black)
            .padding(.vertical,1)
        }
        
    }
}
