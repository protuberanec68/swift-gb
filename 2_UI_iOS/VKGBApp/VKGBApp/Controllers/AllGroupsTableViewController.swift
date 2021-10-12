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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups(text: searchText)
    }
    
    private func searchGroups(text: String) {
        guard !text.isEmpty else {
            searchedGroups = []
            tableView.reloadData()
            return
        }
        
        networkRequester.sendRequest(
            endpoint: VKGroups.init(items: []),
            requestType: "groups.search",
            queryString: text
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
