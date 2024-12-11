//
//  HomeViewModel.swift
//  BestTrip
//
//  Created by İrem Sever on 5.12.2024.
//

import Foundation
class HomeViewModel {
    var homeModel: HomeModel?
    func fetchData(completion: @escaping () -> Void) {
        guard let path = Bundle.main.path(forResource: "home", ofType: "json") else {
            print("json not found")
            return
        }
        
        do {
            let url = URL(filePath: path)
            let jsonData = try Data(contentsOf: url)
            let decodeData = try JSONDecoder().decode(HomeModel.self, from: jsonData)
            
            DispatchQueue.main.async {
                self.homeModel = decodeData
//                print("json decode")
                completion()
            }
        } catch {
            print("error")
        }
    }
}
