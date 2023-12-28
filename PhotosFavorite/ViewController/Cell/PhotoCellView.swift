//
//  PhotoCellView.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 26/12/23.
//

import Foundation
import UIKit

class PhotoCellView: UITableViewCell {
    
    let namePhotoLAbel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hola esta la camara logica"
        label.numberOfLines = 0
        return label
    }()
    
    let favoriteImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "heart_empty")
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(namePhotoLAbel)
        addSubview(favoriteImageView)
        
        NSLayoutConstraint.activate([
            namePhotoLAbel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            namePhotoLAbel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            namePhotoLAbel.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor, constant: -15),
            namePhotoLAbel.widthAnchor.constraint(equalToConstant: 250),
            
            favoriteImageView.widthAnchor.constraint(equalToConstant: 40),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 40),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            favoriteImageView.centerYAnchor.constraint(equalTo: namePhotoLAbel.centerYAnchor)
            
        ])
    }
    
}
