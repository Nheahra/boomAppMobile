//
//  TournamentDetailViewController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 12/3/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit
import MapKit

class TournamentDetailsViewController: UIViewController {

    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var tournamentStartDate: UILabel!
    @IBOutlet weak var tournamentAddressLabel: UILabel!
    @IBOutlet weak var tournamentCityStateLabel: UILabel!
    @IBOutlet weak var tournamentMapView: MKMapView!
    @IBOutlet weak var registeredButton: UIButton!
    
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tournament = tournament else {
            return
        }
        self.tournamentNameLabel.text = tournament.tournamentName
        self.tournamentStartDate.text = "\(String(describing: tournament.startDate))"
        self.tournamentAddressLabel.text = tournament.address
        self.tournamentCityStateLabel.text = "\(tournament.city), \(tournament.state)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
