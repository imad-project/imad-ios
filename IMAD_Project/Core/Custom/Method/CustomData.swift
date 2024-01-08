//
//  CustomData.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import Foundation
import SwiftUI

class CustomData2{
    static let instance = CustomData2()
    
//    ReadReviewResponse(reviewID: 1, contentsID: 1, contentsTitle: "굳", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 3, title: "죠죠", content: "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니무덤", score: 6.7, likeCnt: 2, dislikeCnt: 3, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", likeStatus: 1, spoiler: false)
//
//
    
//    let community:CommunityResponse = CommunityResponse(postingID: 1, contentsID: 1, contentsTitle: "굳", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 3, title: "죠죠", content: "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니무덤", category: 0, viewCnt: 42, likeCnt: 2, dislikeCnt: 3, likeStatus: 1, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", commentCnt: 1,commentListResponse: nil,scrapId: 1, scrapStatus: true, spoiler: false)
//       
    
    
//    let community = CommunityResponse(postingID: 1, contentsID: 1, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "https://an2-img.amz.wtchn.net/image/v2/JD59QW9WTfLRlP0lecVxGg.jpg?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1SZk56STVlREV3T0RCeE9EQWlYU3dpY0NJNklpOTJNaTl6ZEc5eVpTOXBiV0ZuWlM4eE5qTXhNREV6TnpFeU1qRXpNRGsxT0RnMkluMC5fZV92b05NN0xHU0RERTVrbDJEMENnanNjTzFnSXpXRXFjTTBlY0dtOWk4", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", content: "는 구라 ㅋ", category: 1, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579", commentCnt: 4, commentListResponse: CustomData2.instance.commentList,scrapId: 1, scrapStatus: true, spoiler: false)
//
//        let communityList:[CommunityDetailsListResponse] = [
//            CommunityDetailsListResponse(postingID: 1, contentsID: 1, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 0, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, spoiler: true),
//            CommunityDetailsListResponse(postingID: 2, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 0, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, spoiler: true),
//            CommunityDetailsListResponse(postingID: 3, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 0, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, spoiler: true),
//            CommunityDetailsListResponse(postingID: 4, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 0, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, spoiler: true)
//        ]
//    
//    let commentList = CommentListResponse(commentDetailsResponseList: [CustomData2.instance.comment,CustomData2.instance.comment], totalElements: 3, totalPages: 1, pageNumber: 1, numberOfElements: 3, sizeOfPage: 10, sortDirection: 0, sortProperty: "createdDate")
//    let comment = CommentResponse(commentID: 1, userID: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", removed: false)
}
class CustomData{
    
    static let instance = CustomData()
    
    let user = UserResponse(email: "quarang@gamil.com", nickname: "콰랑",gender: "FEMALE", birthYear: 1999, profileImage: 3,tvGenre: [10759,16,35],movieGenre: [28,12,16], authProvider: "IMAD", role: "USER")
    let comment = CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", author: true, removed: false)
    
    let community:CommunityResponse = CommunityResponse(postingID: 1, contentsID: 1, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 3, title: "굳", content: "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니무덤", category: 2, viewCnt: 42, likeCnt: 2, dislikeCnt: 3, likeStatus: 1, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", commentCnt: 1,commentListResponse: CommentListResponse(commentDetailsResponseList: [CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", author: true, removed: false), CommentResponse(commentID: 2, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 2, parentID: 1, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", author: true, removed: false)], totalElements: 3, totalPages: 1, pageNumber: 1, numberOfElements: 3, sizeOfPage: 10, sortDirection: 0, sortProperty: "createdDate"),scrapId: 1, scrapStatus: true, author: true, spoiler: false)
    
    let commentList = [
        CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", author: true, removed: false),
        CommentResponse(commentID: 2, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 2, parentID: 1, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", author: true, removed: false)
    ]
    
    let communityList:[CommunityDetailsListResponse] = [
        CommunityDetailsListResponse(postingID: 1, contentsID: 1, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 1, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, author: true, spoiler: true),
        CommunityDetailsListResponse(postingID: 2, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 2, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, author: true, spoiler: true),
        CommunityDetailsListResponse(postingID: 3, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 3, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, author: true, spoiler: true),
        CommunityDetailsListResponse(postingID: 4, contentsID: 2, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 1, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, author: true, spoiler: true)
    ]
    
//    let commentList = [
//        CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", removed: false),
//        CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", removed: false),
//        CommentResponse(commentID: 1, userID: 1, postingId: 1, userNickname: "콰랑", userProfileImage: 4, parentID: nil, content: "좋다로", childCnt: 2,likeStatus: 1,likeCnt: 20,dislikeCnt: 10, createdAt: "2023-10-17T11:55:25.525746", modifiedAt: "2023-10-17T11:55:25.525746", removed: false)
//    ]
    
    let communityDetails = CommunityDetailsListResponse(postingID: 1, contentsID: 1, contentsTitle: "죠죠의 기묘한 모험", contentsPosterPath: "https://an2-img.amz.wtchn.net/image/v2/JD59QW9WTfLRlP0lecVxGg.jpg?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1SZk56STVlREV3T0RCeE9EQWlYU3dpY0NJNklpOTJNaTl6ZEc5eVpTOXBiV0ZuWlM4eE5qTXhNREV6TnpFeU1qRXpNRGsxT0RnMkluMC5fZV92b05NN0xHU0RERTVrbDJEMENnanNjTzFnSXpXRXFjTTBlY0dtOWk4", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "최고의 아이", category: 0, viewCnt: 45, likeCnt: 3, dislikeCnt: 1, likeStatus: 0, commentCnt: 4, createdAt: "2023-10-16T12:33:35.007579", modifiedAt: "2023-10-16T12:33:35.007579",scrapId: 1,scrapStatus: false, author: true, spoiler: true)
    
    let movieList = [
        "https://i.namu.wiki/i/I52GG9t2PRgVqG6UK-umxRuMYAi6g9dplO3eLIWSPcMMqkJ1mnXo8-mOSzrW43EGyrT6MsBAfnMlWvRdUGRUEMHSAhqNptnLznZgTJhr1AXi_bMNGihiuLZEEHZXdHdI9dfS7kHcftSQ-5zZRyfgfQ.webp",
        "https://image.yes24.com/goods/98829094/XL",
        "https://news.seoul.go.kr/culture/files/2015/06/556fec87e966d6.09940740.jpg",
        "https://www.ntoday.co.kr/news/photo/201803/60835_31273_2948.jpg",
        "https://upload.wikimedia.org/wikipedia/ko/b/b9/%EB%B2%94%EC%A3%84%EB%8F%84%EC%8B%9C_2_%ED%8F%AC%EC%8A%A4%ED%84%B0.jpg",
        "https://upload.wikimedia.org/wikipedia/ko/6/6b/%EC%98%81%ED%99%94_%EC%8B%A0%EC%84%B8%EA%B3%84_%ED%8F%AC%EC%8A%A4%ED%84%B0.jpg",
        "https://i.namu.wiki/i/-oK3N3_o9LEhNOZS4BqYjXi5y7Byjk-aDNjm6d1pPMQHl4IYPDbjrTRHuYvFp9UpraA730qaVDPv5_3lS_mOjOJiKPrP5HkAJaSLp-ZWc1Duys6cZpCXpd3qkQo1zXl3qdwNVuZMgO8imkeXEwvKww.webp",
        "https://www.ichigo.co.kr:5030/data/20/9784088820552_m.jpg"
    ]
    let notification = [
        Notific(icon: "bubble.left", content: "회원님에 게시물에 댓글이 달렸습니다"),
        Notific(icon: "bell", content: "회원님에 게시물에 새로운 추천이 있습니다"),
        Notific(icon: "envelope", content: "개발자의 편지 - 오늘의 새로운 영화!")
    ]
    
    let bookmarkList = [
    
        BookmarkListResponse(bookmarkID: 1, userID: 1, contentsID: 1, contentsTitle: "죠죠", contentsPosterPath:    "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg", createdDate: "2023-10-16T12:33:35.007579"),
        BookmarkListResponse(bookmarkID: 3, userID: 1, contentsID: 3, contentsTitle: "죠죠", contentsPosterPath:    "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg", createdDate: "2023-10-16T12:33:35.007579"),
        BookmarkListResponse(bookmarkID: 4, userID: 1, contentsID: 4, contentsTitle: "죠죠", contentsPosterPath:    "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg", createdDate: "2023-10-16T12:33:35.007579"),
        BookmarkListResponse(bookmarkID: 7, userID: 1, contentsID: 5, contentsTitle: "죠죠", contentsPosterPath:    "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg", createdDate: "2023-10-16T12:33:35.007579")
    ]
    let workInfo:WorkResponse = WorkResponse(genres: [
        80,
        18
    ],
                                     productionCountries: [
                                        "US"
                                     ],
                                     contentsId: 3,
                                     tmdbId: 1396,
                                     tmdbType: "TV",
                                     tagline: "", overview: "2008년 1월 AMC에서 방영을 시작한 범죄 스릴러. Breaking Bad는 막가기를 뜻하는 미국 남부 지방의 속어이다. 한때 노벨화학상까지 바라 볼 정도로 뛰어난 과학자였던 고등학교 화학 교사 월터 화이트는 자신의 50세 생일 날에 폐암 3기 진단을 받는다. 어느 날 동서와 함께 마약 단속 현장을 참관한 그는 현장에서 달아나는 옛 제자 제시를 발견한다. 뇌성마비에 걸린 고등학생 아들과 임신한 아내를 위해 제시에게 동업을 제의한 월터는 자신의 화학지식을 이용해 전례없는 고순도 고품질의 메스암페타민을 제조한다.",
                                     posterPath: "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
                                     originalLanguage: "en",
                                     certification: "19",
                                     contentsType: "TV",
                                     title: nil,
                                     originalTitle: nil,
                                     releaseDate: nil,
                                     runtime: 0,
                                     status: "Ended",
                                     name: "브레이킹 배드",
                                     originalName: "Breaking Bad",
                                     firstAirDate: "2008-01-20",
                                     lastAirDate: "2013-09-29",
                                     reviewCnt: 62,
                                     imadScore: 5,
                                     numberOfEpisodes:7,
                                     numberOfSeasons: 0, bookmark: true,bookmarkId: 1,reviewId: 1,
                                     reviewStatus: true, seasons: [
                                        Season(airDate: "1987-04-19", id: 3581, name: "스페셜", episodeCount: 80, overview: "", posterPath: "/oICoFoPJuEk5VJbEP2HYLEmEQi3.jpg", seasonNumber: 0),
                                        Season(airDate: "1989-12-17", id: 3582, name: "시즌 1", episodeCount: 13, overview: "", posterPath: "/t544zSFUNyvmyeP4sHotlcEX3zH.jpg", seasonNumber: 1),
                                        Season(airDate: "1990-10-11", id: 3583, name: "시즌 2", episodeCount: 22, overview: "", posterPath: "/bRyDlUQQafSoIT052jpjLBMe8TH.jpg", seasonNumber: 2)
                                     ],
                                     networks: [Network(id: 19, logoPath: "/1DSpHrWyOORkL9N2QHX7Adt31mQ.png", name: "FOX", originCountry: "US")],
                                     credits: Credit(cast: [
                                        Person(gender: "MALE", id: 198, creditID: "5256bdc319c2956ff600157c", name: "Dan Castellaneta", profilePath: "/AmeqWhP4A46AWkM4kVphg6jOTQX.jpg", character: "Homer Simpson / Abe Simpson / Barney Gumble / Krusty (voice)", knownForDepartment: "Acting",department: nil,job: nil,  importanceOrder: 0, creditType: "CAST"),
                                        Person(gender: "MALE", id: 28, creditID: "5256bdc319c2956ff600157c", name: "Dan Castellaneta", profilePath: "/AmeqWhP4A46AWkM4kVphg6jOTQX.jpg", character: "Homer Simpson / Abe Simpson / Barney Gumble / Krusty (voice)", knownForDepartment: "Acting",department: nil,job: nil,  importanceOrder: 0, creditType: "CAST"),
                                        Person(gender: "MALE", id: 1928, creditID: "5256bdc319c2956ff600157c", name: "Dan Castellaneta", profilePath: "/AmeqWhP4A46AWkM4kVphg6jOTQX.jpg", character: "Homer Simpson / Abe Simpson / Barney Gumble / Krusty (voice)", knownForDepartment: "Acting",department: nil,job: nil,  importanceOrder: 0, creditType: "CAST")
                                     ], crew: [
                                        Person(gender: "MALE", id: 122397, creditID: "52fe4255c3a36847f8016037", name: "Richard D. Zanuck", profilePath: "/xnqVhmH5MAEuBEZMVpBRjVb2fIN.jpg", character: nil, knownForDepartment: "Production", department: "Production", job: "Producer", importanceOrder: 0, creditType: "CREW"),
                                        Person(gender: "MALE", id: 12397, creditID: "52fe4255c3a36847f8016037", name: "Richard D. Zanuck", profilePath: "/xnqVhmH5MAEuBEZMVpBRjVb2fIN.jpg", character: nil, knownForDepartment: "Production", department: "Production", job: "Producer", importanceOrder: 0, creditType: "CREW"),
                                        Person(gender: "MALE", id: 121197, creditID: "52fe4255c3a36847f8016037", name: "Richard D. Zanuck", profilePath: "/xnqVhmH5MAEuBEZMVpBRjVb2fIN.jpg", character: nil, knownForDepartment: "Production", department: "Production", job: "Producer", importanceOrder: 0, creditType: "CREW")
                                     ])
    )
    let workList:[WorkListResponse] = [
        WorkListResponse(id: 4125790,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath:"/af5UmMSKCqY3SvtzcIiK3zgEIQg.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 4579080,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/sAfNSZ8Th0nb979e6ss5ftTT0Rh.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 4514790,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/zXEChV2myFY8rJaWj4Av7bWH6Zd.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 4577590,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 457987990,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/kGiaOztahZV2x7bil7sbk7fb6ob.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 453123790,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 4577576590,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/67zsN2RRa187v8fwYxlN8c8T19X.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false),
        WorkListResponse(id: 3213,
                    title: nil,
                    originalTitle: nil,
                    releaseDate: nil,
                    name: "죠죠의 기묘한 모험",
                    originalName: "ジョジョの奇妙な冒険",
                    firstAirDate: "2012-10-06",
                    originCountry: [
                        "JP"
                    ],
                    originalLanguage: "ja",
                    adult: false,
                    backdropPath: "/5mUYDoFjDlPmDvnUWSknhYjGBBh.jpg",
                    overview: "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
                    posterPath: "/pnAPAcUHpUQ9v8PXZtMTnbovc7x.jpg",
                    mediaType: "tv",
                    genreIds: [
                        16,
                        10759,
                        10765
                    ],
                    video: false)
    ]
    
    
    let dummyString = "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니다. 오는 추억과 많은 이름과, 이름과 라이너 이름과, 비둘기, 까닭입니다. 별들을 나의 벌레는 피어나듯이 언덕 둘 지나가는 하나 거외다. 아이들의 별 하나에 불러 하나에 있습니다. 아무 했던 쓸쓸함과 동경과 노새, 하나에 많은 아름다운 토끼, 봅니다. 소녀들의 계집애들의 가슴속에 토끼, 남은 새겨지는 까닭입니다.\n\n지나고 라이너 무엇인지 봅니다. 써 덮어 않은 추억과 무엇인지 버리었습니다. 슬퍼하는 헤일 별 내일 위에 하나에 별을 계절이 파란 있습니다. 이네들은 이웃 가득 아무 된 별 동경과 봅니다. 벌써 노루, 시인의 계십니다. 어머님, 쉬이 아스라히 있습니다. 된 다 밤을 다 내 버리었습니다. 아름다운 파란 이런 자랑처럼 나의 하나에 보고, 쓸쓸함과 하나에 버리었습니다. 나는 딴은 별들을 있습니다. 부끄러운 별들을 별을 버리었습니다.\n\n파란 하나에 별 둘 소학교 버리었습니다. 흙으로 당신은 이웃 별이 마디씩 멀리 애기 이름자를 별 봅니다. 위에 별들을 별 어머님, 까닭입니다. 사람들의 그러나 당신은 옥 까닭입니다. 피어나듯이 마디씩 그리워 까닭입니다. 아직 어머니 피어나듯이 불러 나는 다 나는 어머님, 까닭입니다. 다하지 자랑처럼 프랑시스 가을 계십니다. 하나의 이름을 무엇인지 속의 어머니, 듯합니다. 겨울이 경, 나는 봅니다.\n\n그리워 사람들의 이름을 내 별 봄이 소학교 있습니다. 위에 내린 노새, 딴은 별이 이름을 사랑과 계십니다. 때 무엇인지 불러 내린 하늘에는 계십니다. 아침이 당신은 부끄러운 별들을 새겨지는 듯합니다. 프랑시스 오면 하나에 나는 내일 피어나듯이 나는 까닭입니다. 무덤 피어나듯이 이름자를 거외다. 어머님, 하나에 무엇인지 둘 별 계십니다. 강아지, 까닭이요, 멀리 릴케 오면 아름다운 하나의 별에도 어머니, 계십니다. 이름과, 어머니 계절이 계집애들의 우는 오는 경, 이런 나는 봅니다. 하나에 했던 하나의 별들을 까닭입니다."
    
    let reviewDetail:[ReadReviewResponse] = [
        
        ReadReviewResponse(reviewID: 1, contentsID: 1, contentsTitle: "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 4, title: "죠타로", content: "죽음", score: 5.75, likeCnt: 0, dislikeCnt: 0, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", likeStatus: 0, spoiler: true, author: true),
        ReadReviewResponse(reviewID: 1, contentsID: 1, contentsTitle: "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 1, title: "죠타로", content: "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니다. 오는 추억과 많은 이름과, 이름과 라이너 이름과, 비둘기, 까닭입니다. 별들을 나의 벌레는 피어나듯이 언덕 둘 지나가는 하나 거외다. 아이들의 별 하나에 불러 하나에 있습니다. 아무 했던 쓸쓸함과 동경과 노새, 하나에 많은 아름다운 토끼, 봅니다. 소녀들의 계집애들의 가슴속에 토끼, 남은 새겨지는 까닭입니다.\n\n지나고 라이너 무엇인지 봅니다. 써 덮어 않은 추억과 무엇인지 버리었습니다. 슬퍼하는 헤일 별 내일 위에 하나에 별을 계절이 파란 있습니다. 이네들은 이웃 가득 아무 된 별 동경과 봅니다. 벌써 노루, 시인의 계십니다. 어머님, 쉬이 아스라히 있습니다. 된 다 밤을 다 내 버리었습니다. 아름다운 파란 이런 자랑처럼 나의 하나에 보고, 쓸쓸함과 하나에 버리었습니다. 나는 딴은 별들을 있습니다. 부끄러운 별들을 별을 버리었습니다.\n\n파란 하나에 별 둘 소학교 버리었습니다. 흙으로 당신은 이웃 별이 마디씩 멀리 애기 이름자를 별 봅니다. 위에 별들을 별 어머님, 까닭입니다. 사람들의 그러나 당신은 옥 까닭입니다. 피어나듯이 마디씩 그리워 까닭입니다. 아직 어머니 피어나듯이 불러 나는 다 나는 어머님, 까닭입니다. 다하지 자랑처럼 프랑시스 가을 계십니다. 하나의 이름을 무엇인지 속의 어머니, 듯합니다. 겨울이 경, 나는 봅니다.\n\n그리워 사람들의 이름을 내 별 봄이 소학교 있습니다. 위에 내린 노새, 딴은 별이 이름을 사랑과 계십니다. 때 무엇인지 불러 내린 하늘에는 계십니다. 아침이 당신은 부끄러운 별들을 새겨지는 듯합니다. 프랑시스 오면 하나에 나는 내일 피어나듯이 나는 까닭입니다. 무덤", score: 1.2, likeCnt: 0, dislikeCnt: 0, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", likeStatus: 0, spoiler: true, author: true),
        ReadReviewResponse(reviewID: 1, contentsID: 1, contentsTitle: "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 2, title: "죠타로", content: "죽음", score: 8.56, likeCnt: 0, dislikeCnt: 0, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", likeStatus: 0, spoiler: true, author: true)
    ]
//    let bookMarkList:[BookmarkDetailsList] = [
//        BookmarkDetailsList(bookmarkID: 1, userID: 1, contentsID: 1, contentsTitle: "dasd", contentsPosterPath:CustomData.instance.movieList[0], createdDate: "2023-09-15T13:31:10.027532")
//    ]
    let review:ReadReviewResponse = ReadReviewResponse(reviewID: 1, contentsID: 1, contentsTitle: "굳", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", userID: 1, userNickname: "콰랑", userProfileImage: 3, title: "죠죠", content: "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니무덤", score: 6.7, likeCnt: 2, dislikeCnt: 3, createdAt: "2023-09-15T13:31:10.027532", modifiedAt: "2023-09-15T13:31:10.027532", likeStatus: 1, spoiler: false, author: true)
    
    let scrapList:[ScrapListResponse] = [
        ScrapListResponse(scrapID: 1, userID: 1, userNickname: "콰랑", userProfileImage: 1, contentsID: 1, contentsTitle:  "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", postingID: 1, postingTitle: "이거 개쩔지 않노", createdDate: "2023-09-15T13:31:10.027532"),
        ScrapListResponse(scrapID: 1, userID: 1, userNickname: "콰랑", userProfileImage: 3, contentsID: 1, contentsTitle:  "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", postingID: 1, postingTitle: "이거 개쩔지 않노", createdDate: "2023-09-15T13:31:10.027532"),
        ScrapListResponse(scrapID: 1, userID: 1, userNickname: "콰랑", userProfileImage: 2, contentsID: 1, contentsTitle:  "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", postingID: 1, postingTitle: "이거 개쩔지 않노", createdDate: "2023-09-15T13:31:10.027532"),
        ScrapListResponse(scrapID: 1, userID: 1, userNickname: "콰랑", userProfileImage: 4, contentsID: 1, contentsTitle:  "죠죠", contentsPosterPath: "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg", postingID: 1, postingTitle: "이거 개쩔지 않노", createdDate: "2023-09-15T13:31:10.027532")
        ]
}
