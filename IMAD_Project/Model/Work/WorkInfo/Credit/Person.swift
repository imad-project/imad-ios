//
//  Cast.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/21.
//

import Foundation

struct Person: Identifiable,Codable,Hashable {
    let gender: String?
    let id: Int
    let creditID, name: String?
    let profilePath, character: String?
    let knownForDepartment: String?
    let department, job: String?
    let importanceOrder: Int
    let creditType: String?

    enum CodingKeys: String, CodingKey {
        case gender, id
        case creditID = "credit_id"
        case name
        case profilePath = "profile_path"
        case character
        case knownForDepartment = "known_for_department"
        case department, job
        case importanceOrder = "importance_order"
        case creditType = "credit_type"
    }
}
