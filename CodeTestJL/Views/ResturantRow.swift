//
//  ResturantRow.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-06.
//

import SwiftUI

struct ResturantRow: View {
    
    let resturant: Restaurant
    
    @State var rowHeight = 105.0
    @State var rowPadding = 40.0
    
    @State var showingDetail = false
    
    var body: some View {
            VStack{
                ZStack {
                    
                    AsyncImage(url: URL(string: resturant.imageURL))
                        .cornerRadius(20)
                        .onTapGesture {
                            print("Showing detail")
                            self.showingDetail.toggle()
                            if showingDetail {
                                rowHeight = 150
                            }
                            else {
                                rowHeight = 105

                            }                            
                        }
                    
                    VStack {
                        HStack {
                            Button {
                                print("Showing detail")
                                self.showingDetail.toggle()
                            } label: {
                                if showingDetail {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "chevron.up")
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.leading, 30)
                            .padding(.bottom, 90)
                            
                            Spacer()
                        }
                        
                    }
                }
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(resturant.name)
                            .font(.system(size: 23, weight: .semibold, design: .default))
                            .fontWeight(.semibold)
                        .padding(.top, 15)
                        Spacer()
                        Text("⭐️\(resturant.rating, specifier: "%.1f")")
                            .padding(.trailing)
                    }.padding(.leading)
                   
                    HStack {
                        ForEach(resturant.filterIDS, id: \.self) { filter in
                            ForEach(ResturantViewModel().getFilters(), id: \.self) { vmFilter in
                                if filter == vmFilter.id {
                                    Text("\(vmFilter.name) •")
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                            }
                        }
                    
                    }.padding(.leading)
                    .padding(.bottom, 2)
                    .onTapGesture {
                        showingDetail.toggle()
                        if showingDetail {
                            rowHeight = 150
                        }
                        else {
                            rowHeight = 105

                        }  
                    }

                    if showingDetail == false {
                        HStack {
                            Text("🕐 \(resturant.deliveryTimeMinutes) min")
                        }.padding(.leading)
                        
                       
                    }
                    else {
                        if resturant.isOpen {
                            Text("Open")
                                .font(.title)
                                .padding(.top)
                                .padding(.leading)
                                .foregroundColor(.green)
                        } else {
                            Text("Closed")
                                .font(.title)
                                .padding(.top)
                                .padding(.leading)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()

                }
                .frame(width: UIScreen.main.bounds.size.width - 30, height: rowHeight)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, -50)
                .shadow(color: .gray, radius: 5, x: 10, y: 15)
                
            }
            
        

    }
}

struct ResturantRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello world")
    }
}
