//
//  PhotoViewController.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 27/12/23.
//

import Foundation
import UIKit

class PhotoViewController : UIViewController {
    let photoView = PhotoView()
    
    override func viewDidLoad() {
        view.addSubview(photoView)
    }
    
    func setupUI(){
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
