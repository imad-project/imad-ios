//
//  CustomData.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import Foundation
import SwiftUI

class CustomData{
    
    static let instance = CustomData()

    let community = Community(title: "최고의 영화", image: "https://an2-img.amz.wtchn.net/image/v2/JD59QW9WTfLRlP0lecVxGg.jpg?jwt=ZXlKaGJHY2lPaUpJVXpJMU5pSjkuZXlKdmNIUnpJanBiSW1SZk56STVlREV3T0RCeE9EQWlYU3dpY0NJNklpOTJNaTl6ZEc5eVpTOXBiV0ZuWlM4eE5qTXhNREV6TnpFeU1qRXpNRGsxT0RnMkluMC5fZV92b05NN0xHU0RERTVrbDJEMENnanNjTzFnSXpXRXFjTTBlY0dtOWk4", like: 12, hate: 2, content: "1918년 제1차 세계 대전 말 뉴올리언즈. 80세의 외모를 가진 사내 아이가 태어난다. 그의 이름은 벤자민 버튼. 생김새때문에 양로원에 버려져 노인들과 함께 지내던 그는 시간이 지날수록 젊어진다는 것을 알게 된다. 12살이 되며 60대의 외모를 가지게 된 어느 날, 5살 소녀 데이지를 만난 후 그녀의 푸른 눈동자를 잊지 못하게 된다. 점차 중년이 되어 세상으로 나간 벤자민은 숙녀가 된 데이지와 만나 만남과 헤어짐을 반복하다 비로소 둘은 사랑에 빠지게 된다. 하지만 벤자민은 날마다 젊어지고 데이지는 점점 늙어가는데…", date: "2023/04/05 12:24:04",reply: 4)
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
   let reviewList = [
    Review(title: "카지노", thumbnail: "https://i.namu.wiki/i/I52GG9t2PRgVqG6UK-umxRuMYAi6g9dplO3eLIWSPcMMqkJ1mnXo8-mOSzrW43EGyrT6MsBAfnMlWvRdUGRUEMHSAhqNptnLznZgTJhr1AXi_bMNGihiuLZEEHZXdHdI9dfS7kHcftSQ-5zZRyfgfQ.webp", desc: "우여곡절 끝에 카지노의 왕이 된 한 남자가 일련의 사건으로 모든 것을 잃은 후 생존과 목숨을 걸고 게임에 복귀하는 강렬한 이야기", genre: "범죄/느와르", opendDate: "2022년 12월 21일", gradeAvg: 9.4),
    Review(title: "죠죠의 기묘한 모험", thumbnail: "https://image.yes24.com/goods/98829094/XL", desc: "서기 12~16세기, 멕시코 중앙고원에서 번영했던 아스테카 문명. 그중 세계 재패의 야망을 품은 부족이 있었다. 그러나 어느 날, 수수께끼의 돌가면을 남기고 그들은 역사에서 갑자기 자취를 감춘다. 시간은 흘러 19세기 말 영국. 죠스타 경은 생명의 은인이 죽자 그의 아들 디오를 양자 삼아 지원을 아끼지 않는다. 그러나 지나치게 신분 상승욕이 강한 디오는 죠스타 경의 친아들 죠나단 죠스타(죠죠)를 제치고 재산을 독차지할 계획을 세우는데….", genre: "모험/판타지", opendDate: "2012년 10월 06일", gradeAvg: 9.9),
    Review(title: "어벤져스", thumbnail: "https://news.seoul.go.kr/culture/files/2015/06/556fec87e966d6.09940740.jpg", desc: "최강의 슈퍼히어로들이 모였다!", genre: "액션/SF", opendDate: "2012년 4월 26일", gradeAvg: 8.9),
    Review(title: "어벤져스-인피니티 워", thumbnail: "https://www.ntoday.co.kr/news/photo/201803/60835_31273_2948.jpg", desc: "가디언즈 오브 갤럭시 멤버들과 와칸다 군대, 닥터 스트레인지 등 새로운 팀들과 함께 환상의 대연합을 이룬 어벤져스, 역대 최강 빌런 타노스에 맞서 전 우주에 운명이 걸린 인피니티 스톤을 향한 무한 대결이 펼쳐진다!", genre: "액션/SF", opendDate: "2018년 4월 25일", gradeAvg: 7.8),
    Review(title: "범죄도시2", thumbnail: "https://upload.wikimedia.org/wikipedia/ko/b/b9/%EB%B2%94%EC%A3%84%EB%8F%84%EC%8B%9C_2_%ED%8F%AC%EC%8A%A4%ED%84%B0.jpg", desc: "나쁜 놈들 싹 쓸어버린다!", genre: "범죄/액션", opendDate: "2022년 5월 18일", gradeAvg: 8.7),
    Review(title: "신세계", thumbnail: "https://upload.wikimedia.org/wikipedia/ko/6/6b/%EC%98%81%ED%99%94_%EC%8B%A0%EC%84%B8%EA%B3%84_%ED%8F%AC%EC%8A%A4%ED%84%B0.jpg", desc: "너, 나하고 일 하나 같이 하자 경찰청 수사기획과 강과장(최민식)은 국내 최대 범죄 조직인 '골드문'이 기업형 조직으로 그 세력이 점점 확장되자 신입 경찰 이자성(이정재)에게 잠입 수사를 명한다. 그리고 8년 뒤, 자성은 골드문의 2인자이자 그룹 실세인 정청(황정민)의 오른팔이 되기에 이르른다.", genre: "범죄,느와르", opendDate: "2013년 2월 21일", gradeAvg: 9.1),
    Review(title: "나의 히어로 아카데미아", thumbnail: "https://i.namu.wiki/i/-oK3N3_o9LEhNOZS4BqYjXi5y7Byjk-aDNjm6d1pPMQHl4IYPDbjrTRHuYvFp9UpraA730qaVDPv5_3lS_mOjOJiKPrP5HkAJaSLp-ZWc1Duys6cZpCXpd3qkQo1zXl3qdwNVuZMgO8imkeXEwvKww.webp", desc: "'개성'이라는 초능력을 갖고 태어나는 게 당연한 세계, 현재 인류 8할이 개성을 소유하고 있다. 초능력자들이 많아짐에 따라 과거 만화에서나 나오던 히어로라는 직업이 각광받게 되고 주인공 미도리야 이즈쿠도 히어로를 동경하고 있다. 하지만 무개성인 이즈쿠는 히어로가 될 수 없었고, 주변에서도 포기하란 말만 듣는다.", genre: "소년/히어로", opendDate: "2016년 04월 03일", gradeAvg: 9.5),
    Review(title: "닥터스톤", thumbnail: "https://www.ichigo.co.kr:5030/data/20/9784088820552_m.jpg", desc: "그 날─ 이 세상의 인간은 모두 돌이 되었다!!", genre: "SF/아포칼립스", opendDate: "2019년 07월 05일", gradeAvg: 10.0)
   ]
    
    let userReiveList = [
        UserReview(nickName: "Midorizzang", image: "https://mblogthumb-phinf.pstatic.net/20160711_156/o_o192_1468236838078ahcHc_PNG/31.png?type=w800", comment: "정말 감명깊게 봤습니다!!", gradeAvg: 9.5, date: "2023.04.14"),
        UserReview(nickName: "대.폭.살.신 다이너마이트", image: "https://cf.joara.com/literature_file/20211121_2338083024.jpg_thumb.png", comment: "쓰레기; 감독 죽어버려", gradeAvg: 0.4, date: "2023.04.14"),
        UserReview(nickName: "todoriki", image: "https://cf.joara.com/literature_file/20220106_0606222530.jpg_thumb.png", comment: "그냥.. 그럼", gradeAvg: 5.0, date: "2023.04.14"),
        UserReview(nickName: "No.1잉게니움", image: "https://mblogthumb-phinf.pstatic.net/MjAyMTExMjZfMjk3/MDAxNjM3OTI4NTM5ODg0.TuksZEFtPY2AfXX8bExavFlUCEn7b9EYWA9s-mfNpmcg.6YU9a4Cyaa9ekj-D575yZizQ1M6pYn9ALAt81dTzxJcg.PNG.zxcomet4561/b2.png?type=w800", comment: "감독님 너무 수고하셨습니다!!", gradeAvg: 3.6, date: "2023.04.14")
    ]
    
}
