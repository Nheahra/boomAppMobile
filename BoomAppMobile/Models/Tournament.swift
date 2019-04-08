//
//  Tournament.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

struct Tournament: Codable {
    let id: Int?
    let tournamentName: String
    let locationName: String
    let address: String
    let city: String
    let state: String
    let startDate: Date
    let rainDate: Date
}
