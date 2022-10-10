//
//  ResturantViewModel.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-06.
//

import Foundation
import SwiftUI

class ResturantViewModel: ObservableObject {
    
    @Published var restaurants = [Restaurant]()
    
    func fetchRestaurants() async {
        guard let url = URL(string: "https://restaurant-code-test.herokuapp.com/restaurants") else {
            print("Invalid url!")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    print("GOT DATA == \(data)")
                    if let stringData = String(data: data, encoding: .utf8) {
                        print("String data == \(stringData)")
                        print("_____________________________")
                    }
                    do {
                        let decodedRestaurants = try JSONDecoder().decode(Restaurants.self, from: data)
                        print("DECODE SUCCESS!!!")
                        print(decodedRestaurants)
                        
                        self.restaurants = decodedRestaurants.restaurants
                        
                    } catch let error {
                        print("Error decoding", error)
                    }
                }
            }
        }
        dataTask.resume()
      
    }
        
    func getFilters() -> [Filter]{
        let TopRated = Filter(id: "5c64dea3-a4ac-4151-a2e3-42e7919a925d", name: "Top rated", image_url: "https://elgfors.se/code-test/filter/filter_top_rated.png")
        let FastFood = Filter(id: "614fd642-3fa6-4f15-8786-dd3a8358cd78", name: "Fast food", image_url: "https://elgfors.se/code-test/filter/filter_fast_food.png")
        let TakeOut = Filter(id: "c67cd8a3-f191-4083-ad28-741659f214d7", name: "Take out", image_url: "https://elgfors.se/code-test/filter/filter_take_out.png")
        let FastDelivery = Filter(id: "23a38556-779e-4a3b-a75b-fcbc7a1c7a20", name: "Fast delivery", image_url: "https://elgfors.se/code-test/filter/filter_fast_delivery.png")
        let EatIn = Filter(id: "0017e59c-4407-453f-a5be-901695708015", name: "Eat in", image_url: "https://elgfors.se/code-test/filter/filter_eat_in.png")
        
        return [TopRated, FastFood, TakeOut, FastDelivery, EatIn]
    }
}
