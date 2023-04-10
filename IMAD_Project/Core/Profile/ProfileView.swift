//
//  ProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/08.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading){
            header
            Group{
                Text("콰랑님은 사랑꾼이시군요!")
                    .font(.title3)
                Text("콰랑님은 로맨스/사랑에 78% 관심을 보이고 있습니다.")
                    
            }
            .padding(.leading)
            .bold()
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(CustomData.instance.movieList,id: \.self) { item in
                        GeometryReader { geo in
                            //RoundedRectangle(cornerRadius: 20)
                            VStack{
                                Group{
                                    KFImage(URL(string: item))
                                        .resizable()
                                        .overlay {
                                            Color.black.opacity(0.5)
                                            Circle()
                                                .trim(from: 0.0, to: 0.78)
                                                .stroke(lineWidth: 5)
                                                .rotation(Angle(degrees: 270))
                                                .foregroundColor(.white)
                                                .padding(10)
                                            Text("78°")
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                        }
                                        .clipShape(Circle())
                                    Text("로맨스/사랑")
                                        .font(.title2)
                                }
                                .rotation3DEffect(Angle(degrees: getPercentage(geo: geo) * 50), axis: (x:0.0,y:1.0,z:0.0))
                                
                                
                            }
                        }.frame(width: 300,height: 300)
                            .padding()
                            
                    }
                    
                }.padding(.horizontal,50)
            }
            Spacer()
        }
        .background{
            VStack{
                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
                    .frame(height: UIScreen.main.bounds.height/2 + 30)
                    .shadow(radius: 20)
                Spacer()
            }
            
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
    func getPercentage(geo:GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width/2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX/maxDistance))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView{
    var header:some View{
        VStack{
            HStack{
                Text("프로필")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                Spacer()
                KFImage(URL(string: CustomData.instance.movieList.first!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40,height: 40)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
            
        }
        .padding(.vertical)
        .padding(.top,30)
        
//        .background{
//            if colorScheme == .dark {
//                Color.white
//            }else{
//                LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
//            }
//        }
    }
}
