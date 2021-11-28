//
//  MyGroupsTableViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController {
    
    private var networkRequester = Network()
//    private var groups: [VKGroup] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    var groups: Results<RealmGroup>?
    var groupsNotification: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMyGroups()
        
        tableView.register(
            UINib(
                nibName: "MyGroupsViewCell",
                bundle: nil),
            forCellReuseIdentifier: "myGroupCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "myGroupCell",
            for: indexPath) as? MyGroupsViewCell
        else { return UITableViewCell() }
        guard let group = groups?[indexPath.row] else { return UITableViewCell() }
        
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

    func fetchMyGroups() {
        networkRequester.sendRequest(
            endpoint: VKGroups.init(items: []),
            requestType: "groups.get") {
                [weak self] result in
//                guard let self = self else { return }
                switch result {
                case .success(let groups):
                    let realmGroups = groups.items.map { RealmGroup($0) }
                    DispatchQueue.main.async {
                        try? RealmService.save(items: realmGroups)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        self.groups = try? RealmService.load(typeOf: RealmGroup.self)
        self.groupsNotification = self.groups?.observe {
            [weak self] _ in self?.tableView.reloadData()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        groupsNotification?.invalidate()
    }
}
