//
//  ListPhotoViewController.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 26/12/23.
//

import Foundation
import UIKit

class ListPhotoViewController : UIViewController {
    var selectedCell: IndexPath?
    var listPhoto: [Photo]? = []
    var servicePhoto : ServicePhoto?
    var viewModel = PhotoViewModel(servicePhoto: ApiManager())
    let listTable : UITableView = {
      let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    convenience init(servicePhoto: ServicePhoto ) {
        self.init()
        self.servicePhoto = servicePhoto
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        listTable.dataSource = self
        listTable.delegate = self
        listTable.register(PhotoCellView.self, forCellReuseIdentifier: "cellList")
        viewModel.refreshData = {[weak self] in
            self?.listPhoto = self?.viewModel.listPhoto
            self?.listTable.reloadData()
        }
        getPhotoReload()
    }
    
    func getPhotoReload() {
        
        DispatchQueue.main.async {
            self.viewModel.getPhoto { [weak self]  result in
                switch result{
                case .success:
                    break
                case .failure(let error):
                    print("Error fetching photos:\(error)")
                }
            }
        }

    }
    
    func setupUI() {
        view.addSubview(listTable)
        listTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ListPhotoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhoto?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? PhotoCellView,
              let photo = listPhoto?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.namePhotoLAbel.text  = photo.camera.fullName.rawValue
        cell.favoriteImageView.image = photo.isFavorite ? UIImage(named: "heart_fill") : UIImage(named: "me-gusta")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
        let view = PhotoViewController()
        if let imageURLString = listPhoto?[indexPath.row].imgSrc,
            let imageURL = URL(string: imageURLString) {
            view.loadImageFromUrl(url: imageURL)
        }
        view.delegate = self
        navigationController?.pushViewController(view, animated: true)
        DispatchQueue.main.async {
            self.listTable.reloadRows(at: [indexPath], with: .none)
        }
    }
    
}

extension ListPhotoViewController: PhotoViewControllerDelegate {
    func didPressAddFavorite() {
        guard let selectedIndexPath = selectedCell,
              var photo = listPhoto?[selectedIndexPath.row] else {
            return
        }
        photo.isFavorite = true
        listPhoto?[selectedIndexPath.row] = photo
        DispatchQueue.main.async {
            self.listTable.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }
}
