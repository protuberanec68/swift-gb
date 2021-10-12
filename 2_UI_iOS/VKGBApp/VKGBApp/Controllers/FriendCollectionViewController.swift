//
//  FriendCollectionViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit
import Nuke

class FriendCollectionViewController: UICollectionViewController {
    
    private var networkRequester = Network()
    var currentUserID = 0
    var fotoSet: [VKPhoto] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
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
                guard let self = self else { return }
                switch result {
                case .success(let photos):
                    self.fotoSet = photos.items
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return fotoSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "friendCell",
            for: indexPath) as? FriendImageCell else { return UICollectionViewCell() }
        
        if let url = fotoSet[indexPath.row].sizes.first(where: { $0.sizeType == "p" })?.url {
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

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let fotosView = segue.destination as? FotosViewController else { return }
        fotosView.fotoSet = fotoSet
        fotosView.currentFotoIndex = currentFotoIndex
        fotosView.currentUserID = currentUserID
    }

}
