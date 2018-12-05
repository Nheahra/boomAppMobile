////
////  DisplayTournamentController.swift
////  BoomAppMobile
////
////  Created by Katelyn on 11/7/18.
////  Copyright © 2018 Katelyn. All rights reserved.
////
//import UIKit
//
//class CenterViewController: UIViewController {
//    
//    var delegate: CenterViewControllerDelegate?
//    
//    @IBOutlet weak var tableView: UITableView!
//    var menuCell = MenuCell()
//    
//    @IBAction func sortTapped(_ sender: Any) { delegate?.toggleSort?() }
//    
//    //private let model = TournamentModel()
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
//////        tournamentDisplayView.delegate = self
//////        model.delegate = self
////    }
//}
//
//extension CenterViewController: SidePanelViewControllerDelegate {
//    func didSelectOption(_ option: MenuOption) {
//        //segue?
//        delegate?.collapsePanels?()
//    }
//}
//
////extension CenterViewController: UITableViewDelegate {
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
////        print("Selected tournament at \(indexPath)")
////        model.tournamentSelected(at: indexPath.row)
////        performSegue(withIdentifier: "tournamentDetails", sender: self)
////    }
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 150
////    }
////}
////
////extension CenterViewController: UITableViewDataSource {
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 1
////    }
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return model.numberOfRows
////    }
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let tournamentCell = tableView.dequeueReusableCell(withIdentifier: "tournamentCell", for: indexPath) as? TournamentCell, let tournament = model.tournament(at: indexPath.row) else {
////            return UITableViewCell()
////        }
////        tournamentCell.tournamentNameLabel.text = tournament.tournamentName
////        tournamentCell.tournamentDateLabel.text = ""
////        tournamentCell.tournamentGoingLabel.text = "Not yet"
////        return tournamentCell
////    }
////}
