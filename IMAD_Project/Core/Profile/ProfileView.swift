//
//  ProfileView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/08.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State var phase:CGFloat = 0.0
    @Binding var login:Bool
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            VStack(alignment: .leading,spacing: 0){
                header
                    .padding(.bottom)
                Text("내정보")
                    .font(.caption)
                    .bold()
                    .padding(.leading,20)
                    .padding(5)
                    .padding(.bottom,5)
                HStack{
                    KFImage(URL(string: CustomData.instance.movieList.first!))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70,height: 70)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading,spacing:10){
                        Text("콰랑 님")
                            .bold()
                        Text(verbatim: "dbduddnd1225@gmail.com")//이메일 색깔 변경 무시
                            .font(.caption)
                        
                    }
                    Spacer()
                    Group{
                        Text("변경")
                            .font(.caption)
                        
                    }
                    .padding(.horizontal,10)
                    .padding(5)
                    .overlay {
                        Capsule()
                            .stroke(style: .init(lineWidth: 1.0))
                    }
                    
                }.padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(20)
                .padding([.bottom,.horizontal])
               
                    
                
            }
            .background{
                ZStack{
                    LinearGradient(colors: [.black,.customIndigo], startPoint: .top, endPoint: .bottom)
                        .shadow(radius: 20)
                        .clipShape(Wave(progress: 0.9, phase: phase))
                        .onAppear{
                            withAnimation(.linear(duration: 5).repeatForever(autoreverses:false)){
                                self.phase = .pi * 2
                            }
                        }
                        .rotationEffect(Angle(degrees: 180))
                    Wave(progress: 0.91, phase: 0.0)
                        .fill(Color.customIndigo.opacity(0.5))
                        .shadow(radius: 20)
                        .rotationEffect(Angle(degrees: 180))
                }
                
            }
            Text("관심도")
                .font(.caption)
                .bold()
                .padding(.leading,20)
                .foregroundColor(.customIndigo)
                .padding(.top,10)
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(GenreFilter.allCases,id:\.self){ item in
                        VStack{
                            Image(item.rawValue)
                                .resizable()
                                .frame(width:200,height:150)
                                .overlay{
                                    Color.black.opacity(0.5)
                                    VStack(spacing:0){
                                        HStack{
                                            Text(item.generName)
                                                .font(.caption)
                                                .bold()
                                                .padding([.top,.leading])
                                            Spacer()
                                        }
                                        Circle()
                                            .trim(from: 0.0, to: 0.78)
                                            .stroke(lineWidth: 2)
                                            .rotation(Angle(degrees: 270))
                                            .foregroundColor(.white)
                                            .padding(20)
                                            .overlay{
                                                Text("78°")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                    .bold()
                                            }
                                    }
                                }
                                .shadow(radius:5)
                                .clipShape(RoundedRectangle(cornerRadius:20))
                        }
                        .padding(.leading,20)
                        .padding(.bottom)
                    }
                }
                .padding(.vertical,10)
                .padding(.trailing,20)
            }
            .bold()
            Divider()
                .padding(.horizontal)
            ScrollView(showsIndicators: false){
                menu
            }
            Spacer()
        }
        .background{
            Color.white
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
    func getPercentage(geo:GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width * 0.4
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX/maxDistance))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(login: .constant(true))
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
                
            }
            
        }
        .padding(.vertical)
        .padding(.top,30)
        
    }
    var menu:some View{
        VStack{
            LazyVGrid(columns: columns,alignment: .center) {
                ForEach(SettingFilter.allCases,id:\.self){ item in
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100,height: 100)
                            .foregroundColor(.white)
                            .shadow(radius: 7.5)
                            .overlay{
                                VStack{
                                    Image(systemName: item.image)
                                        .font(.largeTitle)
                                        .padding(5)
                                    Text(item.name)
                                        .font(.caption)
                                    
                                }
                                .bold()
                            }
                    }
                    .padding()
                }
            }
            .foregroundColor(.customIndigo)
            .padding(.horizontal)
            .padding(.top)
            HStack{
                Group{
                    Text("로그아웃")
                        .onTapGesture {
                            login = false
                        }
                    Text("약관 확인")
                }
                .font(.callout)
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 10)
                    
            }
            .padding(.horizontal)
            .foregroundColor(Color.black.opacity(0.8))
            .bold()
            
        }
       
        
        
    }
}
