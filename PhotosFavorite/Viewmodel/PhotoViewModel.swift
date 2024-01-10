//
//  PhotoViewModel.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 02/01/24.
//

import Foundation

class PhotoViewModel {
    var refreshData = { () -> () in }
    
    var listPhoto: [Photo] = [] {
        didSet {
            refreshData()
        }
    }
    private let servicePhoto: ServicePhoto?
    
    init(servicePhoto: ServicePhoto?) {
        self.servicePhoto = servicePhoto
    }
    
    func getPhoto(completion: @escaping(Result<[Photo], Error>)-> Void) {
        servicePhoto?.getPhotos { [weak self]  result in
            switch result{
            case .success(let photo):
                DispatchQueue.main.async {
                    self?.listPhoto = photo
                    completion(.success(photo))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
