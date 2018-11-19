//
//  UIViewExtension.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

extension UIView {
    func pinFullScreen(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
