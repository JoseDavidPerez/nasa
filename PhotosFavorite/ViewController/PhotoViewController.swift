//
//  PhotoViewController.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 27/12/23.
//

import Foundation
import UIKit
protocol PhotoViewControllerDelegate  : AnyObject {
    func didPressAddFavorite()
}
class PhotoViewController : UIViewController {
    
    
    weak var delegate: PhotoViewControllerDelegate?
    let photoImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(photoImageView)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            photoImageView.heightAnchor.constraint(equalToConstant: 150),
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            
            
            favoriteButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
    @objc func handleAddFavorite(){
        print("Hola")
        delegate?.didPressAddFavorite()
    }
    
    func loadImageFromUrl(url: URL){
        photoImageView.loadFrom(URLAddres: url.absoluteString)
    }
}

extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                print("Error loading image from URL: \(error?.localizedDescription ?? "")")
                return
            }

            if let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = loadedImage
                }
            }
        }.resume()
    }
}
