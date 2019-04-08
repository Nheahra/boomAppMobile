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
    
    var statesData: [String] = [String]()
    private let model = TournamentModel()
    private let connect = APIConnect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.states.delegate = self
        self.states.dataSource = self
        statesData = ["Alabama - AL","Alaska - AK","Arizona - AZ","Arkansas - AR","California - CA","Colorado - CO","Connecticut - CT","Delaware - DE","Florida - FL","Georgia - GA","Hawaii - HI","Idaho - ID","Illinois - IL","Indiana - IN","Iowa - IA","Kansas - KS","Kentucky - KY","Louisiana - LA","Maine - ME","Maryland - MD","Massachusetts - MA","Michigan - MI","Minnesota - MN","Mississippi - MS","Missouri - MO","Montana - MT","Nebraska - NE","Nevada - NV","New Hampshire - NH","New Jersey - NJ","New Mexico - NM","New York - NY","North Carolina - NC","North Dakota - ND","Ohio - OH","Oklahoma - OK","Oregon - OR","Pennsylvania - PA","Rhode Island - RI","South Carolina - SC","South Dakota - SD","Tennessee - TN","Texas - TX","Utah - UT","Vermont - VT","Virginia - VA","Washington - WA","West Virginia - WV","Wisconsin - WI","Wyoming - WY"]
    }
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
    }
    @IBAction func submitCreateTournament(_sender: UIButton) {
        var tournament = Tournament.init(
            id: 839203,
            tournamentName: tournamentName.text ?? "",
            locationName: "",
            address: tournamentAddress.text ?? "",
            city: tournamentCity.text ?? "",
            state: statesData[states.selectedRow(inComponent: 0)],
            startDate: tournamentStart.date,
            rainDate: rainDate.date)
    }
    connect.createTournament(tournament: tournament)
}

extension CreateTournamentViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statesData[row]
    }
}

extension CreateTournamentViewController: UIPickerViewDelegate {

}
