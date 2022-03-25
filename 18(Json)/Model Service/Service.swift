//
//  Service.swift
//  18(Json)
//
//  Created by Mark Goncharov on 23.03.2022.
//

import Foundation


class Service {
    
    func request(urlString: String, completion: @escaping (Result<SearchRespone, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data,
                                                response,
                                                error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let movies = try JSONDecoder().decode(SearchRespone.self,
                                                          from: data)
                    completion(.success(movies))
                } catch let jsonError {
                    completion(.failure(jsonError))
                    print("Error", jsonError)
                }
            }
        } .resume()
    }
}
