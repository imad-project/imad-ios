//
//  CustomData.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/04/04.
//

import Foundation
import SwiftUI


class CustomData{
    static var  profileImage = "default_profile_image_3.png"
    
    static func decoding<V:Codable>(_ data:String)->V?{
        guard let jsonData = data.data(using: .utf8) else { return V.self as? V}
        do {  return try JSONDecoder().decode(V.self, from: jsonData) }
        catch{
            print("디코딩 에러 \(error)")
            return V.self as? V
        }
    }
    static func decoding<V:Codable>(_ data:String)->[V]{
        guard let jsonData = data.data(using: .utf8) else { return [] }
        do {  return try JSONDecoder().decode([V].self, from: jsonData) }
        catch{
            print("디코딩 에러 \(error)")
            return []
        }
    }
    
    static var user:UserResponse?{
        let data = """
        {
            "email": "testtest@gmail.com",
            "nickname": "Test",
            "auth_provider": "IMAD",
            "gender": "MALE",
            "birth_year": 1952,
            "age_range": 7,
            "profile_image": "default_profile_image_1.png",
            "role": "USER",
            "preferred_tv_genres": [
                16,
                10759
            ],
            "preferred_movie_genres": [
                16,
                28,
                12
            ]
        }
        """
        return decoding(data)
    }                                     //유저
    static var workImage:String{
        "https://www.ichigo.co.kr:5030/data/20/9784088820552_m.jpg"
    }                                       //이미지
    static var dummyString:String{
        "묻힌 때 경, 까닭이요, 사랑과 내 까닭입니다. 지나가는 멀리 시인의 하늘에는 프랑시스 못 가난한 우는 하나에 까닭입니다. 가을로 된 별 아무 우는 당신은 까닭이요, 듯합니다. 무덤 풀이 파란 릴케 봅니다. 오는 추억과 많은 이름과, 이름과 라이너 이름과, 비둘기, 까닭입니다. 별들을 나의 벌레는 피어나듯이 언덕 둘 지나가는 하나 거외다. 아이들의 별 하나에 불러 하나에 있습니다. 아무 했던 쓸쓸함과 동경과 노새, 하나에 많은 아름다운 토끼, 봅니다. 소녀들의 계집애들의 가슴속에 토끼, 남은 새겨지는 까닭입니다.\\n\\n지나고 라이너 무엇인지 봅니다. 써 덮어 않은 추억과 무엇인지 버리었습니다. 슬퍼하는 헤일 별 내일 위에 하나에 별을 계절이 파란 있습니다. 이네들은 이웃 가득 아무 된 별 동경과 봅니다. 벌써 노루, 시인의 계십니다. 어머님, 쉬이 아스라히 있습니다. 된 다 밤을 다 내 버리었습니다. 아름다운 파란 이런 자랑처럼 나의 하나에 보고, 쓸쓸함과 하나에 버리었습니다. 나는 딴은 별들을 있습니다. 부끄러운 별들을 별을 버리었습니다.\\n\\n파란 하나에 별 둘 소학교 버리었습니다. 흙으로 당신은 이웃 별이 마디씩 멀리 애기 이름자를 별 봅니다. 위에 별들을 별 어머님, 까닭입니다. 사람들의 그러나 당신은 옥 까닭입니다. 피어나듯이 마디씩 그리워 까닭입니다. 아직 어머니 피어나듯이 불러 나는 다 나는 어머님, 까닭입니다. 다하지 자랑처럼 프랑시스 가을 계십니다. 하나의 이름을 무엇인지 속의 어머니, 듯합니다. 겨울이 경, 나는 봅니다.\\n\\n그리워 사람들의 이름을 내 별 봄이 소학교 있습니다. 위에 내린 노새, 딴은 별이 이름을 사랑과 계십니다. 때 무엇인지 불러 내린 하늘에는 계십니다. 아침이 당신은 부끄러운 별들을 새겨지는 듯합니다. 프랑시스 오면 하나에 나는 내일 피어나듯이 나는 까닭입니다. 무덤 피어나듯이 이름자를 거외다. 어머님, 하나에 무엇인지 둘 별 계십니다. 강아지, 까닭이요, 멀리 릴케 오면 아름다운 하나의 별에도 어머니, 계십니다. 이름과, 어머니 계절이 계집애들의 우는 오는 경, 이런 나는 봅니다. 하나에 했던 하나의 별들을 까닭입니다."
    }                                     //긴 문자열
    static var comment:CommentResponse?{
        let data = """
            {
                "comment_id": 22,
                "posting_id": 7,
                "user_id": 27,
                "user_nickname": "콰랑쓰",
                "user_profile_image": "cee7bc15-085b-41e9-91e2-a147f433016f.jpg",
                "parent_id": null,
                "child_cnt": 0,
                "content": "이먼씹",
                "like_status": 0,
                "like_cnt": 1,
                "dislike_cnt": 1,
                "created_at": "2024-07-29T14:26:24.350836",
                "modified_at": "2024-07-29T14:26:24.350836",
                "author": false,
                "reported": false,
                "removed": false
            }
        """
        return decoding(data)
    }                               //댓글
    static var community:CommunityResponse?{
        let data = """
        {
                "posting_id": 7,
                "contents_id": 31,
                "contents_title": "내 마음의 위험한 녀석",
                "contents_poster_path": "/bn27ZxhxWmNiKHtPVrDdVEbhjX3.jpg",
                "contents_backdrop_path": "/4OZZJ18Mp1yNO2spKkDfz8KzLfa.jpg",
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "title": "진짜 너무달달해 ",
                "content": "이가 썩어 버릴것만같아 \\n연출도 좋고 \\n간질간질한 느낌도 너무 잘살렸쒀",
                "category": 1,
                "view_cnt": 178,
                "like_cnt": 1,
                "dislike_cnt": 2,
                "like_status": 0,
                "created_at": "2024-07-29T10:58:34.939086",
                "modified_at": "2024-07-29T10:58:34.939086",
                "comment_cnt": 5,
                "comment_list_response": {
                    "details_list": [
                        {
                            "comment_id": 22,
                            "posting_id": 7,
                            "user_id": 27,
                            "user_nickname": "콰랑쓰",
                            "user_profile_image": "cee7bc15-085b-41e9-91e2-a147f433016f.jpg",
                            "parent_id": null,
                            "child_cnt": 0,
                            "content": "이먼씹",
                            "like_status": 0,
                            "like_cnt": 1,
                            "dislike_cnt": 1,
                            "created_at": "2024-07-29T14:26:24.350836",
                            "modified_at": "2024-07-29T14:26:24.350836",
                            "author": false,
                            "reported": false,
                            "removed": false
                        },
                        {
                            "comment_id": 24,
                            "posting_id": 7,
                            "user_id": 14,
                            "user_nickname": "윤원이",
                            "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                            "parent_id": null,
                            "child_cnt": 1,
                            "content": "이먼씹은 너무하자나… 너도꼭보셈",
                            "like_status": 0,
                            "like_cnt": 1,
                            "dislike_cnt": 0,
                            "created_at": "2024-08-04T18:57:09.948067",
                            "modified_at": "2024-08-04T18:57:09.948067",
                            "author": false,
                            "reported": false,
                            "removed": false
                        },
                        {
                            "comment_id": 26,
                            "posting_id": 7,
                            "user_id": 14,
                            "user_nickname": "윤원이",
                            "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                            "parent_id": null,
                            "child_cnt": 0,
                            "content": "언릉3기내줘 ",
                            "like_status": 0,
                            "like_cnt": 0,
                            "dislike_cnt": 0,
                            "created_at": "2024-08-06T18:02:30.667297",
                            "modified_at": "2024-08-06T18:02:30.667297",
                            "author": false,
                            "reported": false,
                            "removed": false
                        }
                    ],
                    "total_elements": 3,
                    "total_pages": 1,
                    "page_number": 0,
                    "number_of_elements": 3,
                    "size_of_page": 10,
                    "sort_direction": 0,
                    "sort_property": "createdDate"
                },
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "author": false,
                "reported": false
            }
        """
        return decoding(data)
    }                           //게시물
    static var communityList:[CommunityDetailsListResponse]{
        let data = """
        [
            {
                "posting_id": 9,
                "contents_id": 212,
                "contents_title": "약속의 네버랜드",
                "contents_poster_path": "/ze3PDkMIfxndqvKPrW3Qk2ZhaPb.jpg",
                "user_id": 16,
                "user_nickname": "닝겐",
                "user_profile_image": "default_profile_image_5.png",
                "title": "개쩐다",
                "category": 1,
                "view_cnt": 8,
                "comment_cnt": 1,
                "like_cnt": 1,
                "dislike_cnt": 1,
                "like_status": 0,
                "created_at": "2024-10-08T16:50:37.692016",
                "modified_at": "2024-10-08T16:50:37.692016",
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "reported": false
            },
            {
                "posting_id": 8,
                "contents_id": 6,
                "contents_title": "하이큐!!",
                "contents_poster_path": "/8GpgkSjPlZv4Qr1qlc4elNU8tra.jpg",
                "user_id": 31,
                "user_nickname": "콰랑3",
                "user_profile_image": "c995a691-7371-413b-abe4-abffde20cad3.jpg",
                "title": "싱크로",
                "category": 1,
                "view_cnt": 28,
                "comment_cnt": 1,
                "like_cnt": 1,
                "dislike_cnt": 1,
                "like_status": 0,
                "created_at": "2024-08-03T14:01:34.713689",
                "modified_at": "2024-08-03T14:01:34.713689",
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "reported": false
            },
            {
                "posting_id": 7,
                "contents_id": 31,
                "contents_title": "내 마음의 위험한 녀석",
                "contents_poster_path": "/bn27ZxhxWmNiKHtPVrDdVEbhjX3.jpg",
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "title": "진짜 너무달달해 ",
                "category": 1,
                "view_cnt": 179,
                "comment_cnt": 5,
                "like_cnt": 1,
                "dislike_cnt": 2,
                "like_status": 0,
                "created_at": "2024-07-29T10:58:34.939086",
                "modified_at": "2024-07-29T10:58:34.939086",
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "reported": false
            },
            {
                "posting_id": 6,
                "contents_id": 22,
                "contents_title": "스위트홈",
                "contents_poster_path": "/eNfNu9sJ2eVmMcbrKpgEovPoyB8.jpg",
                "user_id": 4,
                "user_nickname": "콰광",
                "user_profile_image": "69172736-d6d7-4f38-8e47-86cbc3c5b4d1.jpg",
                "title": "개 노 잼",
                "category": 3,
                "view_cnt": 24,
                "comment_cnt": 0,
                "like_cnt": 0,
                "dislike_cnt": 0,
                "like_status": 0,
                "created_at": "2024-07-22T16:48:18.571167",
                "modified_at": "2024-07-22T16:48:18.571167",
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "reported": false
            },
            {
                "posting_id": 5,
                "contents_id": 2,
                "contents_title": "인사이드 아웃 2",
                "contents_poster_path": "/pmemGuhr450DK8GiTT44mgwWCP7.jpg",
                "user_id": 10,
                "user_nickname": "콰랑",
                "user_profile_image": "02214e3a-4e5a-4156-b1d1-ca4062e80528.jpg",
                "title": "님들 불안이 어떻게 생각함?",
                "category": 3,
                "view_cnt": 39,
                "comment_cnt": 1,
                "like_cnt": 0,
                "dislike_cnt": 0,
                "like_status": 0,
                "created_at": "2024-07-20T20:51:30.440958",
                "modified_at": "2024-07-20T20:51:30.440958",
                "scrap_id": null,
                "scrap_status": false,
                "spoiler": false,
                "reported": false
            }
        ]
        """
        return decoding(data)
    }           //게시물 리스트
    static var communityDetails:CommunityDetailsListResponse?{
        let data = """
        {
            "posting_id": 7,
            "contents_id": 31,
            "contents_title": "내 마음의 위험한 녀석",
            "contents_poster_path": "/bn27ZxhxWmNiKHtPVrDdVEbhjX3.jpg",
            "user_id": 14,
            "user_nickname": "윤원이",
            "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
            "title": "진짜 너무달달해 ",
            "category": 1,
            "view_cnt": 179,
            "comment_cnt": 5,
            "like_cnt": 1,
            "dislike_cnt": 2,
            "like_status": 0,
            "created_at": "2024-07-29T10:58:34.939086",
            "modified_at": "2024-07-29T10:58:34.939086",
            "scrap_id": null,
            "scrap_status": false,
            "spoiler": false,
            "reported": false
        }
        """
        return decoding(data)
    }         //게시물 리스트 아이템
    static var commentList:[CommentResponse]{
    let data = """
    [
            {
                "comment_id": 22,
                "posting_id": 7,
                "user_id": 27,
                "user_nickname": "콰랑쓰",
                "user_profile_image": "cee7bc15-085b-41e9-91e2-a147f433016f.jpg",
                "parent_id": null,
                "child_cnt": 0,
                "content": "이먼씹",
                "like_status": 0,
                "like_cnt": 1,
                "dislike_cnt": 1,
                "created_at": "2024-07-29T14:26:24.350836",
                "modified_at": "2024-07-29T14:26:24.350836",
                "author": false,
                "reported": false,
                "removed": false
            },
            {
                "comment_id": 24,
                "posting_id": 7,
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "parent_id": null,
                "child_cnt": 1,
                "content": "이먼씹은 너무하자나… 너도꼭보셈",
                "like_status": 0,
                "like_cnt": 1,
                "dislike_cnt": 0,
                "created_at": "2024-08-04T18:57:09.948067",
                "modified_at": "2024-08-04T18:57:09.948067",
                "author": false,
                "reported": false,
                "removed": false
            },
            {
                "comment_id": 26,
                "posting_id": 7,
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "parent_id": null,
                "child_cnt": 0,
                "content": "언릉3기내줘 ",
                "like_status": 0,
                "like_cnt": 0,
                "dislike_cnt": 0,
                "created_at": "2024-08-06T18:02:30.667297",
                "modified_at": "2024-08-06T18:02:30.667297",
                "author": false,
                "reported": false,
                "removed": false
            }
    ]
    """
    return decoding(data)
}                          //댓글 리스트
    static var rankingList:[RankingResponseList]{
        let data = """
        [
            {
                "contents_id": 17,
                "contents_type": "TV",
                "imad_score": 6.75,
                "title": "더 보이즈",
                "poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
                "ranking": 1,
                "ranking_changed": 0
            },
            {
                "contents_id": 22,
                "contents_type": "TV",
                "imad_score": null,
                "title": "스위트홈",
                "poster_path": "/eNfNu9sJ2eVmMcbrKpgEovPoyB8.jpg",
                "ranking": 2,
                "ranking_changed": 0
            },
            {
                "contents_id": 6,
                "contents_type": "ANIMATION",
                "imad_score": null,
                "title": "하이큐!!",
                "poster_path": "/8GpgkSjPlZv4Qr1qlc4elNU8tra.jpg",
                "ranking": 3,
                "ranking_changed": 0
            },
            {
                "contents_id": 52,
                "contents_type": "TV",
                "imad_score": null,
                "title": "엄브렐러 아카데미",
                "poster_path": "/UBhjjSojL8z2ThtitnyWaKM8nq.jpg",
                "ranking": 4,
                "ranking_changed": 0
            },
            {
                "contents_id": 26,
                "contents_type": "MOVIE",
                "imad_score": null,
                "title": "세 얼간이",
                "poster_path": "/9zQdFVyDoXqFmGYXp4obna6FEMh.jpg",
                "ranking": 5,
                "ranking_changed": 0
            },
            {
                "contents_id": 24,
                "contents_type": "MOVIE",
                "imad_score": null,
                "title": "라이프 오브 파이",
                "poster_path": "/mexaTje46m4uJ9YToFUydtZuqaL.jpg",
                "ranking": 6,
                "ranking_changed": 0
            },
            {
                "contents_id": 23,
                "contents_type": "ANIMATION",
                "imad_score": null,
                "title": "임금님 랭킹",
                "poster_path": "/e3LbjV2jpNaull04dNuTBbKWw0Q.jpg",
                "ranking": 7,
                "ranking_changed": 0
            },
            {
                "contents_id": 212,
                "contents_type": "ANIMATION",
                "imad_score": 10.0,
                "title": "약속의 네버랜드",
                "poster_path": "/ze3PDkMIfxndqvKPrW3Qk2ZhaPb.jpg",
                "ranking": 8,
                "ranking_changed": 0
            },
            {
                "contents_id": 31,
                "contents_type": "ANIMATION",
                "imad_score": null,
                "title": "내 마음의 위험한 녀석",
                "poster_path": "/bn27ZxhxWmNiKHtPVrDdVEbhjX3.jpg",
                "ranking": 9,
                "ranking_changed": 0
            },
            {
                "contents_id": 84,
                "contents_type": "ANIMATION",
                "imad_score": 8.05555,
                "title": "The Boondocks",
                "poster_path": "/vAvT2RXjOpgH0COriRm9riPqA0m.jpg",
                "ranking": 10,
                "ranking_changed": 0
            }
        ]
        """
        return decoding(data)
    }                      //랭킹 리스트
    static var bookmarkList:[BookmarkListResponse]{
        let data = """
        [
            {
                "bookmark_id": 35,
                "user_id": 20,
                "contents_id": 7,
                "contents_title": "귀멸의 칼날: 인연의 기적, 그리고 합동 강화 훈련으로",
                "contents_poster_path": "/nVCYJqqNp3AWKi8rfLqBaCgWabO.jpg",
                "created_date": "2024-10-10T11:26:55.065891"
            },
            {
                "bookmark_id": 36,
                "user_id": 20,
                "contents_id": 8,
                "contents_title": "극장판 귀멸의 칼날: 무한열차편",
                "contents_poster_path": "/mxdVTei65ymzhJlalIEtR1qSgV2.jpg",
                "created_date": "2024-10-10T11:27:10.6151"
            },
            {
                "bookmark_id": 37,
                "user_id": 20,
                "contents_id": 9,
                "contents_title": "포켓몬스터",
                "contents_poster_path": "/bHBf7URUEZGUPORE6dp1hDtSUt9.jpg",
                "created_date": "2024-10-10T11:27:12.988347"
            },
            {
                "bookmark_id": 38,
                "user_id": 20,
                "contents_id": 10,
                "contents_title": "범죄도시 4",
                "contents_poster_path": "/h1YarEjeYurkAwXgfY1RDMVCiin.jpg",
                "created_date": "2024-10-10T11:27:15.313408"
            },
            {
                "bookmark_id": 39,
                "user_id": 20,
                "contents_id": 11,
                "contents_title": "댓글부대",
                "contents_poster_path": "/eR7ybceTRhBFjsdlshXqAAihBFg.jpg",
                "created_date": "2024-10-10T11:27:17.335863"
            }
        ]
        """
        return decoding(data)
    }                    //북마크 리스트
    static var workInfo:WorkResponse?{
        let data = """
        {
            "genres": [
                16,
                10759,
                10765
            ],
            "production_countries": [
                "JP"
            ],
            "contents_id": 37,
            "tmdb_id": 45790,
            "tmdb_type": "TV",
            "overview": "유서 깊은 죠스타 가문에 얽힌 기묘한 이야기를 아는가. 각기 다른 세상에서 애칭 '죠죠'를 공유하며 살아가는 주인공들. 시간적 공간적 배경은 달라도, 추구하는 가치는 다르지 않다. 악의 세력을 물리치고 정의가 이기는 세상을 만들라.",
            "tagline": "",
            "poster_path": "/9kav2ODiGILqV86XWSUn6g4KQq5.jpg",
            "backdrop_path": "/mLKN1dsimKPiXCZ48KED0X8a02t.jpg",
            "original_language": "ja",
            "certification": "NONE",
            "status": "Returning Series",
            "contents_type": "ANIMATION",
            "review_cnt": 0,
            "imad_score": null,
            "title": null,
            "original_title": null,
            "release_date": null,
            "runtime": 0,
            "name": "죠죠의 기묘한 모험",
            "original_name": "ジョジョの奇妙な冒険",
            "first_air_date": "2012-10-06",
            "last_air_date": "2023-04-08",
            "number_of_episodes": 190,
            "number_of_seasons": 5,
            "seasons": [
                {
                    "air_date": "2017-09-20",
                    "id": 62290,
                    "name": "스페셜",
                    "episode_count": 7,
                    "overview": "",
                    "poster_path": "/gRBIiTPNDOYpkdTKa5ZXhzFUSsu.jpg",
                    "season_number": 0
                },
                {
                    "air_date": "2012-10-06",
                    "id": 54261,
                    "name": "1부: 팬텀 블러드 & 2부: 전투조류",
                    "episode_count": 26,
                    "overview": "19세기 영국에서 이야기를 시작하면서, 젊은 귀족 조나단 죠스타는 디오의 아버지가 죽은 후 조나단의 아버지가 그의 아래로 데려온 천한 소년 디오 브란도와 쓰라린 경쟁에 갇힌 자신을 발견합니다. 자신의 삶의 위치에 불만을 품은 디오는 모든 것을 다스리고자 하는 무한한 욕망으로 인해 결국 죠스타가 소유한 고대 아즈텍 석가면의 초자연적인 힘을 찾게 됩니다. 이 유물은 앞으로 몇 세대 동안 디오와 조나단의 운명을 영원히 바꿀 유물입니다. 50년 후인 1938년 뉴욕 시에서 조나단의 손자 조셉 죠스타는 할아버지의 임무를 맡아 돌 가면과 인류의 존재 자체를 위협하는 엄청나게 강력한 창조주인 필라 맨을 파괴하는 데 필요한 능력을 마스터해야 합니다.",
                    "poster_path": "/8ZigI2GqI8Kk6WsmoA8HjSLeAwc.jpg",
                    "season_number": 1
                },
                {
                    "air_date": "2014-04-05",
                    "id": 62288,
                    "name": "3부: 스타더스트 크루세이더즈",
                    "episode_count": 48,
                    "overview": "일본 감옥에 17세 Kujo Jotaro가 앉아 있습니다. 전 세계에서 악령들이 깨어나고 있습니다. 스탠드(Stands)는 들고 있는 사람에게 놀라운 힘을 주는 보이지 않는 괴물입니다. 어머니의 생명을 구하기 위해 죠타로는 어둠의 세력을 길들이고 가족의 피를 갈망하는 100세 뱀파이어가 있는 이집트 카이로로 전 세계를 여행해야 합니다. 하지만 갈 길은 멀고 사악한 스탠드 유저들의 군대는 죠죠와 그의 친구들을 죽이기 위해 기다리고 있습니다...",
                    "poster_path": "/4nKwMFs5gkr5Zb1GxQUp0D2gfZq.jpg",
                    "season_number": 2
                },
                {
                    "air_date": "2016-04-02",
                    "id": 64407,
                    "name": "4부: 다이아몬드는 부서지지 않는다",
                    "episode_count": 39,
                    "overview": "해안 마을 모리오(Morioh)는 범죄자와 일반인 모두에게 잠재된 기립 능력을 나타내는 고대 유물인 활과 화살에 시달리고 있습니다. Morioh에서 엄청난 양의 스탠드 사용자 유입을 처리하는 동시에 고등학생인 Josuke Higashikata와 그의 친구들은 일련의 살인 사건의 범인을 찾고 있습니다.",
                    "poster_path": "/66FyZpTZ6s9Il12TJ2q4OV75Xrq.jpg",
                    "season_number": 3
                },
                {
                    "air_date": "2018-10-06",
                    "id": 105428,
                    "name": "5부: 황금의 바람",
                    "episode_count": 39,
                    "overview": "Naples, 2001. Giorno Giovanna는 갱스타가 되는 것이 하나의 큰 꿈을 가진 작은 사기꾼입니다. 평범한 도둑이 아닌 Giorno는 놀라운 Joestar 혈통과 연결되어 있으며 Gold Experience라는 스탠드를 보유하고 있습니다. 그의 꿈은 갱 Passione의 마피아이자 동료 Stand 사용자인 Bruno Bucciarati를 만나면서 현실이 되기 시작합니다. 그들이 비슷한 이상을 공유하고 있고 둘 다 갱단의 해로운 일에 동의하지 않는다는 것을 깨달은 Giorno는 Bruno에게 자신의 목표를 밝혔습니다. Bruno의 도움으로 그는 보스를 타도함으로써 Passion을 개혁할 것입니다.\\n\\nGiorno가 Passione의 일원이 되고 Bruno의 분대에 합류하면서 그는 그것이 단순한 갱단이 아님을 알게 됩니다. 그 숫자는 스탠드 사용자로 가득 차 있습니다. 이제 서로 다른 충성도와 예측할 수 없는 능력을 가진 다른 분대와 마주하게 되면서 갱단을 내부에서 외부로 바꾸려는 그들의 목표는 험난한 것이 될 것입니다. 이러한 적들과 맞서면서 Giorno는 계급을 오르고 수수께끼에 싸인 보스인 보스에게 조금 더 가까이 다가가려고 합니다.",
                    "poster_path": "/xGzZa20Bp2Qf6Ztb8RsX3TqzMTM.jpg",
                    "season_number": 4
                },
                {
                    "air_date": "2022-01-08",
                    "id": 189107,
                    "name": "6부: 스톤 오션",
                    "episode_count": 38,
                    "overview": "2011년 미국 플로리다. 연인과 함께 운전하던 중 사고를 당한 Jolyne Cujoh는 함정에 빠지고 국영 최대 보안 교도소인 Green Dolphin Street Prison(일명 수족관)에서 15년형을 선고받습니다. 절망의 위기에 처한 그녀는 아버지로부터 자신의 내면에 신비한 힘을 불러일으키는 펜던트를 받습니다. 이 세상에는 죽음보다 더 무서운 것이 있고, 이 감옥에서 일어나는 일은 분명히 그 중 하나입니다. 졸린 앞에 나타난 의문의 소년의 메시지, 연이어 일어나는 알 수 없는 사건들, 그녀를 찾아온 아버지가 그녀에게 들려주는 무서운 진실, 그리고 디오라는 이름…",
                    "poster_path": "/4wqWh3sMdxgtC3mM0SG8qrZKTgq.jpg",
                    "season_number": 5
                }
            ],
            "networks": [
                {
                    "id": 614,
                    "logo_path": "/hSdroyVthq3CynxTIIY7lnS8w1.png",
                    "name": "Tokyo MX",
                    "origin_country": "JP"
                },
                {
                    "id": 861,
                    "logo_path": "/JQ5bx6n7Qmdmyqz6sqjo5Fz2iR.png",
                    "name": "BS11",
                    "origin_country": "JP"
                }
            ],
            "bookmark_id": null,
            "bookmark_status": false,
            "review_id": null,
            "review_status": false,
            "credits": {
                "cast": [
                    {
                        "gender": "MALE",
                        "id": 1241498,
                        "credit_id": "576ed3ffc3a3687459001208",
                        "name": "오노 다이스케",
                        "profile_path": "/5rjl28lx84JjRS0hzq3Ajvx2dhp.jpg",
                        "character": "Jotaro Kujo (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "FEMALE",
                        "id": 2359492,
                        "credit_id": "6069af3ca14bef007928933a",
                        "name": "파이루즈 아이",
                        "profile_path": "/coFu6WOVBZvqd1fw89vbHkiC0zB.jpg",
                        "character": "Jolyne Cujoh (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "FEMALE",
                        "id": 1253972,
                        "credit_id": "610fdc58960cde00293107b9",
                        "name": "타무라 무츠미",
                        "profile_path": "/uvbBIRiBK6GDLEESiYSFWOVlaE4.jpg",
                        "character": "Ermes Costello (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "FEMALE",
                        "id": 1250465,
                        "credit_id": "610fdc668c44b90082039db9",
                        "name": "이세 마리야",
                        "profile_path": "/tQWlgrlQ70biWdg7x9E75CtwsuD.jpg",
                        "character": "Foo Fighters (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "FEMALE",
                        "id": 1588597,
                        "credit_id": "610fdc7a960cde005c7e8e16",
                        "name": "타네자키 아츠미",
                        "profile_path": "/6tM8GU7QvrdUCvR4kxqVUZivtvO.jpg",
                        "character": "Emporio Alniño (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "MALE",
                        "id": 1483496,
                        "credit_id": "610fdc8c01e4d1005e8d3a40",
                        "name": "우메하라 유이치로",
                        "profile_path": "/v28IZwmQGqrtyljNdzcKELV5t9m.jpg",
                        "character": "Weather Report (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    },
                    {
                        "gender": "MALE",
                        "id": 110665,
                        "credit_id": "610fdc9f5c5cc8004666db6e",
                        "name": "나미카와 다이스케",
                        "profile_path": "/iw0X8oDutxaBAri3Ifga8nhdUJK.jpg",
                        "character": "Narciso Anasui (voice)",
                        "known_for_department": "Acting",
                        "department": null,
                        "job": null,
                        "importance_order": 0,
                        "credit_type": "CAST"
                    }
                ],
                "crew": [
                    {
                        "gender": "MALE",
                        "id": 1898696,
                        "credit_id": "60154b73cb8028003e0b97c2",
                        "name": "하야시 토시야스",
                        "profile_path": null,
                        "character": null,
                        "known_for_department": "Production",
                        "department": "Production",
                        "job": "Producer",
                        "importance_order": 0,
                        "credit_type": "CREW"
                    },
                    {
                        "gender": "MALE",
                        "id": 2102828,
                        "credit_id": "61a7491dbe4b36006a74c582",
                        "name": "小澤文啓",
                        "profile_path": null,
                        "character": null,
                        "known_for_department": "Production",
                        "department": "Production",
                        "job": "Producer",
                        "importance_order": 0,
                        "credit_type": "CREW"
                    },
                    {
                        "gender": "FEMALE",
                        "id": 1579843,
                        "credit_id": "61a749294a52f80064312331",
                        "name": "土肥範子",
                        "profile_path": null,
                        "character": null,
                        "known_for_department": "Production",
                        "department": "Production",
                        "job": "Producer",
                        "importance_order": 0,
                        "credit_type": "CREW"
                    },
                    {
                        "gender": "MALE",
                        "id": 3331148,
                        "credit_id": "61a74974ec8a430063ec2b77",
                        "name": "Takamitsu Sueyoshi",
                        "profile_path": null,
                        "character": null,
                        "known_for_department": "Production",
                        "department": "Production",
                        "job": "Producer",
                        "importance_order": 0,
                        "credit_type": "CREW"
                    }
                ]
            }
        }
        """
        return decoding(data)
    }                                 //작품정보
    static var workList:[WorkListResponse]{
        let data = """
        [
            {
                "id": 1022789,
                "title": "인사이드 아웃 2",
                "original_title": "Inside Out 2",
                "release_date": "2024-06-11",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg",
                "overview": "13살이 된 라일리의 행복을 위해 매일 바쁘게 머릿속 감정 컨트롤 본부를 운영하는 ‘기쁨’, ‘슬픔’, ‘버럭’, ‘까칠’, ‘소심’. 그러던 어느 날, 낯선 감정인 ‘불안’, ‘당황’, ‘따분’, ‘부럽’이가 본부에 등장하고, 언제나 최악의 상황을 대비하며 제멋대로인 ‘불안’이와 기존 감정들은 계속 충돌한다. 결국 새로운 감정들에 의해 본부에서 쫓겨나게 된 기존 감정들은 다시 본부로 돌아가기 위해 위험천만한 모험을 시작하는데…",
                "poster_path": "/x2BHx02jMbvpKjMvbf8XxJkYwHJ.jpg",
                "media_type": null,
                "genre_ids": [
                    16,
                    10751,
                    12,
                    35,
                    18
                ],
                "video": false
            },
            {
                "id": 889737,
                "title": "조커: 폴리 아 되",
                "original_title": "Joker: Folie à Deux",
                "release_date": "2024-10-01",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/reNf6GBzOe48l9WEnFOxXgW56Vg.jpg",
                "overview": "2년 전, 세상을 뒤흔들며 고담시 아이콘으로 자리한 아서 플렉은 아캄 수용소에 갇혀 최종 재판을 앞둔 무기력한 삶을 살아간다. 그러던 어느 날, 수용소에서 운명적으로 만난 리 퀸젤은 아서의 삶을 다시 뒤바꾸며 그의 마음 속에 잠들어 있던 조커를 깨우고 리 역시 각성하며 자신을 할리 퀸이라 지칭하며 서로에게 깊이 빠져든다. 무고한 시민을 죽인 죄로 재판에 오르게 된 아서. 그는 최후의 심판대에서 할리 퀸과 함께 자신, 조커의 이야기를 시작하는데…",
                "poster_path": "/dA1TGJPTVjlqPc8PiEE2PfvFBUp.jpg",
                "media_type": null,
                "genre_ids": [
                    18,
                    80,
                    53
                ],
                "video": false
            },
            {
                "id": 807339,
                "title": "아파트 7A",
                "original_title": "Apartment 7A",
                "release_date": "2024-09-20",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/bGwBlxl9Ht2zljBHfNQD0YCEtrk.jpg",
                "overview": "A struggling young dancer finds herself drawn in by dark forces when a peculiar, well-connected older couple promise her a shot at fame.",
                "poster_path": "/uipHKJHY1nNEQyprXjfNzH0GIOF.jpg",
                "media_type": null,
                "genre_ids": [
                    27,
                    53
                ],
                "video": false
            },
            {
                "id": 614933,
                "title": "아틀라스",
                "original_title": "Atlas",
                "release_date": "2024-05-23",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/3TNSoa0UHGEzEz5ndXGjJVKo8RJ.jpg",
                "overview": "AI를 극도로 불신하는 탁월한 대테러 분석가. 로봇 반역자를 체포하러 나선 임무가 틀어지면서, AI에 의지할 수밖에 없는 상황을 맞닥뜨린다.",
                "poster_path": "/4kiTWS2p1dCIKZI0pQwDfRdhWm6.jpg",
                "media_type": null,
                "genre_ids": [
                    878,
                    28
                ],
                "video": false
            },
            {
                "id": 76600,
                "title": "아바타: 물의 길",
                "original_title": "Avatar: The Way of Water",
                "release_date": "2022-12-14",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/8rpDcsfLJypbO6vREc0547VKqEv.jpg",
                "overview": "판도라 행성에서 제이크 설리와 네이티리가 이룬 가족이 겪게 되는 무자비한 위협과 살아남기 위해 떠나야 하는 긴 여정과 전투, 그리고 견뎌내야 할 상처에 대한 이야기를 그렸다. 살아남기 위해 설리 가족이 숲에서 바다로 터전을 옮기면서 겪게 되는 화합의 과정, 그리고 곳곳에서 도사리는 새로운 위협까지 역경 속에서 더 아름답게 펼쳐진다.",
                "poster_path": "/z56bVX93oRG6uDeMACR7cXCnAbh.jpg",
                "media_type": null,
                "genre_ids": [
                    878,
                    12,
                    28
                ],
                "video": false
            },
            {
                "id": 729165,
                "title": "아웃 오브 에그자일",
                "original_title": "Out of Exile",
                "release_date": "2023-01-20",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/wPNI1fd18z5TKBOK9Mv9Rfjb0j0.jpg",
                "overview": "Recently paroled thief Gabriel Russell tries to balance his life and mend a troubled family as an FBI agent hunts him down, along with his crew after a botched armored car robbery.",
                "poster_path": "/jgF5XaXnJmOgMxulhy2k1f9LNNc.jpg",
                "media_type": null,
                "genre_ids": [
                    53,
                    18,
                    28,
                    80
                ],
                "video": false
            },
            {
                "id": 931461,
                "title": "아메리칸 드리머",
                "original_title": "American Dreamer",
                "release_date": "2022-11-04",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/jurbAGpwehygdxmcdnLAFjoMfTv.jpg",
                "overview": "In this winsome comedy, an entitled Economics professor pursues a tactic to buy an ailing widow’s mansion for nothing, but he quickly realizes that his seemingly foolproof strategy won’t be as easy as he thought.",
                "poster_path": "/9bUsa318eCnztKZlcG86s8xk9Rk.jpg",
                "media_type": null,
                "genre_ids": [
                    35
                ],
                "video": false
            },
            {
                "id": 1001311,
                "title": "센강 아래",
                "original_title": "Sous la Seine",
                "release_date": "2024-06-04",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "fr",
                "adult": false,
                "backdrop_path": "/iwkWvcXcP8M4r9HLglhVEhgGyVu.jpg",
                "overview": "국제 대회를 앞둔 파리의 센강에 거대한 상어가 나타난다. 유혈 사태를 막고자 소환되는 한 과학자. 당면한 문제를 해결하려면, 자신을 사로잡고 있는 과거의 비극부터 마주해야 한다.",
                "poster_path": "/iqTyxjbtWImvdXysxqvLzTF2sHB.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    18,
                    27,
                    53
                ],
                "video": false
            },
            {
                "id": 19995,
                "title": "아바타",
                "original_title": "Avatar",
                "release_date": "2009-12-15",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/vL5LR6WdxWPjLPFRLe133jXWsh5.jpg",
                "overview": "가까운 미래, 지구는 에너지 고갈 문제를 해결하기 위해 머나먼 행성 판도라에서 대체 자원을 채굴하기 시작한다. 하지만 판도라의 독성을 지닌 대기로 인해 자원 획득에 어려움을 겪게 된 인류는 판도라의 토착민 나비의 외형에 인간의 의식을 주입, 원격 조종이 가능한 새로운 생명체를 탄생시키는 프로그램을 개발한다. 한편 하반신이 마비된 전직 해병대원 제이크 설리는 아바타 프로그램에 참가할 것을 제안받는다. 그 곳에서 자신의 아바타를 통해 자유롭게 걸을 수 있게 된 제이크는 자원 채굴을 막으려는 나비의 무리에 침투하라는 임무를 부여받는데...",
                "poster_path": "/idvaCRXzHxiUprGBCpp7s7CSRhP.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    12,
                    14,
                    878
                ],
                "video": false
            },
            {
                "id": 150540,
                "title": "인사이드 아웃",
                "original_title": "Inside Out",
                "release_date": "2015-06-17",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/j29ekbcLpBvxnGk6LjdTc2EI5SA.jpg",
                "overview": "모든 사람의 머릿속에 존재하는 감정 컨트롤 본부. 그곳에서 불철주야 열심히 일하는 기쁨, 슬픔, 버럭, 까칠, 소심 다섯 감정들. 정든 옛 동네를 떠나 도시로 이사하는 라일리 가족. 이사 후 새로운 환경에 적응해야 하는 라일리를 위해 그 어느 때 보다 바쁘게 감정의 신호를 보내지만 우연한 실수로 기쁨과 슬픔이 본부를 이탈하게 되자 라일리의 마음 속에 큰 변화가 찾아온다. 라일리가 예전의 모습을 되찾기 위해서는 기쁨과 슬픔이 본부로 돌아가야만 한다. 그러나 엄청난 기억들이 저장되어 있는 머릿속 세계에서 본부까지 가는 길은 험난하기만 한데...",
                "poster_path": "/rMXHvHzpuYZXrJUhRVJ3TvDSwe5.jpg",
                "media_type": null,
                "genre_ids": [
                    16,
                    10751,
                    12,
                    18,
                    35
                ],
                "video": false
            },
            {
                "id": 10138,
                "title": "아이언맨 2",
                "original_title": "Iron Man 2",
                "release_date": "2010-04-28",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/7lmBufEG7P7Y1HClYK3gCxYrkgS.jpg",
                "overview": "세계 최강의 무기업체를 이끄는 CEO이자, 타고난 매력으로 화려한 삶을 살아가던 토니 스타크. 기자회견을 통해 자신이 아이언맨이라고 정체를 밝힌 이후, 정부로부터 아이언맨 수트를 국가에 귀속시키라는 압박을 받지만 이를 거부한다. 스타크 인더스트리의 운영권까지 수석 비서였던 페퍼 포츠에게 일임하고 히어로로서의 인기를 만끽하며 지내던 토니 스타크. 하지만 그 시각, 아이언맨의 수트 기술을 스타크 가문에 빼앗긴 후 쓸쓸히 돌아가신 아버지의 복수를 다짐해 온 위플래시는 수트의 원천 기술 개발에 성공, 치명적인 무기를 들고 직접 토니 스타크를 찾아 나선다.",
                "poster_path": "/ebJbC9OYAZJxy7bRUGryR72hfa2.jpg",
                "media_type": null,
                "genre_ids": [
                    12,
                    28,
                    878
                ],
                "video": false
            },
            {
                "id": 51608,
                "title": "아저씨",
                "original_title": "아저씨",
                "release_date": "2010-08-04",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "ko",
                "adult": false,
                "backdrop_path": "/8ZNwaC77ytOLSIamcBPnVqdZbmw.jpg",
                "overview": "불행한 사건으로 아내를 잃고 세상을 등진 채 전당포를 꾸려가며 외롭게 살아가는 전직 특수요원 태식. 찾아오는 사람이라곤 전당포에 물건을 맡기러 오는 사람들과 옆집소녀 소미뿐이다. 세상으로부터 버림받은 소미와 함께 보내는 시간이 많아지면서 태식과 소미는 서로 마음을 열며 친구가 되어간다.  그러던 어느 날 소미의 엄마가 범죄단체 연루되고 태식의 눈앞에서 소미가 납치되는데...",
                "poster_path": "/xmD04pnMIO0FUe0FJc8rHjfi6vY.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    53,
                    80
                ],
                "video": false
            },
            {
                "id": 673,
                "title": "해리 포터와 아즈카반의 죄수",
                "original_title": "Harry Potter and the Prisoner of Azkaban",
                "release_date": "2004-05-31",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/obKmfNexgL4ZP5cAmzdL4KbHHYX.jpg",
                "overview": "13세가 된 해리 포터는 또 한번의 여름 방학을 이모 가족인 더즐리 일가와 우울하게 보내야 했다. 물론 마법을 쓰는 건 일체 금지. 하지만, 버논 이모부의 누이인 마지 아줌마가 더즐리 가를 방문하면서 상황은 변한다. 위압적인 마지는 해리에겐 늘 공포의 대상. 마지 아줌마 때문에 스트레스를 받던 해리는 급기야 실수로 그녀를 거대한 괴물 풍선으로 만들어 하늘 높이 띄워 보내버리고 만다. 이모와 이모부에게 벌을 받을 것도 두렵고, 일반 세상에선 마법 사용이 금지돼 있는 것을 어겼기 때문에 호그와트 마법학교와 마법부의 징계가 걱정된 해리는 밤의 어둠 속으로 도망치지만, 순식간에 근사한 보라색 3층 버스에 태워져 한 술집으로 인도되고 마는데...",
                "poster_path": "/anwNl1xbzXoj5Ax1nVw3WoDzHlw.jpg",
                "media_type": null,
                "genre_ids": [
                    12,
                    14
                ],
                "video": false
            },
            {
                "id": 1579,
                "title": "아포칼립토",
                "original_title": "Apocalypto",
                "release_date": "2006-12-07",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/hMl124Go2Ed9Qu8VsPLiA3nBSMk.jpg",
                "overview": "마야 문명이 번창하던 시절, 평화로운 부족 마을의 젊은 전사 표범 발은 가족과 함께 행복한 나날을 보내며 살아가고 있다. 어느 날, 잔인한 전사로 구성된 침략자들이 마을을 습격하여 부족민을 학살하고 젊은 남녀를 그들의 왕국으로 끌고 가는 일이 발생한다. 표범 발은 이 혼란 속에 그의 아내와 어린 아들을 깊숙한 우물에 숨긴 채 자신은 인질로 끌려가게 된다. 죽음과 마주친 위기 상황에서 겨우 탈출한 표범 발은 우물 속에 숨겨둔 가족에게 돌아가려 하지만 적들의 집요한 추적은 계속된다. 생명을 위협하는 죽음의 손길이 조금씩 다가오는 가운데, 표범 발은 도리어 적들을 향해 기상천외한 공격을 하기 시작하는데...",
                "poster_path": "/mAFf4oW3XiH4IlFJw6dgwNnEPhg.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    18,
                    36
                ],
                "video": false
            },
            {
                "id": 271110,
                "title": "캡틴 아메리카: 시빌 워",
                "original_title": "Captain America: Civil War",
                "release_date": "2016-04-27",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/wdwcOBMkt3zmPQuEMxB3FUtMio2.jpg",
                "overview": "어벤져스가 벌인 전투로 많은 사람들이 불의의 사고를 당하는 등 부수적인 피해가 일어나자 정부는 슈퍼히어로 등록제를 추진하려 한다. 어벤져스의 독자적인 판단에 맡기기보다 직접 관리, 감독하겠다는 게 정부의 속내. 아이언맨은 정부의 방침을 따라야 한다는 입장인 반면, 캡틴 아메리카는 정부의 감시 없이 자유롭게 지구를 지켜야 한다고 주장한다. 어벤져스 내부는 캡틴 아메리카(윈터 솔져, 팔콘, 호크아이, 스칼렛 위치, 앤트맨)와 아이언맨(블랙위도우, 워머신, 블랙 팬서, 비전, 스파이더맨) 두 입장으로 나뉘어 대립하게 되는데...",
                "poster_path": "/vaMRzME3Dt73robEjOtDw4SPJGA.jpg",
                "media_type": null,
                "genre_ids": [
                    12,
                    28,
                    878
                ],
                "video": false
            },
            {
                "id": 1019420,
                "title": "아이리시 위시",
                "original_title": "Irish Wish",
                "release_date": "2024-03-14",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/qz2QzkYzesbbL94rdUpZrFPhlRe.jpg",
                "overview": "꿈에 그리던 남자가 며칠 후 절친과 결혼하게 되어 마음이 복잡한 매디. 아일랜드의 고대 바위에 진정한 사랑에 대한 소원을 빌고 나니 운명이 마법처럼 뒤바뀌어 버렸다.",
                "poster_path": "/oYwj0SPbvhGzQdrlZPFEEGvrZ4A.jpg",
                "media_type": null,
                "genre_ids": [
                    10749,
                    35,
                    14
                ],
                "video": false
            },
            {
                "id": 1726,
                "title": "아이언맨",
                "original_title": "Iron Man",
                "release_date": "2008-04-30",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/cyecB7godJ6kNHGONFjUyVN9OX5.jpg",
                "overview": "천재적인 두뇌와 재능으로 세계 최강의 무기업체를 이끄는 CEO이자, 타고난 매력으로 셀러브리티 못지않은 화려한 삶을 살아가던 억만장자 토니 스타크. 아프가니스탄에서 자신이 개발한 신무기 발표를 성공리에 마치고 돌아가던 그는 게릴라군의 갑작스런 공격에 의해 가슴에 치명적인 부상을 입고 게릴라군에게 납치된다. 가까스로 목숨을 건진 그에게 게릴라군은 자신들을 위한 강력한 무기를 개발하라며 그를 위협한다. 그러나 그는 게릴라군을 위한 무기 대신, 탈출을 위한 무기가 장착된 철갑수트를 몰래 만드는 데 성공하고, 그의 첫 수트인 ‘Mark1’를 입고 탈출에 성공한다. 미국으로 돌아온 토니 스타크는 자신이 만든 무기가 많은 사람들의 생명을 위협하고, 세상을 엄청난 위험에 몰아넣고 있다는 사실을 깨닫고 무기사업에서 손 뗄 것을 선언한다. 그리고, Mark1을 토대로 최강의 하이테크 수트를 개발하는 데 자신의 천재적인 재능과 노력을 쏟아 붓기 시작한다. 탈출하는 당시 부서져버린 Mark1을 바탕으로 보다 업그레이드 된 수트 Mark2를 만들어낸 토니 스타크. 거기에 만족하지 않고, 숱한 시행착오와 실패 끝에 자신의 모든 능력과 현실에서 가능한 최강의 최첨단 과학 기술이 집적된 하이테크 수트 Mark3를 마침내 완성, 최강의 슈퍼히어로 ‘아이언맨’으로 거듭난다. 토니 스타크가 탈출하는 과정을 통해 Mark1의 가공할 위력을 확인한 게릴라 군은 토니 스타크가 미처 회수하지 못한 Mark1의 잔해와 설계도를 찾아낸다. Mark1을 재조립하여 그들의 목적을 이루기 위한 거대하고 강력한 철갑수트를 제작하려는 음모를 꾸미는 게릴라군. 토니 스타크가 갖고 있던 에너지원을 훔쳐 ‘아이언맨’을 능가하는 거대하고 강력한 ‘아이언 몽거’를 완성한 그들은 세계 평화를 위협하고, 토니 스타크는 그들의 음모과 배후세력이 누구인지를 알게 되는데...!",
                "poster_path": "/ziReGUV3xURsWmcmsn2GOunPc0L.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    878,
                    12
                ],
                "video": false
            },
            {
                "id": 246655,
                "title": "엑스맨: 아포칼립스",
                "original_title": "X-Men: Apocalypse",
                "release_date": "2016-05-18",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/2ex2beZ4ssMeOduLD0ILzXKCiep.jpg",
                "overview": "고대 이집트에서 신으로 숭배받았던 최초의 돌연변이 아포칼립스가 오랜 잠에서 깨어난다. 초능력을 흡수해가며 수천년을 살아온 아포칼립스는 스톰, 사일록, 아크엔젤 그리고 매그니토에게 자신의 힘을 나누어준 뒤, 그들과 함께 현재의 세상을 뒤엎고 새로운 세상을 건설하려 한다. 찰스 자비에와 미스틱은 아포칼립스의 지구 종말 계획을 알아채고, 진 그레이, 사이클롭스, 퀵 실버, 나이트크롤러 등 젊은 돌연변이들과 함께 아포칼립스에 대항한다.",
                "poster_path": "/4MaTkqk4LKccDYKh7AjV220CVgW.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    12,
                    878,
                    14
                ],
                "video": false
            },
            {
                "id": 572802,
                "title": "아쿠아맨과 로스트 킹덤",
                "original_title": "Aquaman and the Lost Kingdom",
                "release_date": "2023-12-20",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "en",
                "adult": false,
                "backdrop_path": "/cnqwv5Uz3UW5f086IWbQKr3ksJr.jpg",
                "overview": "아틀란티스 왕국을 이끌 왕의 자리에 오른 아쿠아맨. 그 앞에 블랙 만타가 세상을 뒤흔들 강력한 지배 아이템 블랙 트라이던트를 손에 넣게 된다. 그동안 겪지 못 했던 최악의 위협 속 아쿠아맨은 블랙 만타와 손을 잡았던 이복 동생 옴 없이는 절대적 힘이 부족한 상황. 바다를 지배할 슈퍼 히어로가 세상의 판도를 바꾼다!",
                "poster_path": "/eDps1ZhI8IOlbEC7nFg6eTk4jnb.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    12,
                    14
                ],
                "video": false
            },
            {
                "id": 347200,
                "title": "코드 기아스 망국의 아키토 제3장 빛나는 자 하늘에서 내려오다",
                "original_title": "コードギアス 亡国のアキト 第3章「輝くもの天より堕つ」",
                "release_date": "2015-05-02",
                "name": null,
                "original_name": null,
                "first_air_date": null,
                "origin_country": null,
                "original_language": "ja",
                "adult": false,
                "backdrop_path": "/f1iCzEZtrcLTr5QJ2m6WD9yS6P2.jpg",
                "overview": "코드 기아스 망국의 아키토 제3장 빛나는 자 하늘에서 내려오다",
                "poster_path": "/n7ajLedWF7AFMwkUVXhowNZG3cA.jpg",
                "media_type": null,
                "genre_ids": [
                    28,
                    16
                ],
                "video": false
            }
        ]
        """
        return decoding(data)
    }                            //작품정보 리스트
    static var reviewDetailList:[ReadReviewResponse]{
        let data = """
        [
            {
                "review_id": 3,
                "contents_id": 17,
                "contents_title": "더 보이즈",
                "contents_poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
                "contents_backdrop_path": "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "title": "히어로물의 좋은 클리셰비틀기",
                "content": "였지만 시즌이 진행될수록 너무 질질끔",
                "score": 6.02778,
                "like_cnt": 0,
                "dislike_cnt": 0,
                "created_at": "2024-07-19T07:13:12.294998",
                "modified_at": "2024-07-19T07:13:12.294998",
                "like_status": 0,
                "spoiler": false,
                "author": false,
                "reported": false
            },
            {
                "review_id": 5,
                "contents_id": 17,
                "contents_title": "더 보이즈",
                "contents_poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
                "contents_backdrop_path": "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
                "user_id": 27,
                "user_nickname": "콰랑쓰",
                "user_profile_image": "cee7bc15-085b-41e9-91e2-a147f433016f.jpg",
                "title": "홀랜",
                "content": "스럽다",
                "score": 7.27778,
                "like_cnt": 2,
                "dislike_cnt": 0,
                "created_at": "2024-07-30T12:25:22.799936",
                "modified_at": "2024-07-30T12:25:22.799936",
                "like_status": 0,
                "spoiler": false,
                "author": false,
                "reported": false
            },
            {
                "review_id": 6,
                "contents_id": 17,
                "contents_title": "더 보이즈",
                "contents_poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
                "contents_backdrop_path": "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
                "user_id": 31,
                "user_nickname": "콰랑3",
                "user_profile_image": "c995a691-7371-413b-abe4-abffde20cad3.jpg",
                "title": "홀란",
                "content": "스럽다",
                "score": 6.94444,
                "like_cnt": 0,
                "dislike_cnt": 0,
                "created_at": "2024-08-03T13:59:39.342072",
                "modified_at": "2024-08-03T13:59:39.342072",
                "like_status": 0,
                "spoiler": false,
                "author": false,
                "reported": false
            }
        ]
        """
        return decoding(data)
    }                  //리뷰 리스트 아이템
    static var review:ReadReviewResponse?{
        let data = """
        {
            "review_id": 1,
            "contents_id": 12,
            "contents_title": "기생충",
            "contents_poster_path": "/eRM0PykovgtK4lin1D4BUql8TBa.jpg",
            "contents_backdrop_path": "/8eihUxjQsJ7WvGySkVMC0EwbPAD.jpg",
            "user_id": 10,
            "user_nickname": "콰랑",
            "user_profile_image": "02214e3a-4e5a-4156-b1d1-ca4062e80528.jpg",
            "title": "이 영화를 보며….",
            "content": "기생충은 봉준호 감독의 뛰어난 연출력과 배우들의 훌륭한 연기, 그리고 사회적 메시지가 결합된 걸작입니다. 이 영화는 한국 영화의 새로운 가능성을 제시하며, 전 세계적으로 큰 반향을 일으켰습니다. 현대 사회를 살아가는 모든 이들이 공감할 수 있는 이야기로, 강력히 추천합니다.",
            "score": 10.0,
            "like_cnt": 0,
            "dislike_cnt": 1,
            "created_at": "2024-07-15T15:27:33.351759",
            "modified_at": "2024-07-15T15:27:33.351759",
            "like_status": 0,
            "spoiler": false,
            "author": false,
            "reported": false
        }
        """
        return decoding(data)
    }                             //스크랩 리스트
    static var scrapList:[ScrapListResponse]{
        let data = """
        [
            {
                "scrap_id": 7,
                "user_id": 10,
                "user_nickname": "콰랑",
                "user_profile_image": "02214e3a-4e5a-4156-b1d1-ca4062e80528.jpg",
                "contents_id": 2,
                "contents_title": "인사이드 아웃 2",
                "contents_poster_path": "/pmemGuhr450DK8GiTT44mgwWCP7.jpg",
                "posting_id": 5,
                "posting_title": "님들 불안이 어떻게 생각함?",
                "created_date": "2024-10-10T14:06:55.647208"
            },
            {
                "scrap_id": 8,
                "user_id": 4,
                "user_nickname": "콰광",
                "user_profile_image": "69172736-d6d7-4f38-8e47-86cbc3c5b4d1.jpg",
                "contents_id": 22,
                "contents_title": "스위트홈",
                "contents_poster_path": "/eNfNu9sJ2eVmMcbrKpgEovPoyB8.jpg",
                "posting_id": 6,
                "posting_title": "개 노 잼",
                "created_date": "2024-10-10T14:06:58.025055"
            },
            {
                "scrap_id": 9,
                "user_id": 14,
                "user_nickname": "윤원이",
                "user_profile_image": "9d1db79a-793b-4d5c-a960-9be2dabfee2c.png",
                "contents_id": 31,
                "contents_title": "내 마음의 위험한 녀석",
                "contents_poster_path": "/bn27ZxhxWmNiKHtPVrDdVEbhjX3.jpg",
                "posting_id": 7,
                "posting_title": "진짜 너무달달해 ",
                "created_date": "2024-10-10T14:07:01.449331"
            },
            {
                "scrap_id": 10,
                "user_id": 31,
                "user_nickname": "콰랑3",
                "user_profile_image": "c995a691-7371-413b-abe4-abffde20cad3.jpg",
                "contents_id": 6,
                "contents_title": "하이큐!!",
                "contents_poster_path": "/8GpgkSjPlZv4Qr1qlc4elNU8tra.jpg",
                "posting_id": 8,
                "posting_title": "싱크로",
                "created_date": "2024-10-10T14:07:04.039993"
            }
        ]
        """
        return decoding(data)
    }
}


