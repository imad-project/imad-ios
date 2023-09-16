//
//  ReviewDetailsView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import SwiftUI
import Kingfisher

struct ReviewDetailsView: View {
    
    let review:ReviewDetailsResponseList
    @State var like = 0
    @State var anima = false
    @State var menu = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading,pinnedViews: [.sectionHeaders]) {
                Section {
                    HStack{
                        Image(ProfileFilter.allCases.first(where: {$0.num == review.userProfileImage ?? 1})?.rawValue ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30,height: 30)
                            .clipShape(Circle())
                        Text(review.userNickname ?? "")
                        Spacer()
                        Text(review.createdAt ?? "")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .padding()
                    VStack(alignment: .leading){
                        
                        HStack{
                            KFImage(URL(string: review.contentsPosterPath?.getImadImage() ?? ""))
                                .resizable()
                                .frame(width: 80,height: 120)
                                .scaledToFill()
                                .cornerRadius(10)
                            VStack(alignment: .leading){
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
                                HStack{
                                    Text(review.contentsTitle ?? "").bold().font(.subheadline)
                                    Text(review.spoiler ? "스포일러" : "클린")
                                        .font(.caption)
                                        .padding(2)
                                        .padding(.horizontal)
                                        .background(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                                }
                                
                            }
                            .padding(.leading)
                        }.padding(.bottom)
                        Text(review.title ?? "").bold().font(.title3)
                            .padding(.bottom)
                        Text(review.content ?? "")
                            .font(.subheadline)
                        VStack(alignment: .trailing){
                            Divider()
                            HStack{
                                Group{
                                    Button {
                                        if like == 0 || like == -1{
                                            like = 1
                                        }else{
                                            like = 0
                                        }
                                    } label: {
                                        Image(systemName: like == 1 ? "heart.fill":"heart")
                                        Text("좋아요")
                                    }
                                    .foregroundColor(like == 1 ? .red : .gray)
                                    Button {
                                        if like == 0 || like == 1{
                                            like = -1
                                        }else{
                                            like = 0
                                        }
                                    } label: {
                                        HStack{
                                            Image(systemName: like == -1 ? "heart.slash.fill" : "heart.slash")
                                            Text("싫어요")
                                        }
                                    }
                                    .foregroundColor(like == -1 ? .blue : .gray)
                                }
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                            }
                            Divider()
                            HStack(spacing: 2){
                                Image(systemName: "heart.fill").foregroundColor(.red)
                                Text("\(review.likeCnt ?? 0)개")
                                    .padding(.trailing)
                                Image(systemName: "heart.slash.fill").foregroundColor(.blue)
                                Text("\(review.dislikeCnt ?? 0)개")
                            }
                            .font(.subheadline)
                        }.padding(.vertical)
                    }.padding()
                    
                } header: {
                    header
                }
            }
        }
        .onTapGesture {
            menu = false
        }
        .ignoresSafeArea()
        .background(Color.white)
        .foregroundColor(.black)
        .onAppear{
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.5)){
                    anima = true
                }
            }
            
        }
    }
}

struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsView(review: CustomData.instance.reviewDetail.first!)
            .environmentObject(AuthViewModel())
    }
}

extension ReviewDetailsView{
    var header:some View{
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                Spacer()
                if review.userNickname == vmAuth.nickname{
                    ZStack{
                        Button {
                            withAnimation {
                                menu.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                        }
                        
                    }
                    
                }
            }
            .overlay{
                Text("리뷰").bold()
            }
            .padding(.bottom,10)
            .padding(.horizontal)
            Divider()
        }
        .padding(.top,60)
        .background(Color.white)
        .overlay(alignment: .bottomTrailing) {
            if menu{
                VStack{
                    Text("수정하기")
                    Divider()
                    Text("삭제하기")
                        .foregroundColor(.red)
                }
                .padding(.vertical)
                .font(.subheadline)
                .background(Color.white)
                .frame(width: 100,height: 80)
                .cornerRadius(5)
                .shadow(radius: 10)
                .offset(y:80)
                .padding(.trailing)
            }
        }
        
    }
}
