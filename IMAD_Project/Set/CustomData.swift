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
    "https://i.namu.wiki/i/-qvTRDYq5CoZpLNKLL3Gx6p8pU2Se1X1ama2pvVu0n4kOTDqk0-3Oc4XRHry9oNHB0i28wGaswx6KfD8A7zkZwETWHcDpz2Y0SZarHoTP8YYlGTEKYdmqs9asNJZHpuyCBxuywMoxUt7JXq3wtEBCQ.webp",
    "https://i.namu.wiki/i/KTAYhcIHxjGhxJPI1cK0fBaKz4MaiIvmadmZzqjfOmrwfrOlExl-tOkaLdAbRO6bQaRmh_yVyt8SSgjwvtomiC6m-QoqAX2vFMedGRj7gAOI69Tx1hCczUb5Do1bEtYmfUgBomn7mpBVpmxmM3C4QA.webp",
    "https://i.namu.wiki/i/nv2xPwgCF7MoUNKM4ClMhBA1n_lXhfI7i5zYvH0WezwOgmtpfr4rJfxd9MDY29xJ4hFtN2h3o6dGJdkqstXht4jUeV0prj55-E-IXXIHiwBikHbD6M1NEA4UAP8gRwd21Ci_iC1XV6grp07Zl56LbA.webp",
    "https://i.namu.wiki/i/JEtTpNfB738DdT-8vIJWWt46EQyZv7-AKQUF3NoxNpY0_fM_D1ldIwR9q2ifAUPPq1oEnKO0lN73R5nqDOlSF6CHg3RlB9VMODzHk7FgTQUe5agbIlesnvCNxkp5QsGGyfuN8hmzMbv0X1vSheTyyQ.webp",
    "https://i.namu.wiki/i/_dUc3A-VI6ZeJkDU1ekeO4mH8vLIESQCTh9UnsWvPtAmdsWsVmpQUVehqizyKOZKPxwx4UOYbpnkcya4pnLzLrJI3rM3RSXV3qiWcUKU1nCKwpCE0faKLYJRR3ugraGpk2xUlsTspp3ZFsbDep25dQ.webp",
    "https://i.namu.wiki/i/It35jkmOLho6HcScdW8bP8pZghJ6ShlhdTeevfR0A3y5HjMzJIcA3WSdZ-jfk5HfFSP9Rig9rD_qKuI6OSGxshVmCqFZeuFu55ieh_3dORAQ8DkxZKSwoxF_Sr8utDkyu-wKuhXY_t3yYG6bvhM0iA.webp",
    "https://i.namu.wiki/i/KqzJaLGbenad2hkTTY1uNtQRk7MhHVY1Y4yWFtKTuukEm22Tq78YQbdtK5SSKH2COPCCbkPMFBy4SCA7IJ9K7FRiCMEFgcynWW00bGckzIFYg0XXh3YAJFg7SW7nFHjs6ioKpoBRRkyMB2miD8NZqg.webp",
    "https://i.namu.wiki/i/1xh_6ayTSr2KwQPf03LPZVqeeEEjC_w6y7RYdmPwBwdqzpwAXwz3RRiExNr7gwGJ-qJR1qLp_TswzUIPpzlXI3zo1HMhhInx7sOp5WGE45VbZg7F8Cou-lDyVivR9Ji1xhkXg7r_kZth83-NUgHUUw.webp"
    ]
    let notification = [
        Notific(icon: "bubble.left", content: "회원님에 게시물에 댓글이 달렸습니다"),
        Notific(icon: "bell", content: "회원님에 게시물에 새로운 추천이 있습니다"),
        Notific(icon: "envelope", content: "개발자의 편지 - 오늘의 새로운 영화!")
    ]
   
    
}
