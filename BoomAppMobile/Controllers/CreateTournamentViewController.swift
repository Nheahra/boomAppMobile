//
//  EditTournamentViewController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/5/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

class CreateTournamentViewController: UIViewController {

    //MARK: CreateTournamentProperties
    @IBOutlet weak var tournamentName: UITextField!
    @IBOutlet weak var tournamentAddress: UITextField!
    @IBOutlet weak var tournamentCity: UITextField!
    @IBOutlet weak var tournamentStart: UIDatePicker!
    @IBOutlet weak var rainDate: UIDatePicker!
    @IBOutlet weak var states: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

