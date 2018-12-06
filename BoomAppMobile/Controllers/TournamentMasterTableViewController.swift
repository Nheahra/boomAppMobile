//
//  TournamentMasterTableViewController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 12/3/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

class TournamentMasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let tournamentModel = TournamentModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
   
}

extension TournamentMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournamentModel.numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentCell", for: indexPath) as? TournamentCell, let tournament = tournamentModel.tournament(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.tournamentNameLabel.text = tournament.tournamentName
        cell.tournamentDateLabel.text = "\(tournament.startDate)"
        
        return cell
    }
}
extension TournamentMasterViewController: UITableViewDelegate {
    
}
