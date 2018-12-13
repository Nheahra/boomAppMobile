//
//  TournamentModel.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

protocol TournamentModelDelegate: class {
    var isFiltering: Bool {get}
    func dataUpdated()
}

class TournamentModel {
    weak var delegate: TournamentModelDelegate?
    private(set) var selections: [SortSelection]
    private let selectionPersistence: Selection_FlatFilePersistence
    private let tournamentPersistence: Tournament_FlatFilePersistence
    
    fileprivate var apiConnect = APIConnect()
    private var tournaments = [Tournament]()
    private var filteredTournaments = [Tournament]()
    private var selectedTournamentIndex = 0
    private var hasNewSelections = false
    private let concurrentQueue = DispatchQueue.init(label: "TournamentModel", qos: .userInitiated, attributes: [.concurrent])
    
    init() {
        let persistence = Selection_FlatFilePersistence(.json)
        selectionPersistence = persistence
        selections = persistence.selections
        tournamentPersistence = Tournament_FlatFilePersistence(.json)
        
        SpinnerView.sharedInstance.show()
        concurrentQueue.async {[unowned self] in
            self.apiConnect.getTournaments (completion: { (tournaments) in
                self.tournaments = tournaments
                self.delegate?.dataUpdated()
                print("closure stuff \(tournaments)")
                
            })
            print("model print \(self.tournaments)")
            //self.tournamentPersistence.tournaments
            self.sortTournaments()
            self.delegate?.dataUpdated()
            SpinnerView.sharedInstance.hide()
        }
    }
    var selectedTournament: Tournament {return delegate?.isFiltering ?? false ? filteredTournaments[selectedTournamentIndex] : tournaments[selectedTournamentIndex]}
    var numberOfRows: Int { return delegate?.isFiltering ?? false ? filteredTournaments.count : tournaments.count }
    func newSelection(at index: Int) {
        selections[index].isChecked = !selections[index].isChecked
        hasNewSelections = true
    }
    func tournamentSelected(at index: Int) {
        selectedTournamentIndex = index
    }
    func tournament(at index: Int) -> Tournament? {
        let tournamentSource = delegate?.isFiltering ?? false ? filteredTournaments : tournaments
        guard index <= tournamentSource.count - 1 else {
            return nil
        }
        return tournamentSource[index]
    }
    func moveSelection(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let selectionToMove = selections[sourceIndexPath.row]
        selections.remove(at: sourceIndexPath.row)
        selections.insert(selectionToMove, at: destinationIndexPath.row)
        hasNewSelections = true
    }
    func selectionsCompleted() {
        guard hasNewSelections else {return}
        SpinnerView.sharedInstance.show()
        concurrentQueue.async { [unowned self] in
            self.sortTournaments()
            self.delegate?.dataUpdated()
            SpinnerView.sharedInstance.hide()
            self.selectionPersistence.write(self.selections)
            self.hasNewSelections = false
        }
    }
    func clearFilteredTournaments() {
        filteredTournaments = []
        delegate?.dataUpdated()
    }
    func filterTournamentsFor(searchText: String) {
        let searchItems = searchText.lowercased().split(separator: " ").map {String($0)}
        var tournaments = self.tournaments
        for searchItem in searchItems {
            tournaments = tournaments.filter {
                let nameContainsSearchText = $0.tournamentName.lowercased().contains(searchItem)
                return nameContainsSearchText
            }
        }
        filteredTournaments = tournaments
        self.delegate?.dataUpdated()
    }
    //actual sort tournament code here
    private func sortTournaments() {
        
    }
}
