//
//  AllGroupsTableViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    @IBOutlet var groupSearchBar: UISearchBar!
    private var networkRequester = Network()
    private var searchedGroups: [VKGroup] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupSearchBar.delegate = self
        
        tableView.register(
            UINib(
                nibName: "AllGroupsViewCell",
                bundle: nil),
            forCellReuseIdentifier: "customGroupCell")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customGroupCell", for: indexPath) as? AllGroupsViewCell else { return UITableViewCell() }
        let group = searchedGroups[indexPath.row]
        
        cell.configure(group: group)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(searchGroups(_:)),
            object: searchBar)
        self.perform(
            #selector(searchGroups(_:)),
            with: searchBar,
            afterDelay: 0.75)
        
    }
    
    @objc
    private func searchGroups(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        guard !query.isEmpty else {
            searchedGroups = []
            tableView.reloadData()
            return
        }
        
        networkRequester.sendRequest(
            endpoint: VKGroups.init(items: []),
            requestType: "groups.search",
            queryString: query
        ) {
                [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let groups):
                    self.searchedGroups = groups.items
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
