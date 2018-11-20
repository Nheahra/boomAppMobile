//
//  SlideMenuController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/20/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SidePanelViewControllerDelegate?
    var menuOptions: Array<MenuOption>!
    
    enum CellIdentifiers {
        static let MenuCell = "MenuCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension SidePanelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MenuCell, for: indexPath) as! MenuCell
        cell.configureMenuOption(menuOptions[indexPath.row])
        return cell
    }
}

extension SidePanelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = menuOptions[indexPath.row]
        delegate?.didSelectOption(menuOption)
    }
}
