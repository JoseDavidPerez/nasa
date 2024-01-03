//
//  ExtensionUIImageView.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 03/01/24.
//

import Foundation
import  UIKit

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
