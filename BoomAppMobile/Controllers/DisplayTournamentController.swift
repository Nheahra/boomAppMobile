//
//  DisplayTournamentController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/7/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//
import UIKit

class TournamentCell: UITableViewCell {
    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var tournamentDateLabel: UILabel!
    @IBOutlet weak var tournamentGoingLabel: UILabel!
}

class DisplayTournamentViewController: UIViewController {
    
    @IBOutlet weak var TournamentDisplayView: UITableView!
    
    private let model = TournamentModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tournamentDisplayView.delegate = self
//        model.delegate = self
    }
}

extension DisplayTournamentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("Selected tournament at \(indexPath)")
        model.tournamentSelected(at: indexPath.row)
        performSegue(withIdentifier: "tournamentDetails", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension DisplayTournamentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tournamentCell = tableView.dequeueReusableCell(withIdentifier: "tournamentCell")
    }
}
