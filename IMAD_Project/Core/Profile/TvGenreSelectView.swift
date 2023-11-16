//
//  TvGenreSelectView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/10.
//

import SwiftUI
import SwiftUIFlowLayout

struct TvGenreSelectView: View {
    @State var tvCollection:[TVGenreFilter] = []
    @Binding var dismiss:Bool
    @EnvironmentObject var vmAuth:AuthViewModel
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                Text("내 장르 수정").bold()
                    .padding([.leading,.top])
                Spacer()
                FlowLayout(mode: .vstack, items: tvCollection) { item in
                    Button {
                        withAnimation {
                            tvCollection = tvCollection.filter({$0 != item})
                        }
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.caption)
                        .bold()
                        .padding(5)
                        .padding(.trailing)
                        .overlay(alignment:.trailing) {
                            Image(systemName: "xmark").font(.caption)
                        }
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1))
                        .foregroundColor(.customIndigo)
                    }
                }
                .padding()
                Spacer()
                Divider()
                    .padding(.vertical)
                FlowLayout(mode: .scrollable, items: TVGenreFilter.allCases) { item in
                    Button {
                        withAnimation {
                            if tvCollection.contains(item){
                                tvCollection = tvCollection.filter({$0 != item})
                            }else{
                                tvCollection.append(item)
                            }
                        }
                        
                    } label: {
                        HStack{
                            Text(item.name)
                            Text(item.image)
                        }
                        .font(.caption)
                        .bold()
                        .padding(5)
                        .padding(.horizontal).background(Capsule().stroke(lineWidth: 1).foregroundColor(.customIndigo.opacity(0.5)))
                    }
                    
                }.foregroundColor(.customIndigo.opacity(0.5)).padding(.horizontal)
                
                Button {
                    vmAuth.patchUser.tvGenre = tvCollection.map{$0.rawValue}
                    vmAuth.patchUserInfo()
                    dismiss = false
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(.customIndigo)
                        .overlay {
                            Text("완료")
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: 20)
                        }
                }
                .padding()
            }
        }
        .onAppear{
            if let tvs = vmAuth.user?.data?.tvGenre{
                for tv in tvs {
                    if let t = TVGenreFilter(rawValue: tv){
                        self.tvCollection.append(t)
                    }
                }
            }
        }
        .foregroundColor(.customIndigo)
    }
}

struct TvGenreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TvGenreSelectView(dismiss: .constant(true))
            .environmentObject(AuthViewModel(user: nil))
    }
}
