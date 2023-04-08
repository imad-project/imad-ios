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
   
    
}
