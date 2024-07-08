//
//  WorkInfoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import SwiftUI
import Kingfisher

struct WorkInfoView: View {
    let work:WorkResponse
    @State var detail:Season?
    @State var isExtend = false
    @StateObject var vm = ContriesFilter()
    
    var isTV:Bool{
        switch work.contentsType{
        case "MOVIE":
            return false
        case "TV":
            return true
        default:
            return true
        }
    }
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading,spacing: 20){
                title
                countryAndCertification
                genre
                season
                network
                overview
                if let seasons = work.seasons{
                    seasonList(seasons: seasons)
                }
                person
                Spacer()
            }
            .padding(.top)
        }
        .foregroundColor(.black)
        
    }
}

struct WorkInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            WorkInfoView(work: CustomData.instance.workInfo)
        }
    }
}

extension WorkInfoView{
    var title:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("원재")
                .font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold)
            VStack(alignment: .leading){
                HStack(spacing:0){
                    Text(isTV ? (work.name ?? "") : (work.title ?? ""))
                    Text("(\(isTV ? (work.originalName ?? "알수 없음"):(work.originalTitle ?? "알수 없음")))")
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
        .padding(.horizontal)
        .font(.subheadline)
    }
    var countryAndCertification:some View{
        HStack{
            VStack(alignment:.leading,spacing: 10){
                Text("국가")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .fontWeight(.semibold)
                HStack{
                    if let countries = work.productionCountries,countries != []{
                        ForEach(Array(vm.contriesData).filter({countries.contains($0.key)}),id:\.key){ key,value in
                            Text(value)
                        }
                    }
                    else{
                        Text("알수없음")
                    }
                }.padding(.leading,5)
            }
            Spacer()
            VStack(alignment:.leading,spacing: 10){
                Text("연령등급")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .fontWeight(.semibold)
                if let certification = work.certification{
                    if let cer = CertificationFilter.allCases.first(where: {$0.rawValue == certification}){
                        Text(cer.name)
                            .bold()
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(2)
                            .background(cer.color)
                            .cornerRadius(5)
                            .padding(.leading,5)
                    }
                }
                else{
                    Text("--")
                        .bold()
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(2)
                        .background(.cyan)
                        .cornerRadius(5)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
    var genre:some View{
        HStack{
            VStack(alignment: .leading,spacing: 10) {
                Text("장르")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .fontWeight(.semibold)
                Text(isTV ? work.genres.transTvGenreCode() : work.genres.transMovieGenreCode())
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.horizontal,5)
            }
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
    var season:some View{
        VStack(alignment: .leading,spacing: 10) {
            if isTV{
                Text("시즌")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .fontWeight(.semibold)
                HStack{
                    Text("\(work.numberOfSeasons ?? 0)부작 -")
                    Text("\(work.numberOfEpisodes ?? 0)개의 에피소드")
                }
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.6))
                .padding(.leading,5)
            }else{
                Text("상영시간")
                    .font(.custom("GmarketSansTTFMedium", size: 15))
                    .fontWeight(.semibold)
                Text("\(work.runtime ?? 0)분")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
            }
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
    var overview:some View{
        VStack(alignment: .leading,spacing: 10){
            Text("개요")
                .font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold)
            Text(isExtend ? work.overview ?? "내용이 존재하지 않습니다." : String(work.overview?.prefix(200) ?? "내용이 존재하지 않습니다.") + (isExtend ? "" : "..."))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom,5)
                .padding(.horizontal,5)
            if work.overview?.count ?? 0 > 200{
                Button {
                    withAnimation {
                        isExtend.toggle()
                    }
                } label: {
                    Text(isExtend ? "접기" :"더보기")
                        .foregroundColor(.gray)
                        .padding(.horizontal,5)
                        .underline()
                }
            }
        }
        .padding(.horizontal)
        .font(.subheadline)
    }
    
    func seasonList(seasons:[Season]) -> some View{
        VStack(alignment: .leading,spacing: 5){
            Text("시즌정보")
                .font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold)
                .padding(.horizontal)
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
                .padding(.horizontal)
            }
        }
        
        .font(.subheadline)
    }
    var network:some View{
        VStack(alignment: .leading,spacing: 15){
            Text("방송사")
                .font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold)
                .padding(.horizontal)
            if let networks = work.networks{
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(networks){ network in
                            KFImage(URL(string: network.logoPath?.getImadImage() ?? ""))
                                .resizable()
                                .frame(width: 40,height: 15)
                                .padding(.leading,5)
                        }
                    }.padding(.horizontal)
                }
            }else{
                Text("없음")
                    .padding(.horizontal)
            }
        }
        .font(.subheadline)
    }
    var person:some View{
        VStack(alignment: .leading){
            Text("스태프")
                .font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold)
                .padding(.horizontal)
            if let crews = work.credits?.crew,!crews.isEmpty{
                ForEach(crews){ crew in
                    HStack{
                        ActorProfileView(image: crew.profilePath?.getImadImage() ?? "")
                        VStack(alignment: .leading){
                            Text(crew.name ?? "")
                            if let jobs = crew.job?.components(separatedBy: ","){
                                Text(jobs.joined(separator: "\\").translationKorean())
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                        }
                        Spacer()
                    }
                }.padding(.top,10)
                    .padding(.horizontal,20)
                    
            }
            else{
                Text("정보 없음")
                    .padding(.horizontal,20)
                    .foregroundColor(.gray)
            }
            Text("출연진").font(.custom("GmarketSansTTFMedium", size: 15))
                .fontWeight(.semibold).padding(.leading)
                .padding(.top,20)
            if let casts = work.credits?.cast,casts != []{
                ForEach(casts){ cast in
                    HStack{
                        ActorProfileView(image: cast.profilePath?.getImadImage() ?? "")
                        VStack(alignment: .leading){
                            Text(cast.name ?? "")
                            Text("\(cast.character ?? "")역")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                }
                .padding(.top)
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


