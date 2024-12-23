//
//  ContriesFilter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/06/02.
//

import Foundation

enum CountryKey: String {
    case iso31661 = "iso_3166_1"
    case englishName = "english_name"
    case nativeName = "native_name"
}
class ContriesFilter:ObservableObject{
    
    @Published var contriesData:[String: String] = [:]
    @Published var nativename = [String]()
    init(){
        fetchDataFromURL()
    }
    func fetchDataFromURL() {
        let contries = """
            [
              {
                "iso_3166_1": "AD",
                "english_name": "Andorra",
                "native_name": "안도라"
              },
              {
                "iso_3166_1": "AE",
                "english_name": "United Arab Emirates",
                "native_name": "아랍에미리트 연합"
              },
              {
                "iso_3166_1": "AF",
                "english_name": "Afghanistan",
                "native_name": "아프가니스탄"
              },
              {
                "iso_3166_1": "AG",
                "english_name": "Antigua and Barbuda",
                "native_name": "앤티가 바부다"
              },
              {
                "iso_3166_1": "AI",
                "english_name": "Anguilla",
                "native_name": "안길라"
              },
              {
                "iso_3166_1": "AL",
                "english_name": "Albania",
                "native_name": "알바니아"
              },
              {
                "iso_3166_1": "AM",
                "english_name": "Armenia",
                "native_name": "아르메니아"
              },
              {
                "iso_3166_1": "AN",
                "english_name": "Netherlands Antilles",
                "native_name": "네덜란드령 안틸레스"
              },
              {
                "iso_3166_1": "AO",
                "english_name": "Angola",
                "native_name": "앙골라"
              },
              {
                "iso_3166_1": "AQ",
                "english_name": "Antarctica",
                "native_name": "남극 대륙"
              },
              {
                "iso_3166_1": "AR",
                "english_name": "Argentina",
                "native_name": "아르헨티나"
              },
              {
                "iso_3166_1": "AS",
                "english_name": "American Samoa",
                "native_name": "아메리칸 사모아"
              },
              {
                "iso_3166_1": "AT",
                "english_name": "Austria",
                "native_name": "오스트리아"
              },
              {
                "iso_3166_1": "AU",
                "english_name": "Australia",
                "native_name": "호주"
              },
              {
                "iso_3166_1": "AW",
                "english_name": "Aruba",
                "native_name": "아루바"
              },
              {
                "iso_3166_1": "AZ",
                "english_name": "Azerbaijan",
                "native_name": "아제르바이잔"
              },
              {
                "iso_3166_1": "BA",
                "english_name": "Bosnia and Herzegovina",
                "native_name": "보스니아 헤르체고비나"
              },
              {
                "iso_3166_1": "BB",
                "english_name": "Barbados",
                "native_name": "바베이도스"
              },
              {
                "iso_3166_1": "BD",
                "english_name": "Bangladesh",
                "native_name": "방글라데시"
              },
              {
                "iso_3166_1": "BE",
                "english_name": "Belgium",
                "native_name": "벨기에"
              },
              {
                "iso_3166_1": "BF",
                "english_name": "Burkina Faso",
                "native_name": "부르키나파소"
              },
              {
                "iso_3166_1": "BG",
                "english_name": "Bulgaria",
                "native_name": "불가리아"
              },
              {
                "iso_3166_1": "BH",
                "english_name": "Bahrain",
                "native_name": "바레인"
              },
              {
                "iso_3166_1": "BI",
                "english_name": "Burundi",
                "native_name": "부룬디"
              },
              {
                "iso_3166_1": "BJ",
                "english_name": "Benin",
                "native_name": "베냉"
              },
              {
                "iso_3166_1": "BM",
                "english_name": "Bermuda",
                "native_name": "버뮤다"
              },
              {
                "iso_3166_1": "BN",
                "english_name": "Brunei Darussalam",
                "native_name": "브루나이"
              },
              {
                "iso_3166_1": "BO",
                "english_name": "Bolivia",
                "native_name": "볼리비아"
              },
              {
                "iso_3166_1": "BR",
                "english_name": "Brazil",
                "native_name": "브라질"
              },
              {
                "iso_3166_1": "BS",
                "english_name": "Bahamas",
                "native_name": "바하마"
              },
              {
                "iso_3166_1": "BT",
                "english_name": "Bhutan",
                "native_name": "부탄"
              },
              {
                "iso_3166_1": "BU",
                "english_name": "Burma",
                "native_name": "Burma"
              },
              {
                "iso_3166_1": "BV",
                "english_name": "Bouvet Island",
                "native_name": "부베"
              },
              {
                "iso_3166_1": "BW",
                "english_name": "Botswana",
                "native_name": "보츠와나"
              },
              {
                "iso_3166_1": "BY",
                "english_name": "Belarus",
                "native_name": "벨라루스"
              },
              {
                "iso_3166_1": "BZ",
                "english_name": "Belize",
                "native_name": "벨리즈"
              },
              {
                "iso_3166_1": "CA",
                "english_name": "Canada",
                "native_name": "캐나다"
              },
              {
                "iso_3166_1": "CC",
                "english_name": "Cocos  Islands",
                "native_name": "코코스제도"
              },
              {
                "iso_3166_1": "CD",
                "english_name": "Congo",
                "native_name": "콩고-킨샤사"
              },
              {
                "iso_3166_1": "CF",
                "english_name": "Central African Republic",
                "native_name": "중앙 아프리카 공화국"
              },
              {
                "iso_3166_1": "CG",
                "english_name": "Congo",
                "native_name": "콩고"
              },
              {
                "iso_3166_1": "CH",
                "english_name": "Switzerland",
                "native_name": "스위스"
              },
              {
                "iso_3166_1": "CI",
                "english_name": "Cote D'Ivoire",
                "native_name": "코트디부아르"
              },
              {
                "iso_3166_1": "CK",
                "english_name": "Cook Islands",
                "native_name": "쿡제도"
              },
              {
                "iso_3166_1": "CL",
                "english_name": "Chile",
                "native_name": "칠레"
              },
              {
                "iso_3166_1": "CM",
                "english_name": "Cameroon",
                "native_name": "카메룬"
              },
              {
                "iso_3166_1": "CN",
                "english_name": "China",
                "native_name": "중국"
              },
              {
                "iso_3166_1": "CO",
                "english_name": "Colombia",
                "native_name": "콜롬비아"
              },
              {
                "iso_3166_1": "CR",
                "english_name": "Costa Rica",
                "native_name": "코스타리카"
              },
              {
                "iso_3166_1": "CS",
                "english_name": "Serbia and Montenegro",
                "native_name": "Serbia and Montenegro"
              },
              {
                "iso_3166_1": "CU",
                "english_name": "Cuba",
                "native_name": "쿠바"
              },
              {
                "iso_3166_1": "CV",
                "english_name": "Cape Verde",
                "native_name": "까뽀베르데"
              },
              {
                "iso_3166_1": "CX",
                "english_name": "Christmas Island",
                "native_name": "크리스마스섬"
              },
              {
                "iso_3166_1": "CY",
                "english_name": "Cyprus",
                "native_name": "사이프러스"
              },
              {
                "iso_3166_1": "CZ",
                "english_name": "Czech Republic",
                "native_name": "체코"
              },
              {
                "iso_3166_1": "DE",
                "english_name": "Germany",
                "native_name": "독일"
              },
              {
                "iso_3166_1": "DJ",
                "english_name": "Djibouti",
                "native_name": "지부티"
              },
              {
                "iso_3166_1": "DK",
                "english_name": "Denmark",
                "native_name": "덴마크"
              },
              {
                "iso_3166_1": "DM",
                "english_name": "Dominica",
                "native_name": "도미니카"
              },
              {
                "iso_3166_1": "DO",
                "english_name": "Dominican Republic",
                "native_name": "도미니카 공화국"
              },
              {
                "iso_3166_1": "DZ",
                "english_name": "Algeria",
                "native_name": "알제리"
              },
              {
                "iso_3166_1": "EC",
                "english_name": "Ecuador",
                "native_name": "에콰도르"
              },
              {
                "iso_3166_1": "EE",
                "english_name": "Estonia",
                "native_name": "에스토니아"
              },
              {
                "iso_3166_1": "EG",
                "english_name": "Egypt",
                "native_name": "이집트"
              },
              {
                "iso_3166_1": "EH",
                "english_name": "Western Sahara",
                "native_name": "서사하라"
              },
              {
                "iso_3166_1": "ER",
                "english_name": "Eritrea",
                "native_name": "에리트리아"
              },
              {
                "iso_3166_1": "ES",
                "english_name": "Spain",
                "native_name": "스페인"
              },
              {
                "iso_3166_1": "ET",
                "english_name": "Ethiopia",
                "native_name": "이디오피아"
              },
              {
                "iso_3166_1": "FI",
                "english_name": "Finland",
                "native_name": "핀란드"
              },
              {
                "iso_3166_1": "FJ",
                "english_name": "Fiji",
                "native_name": "피지"
              },
              {
                "iso_3166_1": "FK",
                "english_name": "Falkland Islands",
                "native_name": "포클랜드 제도"
              },
              {
                "iso_3166_1": "FM",
                "english_name": "Micronesia",
                "native_name": "미크로네시아"
              },
              {
                "iso_3166_1": "FO",
                "english_name": "Faeroe Islands",
                "native_name": "페로제도"
              },
              {
                "iso_3166_1": "FR",
                "english_name": "France",
                "native_name": "프랑스"
              },
              {
                "iso_3166_1": "GA",
                "english_name": "Gabon",
                "native_name": "가봉"
              },
              {
                "iso_3166_1": "GB",
                "english_name": "United Kingdom",
                "native_name": "영국"
              },
              {
                "iso_3166_1": "GD",
                "english_name": "Grenada",
                "native_name": "그레나다"
              },
              {
                "iso_3166_1": "GE",
                "english_name": "Georgia",
                "native_name": "조지아"
              },
              {
                "iso_3166_1": "GF",
                "english_name": "French Guiana",
                "native_name": "프랑스령 기아나"
              },
              {
                "iso_3166_1": "GH",
                "english_name": "Ghana",
                "native_name": "가나"
              },
              {
                "iso_3166_1": "GI",
                "english_name": "Gibraltar",
                "native_name": "지브롤터"
              },
              {
                "iso_3166_1": "GL",
                "english_name": "Greenland",
                "native_name": "그린란드"
              },
              {
                "iso_3166_1": "GM",
                "english_name": "Gambia",
                "native_name": "감비아"
              },
              {
                "iso_3166_1": "GN",
                "english_name": "Guinea",
                "native_name": "기니"
              },
              {
                "iso_3166_1": "GP",
                "english_name": "Guadaloupe",
                "native_name": "과들루프"
              },
              {
                "iso_3166_1": "GQ",
                "english_name": "Equatorial Guinea",
                "native_name": "적도 기니"
              },
              {
                "iso_3166_1": "GR",
                "english_name": "Greece",
                "native_name": "그리스"
              },
              {
                "iso_3166_1": "GS",
                "english_name": "South Georgia and the South Sandwich Islands",
                "native_name": "사우스조지아 사우스샌드위치 제도"
              },
              {
                "iso_3166_1": "GT",
                "english_name": "Guatemala",
                "native_name": "과테말라"
              },
              {
                "iso_3166_1": "GU",
                "english_name": "Guam",
                "native_name": "괌"
              },
              {
                "iso_3166_1": "GW",
                "english_name": "Guinea-Bissau",
                "native_name": "기네비쏘"
              },
              {
                "iso_3166_1": "GY",
                "english_name": "Guyana",
                "native_name": "가이아나"
              },
              {
                "iso_3166_1": "HK",
                "english_name": "Hong Kong",
                "native_name": "홍콩, 중국 특별행정구"
              },
              {
                "iso_3166_1": "HM",
                "english_name": "Heard and McDonald Islands",
                "native_name": "허드섬-맥도널드제도"
              },
              {
                "iso_3166_1": "HN",
                "english_name": "Honduras",
                "native_name": "온두라스"
              },
              {
                "iso_3166_1": "HR",
                "english_name": "Croatia",
                "native_name": "크로아티아"
              },
              {
                "iso_3166_1": "HT",
                "english_name": "Haiti",
                "native_name": "아이티"
              },
              {
                "iso_3166_1": "HU",
                "english_name": "Hungary",
                "native_name": "헝가리"
              },
              {
                "iso_3166_1": "ID",
                "english_name": "Indonesia",
                "native_name": "인도네시아"
              },
              {
                "iso_3166_1": "IE",
                "english_name": "Ireland",
                "native_name": "아일랜드"
              },
              {
                "iso_3166_1": "IL",
                "english_name": "Israel",
                "native_name": "이스라엘"
              },
              {
                "iso_3166_1": "IN",
                "english_name": "India",
                "native_name": "인도"
              },
              {
                "iso_3166_1": "IO",
                "english_name": "British Indian Ocean Territory",
                "native_name": "영국령인도양식민지"
              },
              {
                "iso_3166_1": "IQ",
                "english_name": "Iraq",
                "native_name": "이라크"
              },
              {
                "iso_3166_1": "IR",
                "english_name": "Iran",
                "native_name": "이란"
              },
              {
                "iso_3166_1": "IS",
                "english_name": "Iceland",
                "native_name": "아이슬란드"
              },
              {
                "iso_3166_1": "IT",
                "english_name": "Italy",
                "native_name": "이탈리아"
              },
              {
                "iso_3166_1": "JM",
                "english_name": "Jamaica",
                "native_name": "자메이카"
              },
              {
                "iso_3166_1": "JO",
                "english_name": "Jordan",
                "native_name": "요르단"
              },
              {
                "iso_3166_1": "JP",
                "english_name": "Japan",
                "native_name": "일본"
              },
              {
                "iso_3166_1": "KE",
                "english_name": "Kenya",
                "native_name": "케냐"
              },
              {
                "iso_3166_1": "KG",
                "english_name": "Kyrgyz Republic",
                "native_name": "키르기스스탄"
              },
              {
                "iso_3166_1": "KH",
                "english_name": "Cambodia",
                "native_name": "캄보디아"
              },
              {
                "iso_3166_1": "KI",
                "english_name": "Kiribati",
                "native_name": "키리바시"
              },
              {
                "iso_3166_1": "KM",
                "english_name": "Comoros",
                "native_name": "코모로스"
              },
              {
                "iso_3166_1": "KN",
                "english_name": "St. Kitts and Nevis",
                "native_name": "세인트 키츠 네비스"
              },
              {
                "iso_3166_1": "KP",
                "english_name": "North Korea",
                "native_name": "조선 민주주의 인민 공화국"
              },
              {
                "iso_3166_1": "KR",
                "english_name": "South Korea",
                "native_name": "대한민국"
              },
              {
                "iso_3166_1": "KW",
                "english_name": "Kuwait",
                "native_name": "쿠웨이트"
              },
              {
                "iso_3166_1": "KY",
                "english_name": "Cayman Islands",
                "native_name": "케이맨제도"
              },
              {
                "iso_3166_1": "KZ",
                "english_name": "Kazakhstan",
                "native_name": "카자흐스탄"
              },
              {
                "iso_3166_1": "LA",
                "english_name": "Lao People's Democratic Republic",
                "native_name": "라오스"
              },
              {
                "iso_3166_1": "LB",
                "english_name": "Lebanon",
                "native_name": "레바논"
              },
              {
                "iso_3166_1": "LC",
                "english_name": "St. Lucia",
                "native_name": "세인트루시아"
              },
              {
                "iso_3166_1": "LI",
                "english_name": "Liechtenstein",
                "native_name": "리히텐슈타인"
              },
              {
                "iso_3166_1": "LK",
                "english_name": "Sri Lanka",
                "native_name": "스리랑카"
              },
              {
                "iso_3166_1": "LR",
                "english_name": "Liberia",
                "native_name": "라이베리아"
              },
              {
                "iso_3166_1": "LS",
                "english_name": "Lesotho",
                "native_name": "레소토"
              },
              {
                "iso_3166_1": "LT",
                "english_name": "Lithuania",
                "native_name": "리투아니아"
              },
              {
                "iso_3166_1": "LU",
                "english_name": "Luxembourg",
                "native_name": "룩셈부르크"
              },
              {
                "iso_3166_1": "LV",
                "english_name": "Latvia",
                "native_name": "라트비아"
              },
              {
                "iso_3166_1": "LY",
                "english_name": "Libyan Arab Jamahiriya",
                "native_name": "리비아"
              },
              {
                "iso_3166_1": "MA",
                "english_name": "Morocco",
                "native_name": "모로코"
              },
              {
                "iso_3166_1": "MC",
                "english_name": "Monaco",
                "native_name": "모나코"
              },
              {
                "iso_3166_1": "MD",
                "english_name": "Moldova",
                "native_name": "몰도바"
              },
              {
                "iso_3166_1": "ME",
                "english_name": "Montenegro",
                "native_name": "몬테네그로"
              },
              {
                "iso_3166_1": "MG",
                "english_name": "Madagascar",
                "native_name": "마다가스카르"
              },
              {
                "iso_3166_1": "MH",
                "english_name": "Marshall Islands",
                "native_name": "마샬 군도"
              },
              {
                "iso_3166_1": "MK",
                "english_name": "Macedonia",
                "native_name": "마케도니아"
              },
              {
                "iso_3166_1": "ML",
                "english_name": "Mali",
                "native_name": "말리"
              },
              {
                "iso_3166_1": "MM",
                "english_name": "Myanmar",
                "native_name": "미얀마"
              },
              {
                "iso_3166_1": "MN",
                "english_name": "Mongolia",
                "native_name": "몽골"
              },
              {
                "iso_3166_1": "MO",
                "english_name": "Macao",
                "native_name": "마카오, 중국 특별행정구"
              },
              {
                "iso_3166_1": "MP",
                "english_name": "Northern Mariana Islands",
                "native_name": "북마리아나제도"
              },
              {
                "iso_3166_1": "MQ",
                "english_name": "Martinique",
                "native_name": "말티니크"
              },
              {
                "iso_3166_1": "MR",
                "english_name": "Mauritania",
                "native_name": "모리타니"
              },
              {
                "iso_3166_1": "MS",
                "english_name": "Montserrat",
                "native_name": "몬트세라트"
              },
              {
                "iso_3166_1": "MT",
                "english_name": "Malta",
                "native_name": "몰타"
              },
              {
                "iso_3166_1": "MU",
                "english_name": "Mauritius",
                "native_name": "모리셔스"
              },
              {
                "iso_3166_1": "MV",
                "english_name": "Maldives",
                "native_name": "몰디브"
              },
              {
                "iso_3166_1": "MW",
                "english_name": "Malawi",
                "native_name": "말라위"
              },
              {
                "iso_3166_1": "MX",
                "english_name": "Mexico",
                "native_name": "멕시코"
              },
              {
                "iso_3166_1": "MY",
                "english_name": "Malaysia",
                "native_name": "말레이시아"
              },
              {
                "iso_3166_1": "MZ",
                "english_name": "Mozambique",
                "native_name": "모잠비크"
              },
              {
                "iso_3166_1": "NA",
                "english_name": "Namibia",
                "native_name": "나미비아"
              },
              {
                "iso_3166_1": "NC",
                "english_name": "New Caledonia",
                "native_name": "뉴 칼레도니아"
              },
              {
                "iso_3166_1": "NE",
                "english_name": "Niger",
                "native_name": "니제르"
              },
              {
                "iso_3166_1": "NF",
                "english_name": "Norfolk Island",
                "native_name": "노퍽섬"
              },
              {
                "iso_3166_1": "NG",
                "english_name": "Nigeria",
                "native_name": "나이지리아"
              },
              {
                "iso_3166_1": "NI",
                "english_name": "Nicaragua",
                "native_name": "니카라과"
              },
              {
                "iso_3166_1": "NL",
                "english_name": "Netherlands",
                "native_name": "네덜란드"
              },
              {
                "iso_3166_1": "NO",
                "english_name": "Norway",
                "native_name": "노르웨이"
              },
              {
                "iso_3166_1": "NP",
                "english_name": "Nepal",
                "native_name": "네팔"
              },
              {
                "iso_3166_1": "NR",
                "english_name": "Nauru",
                "native_name": "나우루"
              },
              {
                "iso_3166_1": "NU",
                "english_name": "Niue",
                "native_name": "니우에"
              },
              {
                "iso_3166_1": "NZ",
                "english_name": "New Zealand",
                "native_name": "뉴질랜드"
              },
              {
                "iso_3166_1": "OM",
                "english_name": "Oman",
                "native_name": "오만"
              },
              {
                "iso_3166_1": "PA",
                "english_name": "Panama",
                "native_name": "파나마"
              },
              {
                "iso_3166_1": "PE",
                "english_name": "Peru",
                "native_name": "페루"
              },
              {
                "iso_3166_1": "PF",
                "english_name": "French Polynesia",
                "native_name": "프랑스령 폴리네시아"
              },
              {
                "iso_3166_1": "PG",
                "english_name": "Papua New Guinea",
                "native_name": "파푸아뉴기니"
              },
              {
                "iso_3166_1": "PH",
                "english_name": "Philippines",
                "native_name": "필리핀"
              },
              {
                "iso_3166_1": "PK",
                "english_name": "Pakistan",
                "native_name": "파키스탄"
              },
              {
                "iso_3166_1": "PL",
                "english_name": "Poland",
                "native_name": "폴란드"
              },
              {
                "iso_3166_1": "PM",
                "english_name": "St. Pierre and Miquelon",
                "native_name": "생피에르 미클롱"
              },
              {
                "iso_3166_1": "PN",
                "english_name": "Pitcairn Island",
                "native_name": "핏케언 섬"
              },
              {
                "iso_3166_1": "PR",
                "english_name": "Puerto Rico",
                "native_name": "푸에르토리코"
              },
              {
                "iso_3166_1": "PS",
                "english_name": "Palestinian Territory",
                "native_name": "팔레스타인 지구"
              },
              {
                "iso_3166_1": "PT",
                "english_name": "Portugal",
                "native_name": "포르투갈"
              },
              {
                "iso_3166_1": "PW",
                "english_name": "Palau",
                "native_name": "팔라우"
              },
              {
                "iso_3166_1": "PY",
                "english_name": "Paraguay",
                "native_name": "파라과이"
              },
              {
                "iso_3166_1": "QA",
                "english_name": "Qatar",
                "native_name": "카타르"
              },
              {
                "iso_3166_1": "RE",
                "english_name": "Reunion",
                "native_name": "리유니온"
              },
              {
                "iso_3166_1": "RO",
                "english_name": "Romania",
                "native_name": "루마니아"
              },
              {
                "iso_3166_1": "RS",
                "english_name": "Serbia",
                "native_name": "세르비아"
              },
              {
                "iso_3166_1": "RU",
                "english_name": "Russia",
                "native_name": "러시아"
              },
              {
                "iso_3166_1": "RW",
                "english_name": "Rwanda",
                "native_name": "르완다"
              },
              {
                "iso_3166_1": "SA",
                "english_name": "Saudi Arabia",
                "native_name": "사우디아라비아"
              },
              {
                "iso_3166_1": "SB",
                "english_name": "Solomon Islands",
                "native_name": "솔로몬 제도"
              },
              {
                "iso_3166_1": "SC",
                "english_name": "Seychelles",
                "native_name": "쉐이쉘"
              },
              {
                "iso_3166_1": "SD",
                "english_name": "Sudan",
                "native_name": "수단"
              },
              {
                "iso_3166_1": "SE",
                "english_name": "Sweden",
                "native_name": "스웨덴"
              },
              {
                "iso_3166_1": "SG",
                "english_name": "Singapore",
                "native_name": "싱가포르"
              },
              {
                "iso_3166_1": "SH",
                "english_name": "St. Helena",
                "native_name": "세인트헬레나"
              },
              {
                "iso_3166_1": "SI",
                "english_name": "Slovenia",
                "native_name": "슬로베니아"
              },
              {
                "iso_3166_1": "SJ",
                "english_name": "Svalbard & Jan Mayen Islands",
                "native_name": "스발바르제도-얀마웬섬"
              },
              {
                "iso_3166_1": "SK",
                "english_name": "Slovakia",
                "native_name": "슬로바키아"
              },
              {
                "iso_3166_1": "SL",
                "english_name": "Sierra Leone",
                "native_name": "시에라리온"
              },
              {
                "iso_3166_1": "SM",
                "english_name": "San Marino",
                "native_name": "산마리노"
              },
              {
                "iso_3166_1": "SN",
                "english_name": "Senegal",
                "native_name": "세네갈"
              },
              {
                "iso_3166_1": "SO",
                "english_name": "Somalia",
                "native_name": "소말리아"
              },
              {
                "iso_3166_1": "SR",
                "english_name": "Suriname",
                "native_name": "수리남"
              },
              {
                "iso_3166_1": "SS",
                "english_name": "South Sudan",
                "native_name": "남수단"
              },
              {
                "iso_3166_1": "ST",
                "english_name": "Sao Tome and Principe",
                "native_name": "상투메 프린시페"
              },
              {
                "iso_3166_1": "SU",
                "english_name": "Soviet Union",
                "native_name": "Soviet Union"
              },
              {
                "iso_3166_1": "SV",
                "english_name": "El Salvador",
                "native_name": "엘살바도르"
              },
              {
                "iso_3166_1": "SY",
                "english_name": "Syrian Arab Republic",
                "native_name": "시리아"
              },
              {
                "iso_3166_1": "SZ",
                "english_name": "Swaziland",
                "native_name": "스와질랜드"
              },
              {
                "iso_3166_1": "TC",
                "english_name": "Turks and Caicos Islands",
                "native_name": "터크스케이커스제도"
              },
              {
                "iso_3166_1": "TD",
                "english_name": "Chad",
                "native_name": "차드"
              },
              {
                "iso_3166_1": "TF",
                "english_name": "French Southern Territories",
                "native_name": "프랑스 남부 지방"
              },
              {
                "iso_3166_1": "TG",
                "english_name": "Togo",
                "native_name": "토고"
              },
              {
                "iso_3166_1": "TH",
                "english_name": "Thailand",
                "native_name": "태국"
              },
              {
                "iso_3166_1": "TJ",
                "english_name": "Tajikistan",
                "native_name": "타지키스탄"
              },
              {
                "iso_3166_1": "TK",
                "english_name": "Tokelau",
                "native_name": "토켈라우"
              },
              {
                "iso_3166_1": "TL",
                "english_name": "Timor-Leste",
                "native_name": "동티모르"
              },
              {
                "iso_3166_1": "TM",
                "english_name": "Turkmenistan",
                "native_name": "투르크메니스탄"
              },
              {
                "iso_3166_1": "TN",
                "english_name": "Tunisia",
                "native_name": "튀니지"
              },
              {
                "iso_3166_1": "TO",
                "english_name": "Tonga",
                "native_name": "통가"
              },
              {
                "iso_3166_1": "TP",
                "english_name": "East Timor",
                "native_name": "East Timor"
              },
              {
                "iso_3166_1": "TR",
                "english_name": "Turkey",
                "native_name": "터키"
              },
              {
                "iso_3166_1": "TT",
                "english_name": "Trinidad and Tobago",
                "native_name": "트리니다드 토바고"
              },
              {
                "iso_3166_1": "TV",
                "english_name": "Tuvalu",
                "native_name": "투발루"
              },
              {
                "iso_3166_1": "TW",
                "english_name": "Taiwan",
                "native_name": "대만"
              },
              {
                "iso_3166_1": "TZ",
                "english_name": "Tanzania",
                "native_name": "탄자니아"
              },
              {
                "iso_3166_1": "UA",
                "english_name": "Ukraine",
                "native_name": "우크라이나"
              },
              {
                "iso_3166_1": "UG",
                "english_name": "Uganda",
                "native_name": "우간다"
              },
              {
                "iso_3166_1": "UM",
                "english_name": "United States Minor Outlying Islands",
                "native_name": "미국령 해외 제도"
              },
              {
                "iso_3166_1": "US",
                "english_name": "United States of America",
                "native_name": "미국"
              },
              {
                "iso_3166_1": "UY",
                "english_name": "Uruguay",
                "native_name": "우루과이"
              },
              {
                "iso_3166_1": "UZ",
                "english_name": "Uzbekistan",
                "native_name": "우즈베키스탄"
              },
              {
                "iso_3166_1": "VA",
                "english_name": "Holy See",
                "native_name": "바티칸"
              },
              {
                "iso_3166_1": "VC",
                "english_name": "St. Vincent and the Grenadines",
                "native_name": "세인트빈센트그레나딘"
              },
              {
                "iso_3166_1": "VE",
                "english_name": "Venezuela",
                "native_name": "베네수엘라"
              },
              {
                "iso_3166_1": "VG",
                "english_name": "British Virgin Islands",
                "native_name": "영국령 버진 아일랜드"
              },
              {
                "iso_3166_1": "VI",
                "english_name": "US Virgin Islands",
                "native_name": "미국령 버진 아일랜드"
              },
              {
                "iso_3166_1": "VN",
                "english_name": "Vietnam",
                "native_name": "베트남"
              },
              {
                "iso_3166_1": "VU",
                "english_name": "Vanuatu",
                "native_name": "바누아투"
              },
              {
                "iso_3166_1": "WF",
                "english_name": "Wallis and Futuna Islands",
                "native_name": "왈리스-푸투나 제도"
              },
              {
                "iso_3166_1": "WS",
                "english_name": "Samoa",
                "native_name": "사모아"
              },
              {
                "iso_3166_1": "XC",
                "english_name": "Czechoslovakia",
                "native_name": "Czechoslovakia"
              },
              {
                "iso_3166_1": "XG",
                "english_name": "East Germany",
                "native_name": "East Germany"
              },
              {
                "iso_3166_1": "XI",
                "english_name": "Northern Ireland",
                "native_name": "Northern Ireland"
              },
              {
                "iso_3166_1": "XK",
                "english_name": "Kosovo",
                "native_name": "코소보"
              },
              {
                "iso_3166_1": "YE",
                "english_name": "Yemen",
                "native_name": "예멘"
              },
              {
                "iso_3166_1": "YT",
                "english_name": "Mayotte",
                "native_name": "마요티"
              },
              {
                "iso_3166_1": "YU",
                "english_name": "Yugoslavia",
                "native_name": "Yugoslavia"
              },
              {
                "iso_3166_1": "ZA",
                "english_name": "South Africa",
                "native_name": "남아프리카"
              },
              {
                "iso_3166_1": "ZM",
                "english_name": "Zambia",
                "native_name": "잠비아"
              },
              {
                "iso_3166_1": "ZR",
                "english_name": "Zaire",
                "native_name": "Zaire"
              },
              {
                "iso_3166_1": "ZW",
                "english_name": "Zimbabwe",
                "native_name": "짐바브웨"
              }
            ]
            """
        if let jsonData = contries.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                    for item in jsonArray {
                        if let iso3166 = item["iso_3166_1"] as? String, let nativeName = item["native_name"] as? String {
                            contriesData[iso3166] = nativeName
                        }
                    }
                    contriesData.forEach { dic in
                        if dic.key == CountryKey.nativeName.rawValue{
                            nativename.append(dic.value)
                        }
                    }
                } else {
                    print("JSON 데이터를 배열로 파싱할 수 없습니다.")
                }
            } catch {
                print("JSON 데이터 파싱 중 오류 발생: \(error)")
            }
        } else {
            print("JSON 데이터를 Data로 변환할 수 없습니다.")
        }
    }
}
