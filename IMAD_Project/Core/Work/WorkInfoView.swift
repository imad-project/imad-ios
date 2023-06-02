//
//  WorkInfoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkInfoView: View {
    let review:Review
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 10){
                Group{
                    Text("원재")
                        .bold()
                    Text("ジョジョの奇妙な冒険 ダイヤモンドは砕けない 第一章")
                        .padding(.bottom,5)
                        .font(.subheadline)
                    Text("국가")
                        .bold()
                    Text("일본")
                        .foregroundColor(.gray)
                        .padding(.bottom,5)
                        .font(.subheadline)
                }.padding(.leading)
                Group{
                    Text("장르").bold()
                    Text(review.genre)
                        .padding(.bottom,5)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("개요").bold()
                    Text(review.desc)
                        .padding(.bottom,5)
                        .font(.subheadline)
                    HStack{
                        VStack(alignment: .leading,spacing: 10){
                            Text("최초개봉일")
                                .bold()
                            Text("2017-08-04")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack(alignment: .leading,spacing: 10){
                            Text("상태")
                                .bold()
                            Text("개봉됨")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        Spacer()
                    }.padding(.bottom,5)
                }.padding(.leading)
                    Text("감독").bold().padding(.leading)
                    VStack{
                        KFImage(URL(string: "https://i.namu.wiki/i/AhZqffH5JK_cJmB5iJE-fIo0SbMCg8-cea10ZjQ949dnyRr_NulwRbTagcnkc6gpB73tZaxUxVE3kWPnNEoiuzk_1Y6eWZ6xbxZCJRbh3vX6MQZsJgZS_2GgMzXdj29DlZU0y1hJt4hos3pbpwAuwA.webp"))
                            .resizable()
                            .frame(width: 80,height: 80)
                            .clipShape(Circle())
                        Text("아무게")
                    }.padding(.bottom).padding(.leading)
                
                Text("출연진").bold().padding(.leading)
                
                ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                        ForEach(0...10,id:\.self){ _ in
                            VStack{
                                KFImage(URL(string: "https://i.namu.wiki/i/AhZqffH5JK_cJmB5iJE-fIo0SbMCg8-cea10ZjQ949dnyRr_NulwRbTagcnkc6gpB73tZaxUxVE3kWPnNEoiuzk_1Y6eWZ6xbxZCJRbh3vX6MQZsJgZS_2GgMzXdj29DlZU0y1hJt4hos3pbpwAuwA.webp"))
                                    .resizable()
                                    .frame(width: 80,height: 80)
                                    .clipShape(Circle())
                                Text("아무게")
                            }
                        }.padding(.leading)
                    }
                    
                }.padding(.bottom)
                
                
                Spacer()
            }
        }
        .foregroundColor(.black)
    }
}

struct WorkInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkInfoView(review: CustomData.instance.reviewList.first!)
    }
}
