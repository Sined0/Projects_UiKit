//
//  JsonParsModel.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//

import Foundation

struct JsonDec{
    
    func fetchRecipte(comlete: @escaping(Reciptes) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://food2fork.ca/api/recipe/search/?page=2&query=beef")!)
        request.addValue("Token 9c8b06d329136da358c2d00e76946b0111ce2c48", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(Reciptes.self, from: jsonData)
                comlete(decodedData)
            } catch {
                print("Error decoding data.")
            }
        }
        dataTask.resume()
    }
}
