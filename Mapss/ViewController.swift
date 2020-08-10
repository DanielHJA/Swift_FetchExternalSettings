//
//  ViewController.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-03.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
        
    private lazy var mapView: MapView = {
        let temp = MapView(self) 
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
        return temp
    }()
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = LayoutSettings.shared.standardColor
        temp.text = "This is some text"
        temp.textAlignment = .center
        temp.font = LayoutSettings.shared.standardFont
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var searchView: UIView = {
        let temp = UIView()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.heightAnchor.constraint(lessThanOrEqualToConstant: 60.0).isActive = true
        return temp
    }()
    
    private lazy var searchController: UISearchController = {
        let filterController = FilterResultsTableViewController()
        let temp = UISearchController(searchResultsController: filterController)
        temp.delegate = self
        filterController.delegate = self
        temp.searchResultsUpdater = filterController
        temp.hidesNavigationBarDuringPresentation = false
        temp.searchBar.delegate = self
        temp.definesPresentationContext = true
        return temp
    }()
    
    private lazy var barButtonItem: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Details", style: UIBarButtonItem.Style.plain, target: self, action: #selector(getDirections))
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Alertify"
        view.backgroundColor = .white
        searchView.addSubview(searchController.searchBar)
        navigationItem.rightBarButtonItem = barButtonItem
        mapView.isHidden = false
    }
    
    @objc private func getDirections() {
        mapView.getDirections()
    }
    
}

extension ViewController: FilterResultsTableViewControllerDelegate {
    func didSelectAddress(_ address: String) {
        searchController.isActive = false
        mapView.getAddress(address)
    }
}
