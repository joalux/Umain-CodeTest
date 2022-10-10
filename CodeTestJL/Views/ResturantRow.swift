//
//  ResturantRow.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-06.
//

import SwiftUI

struct ResturantRow: View {
    
    let resturant: Restaurant
    
    @State var rowHeight = 90.0
    @State var rowPadding = 40.0
    
    @State var showingDetail = false
    
    var body: some View {
            VStack{
                ZStack {
                    
                    AsyncImage(url: URL(string: resturant.imageURL))
                        .onTapGesture {
                            print("Showing detail")
                            self.showingDetail.toggle()
                            if showingDetail {
                                rowHeight = 150
                            }
                            else {
                                rowHeight = 90

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
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        .padding(.top, 15)
                        Spacer()
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
                        .padding(.bottom)
                    
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
