//
//  ListPhotoViewController.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 26/12/23.
//

import Foundation
import UIKit

class ListPhotoViewController : UIViewController {
    var ListPhoto: [Photo]? = []
    let apiManager = ApiManager()
    let listTable : UITableView = {
      let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        listTable.dataSource = self
        listTable.delegate = self
        listTable.register(PhotoCellView.self, forCellReuseIdentifier: "cellList")
        getPhoto()
    }
    func getPhoto(){
        apiManager.getPhotos { [weak self]  result in
            switch result{
            case .success(let photo):
                DispatchQueue.main.async {
                    self?.ListPhoto = photo
                    self?.listTable.reloadData()
                }
            case .failure(let error):
                print("Error fetching photos: \(error)")
            }
        }
    }
    func setupUI(){
        view.addSubview(listTable)
        listTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ListPhotoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListPhoto?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as? PhotoCellView,
            let photo = ListPhoto?[indexPath.row] else {
                return UITableViewCell()
        }

        cell.namePhotoLAbel.text  = "ID \(photo.id), Sol: \(photo.sol)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
print("hola")
    }
    
}
