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
    @Published var hasRestaurants = false
    
    @Published var filterIDs = [String]()
    @Published var filters = [Filter]()
    @Published var activeFilters = [Filter]()
    
    func setResturants() async {
        await fetchRestaurants()
        
        await getIsOpen()
    }
    
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
                        
                        print("___GOT RESTAURANTS = \(self.restaurants.count)")
                        for restaurant in self.restaurants {
                            for filter in restaurant.filterIDS {
                                if self.filterIDs.contains(filter) == false {
                                    print("Adding new filter \(filter)")
                                    self.filterIDs.append(filter)
                                }
                            }
                        }
                        self.hasRestaurants = true
                        print("HAS RESTAURANTS!!!")
                        for filterID in self.filterIDs {
                            print("ID = \(filterID)")
                            self.fetchFilter(id: filterID)
                        }
                        
                    } catch let error {
                        print("Error decoding", error)
                    }
                }
            }
        }
        dataTask.resume()
        
    }
    
    func getIsOpen() async{
        print("GETTING OPEN!!!!")
        for index in restaurants.indices {
            print(restaurants[index].id)
            guard let url = URL(string: "https://restaurant-code-test.herokuapp.com/open/\(restaurants[index].id)") else {
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
                        if let stringData = String(data: data, encoding: .utf8) {
                            if stringData.contains("false") {
                                self.restaurants[index].isOpen = false
                            }
                            else {
                                self.restaurants[index].isOpen = true

                            }
                        }
                    }
                }
            }
            dataTask.resume()
        }
       
    }
    
    func applyFilter(newFilter: Filter) {
        if activeFilters.contains(newFilter){
            if let filterIndex = activeFilters.firstIndex(of: newFilter) {
                print("Remving filter at \(filterIndex)")
                activeFilters.remove(at: filterIndex)
            }
        }
        else {
            print("Appying filter!!")
            activeFilters.append(newFilter)
        }
    }
    
   
    
    func fetchFilter(id: String) {
        print("Fetching filter id: \(id)")
        guard let url = URL(string: "https://restaurant-code-test.herokuapp.com/filter/\(id)") else {
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
                    print("GOT DATA == \(data.first)")
                    if let stringData = String(data: data, encoding: .utf8) {
                        print("String data == \(stringData)")
                        print("_____________________________")
                    
                    }
                    do {
                        let decodedFilter = try JSONDecoder().decode(Filter.self, from: data)
                        print("DECODE SUCCESS!!!")
                        print(decodedFilter)
                        
                        if self.filters.contains(decodedFilter) == false {
                            print("Appending filter \(decodedFilter.name)")
                            self.filters.append(decodedFilter)
                            
                        }
                        
                    } catch let error {
                        print("Error decoding", error)
                    }
                    
                }
            }
        }
        dataTask.resume()
    
    }
}
