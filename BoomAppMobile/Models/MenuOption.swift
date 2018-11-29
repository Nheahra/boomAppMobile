//
//  MenuOptions.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/20/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

struct MenuOption {
    
    let option: String
    
    init(option: String) {
        self.option = option
    }
    
    static func homeOptions() -> [MenuOption] {
        return [
            MenuOption(option: "My Tournaments"),
            MenuOption(option: "All Tournaments"),
            MenuOption(option: "Create A Tournament")
        ]
    }
    static func sortOptions() -> [MenuOption] {
        return [
            MenuOption(option: "Newest"),
            MenuOption(option: "Oldest"),
            MenuOption(option: "Upcoming")
        ]
    }
}


