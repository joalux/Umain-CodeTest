//
//  ResturantsView.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-06.
//

import SwiftUI

struct ResturantsView: View {
    
    @ObservedObject var vm = ResturantViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(vm.getFilters(), id: \.self) { filter in
                            HStack {
                                AsyncImage(url: URL(string: filter.image_url))
                                Text(filter.name)
                            }.padding()
                                .onTapGesture {
                                    print("Applying filter = \(filter.name), \(filter.id)")
                                    vm.applyFilter(newFilter: filter)
                                }
                        }
                    }
                }
                Spacer()
                   
                if vm.hasRestaurant {
                    Text("")
                        .task {
                            await vm.getIsOpen()
                        }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(vm.restaurants, id: \.self) { rest in
                            if vm.activeFilters.isEmpty {
                                ResturantRow(resturant: rest)
                                    .padding()
                                    .padding(.leading, 50)
                                    .padding(.trailing, 50)
                            }
                            else {
                                ForEach(vm.activeFilters) { filter in
                                    if rest.filterIDS.contains(filter.id) {
                                        ResturantRow(resturant: rest)
                                            .padding()
                                            .padding(.leading, 50)
                                            .padding(.trailing, 50)
                                    }
                                }
                            }
                            
                        }
                    }
                }.task {
                   await vm.fetchRestaurants()
                    
                }
                .navigationTitle(Text("U°"))
                .navigationBarTitleDisplayMode(.large)
            }
        }
        
           
        
        
    }
}

struct ResturantsView_Previews: PreviewProvider {
    static var previews: some View {
        
        ResturantsView()
    }
}
