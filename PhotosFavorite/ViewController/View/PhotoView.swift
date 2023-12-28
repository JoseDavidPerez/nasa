//
//  PhotoView.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 27/12/23.
//

import Foundation
import UIKit

class PhotoView: UIView {
    
    var navigationController : UINavigationController?
    
    let photoImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "heart_fill")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var favoriteButton : UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Favorite", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddFavorite), for: .touchUpInside)
        return button
    }()
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubview(photoImageView)
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 30),

            
            favoriteButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
    @objc func handleAddFavorite(){
        print("Hola")
    }
}
