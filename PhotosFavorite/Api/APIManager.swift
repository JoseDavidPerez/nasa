//
//  APIManager.swift
//  PhotosFavorite
//
//  Created by Jose David Torres Perez on 26/12/23.
//

import Foundation
///
protocol ServicePhoto {
    ///- Inyecciones 
    ///- Returns:
    ///- `[Photo]` : Array of
    func getPhotos(completion: @escaping(Result<[Photo],Error>)-> Void)
}

class ApiManager : ServicePhoto {
    /// Funcion return json
    func getPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=ebIStTbKmXzyVhtxkCOpqLeNX616o5Ry9lcthjQx&sol=2000&page=1")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let photos = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    completion(.success(photos.photos))
                    //print(photos.photos)
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

class CoreDataManager : ServicePhoto{
    func getPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        var photos = Photo(id: 1, sol: 2, camera: PhotoCamera(id: 1, name: .chemcam, roverID: 1, fullName: .chemistryAndCameraComplex), imgSrc: "", earthDate: "", rover: .init(id: 1, name: .curiosity, landingDate: "", launchDate: "", status: .active, maxSol: 1, maxDate: "", totalPhotos: 1, cameras: []))
        completion(.success([photos]))
    }
}
