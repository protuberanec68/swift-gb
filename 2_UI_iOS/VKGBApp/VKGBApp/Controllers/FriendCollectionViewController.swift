//
//  FriendCollectionViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit
import Nuke
import RealmSwift

class FriendCollectionViewController: UICollectionViewController {
    
    private var networkRequester = Network()
    var currentUserID = 0
    
    var photoSet: Results<RealmPhoto>?
    var photosNotification: NotificationToken?
    
    var currentFotoIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserPhoto()
    }
    
    func fetchUserPhoto() {
        networkRequester.sendRequest(
            endpoint: VKPhotos.init(items: []),
            requestType: "photos.getAll",
            userID: currentUserID) {
                [weak self] result in
//                guard let self = self else { return }
                switch result {
                case .success(let photos):
                    let realmPhotos = photos.items.map { RealmPhoto($0) }
                    DispatchQueue.main.async {
                        try? RealmService.save(items: realmPhotos)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        self.photoSet = try? RealmService.load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(
                format: "ownerID = %i",
                self.currentUserID))
        self.photosNotification = self.photoSet?.observe {
            [weak self] _ in
            self?.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoSet?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "friendCell",
            for: indexPath) as? FriendImageCell else { return UICollectionViewCell() }
        
        if let url = URL(string: photoSet?[indexPath.row].photoURL["p"] ?? "") {
            Nuke.loadImage(
                with: url,
                into: cell.friendFotoImage)
        } else {
            cell.friendFotoImage.image = UIImage(named: "default")
        }
        cell.friendFotoImage.translatesAutoresizingMaskIntoConstraints = true
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentFotoIndex = indexPath.row
        performSegue(withIdentifier: "showFoto", sender: nil)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let fotosView = segue.destination as? FotosViewController else { return }
        fotosView.fotoSet = photoSet
        fotosView.currentFotoIndex = currentFotoIndex
        fotosView.currentUserID = currentUserID
    }

}
