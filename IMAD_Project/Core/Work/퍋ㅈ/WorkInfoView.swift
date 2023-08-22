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
    @State var detail:Season?
    @StateObject var vm = ContriesFilter()
    
    var isTV:Bool{
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
                    title
                    countryAndCertification
                }.padding(.leading)
                Group{
                    genre
                    season
                    network
                    releseAndType
                    overview
                }.padding(.leading)
                if let seasons = work.seasons{
                    seasonList(seasons: seasons)
                }
                person
                Spacer()
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

extension WorkInfoView{
    var title:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("원재")
                .bold()
            VStack(alignment: .leading){
                HStack{
                    if !isTV{
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
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
            .padding(.bottom,5)
            .padding(.leading,5)
        }
        .font(.subheadline)
    }
    var countryAndCertification:some View{
        HStack{
            VStack(alignment:.leading,spacing: 5){
                Text("국가")
                    .bold()
                HStack{
                    if let countries = work.productionCountries,countries != []{
                        ForEach(vm.contriesData,id: \.self) { dic in
                            ForEach(dic.filter{countries.contains($0.value)},id:\.key){ key,value in
                                if let country = dic["native_name"]{
                                    Text(country)
                                }
                            }
                        }
                    }
                    else{
                        Text("알수없음")
                    }
                }.padding(.leading,5)
            }
            Spacer()
            VStack(alignment:.leading,spacing: 5){
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
                    }.padding(.leading,5)
                }
            }
            Spacer()
        }
        .font(.subheadline)
    }
    var genre:some View{
        HStack{
            VStack(alignment: .leading,spacing: 5) {
                Text("장르").bold()
                HStack(spacing:0){
                    if isTV{
                        Text(work.genres.transTvGenreCode())
                    }else{
                        Text(work.genres.transMovieGenreCode())
                    }
                }
                
                .foregroundColor(.gray)
                .padding(.leading,5)
            }
        } .font(.subheadline)
    }
    var season:some View{
        
        VStack(alignment: .leading,spacing: 5) {
            if isTV{
                Text("시즌").bold()
                HStack{
                    Text("\(work.numberOfSeasons ?? 0)부작 -")
                    Text("\(work.numberOfEpisodes ?? 0)개의 에피소드")
                    
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading,5)
            }else{
                Text("상영시간").bold()
                HStack{
                    Text("\(work.runtime ?? 0)분")
                    
                }
                .foregroundColor(.gray)
                .padding(.leading,5)
            }
        }.font(.subheadline)
    }
    var overview:some View{
        VStack(alignment: .leading,spacing: 5){
            Text("개요").bold()
            Text(work.overview ?? "내용이 존재하지 않습니다.")
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom)
                .padding(.horizontal,5)
        }
        .font(.subheadline)
    }
    var releseAndType:some View{
        HStack{
            VStack(alignment: .leading,spacing: 10){
                
                Group{
                    if !isTV{
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
                Text(isTV ? "TV" : "영화")
                    .foregroundColor(.gray)
                
                    .padding(.leading,5)
            }
            Spacer()
        }.padding(.bottom,5).font(.subheadline)
    }
    func seasonList(seasons:[Season]) -> some View{
        VStack(alignment: .leading,spacing: 5){
            Text("시즌정보")
                .bold()
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(seasons){ season in
                        HStack(spacing:0){
                            Button {
                                withAnimation {
                                    detail = season
                                }
                            } label: {
                                VStack(spacing:0){
                                    KFImage(URL(string: season.posterPath?.getImadImage() ?? ""))
                                        .resizable()
                                        .placeholder{
                                            KFImage(URL(string: work.posterPath?.getImadImage() ?? ""))
                                                .resizable()
                                        }
                                        .frame(height: 120)
                                    Rectangle()
                                        .frame(height: 40)
                                        .foregroundColor(.white)
                                        .overlay{
                                            Text(season.name ?? "")
                                                .bold()
                                        }
                                    
                                }
                                .frame(width: 100)
                                
                            }
                            if season == detail{
                                KFImage(URL(string: season.posterPath?.getImadImage() ?? ""))
                                    .resizable()
                                    .frame(width: 100, height: 160)
                                    .overlay{
                                        ZStack{
                                            Color.black.opacity(0.2)
                                            Color.clear
                                                .background(Material.thin)
                                                .environment(\.colorScheme, .dark)
                                        }
                                        VStack(alignment: .leading,spacing:1) {
                                            Text("시즌명")
                                                .bold()
                                            Text(season.name ?? "")
                                                .padding(.leading,3)
                                                .foregroundColor(.white.opacity(0.7))
                                                .padding(.bottom,5)
                                            Text("시즌넘버")
                                                .bold()
                                            Text("\(season.seasonNumber ?? 0)")
                                                .padding(.leading,3)
                                                .foregroundColor(.white.opacity(0.7))
                                                .padding(.bottom,5)
                                            Text("최초 공개일")
                                                .bold()
                                            Text(season.airDate ?? "")
                                                .padding(.leading,3)
                                                .foregroundColor(.white.opacity(0.7))
                                                .padding(.bottom,5)
                                            Text("에피소드")
                                                .bold()
                                            Text("\(season.episodeCount ?? 0)부작")
                                                .padding(.leading,3)
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        .foregroundColor(.white)
                                    }
                                
                            }
                        }
                        .font(.caption2)
                        .cornerRadius(10)
                    }.padding(5)
                        .shadow(radius: 2)
                    
                }
                
            }
        }
        .padding(.leading)
        .font(.subheadline)
    }
    var network:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("방송사")
                .bold()
            if let networks = work.networks{
                HStack{
                    ForEach(networks){ network in
                        KFImage(URL(string: network.logoPath?.getImadImage() ?? ""))
                            .resizable()
                            .frame(width: 40,height: 15)
                            .padding(.leading,5)
                    }
                }
            }else{
                Text("없음")
            }
        }
        .font(.subheadline)
    }
    var person:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("스태프").bold().padding(.leading)
            ScrollView(.horizontal,showsIndicators: false){
                if let crews = work.credits?.crew,crews != []{
                    HStack(alignment: .top){
                        ForEach(crews){ crew in
                            VStack{
                                KFImage(URL(string: crew.profilePath?.getImadImage() ?? ""))
                                    .resizable()
                                    .placeholder{ _ in
                                        NoImageView()
                                    }
                                    .frame(width: 80,height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Text(crew.name ?? "")
                                    .font(.caption)
                                if let jobs = crew.job?.components(separatedBy: ","){
                                    Text(jobs.joined(separator: "\\").translationKorean())
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                    
                    .padding(.horizontal,20)
                }
                else{
                    Text("정보 없음")
                        .padding(.horizontal,20)
                        .foregroundColor(.gray)
                }
            }
            Text("출연진").bold().padding(.leading)
            if let casts = work.credits?.cast,casts != []{
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(alignment: .top){
                        ForEach(casts){ cast in
                            VStack{
                                KFImage(URL(string: cast.profilePath?.getImadImage() ?? ""))
                                    .resizable()
                                    .placeholder{ _ in
                                        NoImageView()
                                    }
                                    .frame(width: 80,height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Text(cast.name ?? "")
                                    .font(.caption)
                                Text("\(cast.character ?? "")역")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                                    .frame(width: 90)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .padding(.horizontal,20)
            }else{
                Text("정보 없음")
                    .padding(.horizontal,20)
                    .foregroundColor(.gray)
            }
        }
        .font(.subheadline)
    }
}


