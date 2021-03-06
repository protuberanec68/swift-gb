//
//  FriendsTableViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    private var selectedUserID = 0
    private var friendsModel = FriendsModel()
    var friends: Results<RealmUser>?
    var friendsNotification: NotificationToken?
    
    private let headerColor = UIColor(white: 1.0, alpha: 0.7)
    
    private let friendsFactory = FriendsFactory()
    private var networkRequester = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
        friendsNotificationObserve()
        setDictOfFriends()
        
        tableView.register(
            UINib(
                nibName: "FriendViewCell",
                bundle: nil),
            forCellReuseIdentifier: "customFriendCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        friendsNotification?.invalidate()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsModel.firstCharsFriendsName.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsModel.dictOfFriends[friendsModel.firstCharsFriendsName[section]]!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsModel.firstCharsFriendsName[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = headerColor
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customFriendCell", for: indexPath) as? FriendViewCell else { return UITableViewCell() }
        
        if let friend = friendsModel.dictOfFriends[friendsModel.firstCharsFriendsName[indexPath.section]]?[indexPath.row] {
            cell.configure(friend: friend)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let friend = friendsModel.dictOfFriends[friendsModel.firstCharsFriendsName[indexPath.section]]?[indexPath.row]
        else { return }
        self.selectedUserID = friend.id
        performSegue(withIdentifier: "showFriend", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func fetchFriends() {
        //MARK: Alamofire + Operations code block
        let fetchOperation = FetchJSONvkGroups()
        let parsingOperation = ParsingJSONvkFriends()
        let realmOperation = SaveRealmVKFriends()

        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10

        parsingOperation.addDependency(fetchOperation)
        realmOperation.addDependency(parsingOperation)

        operationQueue.addOperation(fetchOperation)
        operationQueue.addOperation(parsingOperation)
        operationQueue.addOperation(realmOperation)

        
        //MARK: URLSession code block
//        networkRequester.sendRequest(
//            endpoint: VKUsers.init(items: []),
//            requestType: "friends.get") {
//                [weak self] result in
////                guard let self = self else { return }
//                switch result {
//                case .success(let users):
//                    let realmFriends = users.items.map { RealmUser($0) }
//                    DispatchQueue.main.async {
//                        try? RealmService.save(items: realmFriends)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//        }
    }
    
    func friendsNotificationObserve() {
        self.friends = try? RealmService.load(typeOf: RealmUser.self)
        self.friendsNotification = self.friends?.observe {
            [weak self] _ in
            guard let self = self else {return}
            self.setDictOfFriends()
            self.tableView.reloadData()
        }
    }
    
    func setDictOfFriends() {
        guard let friends = friends else {return}
        friendsModel = friendsFactory.prepareFriendsModel(from: friends)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let friendCVC = segue.destination as? FriendCollectionViewController else { return }
        friendCVC.currentUserID = selectedUserID
    }

}
