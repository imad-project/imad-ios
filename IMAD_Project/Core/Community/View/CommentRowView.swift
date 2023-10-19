//
//  CommentRowView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/17.
//

import SwiftUI

struct CommentRowView: View {
    @State var statingOffsetY:CGFloat = 0
    @State var currentDragOffstY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    let comment:CommentResponse
    @EnvironmentObject var vmAuth:AuthViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(ProfileFilter.allCases.first(where: {$0.num == comment.userProfileImage})?.rawValue ?? "soso")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .padding(.trailing,7)
                Text(comment.userNickname).bold()
                Spacer()
                Text(comment.modifiedAt.relativeTime())
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            .padding(.bottom,10)
            Text(comment.content).padding(.leading).font(.footnote)
            Divider()
        }.padding(.horizontal)
            .padding(.vertical,3)
            .overlay(alignment: .trailing){
                HStack{
//                    if let nickname = vmAuth.getUserRes?.data?.nickname,nickname == comment.userNickname{
                        Button {
                            
                        } label: {
                            VStack{
                                Image(systemName: "square.and.pencil")
                                    .font(.title3)
                                Text("수정")
                                
                            }
                            .padding(15)
                            .padding(.horizontal,10)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.customIndigo.opacity(0.6))
                            .cornerRadius(10)
                            .offset(x:200)
                        }

                        Button {
                            
                        } label: {
                            VStack{
                                Image(systemName: "trash")
                                    .font(.title3)
                                Text("삭제")
                                
                            }
                            .padding(15)
                            .padding(.horizontal,10)
                            .font(.caption)
                            .bold()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(x:195)
                        }

                        
//                    }else {
//                        VStack{
//                            Image(systemName: "exclamationmark.square")
//                                .font(.title3)
//                            Text("신고")
//
//                        }
//                        .padding(15)
//                        .padding(.horizontal,10)
//                        .font(.caption)
//                        .bold()
//                        .background(Color.yellow)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .offset(x:90)
//                    }
                    
                }
            }
            .background(Color.white)
            .offset(x:statingOffsetY)
            .offset(x:currentDragOffstY )
            .offset(x:endingOffsetY )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()){
                            currentDragOffstY = value.translation.width
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.spring()){
                            if let nickname = vmAuth.getUserRes?.data?.nickname,nickname == comment.userNickname{
                                if currentDragOffstY < -100{
                                    statingOffsetY = -200
                                }else if currentDragOffstY > 100{
                                    statingOffsetY = 0
                                }
                                currentDragOffstY = 0
                            }else{
                                if currentDragOffstY < -50{
                                    statingOffsetY = -100
                                }else if currentDragOffstY > 50{
                                    statingOffsetY = 0
                                }
                                currentDragOffstY = 0
                            }
                            
                        }
                    }
            )
        
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: CustomData.instance.comment)
            .environmentObject(AuthViewModel())
    }
}
