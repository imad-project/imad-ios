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
    static var community:PostingResponse?{
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
    static var communityList:[PostingResponse]{
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
    static var communityDetails:PostingResponse?{
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
    static var rankingList:[RankingResponse]{
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
    static var bookmarkList:[BookmarkResponse]{
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
    static var scrapList:[ScrapResponse]{
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
    static var recommandAll:AllRecommendResponse?{
        let data = """
        {
            "preferred_genre_recommendation_tv": {
                "page": 1,
                "total_pages": 845,
                "total_results": 16881,
                "results": [
                    {
                        "id": 242931,
                        "name": "Pulang Araw",
                        "genre_ids": [
                            10759,
                            18,
                            10768,
                            10751
                        ],
                        "poster_path": "/2zbaRzgieKiHYkTGztQUzrAYbgb.jpg",
                        "backdrop_path": "/sx3N4xsZDv0zAGfImtruZLYirhs.jpg"
                    },
                    {
                        "id": 256121,
                        "name": "Lavender Fields",
                        "genre_ids": [
                            18,
                            10759
                        ],
                        "poster_path": "/lphvsr062SlxWM6XegsV2dLGaiE.jpg",
                        "backdrop_path": "/zk3UqXnnK7cpUv6LsD9DS8FtUxb.jpg"
                    },
                    {
                        "id": 84773,
                        "name": "반지의 제왕: 힘의 반지",
                        "genre_ids": [
                            10759,
                            10765,
                            18
                        ],
                        "poster_path": "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
                        "backdrop_path": "/NNC08YmJFFlLi1prBkK8quk3dp.jpg"
                    },
                    {
                        "id": 247884,
                        "name": "Fugitivas: en busca de la libertad",
                        "genre_ids": [
                            10766,
                            18,
                            10759,
                            10765
                        ],
                        "poster_path": "/oqHWSZmoCgz7JPsbNXihASGnfLW.jpg",
                        "backdrop_path": "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg"
                    },
                    {
                        "id": 261033,
                        "name": "العميل",
                        "genre_ids": [
                            10759,
                            18
                        ],
                        "poster_path": "/pFlp1GZ8dgNfGuBe3tYGrbnrUHu.jpg",
                        "backdrop_path": "/sCTlziZeyf4eWXh09pt63zMtJRw.jpg"
                    },
                    {
                        "id": 100757,
                        "name": "아우터 뱅크스",
                        "genre_ids": [
                            10759,
                            18,
                            9648
                        ],
                        "poster_path": "/ovDgO2LPfwdVRfvScAqo9aMiIW.jpg",
                        "backdrop_path": "/tMLH2VDnTpZLYg7T4QPBjaaleVx.jpg"
                    },
                    {
                        "id": 236994,
                        "name": "드래곤볼 다이마",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/u8GIA3ue6qsgA0QVxku5tg4IPVG.jpg",
                        "backdrop_path": "/jd0UJBrusmiNqLLP7Jxk1mmCWHS.jpg"
                    },
                    {
                        "id": 256429,
                        "name": "Pamilya Sagrado",
                        "genre_ids": [
                            18,
                            10759
                        ],
                        "poster_path": "/hlRhstt3Du57qm4A30w7RkHqEXg.jpg",
                        "backdrop_path": "/wCsDvlcQLwz7fzuZkfe2eS5Pgkh.jpg"
                    },
                    {
                        "id": 4614,
                        "name": "NCIS",
                        "genre_ids": [
                            80,
                            18,
                            10759
                        ],
                        "poster_path": "/2exOHePjOTquUsbThPGhuEjYTyA.jpg",
                        "backdrop_path": "/vTh69QDXy9QqaujdSGWkXRBaYHN.jpg"
                    },
                    {
                        "id": 2288,
                        "name": "프리즌 브레이크",
                        "genre_ids": [
                            10759,
                            80,
                            18
                        ],
                        "poster_path": "/25CanTqZbSxroa2dqcbtRi7jaQ5.jpg",
                        "backdrop_path": "/7w165QdHmJuTHSQwEyJDBDpuDT7.jpg"
                    },
                    {
                        "id": 456,
                        "name": "심슨 가족",
                        "genre_ids": [
                            10751,
                            16,
                            35
                        ],
                        "poster_path": "/sLTAEFtjentQ5satiGdmv7o2f1C.jpg",
                        "backdrop_path": "/pxeqQX4qFQ0cVxPt5SWZENV5BH3.jpg"
                    },
                    {
                        "id": 1399,
                        "name": "왕좌의 게임",
                        "genre_ids": [
                            10765,
                            18,
                            10759
                        ],
                        "poster_path": "/lxfllsQQ32gKglUxrM61WaFeNcy.jpg",
                        "backdrop_path": "/zZqpAXxVSBtxV9qPBcscfXBcL2w.jpg"
                    },
                    {
                        "id": 4607,
                        "name": "로스트",
                        "genre_ids": [
                            9648,
                            10759,
                            18
                        ],
                        "poster_path": "/og6S0aTZU6YUJAbqxeKjCa3kY1E.jpg",
                        "backdrop_path": "/jBhcm0Rm5Uv1UaHt0TTWuRjG5G3.jpg"
                    },
                    {
                        "id": 131041,
                        "name": "블루 록",
                        "genre_ids": [
                            16,
                            10759,
                            18
                        ],
                        "poster_path": "/tqiDHyR3YoIq4h0taoodUwp78Uz.jpg",
                        "backdrop_path": "/seMRyWVwIVBWbC9xaMzDMZJ8fUH.jpg"
                    },
                    {
                        "id": 95897,
                        "name": "오버플로우",
                        "genre_ids": [
                            16,
                            35
                        ],
                        "poster_path": "/8RtwL5gxUvh9YViqjhNlVRvJpum.jpg",
                        "backdrop_path": "/lbMenc3mIqxnExUsdCYQiC2Bozl.jpg"
                    },
                    {
                        "id": 1434,
                        "name": "패밀리 가이",
                        "genre_ids": [
                            16,
                            35
                        ],
                        "poster_path": "/y0HUz4eUNUe3TeEd8fQWYazPaC7.jpg",
                        "backdrop_path": "/jbTqU6BJMufoMnPSlO4ThrcXs3Y.jpg"
                    },
                    {
                        "id": 218843,
                        "name": "일곱 개의 대죄: 묵시록의 4기사",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/k5EfaLuyR4iBdXhIe9xEL2Qr7q3.jpg",
                        "backdrop_path": "/4msN2f5WeKVldbdxSymdndWTOmr.jpg"
                    },
                    {
                        "id": 65334,
                        "name": "미라큘러스 레이디버그",
                        "genre_ids": [
                            10759,
                            16,
                            10762
                        ],
                        "poster_path": "/xjv32Hlk7eMeX2c3Aru0yIGQN1E.jpg",
                        "backdrop_path": "/ogMd4e3A0uSNwZADzgC23zCByoi.jpg"
                    },
                    {
                        "id": 94997,
                        "name": "하우스 오브 드래곤",
                        "genre_ids": [
                            10765,
                            18,
                            10759
                        ],
                        "poster_path": "/wj1bri2gXqfe1iEwfQzZfvFuKC.jpg",
                        "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg"
                    },
                    {
                        "id": 240411,
                        "name": "단다단",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/rFAymAzC8Q8WT4YTZuxcovyKFSN.jpg",
                        "backdrop_path": "/jlbUx0aHJupDVDlCo0R7UxSaUUd.jpg"
                    }
                ],
                "contents_id": null
            },
            "preferred_genre_recommendation_movie": {
                "page": 1,
                "total_pages": 5407,
                "total_results": 108134,
                "results": [
                    {
                        "id": 533535,
                        "title": "데드풀과 울버린",
                        "genre_ids": [
                            28,
                            35,
                            878
                        ],
                        "poster_path": "/4Zb4Z2HjX1t5zr1qYOTdVoisJKp.jpg",
                        "backdrop_path": "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg"
                    },
                    {
                        "id": 519182,
                        "title": "슈퍼배드 4",
                        "genre_ids": [
                            16,
                            10751,
                            35,
                            28
                        ],
                        "poster_path": "/5hl1PEpAvZ8Ok37kB7woIssHi3X.jpg",
                        "backdrop_path": "/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg"
                    },
                    {
                        "id": 726139,
                        "title": "탈출: 프로젝트 사일런스",
                        "genre_ids": [
                            28,
                            53,
                            27,
                            878
                        ],
                        "poster_path": "/7eYasyaCvfJRHdnYl24jqPhf9y0.jpg",
                        "backdrop_path": "/hPIWQT70wQK6akqfLXByEvr62u0.jpg"
                    },
                    {
                        "id": 1184918,
                        "title": "와일드 로봇",
                        "genre_ids": [
                            16,
                            878,
                            10751
                        ],
                        "poster_path": "/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg",
                        "backdrop_path": "/4zlOPT9CrtIX05bBIkYxNZsm5zN.jpg"
                    },
                    {
                        "id": 1022789,
                        "title": "인사이드 아웃 2",
                        "genre_ids": [
                            16,
                            10751,
                            12,
                            35,
                            18
                        ],
                        "poster_path": "/x2BHx02jMbvpKjMvbf8XxJkYwHJ.jpg",
                        "backdrop_path": "/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg"
                    },
                    {
                        "id": 1144962,
                        "title": "Transmorphers: Mech Beasts",
                        "genre_ids": [
                            28,
                            878
                        ],
                        "poster_path": "/oqhaffnQqSzdLrYAQA5W4IdAoCX.jpg",
                        "backdrop_path": "/tCKWksaQI8XkAQLVou0AlGab5S6.jpg"
                    },
                    {
                        "id": 957452,
                        "title": "더 크로우",
                        "genre_ids": [
                            28,
                            14,
                            27
                        ],
                        "poster_path": "/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg",
                        "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg"
                    },
                    {
                        "id": 1329336,
                        "title": "배드 가이즈: 오싹한 핼러윈",
                        "genre_ids": [
                            16,
                            35
                        ],
                        "poster_path": "/oEJC05CqPugMxC4rFu9r6r6vg6m.jpg",
                        "backdrop_path": "/vGaBqgY8YRzQVUbBMPnd5SmYvL7.jpg"
                    },
                    {
                        "id": 1210794,
                        "title": "미스터 트러블",
                        "genre_ids": [
                            28,
                            35,
                            80
                        ],
                        "poster_path": "/liWKsgB2W48cssyfmEkEjjSEQdJ.jpg",
                        "backdrop_path": "/eXQ8O0ykuEB8dUJhq2WJll4vXmA.jpg"
                    },
                    {
                        "id": 507241,
                        "title": "더 킬러스 게임",
                        "genre_ids": [
                            28,
                            35,
                            80
                        ],
                        "poster_path": "/4bKlTeOUr5AKrLky8mwWvlQqyVd.jpg",
                        "backdrop_path": "/uVWlwJebxX0M3axXAUrryJ6w9cQ.jpg"
                    },
                    {
                        "id": 877817,
                        "title": "'울프스' - Wolfs",
                        "genre_ids": [
                            35,
                            53,
                            28
                        ],
                        "poster_path": "/isf7Z8Ze3dvmaOuJG1hfF2LTtUh.jpg",
                        "backdrop_path": "/uXDwP5qPhuRyPpQ7WkLbE6t2z5W.jpg"
                    },
                    {
                        "id": 1087822,
                        "title": "헬보이: 더 크룩드 맨",
                        "genre_ids": [
                            14,
                            27,
                            28
                        ],
                        "poster_path": "/iz2GabtToVB05gLTVSH7ZvFtsMM.jpg",
                        "backdrop_path": "/g1z1ZvYKcmk9EnVOTYXR6vkNjkZ.jpg"
                    },
                    {
                        "id": 573435,
                        "title": "나쁜 녀석들: 라이드 오어 다이",
                        "genre_ids": [
                            28,
                            80,
                            53,
                            35
                        ],
                        "poster_path": "/wIrhEUBWjRmZuL1Ix41cF2LhJrW.jpg",
                        "backdrop_path": "/tncbMvfV0V07UZozXdBEq4Wu9HH.jpg"
                    },
                    {
                        "id": 823219,
                        "title": "플로우",
                        "genre_ids": [
                            16,
                            14,
                            12
                        ],
                        "poster_path": "/dzDMewC0Hwv01SROiWgKOi4iOc1.jpg",
                        "backdrop_path": "/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg"
                    },
                    {
                        "id": 1215162,
                        "title": "Kill 'em All 2",
                        "genre_ids": [
                            28,
                            80,
                            53
                        ],
                        "poster_path": "/hgA5hN3NjNNSTXYOmAI6KNKOzbp.jpg",
                        "backdrop_path": "/wh1IhMWkW7u5c5bkzSGFylF9G8r.jpg"
                    },
                    {
                        "id": 1337309,
                        "title": "방콕 브레이킹: 천국과 지옥",
                        "genre_ids": [
                            28,
                            80,
                            18,
                            53
                        ],
                        "poster_path": "/HFtb46fmiNtbYboIuS6vn27LdS.jpg",
                        "backdrop_path": "/igtm12Wy9EUlxFeyb4v8bRyuYSY.jpg"
                    },
                    {
                        "id": 718821,
                        "title": "트위스터스",
                        "genre_ids": [
                            28,
                            12,
                            53
                        ],
                        "poster_path": "/w5mXdM9AIf7urUtoUVYjABdp3g8.jpg",
                        "backdrop_path": "/7aPrv2HFssWcOtpig5G3HEVk3uS.jpg"
                    },
                    {
                        "id": 1029235,
                        "title": "아즈라엘",
                        "genre_ids": [
                            28,
                            27,
                            53
                        ],
                        "poster_path": "/qpdFKDvJS7oLKTcBLXOaMwUESbs.jpg",
                        "backdrop_path": "/6n8x85cljOfJkUvPDc7tTmGPv7F.jpg"
                    },
                    {
                        "id": 698687,
                        "title": "트랜스포머 ONE",
                        "genre_ids": [
                            16,
                            878,
                            12,
                            10751,
                            28
                        ],
                        "poster_path": "/c2JXlWzvXegSda8qaATr8I47kMx.jpg",
                        "backdrop_path": "/m1DkRQbNXjs2RYC0FP4r6mdaLCi.jpg"
                    },
                    {
                        "id": 365177,
                        "title": "보더랜드",
                        "genre_ids": [
                            28,
                            878,
                            35
                        ],
                        "poster_path": "/865DntZzOdX6rLMd405R0nFkLmL.jpg",
                        "backdrop_path": "/mKOBdgaEFguADkJhfFslY7TYxIh.jpg"
                    }
                ],
                "contents_id": null
            },
            "user_activity_recommendation_tv": {
                "page": 1,
                "total_pages": 702,
                "total_results": 14033,
                "results": [
                    {
                        "id": 813,
                        "name": "Hell's Kitchen",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/tXC13Lkw4o1S6QiUxlmsVepiBnV.jpg",
                        "backdrop_path": "/9fOttCTnYeAYBWdM40P8rYKiumr.jpg"
                    },
                    {
                        "id": 1187,
                        "name": "The Restaurant",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": null,
                        "backdrop_path": null
                    },
                    {
                        "id": 138605,
                        "name": "Wigs in a Blanket",
                        "genre_ids": [
                            10764,
                            35
                        ],
                        "poster_path": "/cfWDjhN1Znz5c4XeS0p1oIZ58oJ.jpg",
                        "backdrop_path": null
                    },
                    {
                        "id": 138451,
                        "name": "Mary Berry: Love to Cook",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/tMav89w6Ve1DLWPBizV6kSXfGDu.jpg",
                        "backdrop_path": "/j2y9ETiVb5Kq7KzSd3FvIdm4V0G.jpg"
                    },
                    {
                        "id": 83179,
                        "name": "Good Eats: Reloaded",
                        "genre_ids": [
                            10764,
                            35
                        ],
                        "poster_path": "/hg1HF2POx3JojEOo82uKuHTR553.jpg",
                        "backdrop_path": "/y3mOY1hMxJdB6XPoLvQMQjvElMz.jpg"
                    },
                    {
                        "id": 83273,
                        "name": "Le goût de l'amour",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/x2xHNcG2XdAHoBPzSoBp0cioOS6.jpg",
                        "backdrop_path": null
                    },
                    {
                        "id": 139572,
                        "name": "Rachel Khoo's Kitchen Notebook: London",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/aeVec1LNnuqyTVaGhHLxR8RdXZL.jpg",
                        "backdrop_path": "/2Iri1TEIn5PiqmtVJiuv8w61zNu.jpg"
                    },
                    {
                        "id": 2178,
                        "name": "Ramsay's Kitchen Nightmares",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/5tadsgz2UCiLPtUj0mJ8ohCsiWH.jpg",
                        "backdrop_path": "/qwQiB8ftACqvb11gickoaf5SyJX.jpg"
                    },
                    {
                        "id": 139389,
                        "name": "My Ireland with Colin",
                        "genre_ids": [
                            99,
                            10764
                        ],
                        "poster_path": "/pb5kjBgvlCcwg4zQ4uuYpT4s5jI.jpg",
                        "backdrop_path": "/blD6c9EI9nRiJnOvr7yC0ysAu6q.jpg"
                    },
                    {
                        "id": 215916,
                        "name": "Martha Cooks",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/dNu7B7u33j89T7Jve0jIAPurnYA.jpg",
                        "backdrop_path": "/4iUbk16ZehidoZ3U1AyQSIj6tsF.jpg"
                    },
                    {
                        "id": 25229,
                        "name": "Junior Masterchef",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": null,
                        "backdrop_path": null
                    },
                    {
                        "id": 243232,
                        "name": "MasterChef Québec",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/A06OztBLK1IGfefbGMal2VJWH6i.jpg",
                        "backdrop_path": "/fu4HVoU3cDMzs58xl8Hk0s7pqEq.jpg"
                    },
                    {
                        "id": 243310,
                        "name": "Top Chef VIP",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/qDnFo8HTZckkT6rmohxxX4gC8JD.jpg",
                        "backdrop_path": "/sZDaoJggsck1XFfDXoFKLusR64c.jpg"
                    },
                    {
                        "id": 81284,
                        "name": "크리스틴 매코널과 이상한 과자의 집",
                        "genre_ids": [
                            35,
                            10767,
                            10764
                        ],
                        "poster_path": "/81BS0vEbWOfsAVo9ln9OAnXLUtd.jpg",
                        "backdrop_path": "/eXHfjm2bz15XJNlNg6JZ3Rmjlxu.jpg"
                    },
                    {
                        "id": 109819,
                        "name": "아메리칸 바비큐 최후의 마스터",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/4yf81AlYGP5sDKtAwluGmcPjMlU.jpg",
                        "backdrop_path": "/bnLOYyNlcHbqLjQlOLtCBGweWVu.jpg"
                    },
                    {
                        "id": 216575,
                        "name": "프레셔 쿠커: 압박감을 요리하라",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/5Fwerl8ORkDTrwekLmaSKlriTWS.jpg",
                        "backdrop_path": "/bjuYyTK7xwqxWwrKMbsASoPewYe.jpg"
                    },
                    {
                        "id": 80357,
                        "name": "쿠킹 온 하이: 수상한 요리 대결",
                        "genre_ids": [
                            35,
                            10764
                        ],
                        "poster_path": "/6wU0kZ93zyN4FFlUwMx4Jsn95ch.jpg",
                        "backdrop_path": "/ArZm90Y1z1FCvjOAPiGqjUwtcyY.jpg"
                    },
                    {
                        "id": 218076,
                        "name": "NFL Tailgate Takedown",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/apr1lhH5sAnj8VXDi5OV1ZtGCpf.jpg",
                        "backdrop_path": "/f5HjxpNVnJwrZePLujW0vosO5qs.jpg"
                    },
                    {
                        "id": 26521,
                        "name": "A Cook on the Wild Side",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/8m5B535rcP2mvHv1q5x590FgHEF.jpg",
                        "backdrop_path": "/jcoBUAoDZheYH5DqkdeT1SKA9wv.jpg"
                    },
                    {
                        "id": 138972,
                        "name": "MasterChef Portugal",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/lRrkkVHrdhyILipLMu8SSqP28qf.jpg",
                        "backdrop_path": "/AdIOJt4s7wSp9MTEVdkcAHsdJgz.jpg"
                    }
                ],
                "contents_id": 193
            },
            "user_activity_recommendation_movie": {
                "page": 1,
                "total_pages": 20185,
                "total_results": 403689,
                "results": [
                    {
                        "id": 10856,
                        "title": "Intacto",
                        "genre_ids": [
                            28,
                            35,
                            18,
                            10749,
                            878,
                            53
                        ],
                        "poster_path": "/7mU6bhGaDLtpO4Tuf7qii0HnQF6.jpg",
                        "backdrop_path": "/orCqFI2ROrtr1ajUTIolzMmQiqP.jpg"
                    },
                    {
                        "id": 10859,
                        "title": "잠복근무",
                        "genre_ids": [
                            28,
                            35,
                            10749
                        ],
                        "poster_path": "/wvu6SSTOWY7DKOFvCCXZnowyG4n.jpg",
                        "backdrop_path": "/76dAUlFGWs2Ujf3O8AWNR5UKJr9.jpg"
                    },
                    {
                        "id": 10869,
                        "title": "허비: 돌아오다",
                        "genre_ids": [
                            10749,
                            35,
                            10751,
                            14
                        ],
                        "poster_path": "/1k14PPykkUQfhjn3xXDrc55lfHl.jpg",
                        "backdrop_path": "/jzHwueypEAhp1KHza9DE32OnzIa.jpg"
                    },
                    {
                        "id": 10872,
                        "title": "사랑의 금고털이",
                        "genre_ids": [
                            35,
                            80,
                            18
                        ],
                        "poster_path": "/bxMjOeECQxHPf6QvkBChdxaOxVh.jpg",
                        "backdrop_path": "/4MfL5WobEQdg0vph0OzVuyGoKyt.jpg"
                    },
                    {
                        "id": 10877,
                        "title": "엑시트 운즈",
                        "genre_ids": [
                            28,
                            80,
                            53
                        ],
                        "poster_path": "/tGIJhBejmredgUZRNdteZyiahag.jpg",
                        "backdrop_path": "/s7TYR0skv7hwLUF343AA7UtMCAy.jpg"
                    },
                    {
                        "id": 10898,
                        "title": "인어공주 2",
                        "genre_ids": [
                            16,
                            12,
                            10751,
                            35
                        ],
                        "poster_path": "/7QL0uTT7Qv9YmXhIdWA8nlet17j.jpg",
                        "backdrop_path": "/kBwQZBugAJ7pQObSCQ8GHTJ4qiB.jpg"
                    },
                    {
                        "id": 10900,
                        "title": "서베일런스",
                        "genre_ids": [
                            27,
                            53,
                            9648
                        ],
                        "poster_path": "/8CYX53rLeRonQjJOKyHkwAwBIWD.jpg",
                        "backdrop_path": "/iExOE5nfduuD1rL1flHBhkCffxp.jpg"
                    },
                    {
                        "id": 10939,
                        "title": "스파이 오퍼레이션 2",
                        "genre_ids": [
                            35
                        ],
                        "poster_path": "/1ywhR3LWDWw5C8wcL4gnd0DhloQ.jpg",
                        "backdrop_path": "/o3bSYbap4gDnHeAru7umPVWTzAP.jpg"
                    },
                    {
                        "id": 10090,
                        "title": "르노 911! - 마이애미",
                        "genre_ids": [
                            28,
                            35,
                            80
                        ],
                        "poster_path": "/l9v3nqTU4Gj2zuASGDLJX4YD8ma.jpg",
                        "backdrop_path": "/tNCBhUrlskXHvp7JozWUmVKeuP0.jpg"
                    },
                    {
                        "id": 10108,
                        "title": "D.C. Sniper: 23 Days of Fear",
                        "genre_ids": [
                            18,
                            53,
                            10770
                        ],
                        "poster_path": "/wt9e6zLJ0mxIPoqG5rQbPCXoyd.jpg",
                        "backdrop_path": "/gHmpSJzSc7agekPXnGSKCLAzxrh.jpg"
                    },
                    {
                        "id": 10126,
                        "title": "범죄와의 전쟁",
                        "genre_ids": [
                            28,
                            80,
                            18
                        ],
                        "poster_path": "/5KueYME8A449pxaKTJZp3cWKKSX.jpg",
                        "backdrop_path": "/aWPZsW1rJpcmjnQ7vdsdRu0Mpq5.jpg"
                    },
                    {
                        "id": 10131,
                        "title": "나이트메어 4: 꿈의 지배자",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/boStYG7jKdoIZTduiOOsUVknD13.jpg",
                        "backdrop_path": "/n9iKgzDObyu4PxvNBwJZDZSfXP1.jpg"
                    },
                    {
                        "id": 10141,
                        "title": "화려한 사기꾼",
                        "genre_ids": [
                            80,
                            35
                        ],
                        "poster_path": "/3176xH21fSetstKpEtAD1giHbyT.jpg",
                        "backdrop_path": "/zzAnipQc2zv7TILeOWXyOU2WWkw.jpg"
                    },
                    {
                        "id": 10160,
                        "title": "나이트메어 5: 꿈꾸는 아이들",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/kizvpgXQfrAgN8FhOd87LbKk6kO.jpg",
                        "backdrop_path": "/vHgIvVAwo9rvmLzcCzecv76iz8L.jpg"
                    },
                    {
                        "id": 896928,
                        "title": "警視庁物語　血液型の秘密",
                        "genre_ids": [
                            80,
                            9648
                        ],
                        "poster_path": "/83kJuCfiOHDgK6KRce2sZaYodD1.jpg",
                        "backdrop_path": "/9a8O0kopQRxkOd7LMB87pbmAlMp.jpg"
                    },
                    {
                        "id": 897029,
                        "title": "警視庁物語 不在証明",
                        "genre_ids": [
                            80,
                            9648
                        ],
                        "poster_path": null,
                        "backdrop_path": "/ej5OYDQ7mYgGgUlOw9wSfEuIKA5.jpg"
                    },
                    {
                        "id": 569381,
                        "title": "Interference",
                        "genre_ids": [
                            80,
                            18,
                            9648
                        ],
                        "poster_path": "/eZzi5J467uLp41VfVJjHg8duxRC.jpg",
                        "backdrop_path": "/yPwXY7Cxbqh6LucERTMtBcwjtl9.jpg"
                    },
                    {
                        "id": 730890,
                        "title": "Cruiser",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/wDezooy1winW4231ysxBA8i9jxt.jpg",
                        "backdrop_path": "/i1VA3y5o2Ucf2ovipNCfWhLJnMA.jpg"
                    },
                    {
                        "id": 10990,
                        "title": "멀홀랜드 폴스",
                        "genre_ids": [
                            18,
                            9648,
                            53,
                            80
                        ],
                        "poster_path": "/tT5rYDXloX5ZxISr8HdlRC9TBcP.jpg",
                        "backdrop_path": "/6bXiMdZezdJ6WyshAaV2GIEqdEu.jpg"
                    },
                    {
                        "id": 11004,
                        "title": "원더 보이즈",
                        "genre_ids": [
                            35,
                            18
                        ],
                        "poster_path": "/vGOdSLaZmu42qqwDUMgrfctJ65M.jpg",
                        "backdrop_path": "/f6axPiSzkPa2ErTtTxBUGfCLFPd.jpg"
                    }
                ],
                "contents_id": 10
            },
            "user_activity_recommendation_tv_animation": {
                "page": 1,
                "total_pages": 2102,
                "total_results": 42032,
                "results": [
                    {
                        "id": 967,
                        "name": "The Huckleberry Hound Show",
                        "genre_ids": [
                            16,
                            35,
                            10762
                        ],
                        "poster_path": "/fur8UZZX0EhvvfjtxGzhPQzzdQ5.jpg",
                        "backdrop_path": "/1lTXCp8kMqBT5TQF3no2pjA3MZ2.jpg"
                    },
                    {
                        "id": 982,
                        "name": "超ロボット生命体トランスフォーマー マイクロン伝説",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/dp8ths1rTC7XDX8SmFEfHqiiyni.jpg",
                        "backdrop_path": "/40Q6bTumMp5SAGuGnuu2lcGvbHE.jpg"
                    },
                    {
                        "id": 1041,
                        "name": "느와르",
                        "genre_ids": [
                            18,
                            16,
                            10759
                        ],
                        "poster_path": "/enPxNVtbam3oAcsvtB8rvyXRAuE.jpg",
                        "backdrop_path": "/utMf670mP8jvxhkKg3fwRbnMWYa.jpg"
                    },
                    {
                        "id": 1042,
                        "name": "소녀혁명 우테나",
                        "genre_ids": [
                            16,
                            18,
                            9648,
                            10765
                        ],
                        "poster_path": "/pOjDuclpsWGV13Nj7XtZukuZj6f.jpg",
                        "backdrop_path": "/802aSsZzIyOhbaL1bt19gp0RVYq.jpg"
                    },
                    {
                        "id": 1043,
                        "name": "오란고교 호스트부",
                        "genre_ids": [
                            16,
                            35,
                            18
                        ],
                        "poster_path": "/rd6QqoO7mOqrfOWiSEa6XL9Jqlv.jpg",
                        "backdrop_path": "/76pPMEBF8LeoAwrtKGjSPPtjvk1.jpg"
                    },
                    {
                        "id": 1063,
                        "name": "사무라이 참프루",
                        "genre_ids": [
                            10759,
                            16,
                            35,
                            18
                        ],
                        "poster_path": "/t6x0fNlD89oOKDJDfgjYDNGLp5R.jpg",
                        "backdrop_path": "/aZRGh7ccNAdqQWhHypvlT9UuXjZ.jpg"
                    },
                    {
                        "id": 1087,
                        "name": "시리얼 익스페리먼츠 레인",
                        "genre_ids": [
                            16,
                            18,
                            10765,
                            9648
                        ],
                        "poster_path": "/ej3tcxv2YYVWy6WoOeWZTcrkiI8.jpg",
                        "backdrop_path": "/bW9cmJpv672gyBgA2Boje6Q8BX5.jpg"
                    },
                    {
                        "id": 1095,
                        "name": "공각기동대 STAND ALONE COMPLEX",
                        "genre_ids": [
                            10759,
                            16,
                            80,
                            10765
                        ],
                        "poster_path": "/cFsm04wI44K3yEDFWES94uqVGpz.jpg",
                        "backdrop_path": "/tY6ZweSX4Mg8AYNSia9vyH1su8k.jpg"
                    },
                    {
                        "id": 1096,
                        "name": "카미츄!",
                        "genre_ids": [
                            16,
                            18,
                            35
                        ],
                        "poster_path": "/9D04WbrnibtpERwUpihUvGWsXRd.jpg",
                        "backdrop_path": "/7otc7fhibDFIvUf9HvOgyXHeoK7.jpg"
                    },
                    {
                        "id": 1097,
                        "name": "에르고 프록시",
                        "genre_ids": [
                            16,
                            10765,
                            9648
                        ],
                        "poster_path": "/ctq3DBf7t3qtgVPlm8CO2x1Zj4v.jpg",
                        "backdrop_path": "/pocqO2L8PW9xh1oA7ZG3iXh62FL.jpg"
                    },
                    {
                        "id": 1098,
                        "name": "위치헌터 로빈",
                        "genre_ids": [
                            16,
                            10759,
                            18
                        ],
                        "poster_path": "/kaJWK1AU9nDNvXji1piS7POW1DK.jpg",
                        "backdrop_path": "/y9ETqHxMWc8IrDtVvRGST3IxafB.jpg"
                    },
                    {
                        "id": 1102,
                        "name": "시문",
                        "genre_ids": [
                            16,
                            18,
                            10765
                        ],
                        "poster_path": "/wLWB1z3WazzQxReEpr4HbJHP1X2.jpg",
                        "backdrop_path": "/zfjO1BTSb9XGH59Id3lUTrQSdwi.jpg"
                    },
                    {
                        "id": 52814,
                        "name": "헤일로",
                        "genre_ids": [
                            10765,
                            10759
                        ],
                        "poster_path": "/stC0UTb4qP3hC3cayWMDR9phLHo.jpg",
                        "backdrop_path": "/zW0v2YT74C6tRafzqqBkfSqLAN0.jpg"
                    },
                    {
                        "id": 81554,
                        "name": "크라이시스 융",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/2y3LtI5DDzRrNWEv9Tyd0E3JdeR.jpg",
                        "backdrop_path": "/aDYcmw5aBahksmPLEdHq3BBfkcc.jpg"
                    },
                    {
                        "id": 81630,
                        "name": "アニメ：バロムワン",
                        "genre_ids": [
                            10759,
                            10765,
                            16
                        ],
                        "poster_path": "/taakVsSr2OtTve0Ke0vmyiSNlFb.jpg",
                        "backdrop_path": "/8UShLevAdrI85feUQ07mKM1vl0A.jpg"
                    },
                    {
                        "id": 52850,
                        "name": "단재분리의 크라임엣지",
                        "genre_ids": [
                            16,
                            10759,
                            35
                        ],
                        "poster_path": "/aJIQ63qHGlb1iuUhLWUrwpkgoyY.jpg",
                        "backdrop_path": "/yzscLZvmVRQzoWYRt8BuYulg6rw.jpg"
                    },
                    {
                        "id": 52873,
                        "name": "리코더와 란도셀",
                        "genre_ids": [
                            16,
                            10751,
                            35
                        ],
                        "poster_path": "/3N78xAszaBfwteZqGtLxRhK2iim.jpg",
                        "backdrop_path": null
                    },
                    {
                        "id": 52878,
                        "name": "사랑한다고 말해",
                        "genre_ids": [
                            16,
                            18
                        ],
                        "poster_path": "/ctTbPg3J42fwnwKbHgqnqhxvcAf.jpg",
                        "backdrop_path": "/23JsXTt0m1P17vIYqUpqeDgAJYk.jpg"
                    },
                    {
                        "id": 52883,
                        "name": "전용",
                        "genre_ids": [
                            10759,
                            16,
                            35
                        ],
                        "poster_path": "/eF2CoVU16N7npyC4NsRgiy9cwts.jpg",
                        "backdrop_path": "/yFzSh9arGxgFnj7pjxGXQPSbRyQ.jpg"
                    },
                    {
                        "id": 52890,
                        "name": "유유시키",
                        "genre_ids": [
                            16,
                            35
                        ],
                        "poster_path": "/oEcYsmRtaru4YiPvQ0EaRmRHt6E.jpg",
                        "backdrop_path": "/sVlPLYx4tXII8VXajxhnJu779ee.jpg"
                    }
                ],
                "contents_id": 9
            },
            "user_activity_recommendation_movie_animation": null,
            "popular_recommendation_tv": {
                "page": 1,
                "total_pages": 9157,
                "total_results": 183130,
                "results": [
                    {
                        "id": 8892,
                        "name": "Pinoy Big Brother",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/t77HwrtME1Pupc56Ftdb283uUYM.jpg",
                        "backdrop_path": "/nCXV9ARvIE2Yc9tLg6pBwpPpPld.jpg"
                    },
                    {
                        "id": 94722,
                        "name": "타게스샤우",
                        "genre_ids": [
                            10763
                        ],
                        "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
                        "backdrop_path": "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg"
                    },
                    {
                        "id": 124364,
                        "name": "프롬",
                        "genre_ids": [
                            9648,
                            18,
                            10765
                        ],
                        "poster_path": "/wjaz71csFQWCvXkXDuIptfqwY7R.jpg",
                        "backdrop_path": "/q3UGWifvIpdey1T2efX4dSmbZpU.jpg"
                    },
                    {
                        "id": 122653,
                        "name": "Gutfeld!",
                        "genre_ids": [
                            35,
                            10767
                        ],
                        "poster_path": "/9zLuN3MfvTcABYYNJq5PkIG81S5.jpg",
                        "backdrop_path": "/bPnzBs4Ka1tZFCsZF3cPkzNjiLC.jpg"
                    },
                    {
                        "id": 18770,
                        "name": "Gran hermano",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/gQ0Emh2LT047Fip2HWye3NkrkQB.jpg",
                        "backdrop_path": "/ookJ1LS8Uc0ji7cSDuJfV7Qh6Lb.jpg"
                    },
                    {
                        "id": 260196,
                        "name": "La isla: Desafío extremo",
                        "genre_ids": [],
                        "poster_path": "/1mOLASAf5AkdYcRwe8L3uVa6yvb.jpg",
                        "backdrop_path": "/6sI85zW1DWcOVVdMfAxlRS8YEpY.jpg"
                    },
                    {
                        "id": 263040,
                        "name": "막풍음",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/bCeWaFJcBcIzCPeRkEEm2NIaaSZ.jpg",
                        "backdrop_path": "/48muJ8cxJbxbcalDPmDApGNtTVP.jpg"
                    },
                    {
                        "id": 81329,
                        "name": "Un si grand soleil",
                        "genre_ids": [
                            10766
                        ],
                        "poster_path": "/v4r70Z5id8eHFCxrfBOtRgu6wLr.jpg",
                        "backdrop_path": "/rj3jBAZwPiOgkwAy1205MAgLahj.jpg"
                    },
                    {
                        "id": 242931,
                        "name": "Pulang Araw",
                        "genre_ids": [
                            10759,
                            18,
                            10768,
                            10751
                        ],
                        "poster_path": "/2zbaRzgieKiHYkTGztQUzrAYbgb.jpg",
                        "backdrop_path": "/sx3N4xsZDv0zAGfImtruZLYirhs.jpg"
                    },
                    {
                        "id": 91759,
                        "name": "愛·回家之開心速遞",
                        "genre_ids": [
                            10751,
                            35,
                            18
                        ],
                        "poster_path": "/lgD4j9gUGmMckZpWWRJjorWqGVT.jpg",
                        "backdrop_path": "/ohJTnu93hJ0Uonl86Wn3mOSlWXN.jpg"
                    },
                    {
                        "id": 243117,
                        "name": "Plus belle la vie, encore plus belle",
                        "genre_ids": [
                            10766,
                            18
                        ],
                        "poster_path": "/5js5JCtxfiYF2MdNn0zGyCwyg8L.jpg",
                        "backdrop_path": "/3Jolb6Ky31IhEwyS8QhRykKo79J.jpg"
                    },
                    {
                        "id": 112470,
                        "name": "Ici tout commence",
                        "genre_ids": [
                            10766,
                            18
                        ],
                        "poster_path": "/yuTHx38jpogXovMhqNatvozigMJ.jpg",
                        "backdrop_path": "/vgeDRVpSUa4Hvovg4C6dgm4dfUW.jpg"
                    },
                    {
                        "id": 218145,
                        "name": "Mama na prenájom",
                        "genre_ids": [
                            10751,
                            35
                        ],
                        "poster_path": "/fH7PP2Rkdlo414IHvZABBHhtoqd.jpg",
                        "backdrop_path": "/l7LRGYJY3NzIGBlpvHpMsNXHbm5.jpg"
                    },
                    {
                        "id": 82708,
                        "name": "Brugklas",
                        "genre_ids": [
                            10766,
                            18
                        ],
                        "poster_path": "/6Gr6rggaHHeUKgxEXONRyC66oRG.jpg",
                        "backdrop_path": "/mlX6SG7lJ0BiLui5x5Nu4agetBA.jpg"
                    },
                    {
                        "id": 134156,
                        "name": "러브 아일랜드: 체코 & 슬로바키아",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/p10tBxVHtHfSfbYOpqDZTMSvVLN.jpg",
                        "backdrop_path": "/8hnuZvCF9M2H6tnvy6gXxM6Htd2.jpg"
                    },
                    {
                        "id": 237478,
                        "name": "Mania de Você",
                        "genre_ids": [
                            10766,
                            18,
                            9648
                        ],
                        "poster_path": "/xq1X6H8pupwx0jeZpu4Piq0V5uL.jpg",
                        "backdrop_path": "/xeJJZE8yC09lRbiV2f2hqURJmhd.jpg"
                    },
                    {
                        "id": 247174,
                        "name": "El Conde: Amor y Honor",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/lwcTD8hRx5Ch4sAmjNHmWigkaND.jpg",
                        "backdrop_path": "/1rGfdcrJOzqyBGo0HUa740L2GhX.jpg"
                    },
                    {
                        "id": 84773,
                        "name": "반지의 제왕: 힘의 반지",
                        "genre_ids": [
                            10759,
                            10765,
                            18
                        ],
                        "poster_path": "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
                        "backdrop_path": "/NNC08YmJFFlLi1prBkK8quk3dp.jpg"
                    },
                    {
                        "id": 250716,
                        "name": "¿Ganar o servir?",
                        "genre_ids": [
                            10764
                        ],
                        "poster_path": "/7ZhXzKBXNuFictb3XE2HZDLN9tl.jpg",
                        "backdrop_path": "/725Dh3UC4bjDTflsIxQvSx9vkLr.jpg"
                    },
                    {
                        "id": 4682,
                        "name": "Strictly Come Dancing: It Takes Two",
                        "genre_ids": [],
                        "poster_path": "/1UOKLsJ3bopZHg6ntRfmO4C5Gcm.jpg",
                        "backdrop_path": "/7ZBNbpkLhC2fS90j6onLS8qqfRX.jpg"
                    }
                ],
                "contents_id": null
            },
            "popular_recommendation_movie": {
                "page": 1,
                "total_pages": 46511,
                "total_results": 930212,
                "results": [
                    {
                        "id": 533535,
                        "title": "데드풀과 울버린",
                        "genre_ids": [
                            28,
                            35,
                            878
                        ],
                        "poster_path": "/4Zb4Z2HjX1t5zr1qYOTdVoisJKp.jpg",
                        "backdrop_path": "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg"
                    },
                    {
                        "id": 917496,
                        "title": "비틀쥬스 비틀쥬스",
                        "genre_ids": [
                            35,
                            14,
                            27
                        ],
                        "poster_path": "/ypWQatJYyESE5PIzdlSdiOyWYja.jpg",
                        "backdrop_path": "/xi1VSt3DtkevUmzCx2mNlCoDe74.jpg"
                    },
                    {
                        "id": 933260,
                        "title": "서브스턴스",
                        "genre_ids": [
                            27,
                            18,
                            878
                        ],
                        "poster_path": "/xSa67KtRbpvVUN3SDzQWk2Zs5Nm.jpg",
                        "backdrop_path": "/jlWk4J1sV1EHgkjhvsN7EdzGvOx.jpg"
                    },
                    {
                        "id": 1125510,
                        "title": "더 플랫폼 2",
                        "genre_ids": [
                            878,
                            53,
                            18,
                            27
                        ],
                        "poster_path": "/poELZsrROLJW28gc1V9nB1kJigq.jpg",
                        "backdrop_path": "/3m0j3hCS8kMAaP9El6Vy5Lqnyft.jpg"
                    },
                    {
                        "id": 1034541,
                        "title": "테리파이어 3",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/7NDHoebflLwL1CcgLJ9wZbbDrmV.jpg",
                        "backdrop_path": "/xlkclSE4aq7r3JsFIJRgs21zUew.jpg"
                    },
                    {
                        "id": 519182,
                        "title": "슈퍼배드 4",
                        "genre_ids": [
                            16,
                            10751,
                            35,
                            28
                        ],
                        "poster_path": "/5hl1PEpAvZ8Ok37kB7woIssHi3X.jpg",
                        "backdrop_path": "/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg"
                    },
                    {
                        "id": 1184918,
                        "title": "와일드 로봇",
                        "genre_ids": [
                            16,
                            878,
                            10751
                        ],
                        "poster_path": "/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg",
                        "backdrop_path": "/4zlOPT9CrtIX05bBIkYxNZsm5zN.jpg"
                    },
                    {
                        "id": 1022789,
                        "title": "인사이드 아웃 2",
                        "genre_ids": [
                            16,
                            10751,
                            12,
                            35,
                            18
                        ],
                        "poster_path": "/x2BHx02jMbvpKjMvbf8XxJkYwHJ.jpg",
                        "backdrop_path": "/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg"
                    },
                    {
                        "id": 726139,
                        "title": "탈출: 프로젝트 사일런스",
                        "genre_ids": [
                            28,
                            53,
                            27,
                            878
                        ],
                        "poster_path": "/7eYasyaCvfJRHdnYl24jqPhf9y0.jpg",
                        "backdrop_path": "/hPIWQT70wQK6akqfLXByEvr62u0.jpg"
                    },
                    {
                        "id": 1144962,
                        "title": "Transmorphers: Mech Beasts",
                        "genre_ids": [
                            28,
                            878
                        ],
                        "poster_path": "/oqhaffnQqSzdLrYAQA5W4IdAoCX.jpg",
                        "backdrop_path": "/tCKWksaQI8XkAQLVou0AlGab5S6.jpg"
                    },
                    {
                        "id": 1329336,
                        "title": "배드 가이즈: 오싹한 핼러윈",
                        "genre_ids": [
                            16,
                            35
                        ],
                        "poster_path": "/oEJC05CqPugMxC4rFu9r6r6vg6m.jpg",
                        "backdrop_path": "/vGaBqgY8YRzQVUbBMPnd5SmYvL7.jpg"
                    },
                    {
                        "id": 957452,
                        "title": "더 크로우",
                        "genre_ids": [
                            28,
                            14,
                            27
                        ],
                        "poster_path": "/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg",
                        "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg"
                    },
                    {
                        "id": 889737,
                        "title": "조커: 폴리 아 되",
                        "genre_ids": [
                            18,
                            80,
                            53
                        ],
                        "poster_path": "/dA1TGJPTVjlqPc8PiEE2PfvFBUp.jpg",
                        "backdrop_path": "/reNf6GBzOe48l9WEnFOxXgW56Vg.jpg"
                    },
                    {
                        "id": 1114513,
                        "title": "스픽 노 이블",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/mXGlp8K10JhiY5ZNY7zMldm2lss.jpg",
                        "backdrop_path": "/9R9Za5kybgl5AhuCNoK3gngaBdG.jpg"
                    },
                    {
                        "id": 573435,
                        "title": "나쁜 녀석들: 라이드 오어 다이",
                        "genre_ids": [
                            28,
                            80,
                            53,
                            35
                        ],
                        "poster_path": "/wIrhEUBWjRmZuL1Ix41cF2LhJrW.jpg",
                        "backdrop_path": "/tncbMvfV0V07UZozXdBEq4Wu9HH.jpg"
                    },
                    {
                        "id": 420634,
                        "title": "테리파이어",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/wmVLWbiMmlA3Savm7jjvbExwGC3.jpg",
                        "backdrop_path": "/naNXYdBzTEb1KwOdi1RbBkM9Zv1.jpg"
                    },
                    {
                        "id": 1210794,
                        "title": "미스터 트러블",
                        "genre_ids": [
                            28,
                            35,
                            80
                        ],
                        "poster_path": "/liWKsgB2W48cssyfmEkEjjSEQdJ.jpg",
                        "backdrop_path": "/eXQ8O0ykuEB8dUJhq2WJll4vXmA.jpg"
                    },
                    {
                        "id": 179387,
                        "title": "Heavenly Touch",
                        "genre_ids": [
                            18,
                            10749
                        ],
                        "poster_path": "/ory8WuAqznTE7lfopTSymHpop2t.jpg",
                        "backdrop_path": "/9msuazXGWAyl7vhxVFU7e7Bb5Ik.jpg"
                    },
                    {
                        "id": 877817,
                        "title": "'울프스' - Wolfs",
                        "genre_ids": [
                            35,
                            53,
                            28
                        ],
                        "poster_path": "/isf7Z8Ze3dvmaOuJG1hfF2LTtUh.jpg",
                        "backdrop_path": "/uXDwP5qPhuRyPpQ7WkLbE6t2z5W.jpg"
                    },
                    {
                        "id": 823219,
                        "title": "플로우",
                        "genre_ids": [
                            16,
                            14,
                            12
                        ],
                        "poster_path": "/dzDMewC0Hwv01SROiWgKOi4iOc1.jpg",
                        "backdrop_path": "/b3mdmjYTEL70j7nuXATUAD9qgu4.jpg"
                    }
                ],
                "contents_id": null
            },
            "top_rated_recommendation_tv": {
                "page": 1,
                "total_pages": 103,
                "total_results": 2049,
                "results": [
                    {
                        "id": 1396,
                        "name": "브레이킹 배드",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
                        "backdrop_path": "/9faGSFi5jam6pDWGNd0p8JcJgXQ.jpg"
                    },
                    {
                        "id": 209867,
                        "name": "장송의 프리렌",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/mnj30hYDVAbL9BOA0f4HrKubAGF.jpg",
                        "backdrop_path": "/96RT2A47UdzWlUfvIERFyBsLhL2.jpg"
                    },
                    {
                        "id": 94954,
                        "name": "해즈빈 호텔",
                        "genre_ids": [
                            16,
                            35,
                            10765
                        ],
                        "poster_path": "/c9epbOyQ5E0jc6uC10D21MsKYuF.jpg",
                        "backdrop_path": "/tuCU2yVRM2iZxFkpqlPUyvd6tSu.jpg"
                    },
                    {
                        "id": 94605,
                        "name": "아케인",
                        "genre_ids": [
                            16,
                            10765,
                            10759,
                            9648
                        ],
                        "poster_path": "/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg",
                        "backdrop_path": "/wQEW3xLrQAThu1GvqpsKQyejrYS.jpg"
                    },
                    {
                        "id": 246,
                        "name": "아바타 아앙의 전설",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/m4NuY6DEm3gwYJiPCCJwYzd32lr.jpg",
                        "backdrop_path": "/kU98MbVVgi72wzceyrEbClZmMFe.jpg"
                    },
                    {
                        "id": 37854,
                        "name": "원피스",
                        "genre_ids": [
                            10759,
                            35,
                            16
                        ],
                        "poster_path": "/qHjXsSUuolEtbgvYPzRjAuB1VHE.jpg",
                        "backdrop_path": "/2rmK7mnchw9Xr3XdiTFSxTTLXqv.jpg"
                    },
                    {
                        "id": 60625,
                        "name": "릭 앤 모티",
                        "genre_ids": [
                            16,
                            35,
                            10765,
                            10759
                        ],
                        "poster_path": "/gdIrmf2DdY5mgN6ycVP0XlzKzbE.jpg",
                        "backdrop_path": "/rBF8wVQN8hTWHspVZBlI3h7HZJ.jpg"
                    },
                    {
                        "id": 31911,
                        "name": "강철의 연금술사 BROTHERHOOD",
                        "genre_ids": [
                            10759,
                            16,
                            10765,
                            35
                        ],
                        "poster_path": "/9SkrxQDka8JAk8tUwb396prUR9J.jpg",
                        "backdrop_path": "/A6tMQAo6t6eRFCPhsrShmxZLqFB.jpg"
                    },
                    {
                        "id": 60059,
                        "name": "베터 콜 사울",
                        "genre_ids": [
                            80,
                            18
                        ],
                        "poster_path": "/fC2HDm5t0kHl7mTm7jxMR31b7by.jpg",
                        "backdrop_path": "/hPea3Qy5Gd6z4kJLUruBbwAH8Rm.jpg"
                    },
                    {
                        "id": 87108,
                        "name": "체르노빌",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/oaTzO8CbeazTwACbR4B5Je9JNys.jpg",
                        "backdrop_path": "/900tHlUYUkp7Ol04XFSoAaEIXcT.jpg"
                    },
                    {
                        "id": 70785,
                        "name": "빨간 머리 앤",
                        "genre_ids": [
                            18,
                            10751
                        ],
                        "poster_path": "/lKUYNB42aCLYEO7368W5EkjtwAt.jpg",
                        "backdrop_path": "/70YdbMELM4b8x8VXjlubymb2bQ0.jpg"
                    },
                    {
                        "id": 92685,
                        "name": "아울 하우스",
                        "genre_ids": [
                            16,
                            10765,
                            18,
                            10759,
                            35,
                            10762
                        ],
                        "poster_path": "/zhdy3PcNVE15wj1wrxn45ARZBnx.jpg",
                        "backdrop_path": "/cHyY5z4txdVyGtYMvBJhCqCcJso.jpg"
                    },
                    {
                        "id": 1429,
                        "name": "진격의 거인",
                        "genre_ids": [
                            16,
                            10765,
                            10759
                        ],
                        "poster_path": "/quLA9tkgHFte762gqQaayBslB2T.jpg",
                        "backdrop_path": "/rqbCbjB19amtOtFQbb3K2lgm2zv.jpg"
                    },
                    {
                        "id": 85937,
                        "name": "귀멸의 칼날",
                        "genre_ids": [
                            16,
                            10759,
                            10765
                        ],
                        "poster_path": "/iR6T6QxSJpSQi1S4GGjGWLQkSva.jpg",
                        "backdrop_path": "/3GQKYh6Trm8pxd2AypovoYQf4Ay.jpg"
                    },
                    {
                        "id": 62741,
                        "name": "오늘부터 신령님",
                        "genre_ids": [
                            16,
                            35,
                            10765
                        ],
                        "poster_path": "/8nfyyLqcAbEocNvPXj26uIflThp.jpg",
                        "backdrop_path": "/xdTwlG8MYAOkFuAGUqt8LgmgTNZ.jpg"
                    },
                    {
                        "id": 42705,
                        "name": "더 파이팅",
                        "genre_ids": [
                            16,
                            35,
                            18,
                            10759
                        ],
                        "poster_path": "/a5g4AltmlNq0e1hN1jugemNa5wX.jpg",
                        "backdrop_path": "/2w8FaLwwJTWr6ExUMeVgT2Th5YT.jpg"
                    },
                    {
                        "id": 135157,
                        "name": "환혼",
                        "genre_ids": [
                            10765,
                            18,
                            10759,
                            9648
                        ],
                        "poster_path": "/pGs6UA4rPUZEokDyTwAGdRvwrAD.jpg",
                        "backdrop_path": "/3MC8VIxq8u1vKOKTfz6FtrFXuMZ.jpg"
                    },
                    {
                        "id": 68349,
                        "name": "역도요정 김복주",
                        "genre_ids": [
                            35,
                            18
                        ],
                        "poster_path": "/ssKVvJM341QiRdBmj8fOAOcpYdl.jpg",
                        "backdrop_path": "/j0viazcPT7Te2XC7iomH9lBtiVG.jpg"
                    },
                    {
                        "id": 221851,
                        "name": "내 남편과 결혼해줘",
                        "genre_ids": [
                            18,
                            10765,
                            35
                        ],
                        "poster_path": "/oZ7HBsoYNL4IGeHRD7JRnZDCegk.jpg",
                        "backdrop_path": "/7BoRhg8zXP0ca9Zql4p8llCFR2P.jpg"
                    },
                    {
                        "id": 1398,
                        "name": "소프라노스",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/lXaipuB4DrTfbyGT2xN9IpDtNH.jpg",
                        "backdrop_path": "/lNpkvX2s8LGB0mjGODMT4o6Up7j.jpg"
                    }
                ],
                "contents_id": null
            },
            "top_rated_recommendation_movie": {
                "page": 1,
                "total_pages": 484,
                "total_results": 9667,
                "results": [
                    {
                        "id": 278,
                        "title": "쇼생크 탈출",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/oAt6OtpwYCdJI76AVtVKW1eorYx.jpg",
                        "backdrop_path": "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg"
                    },
                    {
                        "id": 238,
                        "title": "대부",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/I1fkNd5CeJGv56mhrTDoOeMc2r.jpg",
                        "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg"
                    },
                    {
                        "id": 240,
                        "title": "대부 2",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/bhqvqYuAgrTGwyNAmMR0ZVmjXel.jpg",
                        "backdrop_path": "/kGzFbGhp99zva6oZODW5atUtnqi.jpg"
                    },
                    {
                        "id": 424,
                        "title": "쉰들러 리스트",
                        "genre_ids": [
                            18,
                            36,
                            10752
                        ],
                        "poster_path": "/oyyUcGwLX7LTFS1pQbLrQpyzIyt.jpg",
                        "backdrop_path": "/zb6fM1CX41D9rF9hdgclu0peUmy.jpg"
                    },
                    {
                        "id": 389,
                        "title": "12명의 성난 사람들",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/xzh6Rq9cKnE1M309PzC5S5QWF9S.jpg",
                        "backdrop_path": "/qqHQsStV6exghCM7zbObuYBiYxw.jpg"
                    },
                    {
                        "id": 129,
                        "title": "센과 치히로의 행방불명",
                        "genre_ids": [
                            16,
                            10751,
                            14
                        ],
                        "poster_path": "/aZuBfbR0PnCb2up7lqHDsgJlLjs.jpg",
                        "backdrop_path": "/6oaL4DP75yABrd5EbC4H2zq5ghc.jpg"
                    },
                    {
                        "id": 19404,
                        "title": "용감한 자가 신부를 데려가리",
                        "genre_ids": [
                            35,
                            18,
                            10749
                        ],
                        "poster_path": "/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                        "backdrop_path": "/90ez6ArvpO8bvpyIngBuwXOqJm5.jpg"
                    },
                    {
                        "id": 155,
                        "title": "다크 나이트",
                        "genre_ids": [
                            18,
                            28,
                            80,
                            53
                        ],
                        "poster_path": "/f6dNinWX8rBM79JXKcShkfSh2oA.jpg",
                        "backdrop_path": "/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg"
                    },
                    {
                        "id": 496243,
                        "title": "기생충",
                        "genre_ids": [
                            35,
                            53,
                            18
                        ],
                        "poster_path": "/eRM0PykovgtK4lin1D4BUql8TBa.jpg",
                        "backdrop_path": "/8eihUxjQsJ7WvGySkVMC0EwbPAD.jpg"
                    },
                    {
                        "id": 497,
                        "title": "그린 마일",
                        "genre_ids": [
                            14,
                            18,
                            80
                        ],
                        "poster_path": "/yuSpRhrTIJa5JN8oESrfD2bndp1.jpg",
                        "backdrop_path": "/vxJ08SvwomfKbpboCWynC3uqUg4.jpg"
                    },
                    {
                        "id": 680,
                        "title": "펄프 픽션",
                        "genre_ids": [
                            53,
                            80
                        ],
                        "poster_path": "/6lXRHGoEbnnBUKsuqpL9JxD4DzT.jpg",
                        "backdrop_path": "/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg"
                    },
                    {
                        "id": 372058,
                        "title": "너의 이름은.",
                        "genre_ids": [
                            16,
                            10749,
                            18
                        ],
                        "poster_path": "/2DJCufz3Oa703PbLjNX1pM6MCG2.jpg",
                        "backdrop_path": "/dIWwZW7dJJtqC6CgWzYkNVKIUm8.jpg"
                    },
                    {
                        "id": 122,
                        "title": "반지의 제왕: 왕의 귀환",
                        "genre_ids": [
                            12,
                            14,
                            28
                        ],
                        "poster_path": "/n8BPIRqvj1SdTRND828ANXhmSng.jpg",
                        "backdrop_path": "/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg"
                    },
                    {
                        "id": 13,
                        "title": "포레스트 검프",
                        "genre_ids": [
                            35,
                            18,
                            10749
                        ],
                        "poster_path": "/xdJxoq0dtkchOkUz5UVKuxn7a2V.jpg",
                        "backdrop_path": "/ghgfzbEV7kbpbi1O8eIILKVXEA8.jpg"
                    },
                    {
                        "id": 429,
                        "title": "석양의 무법자",
                        "genre_ids": [
                            37
                        ],
                        "poster_path": "/s7qPuoj4liolAtmx9vcL6AyaZzR.jpg",
                        "backdrop_path": "/Adrip2Jqzw56KeuV2nAxucKMNXA.jpg"
                    },
                    {
                        "id": 769,
                        "title": "좋은 친구들",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/zF9hSBS1t7PVFLo01GrJ3OjGi67.jpg",
                        "backdrop_path": "/7TF4p86ZafnxFuNqWdhpHXFO244.jpg"
                    },
                    {
                        "id": 346,
                        "title": "7인의 사무라이",
                        "genre_ids": [
                            28,
                            18
                        ],
                        "poster_path": "/6Y8Q5t79ybiDA7XubUTneqZhjA3.jpg",
                        "backdrop_path": "/sJNNMCc6B7KZIY3LH3JMYJJNH5j.jpg"
                    },
                    {
                        "id": 12477,
                        "title": "반딧불이의 묘",
                        "genre_ids": [
                            16,
                            18,
                            10752
                        ],
                        "poster_path": "/uN0x0G4uuRjFJIFN57iYihBV2Qh.jpg",
                        "backdrop_path": "/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg"
                    },
                    {
                        "id": 11216,
                        "title": "시네마 천국",
                        "genre_ids": [
                            18,
                            10749
                        ],
                        "poster_path": "/r782z4H7GzkyNaf3hAtBB4pVkOj.jpg",
                        "backdrop_path": "/7lyq8hK0MhPHpUXdnqbFvZYSfkk.jpg"
                    },
                    {
                        "id": 637,
                        "title": "인생은 아름다워",
                        "genre_ids": [
                            35,
                            18
                        ],
                        "poster_path": "/yjOqQsQHdsEZfAosZERqHiwjaty.jpg",
                        "backdrop_path": "/gavyCu1UaTaTNPsVaGXT6pe5u24.jpg"
                    }
                ],
                "contents_id": null
            },
            "trend_recommendation_tv": {
                "page": 1,
                "total_pages": 1000,
                "total_results": 20000,
                "results": [
                    {
                        "id": 265156,
                        "name": "사랑이라는 거짓",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/AgKGqINmSEkZExekGCMH68KMSmE.jpg",
                        "backdrop_path": "/juXVrBTNzYZcUsdBveNMHEEaB4R.jpg"
                    },
                    {
                        "id": 259140,
                        "name": "란마1/2",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/yOFvSq8YGKSVvnbCc6IY4PWEssa.jpg",
                        "backdrop_path": "/xMgzRUA1RjxLQn05oJ8IFbf06AO.jpg"
                    },
                    {
                        "id": 255086,
                        "name": "정숙한 세일즈",
                        "genre_ids": [
                            35,
                            18
                        ],
                        "poster_path": "/4fncJSnUqbkMurayrXHNmOw2YTC.jpg",
                        "backdrop_path": "/c2WU8UKZtaBqTQviW2Y1iNXKzoh.jpg"
                    },
                    {
                        "id": 247721,
                        "name": "티컵",
                        "genre_ids": [
                            9648,
                            10765,
                            18
                        ],
                        "poster_path": "/emeFo6OW5tE0BISzx0HEdVqOOgG.jpg",
                        "backdrop_path": "/sVZX95m6Ti66pzIDek3oKPWZyBa.jpg"
                    },
                    {
                        "id": 243073,
                        "name": "Kill Me Love Me",
                        "genre_ids": [
                            18,
                            10759
                        ],
                        "poster_path": "/6kDZpnHamK38Q0b7wzWsoDSpZWk.jpg",
                        "backdrop_path": "/ygqfTpdow6NQEsZBJ0suBnGXSl.jpg"
                    },
                    {
                        "id": 240411,
                        "name": "단다단",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/rFAymAzC8Q8WT4YTZuxcovyKFSN.jpg",
                        "backdrop_path": "/jlbUx0aHJupDVDlCo0R7UxSaUUd.jpg"
                    },
                    {
                        "id": 236994,
                        "name": "드래곤볼 DAIMA",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/cIDPZMGsiVHkHA6HPJmEmGcgyyw.jpg",
                        "backdrop_path": "/jd0UJBrusmiNqLLP7Jxk1mmCWHS.jpg"
                    },
                    {
                        "id": 234538,
                        "name": "마왕 2099",
                        "genre_ids": [
                            16,
                            10765,
                            10759
                        ],
                        "poster_path": "/oXMvsgQR6I2H8AuClir6XpWkvEx.jpg",
                        "backdrop_path": "/rS6CNUPU62dsSmsPieLGm6NceZa.jpg"
                    },
                    {
                        "id": 225634,
                        "name": "괴물: 메넨데즈 형제 이야기",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/fHQOrThCnFffqz2w65P6Dgtdl5J.jpg",
                        "backdrop_path": "/h324Kf6pjDzGQiUrc4W2r4YcD9L.jpg"
                    },
                    {
                        "id": 218347,
                        "name": "Sweetpea",
                        "genre_ids": [
                            35,
                            18
                        ],
                        "poster_path": "/feoDYCy0AUD031gLqBmA9gC4pw1.jpg",
                        "backdrop_path": "/ka7LNRVhgB7No8yYKp9lrtauAIs.jpg"
                    },
                    {
                        "id": 216619,
                        "name": "더 프랜차이즈",
                        "genre_ids": [
                            35
                        ],
                        "poster_path": "/kWitzLQnweAcYFyjzVblkoByQDO.jpg",
                        "backdrop_path": "/m8LWW3Hw0a6LqzC0v6Xsx4udHiL.jpg"
                    },
                    {
                        "id": 214528,
                        "name": "정년이",
                        "genre_ids": [
                            18
                        ],
                        "poster_path": "/n87kHOWKkPsfTZQ4Cj4d0ntQj6J.jpg",
                        "backdrop_path": "/eQTBKvOqxaO4PBxs7rMj5MRw7Eb.jpg"
                    },
                    {
                        "id": 214032,
                        "name": "시타델: 디아나",
                        "genre_ids": [
                            10759,
                            18
                        ],
                        "poster_path": "/pXfgTz0uYUfYVEiJ0gRra6tKoAp.jpg",
                        "backdrop_path": "/oKDA5vAw7sDMGO7GHVAivmRCBlN.jpg"
                    },
                    {
                        "id": 211288,
                        "name": "트래커",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/r2AesQ7w9ejurJAMIMUWd2YSbVJ.jpg",
                        "backdrop_path": "/uVnGusAwehV4WdxgKwFg0UJql1R.jpg"
                    },
                    {
                        "id": 205050,
                        "name": "샹그릴라 프론티어 ~망겜 헌터, 갓겜에 도전하다~",
                        "genre_ids": [
                            16,
                            10759,
                            35,
                            10765
                        ],
                        "poster_path": "/fPo5XKxuSK5KEEa5DBu5GSY5ZPb.jpg",
                        "backdrop_path": "/yErVUZkLVak2ICxFC7mMfl3vcNP.jpg"
                    },
                    {
                        "id": 203737,
                        "name": "【최애의 아이】",
                        "genre_ids": [
                            16,
                            18
                        ],
                        "poster_path": "/zim3SB5YPcS6Hl2uLScJeW5bLIz.jpg",
                        "backdrop_path": "/gArCVC4ML529WMCEqOXbALdQbUq.jpg"
                    },
                    {
                        "id": 194764,
                        "name": "더 펭귄",
                        "genre_ids": [
                            18,
                            80
                        ],
                        "poster_path": "/a2fqompEWB2GFp9GOdlqLcfEFfw.jpg",
                        "backdrop_path": "/VSRmtRlYgd0pBISf7d34TAwWgB.jpg"
                    },
                    {
                        "id": 153312,
                        "name": "털사 킹",
                        "genre_ids": [
                            80,
                            18
                        ],
                        "poster_path": "/e8M3uJPFEEubf9dL9r5TYnbD8Io.jpg",
                        "backdrop_path": "/mNHRGO1gFpR2CYZdANe72kcKq7G.jpg"
                    },
                    {
                        "id": 147050,
                        "name": "'디스클레이머' - Disclaimer",
                        "genre_ids": [
                            18,
                            9648
                        ],
                        "poster_path": "/6TdW4T2EsnhXrPQccB8szK93UhF.jpg",
                        "backdrop_path": "/j7HEQlQoWA2weOR7jS1h5YbsEvM.jpg"
                    },
                    {
                        "id": 138501,
                        "name": "전부 애거사 짓이야",
                        "genre_ids": [
                            10765,
                            9648,
                            35
                        ],
                        "poster_path": "/skmiodZ3wLEuwKFjfQD8toC5tTq.jpg",
                        "backdrop_path": "/tYLXJW1sZQU09VWY1BhSVPKGIwc.jpg"
                    }
                ],
                "contents_id": null
            },
            "trend_recommendation_movie": {
                "page": 1,
                "total_pages": 1000,
                "total_results": 20000,
                "results": [
                    {
                        "id": 1317218,
                        "title": "미스터 크로켓",
                        "genre_ids": [
                            27
                        ],
                        "poster_path": "/oBJlQT3tfrDGRFE8X8UxVBVpQnZ.jpg",
                        "backdrop_path": "/45kRTSFsRqOmmkSVJjgOE0XVPEQ.jpg"
                    },
                    {
                        "id": 1247458,
                        "title": "그 여자의 집",
                        "genre_ids": [
                            18,
                            80,
                            53
                        ],
                        "poster_path": "/5NCP5M64H3IvCM6uxjz3QC9olPc.jpg",
                        "backdrop_path": "/ynS5uksQzVyDs3ySEjnQADnwoCB.jpg"
                    },
                    {
                        "id": 1207123,
                        "title": "White Snake: Afloat",
                        "genre_ids": [
                            16,
                            10749,
                            35,
                            14
                        ],
                        "poster_path": "/7tltIsVonubKCBUVpzsfaK4FaDF.jpg",
                        "backdrop_path": "/rDrc51pmicFppEXUMWvofCVvLn5.jpg"
                    },
                    {
                        "id": 1186532,
                        "title": "The Forge",
                        "genre_ids": [
                            18,
                            10751
                        ],
                        "poster_path": "/vXW1I7HGZkeGUqw8QpGFiDA31Ih.jpg",
                        "backdrop_path": "/1bWwaeVSFeytOBYNNEjZwH3VpFj.jpg"
                    },
                    {
                        "id": 1184918,
                        "title": "와일드 로봇",
                        "genre_ids": [
                            16,
                            878,
                            10751
                        ],
                        "poster_path": "/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg",
                        "backdrop_path": "/4zlOPT9CrtIX05bBIkYxNZsm5zN.jpg"
                    },
                    {
                        "id": 1182047,
                        "title": "어프렌티스",
                        "genre_ids": [
                            18,
                            36
                        ],
                        "poster_path": "/36t19mk84eUaAysyWb29CHp3Rcv.jpg",
                        "backdrop_path": "/pmPDfocouP0mS1UjiRDSqUdNIWH.jpg"
                    },
                    {
                        "id": 1153110,
                        "title": "책벌레",
                        "genre_ids": [
                            10751,
                            12,
                            35
                        ],
                        "poster_path": "/25ji4MPbb93DGjD6wyB76ifcTFD.jpg",
                        "backdrop_path": "/dOTybFWBSrHiYNZjC6DP7oubxZc.jpg"
                    },
                    {
                        "id": 1125510,
                        "title": "더 플랫폼 2",
                        "genre_ids": [
                            878,
                            53,
                            18,
                            27
                        ],
                        "poster_path": "/poELZsrROLJW28gc1V9nB1kJigq.jpg",
                        "backdrop_path": "/3m0j3hCS8kMAaP9El6Vy5Lqnyft.jpg"
                    },
                    {
                        "id": 1114513,
                        "title": "스픽 노 이블",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/mXGlp8K10JhiY5ZNY7zMldm2lss.jpg",
                        "backdrop_path": "/9R9Za5kybgl5AhuCNoK3gngaBdG.jpg"
                    },
                    {
                        "id": 1100782,
                        "title": "스마일 2",
                        "genre_ids": [
                            27,
                            9648
                        ],
                        "poster_path": "/4nQk1OgbtdnKYMEQiOwwMB4yGxn.jpg",
                        "backdrop_path": "/cVg97LOJgrDZJ7bVmjU2KsGRYnU.jpg"
                    },
                    {
                        "id": 1094974,
                        "title": "Take Cover",
                        "genre_ids": [
                            28,
                            53
                        ],
                        "poster_path": "/xNLiMNyFzKTL9PVIEulG55Hei8j.jpg",
                        "backdrop_path": "/1aOPPkXASkd2By3EKIw66Ilx5qF.jpg"
                    },
                    {
                        "id": 1087822,
                        "title": "헬보이: 더 크룩드 맨",
                        "genre_ids": [
                            14,
                            27,
                            28
                        ],
                        "poster_path": "/iz2GabtToVB05gLTVSH7ZvFtsMM.jpg",
                        "backdrop_path": "/g1z1ZvYKcmk9EnVOTYXR6vkNjkZ.jpg"
                    },
                    {
                        "id": 1075676,
                        "title": "전,란",
                        "genre_ids": [
                            28,
                            18,
                            36
                        ],
                        "poster_path": "/gnfNGXdW7J9HGNeHyaDpkAFJkHK.jpg",
                        "backdrop_path": "/64tinBsds1nVp4wOCgYhMbSgsRW.jpg"
                    },
                    {
                        "id": 1052280,
                        "title": "왓츠 인사이드",
                        "genre_ids": [
                            35,
                            9648,
                            878
                        ],
                        "poster_path": "/hP4KuHMQBUbyundBNet3wV7RPY7.jpg",
                        "backdrop_path": "/3LVVSvAkQGbL5fvG4VM3GfMaZBe.jpg"
                    },
                    {
                        "id": 1047373,
                        "title": "The Silent Hour",
                        "genre_ids": [
                            80,
                            53,
                            28
                        ],
                        "poster_path": "/j736cRzBtEPCm0nHnpRN1prqiqj.jpg",
                        "backdrop_path": "/udXJlkJScrlOJLBpS1Reorn807o.jpg"
                    },
                    {
                        "id": 1034541,
                        "title": "테리파이어 3",
                        "genre_ids": [
                            27,
                            53
                        ],
                        "poster_path": "/7NDHoebflLwL1CcgLJ9wZbbDrmV.jpg",
                        "backdrop_path": "/xlkclSE4aq7r3JsFIJRgs21zUew.jpg"
                    },
                    {
                        "id": 1022789,
                        "title": "인사이드 아웃 2",
                        "genre_ids": [
                            16,
                            10751,
                            12,
                            35,
                            18
                        ],
                        "poster_path": "/x2BHx02jMbvpKjMvbf8XxJkYwHJ.jpg",
                        "backdrop_path": "/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg"
                    },
                    {
                        "id": 959429,
                        "title": "론리 플래닛",
                        "genre_ids": [
                            10749,
                            18
                        ],
                        "poster_path": "/sH7Orig1yqa6ojMLIzLDxA2GRkH.jpg",
                        "backdrop_path": "/u6GpYb8MIC1W3fW4ZcsOul9GjzY.jpg"
                    },
                    {
                        "id": 957452,
                        "title": "더 크로우",
                        "genre_ids": [
                            28,
                            14,
                            27
                        ],
                        "poster_path": "/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg",
                        "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg"
                    },
                    {
                        "id": 945961,
                        "title": "에이리언: 로물루스",
                        "genre_ids": [
                            27,
                            878,
                            28
                        ],
                        "poster_path": "/bMGcJVd4hXlDcevRJZBK5qROlyP.jpg",
                        "backdrop_path": "/6vn6K9oX82i6E86ZiHVxqVEMQqP.jpg"
                    }
                ],
                "contents_id": null
            }
        }
        """
        return decoding(data)
    }
}


