//
//  WorkInfoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkInfoView: View {
    let work:WorkInfo
    let type:String
    @State var morethan = false
    @StateObject var vm = ContriesFilter()
    
    var returnType:Bool{
        switch type{
        case "movie":
            return false
        case "tv":
            return true
        default:
            return true
        }
    }
    
    var body: some View {
        
            ZStack{
                Color.white.ignoresSafeArea()
                
     
               
                    VStack(alignment: .leading,spacing: 10){
                        Group{
                            Text("원재")
                                .bold()
                            VStack{
                                HStack{
                                    if !returnType{
                                        Text(work.title ?? "")
                                        Text("(\(work.originalTitle ?? ""))")
                                    }
                                    else{
                                        Text(work.name ?? "")
                                        Text("(\(work.originalName ?? ""))")
                                    }
                                }
                                if work.tagline != ""{
                                    Text(work.tagline)
                                }
                            }
                            .font(.subheadline)
                            .padding(.bottom,5)
                            .padding(.leading,5)
                            
                            
                            HStack{
                                VStack(spacing: 5){
                                    Text("국가")
                                        .bold()
                                    Group{
                                        if let country = work.productionCountries{
                                            ForEach(Array(zip(vm.iso31661, vm.nativename)),id: \.0){ (iso,native) in
                                                ForEach(country,id:\.self){
                                                    if iso == $0{
                                                        Text(native)
                                                    }
                                                }
                                            }
                                        }
                                        else{
                                            Text("알수없음")
                                        }
                                    }
                                }
                                Spacer()
                                VStack(spacing: 5){
                                    Text("연령등급")
                                        .bold()
                                    if let certification = work.certification{
                                        ForEach(CertificationFilter.allCases,id:\.self){ cer in
                                            if cer.rawValue == certification{
                                                Text(cer.name)
                                                    .bold()
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                    .padding(2)
                                                    .background(cer.color)
                                                    .cornerRadius(5)
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .font(.subheadline)
                            .padding(.leading,5)
                        }.padding(.leading)
                        Group{
                            Text("장르").bold()
                            HStack(spacing:0){
                                if returnType{
                                    ForEach(TVGenreFilter.allCases,id:\.self){ genre in
                                        if work.genres.contains(genre.rawValue){
                                            Text(genre.name)
                                            
                                            Text(", ")
                                        }
                                    }
                                }else{
                                    ForEach(MovieGenreFilter.allCases,id:\.self){ genre in
                                        if work.genres.contains(genre.rawValue){
                                            Text(genre.name)
                                        }
                                    }
                                }
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading,5)
                            
                            Text("개요").bold()
                            Text(work.overview ?? "")
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom)
                                .padding(.horizontal,5)
                            
                            
                            HStack{
                                VStack(alignment: .leading,spacing: 10){
                                    
                                    Group{
                                        if !returnType{
                                            Text("최초개봉일")
                                                .bold()
                                            Text(work.releaseDate ?? "")
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                                .padding(.leading,5)
                                        }else{
                                            Text("최초공개일")
                                                .bold()
                                            Text(work.firstAirDate ?? "")
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                                .padding(.leading,5)
                                        }
                                    }
                                    
                                }
                                Spacer()
                                VStack(alignment: .leading,spacing: 10){
                                    Text("타입")
                                        .bold()
                                    Text(returnType ? "TV" : "영화")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                        .padding(.leading,5)
                                }
                                Spacer()
                            }.padding(.bottom,5)
                        }.padding(.leading)
                        Text("감독").bold().padding(.leading)
                        VStack{
                            KFImage(URL(string: "https://image.newsis.com/2022/03/17/NISI20220317_0018600863_web.jpg"))
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
                                        KFImage(URL(string: "https://image.newsis.com/2022/03/17/NISI20220317_0018600863_web.jpg"))
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
               
                if morethan{
                    Color.black.opacity(0.5).ignoresSafeArea()
                    VStack{
                        ScrollView {
                            Text(work.overview ?? "")
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                        }
                        .frame(height:500)
                        Divider()
                        Button {
                            morethan = false
                        } label: {
                            Text("닫기")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background{
                        Color.white
                            .cornerRadius(15)
                    }
                    .padding()
                    
                }
            
            
        }
        
        .foregroundColor(.black)
        .onAppear{
            vm.fetchDataFromURL()
        }
        
    }
}

struct WorkInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkInfoView(work: CustomData.instance.workInfo, type: "tv")
    }
}
