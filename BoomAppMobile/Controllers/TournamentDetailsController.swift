//
//  TournamentDetailsController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation
import UIKit

class TournamentDetailsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tournament = tournament else {
            return
        }
        self.textView.text = tournament.address
    }
}
