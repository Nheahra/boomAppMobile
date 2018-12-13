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
    
    let model = TournamentModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tournamentViewController = segue.destination as? TournamentDetailsViewController {
            tournamentViewController.tournament = model.selectedTournament
        } else {
            return
        }
        super.prepare(for: segue, sender: sender)
    }
}

extension TournamentMasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentCell", for: indexPath) as? TournamentCell, let tournament = model.tournament(at: indexPath.row) else {
            return UITableViewCell()
        }
        //let tournament = tournament[indexPath.row]
        cell.tournamentNameLabel.text = tournament.tournamentName
        cell.tournamentDateLabel.text = "\(tournament.startDate)"
        
        return cell
    }
}

extension TournamentMasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Tournament row: \(indexPath)")
        model.tournamentSelected(at: indexPath.row)
        performSegue(withIdentifier: "TournamentDetailsSegue", sender: self)
    }
}

extension TournamentMasterViewController: TournamentModelDelegate {
    var isFiltering: Bool {
        return false
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
