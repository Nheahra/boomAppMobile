//
//  CenterViewControllerDelegate.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/20/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    @objc optional func toggleMenu()
    @objc optional func toggleSort()
    @objc optional func collapsePanels()
}
