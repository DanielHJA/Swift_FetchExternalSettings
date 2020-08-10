//
//  FilterResultsControllerTableViewController.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-03.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol FilterResultsTableViewControllerDelegate: class {
    func didSelectAddress(_ address: String)
}

class FilterResultsTableViewController: UITableViewController, UISearchResultsUpdating {

    weak var delegate: FilterResultsTableViewControllerDelegate?
    
    private var adresses: [String] = {
        return [
            "Oppeby gård 3, Nyköping",
            "Axgränd 3, Linköping",
            "Storgatan 5, Stockholm",
            "Tornby Park 5, Linköping",
            "Någonstansgatan 4, Solna",
            "Stallvägen 15, Växjö"
        ]
    }()
    
    private var filteredAdresses: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        filteredAdresses = adresses
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAdresses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = filteredAdresses[indexPath.row]
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = filteredAdresses[indexPath.row]
        delegate?.didSelectAddress(item)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredAdresses = adresses.filter { return $0.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
}
