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
    @IBOutlet weak var tournamentAddressTextView: UITextView!
    @IBOutlet weak var tournamentMapView: MKMapView!
    @IBOutlet weak var registeredButton: UIButton!
    
    var tournament: Tournament? {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        tournamentNameLabel.text = tournament?.tournamentName
        tournamentAddressTextView.text = "\(tournament?.address ??  "Address") \n\(tournament?.city ?? "City"), \(tournament?.state ?? "State")"
        
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
