//
//  SortOption.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

enum SortOption: String, Codable, CaseIterable {
    case upcoming
    
    var displayName: String {
        switch self {
        case .upcoming:
            return "Upcoming:"
        }
    }
    static func optionFor(key: String) -> SortOption? {
        return SortOption.allCases.first(where: {key == $0.rawValue})
    }
}
