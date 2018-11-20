//
//  MenuCell.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/20/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuOption: UILabel!
    
    func configureMenuOption(_ option: MenuOption){
        menuOption.text = option.option
    }
}
