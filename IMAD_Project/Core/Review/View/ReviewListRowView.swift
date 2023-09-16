//
//  ReviewListRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/15.
//

import SwiftUI
import Kingfisher

struct ReviewListRowView: View {
    let review:ReviewDetailsResponseList
    @State var isExtend = false
    @State var anima = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == (review.userProfileImage ?? 1)})?.rawValue ?? "soso")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 40,height: 40)
                Text(review.userNickname ?? "평론가\(Int.random(in: 0...10))")
                    .font(.subheadline)
                    .bold()
                Spacer()
                Text(review.createdAt ?? "")
                    .foregroundColor(.gray)
                    .font(.caption)
                
            }
            .padding(.bottom,5)
            
            
            HStack{
                VStack(alignment: .leading) {
                    Text(review.title ?? "").bold()
                        .padding(.vertical)
                        .font(.subheadline)
                    Text(review.content ?? "" )
                        .font(.caption)
                        .lineLimit(5)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom,5)
                        .padding(.horizontal,5)
                }
                
                Spacer()
                VStack{
                    Circle()
                        .trim(from: 0.0, to: anima ? (review.score ?? 0) * 0.1 : 0)
                        .stroke(lineWidth: 3)
                        .rotation(Angle(degrees: 270))
                        .frame(width: 50,height: 50)
                        .overlay{
                            VStack{
                                Image(systemName: "star.fill")
                                Text(String(format: "%0.1f", (review.score ?? 0)))
                            }
                            .font(.caption)
                            Circle().stroke(lineWidth:0.1)
                        }
                        .shadow(radius: 20)
                        .padding(.bottom)
                    HStack(spacing: 15){
                        Text("🥰" + "\(review.likeCnt ?? 0)")
                        Text("😢" + "\(review.dislikeCnt ?? 0)")
                    }
                    .font(.subheadline)
                }.padding(.horizontal)
            }
            
        }
        .onAppear{
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
            
        }
        
    }
    
}

struct ReviewListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListRowView(review: CustomData.instance.reviewDetail[1])
    }
}