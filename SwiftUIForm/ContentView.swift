//
//  ContentView.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: RestaurantViewModel
    @ObservedObject private var authModel = AuthViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.restaurantDB.sorted(by: viewModel.settingStore.displayOrder.predicate())) { restaurant in
                    if viewModel.shouldShowItem(restaurant: restaurant) {
                        
                        BasicImageRow(restaurant: restaurant)
                            .contextMenu {
                                Button(action: {
                                    // mark the selected restaurant as check-in
                                    self.viewModel.checkIn(restaurant: restaurant)
                                    viewModel.fetchRestaurant()
                                }) {
                                    HStack {
                                        Text("Check-in")
                                        Image(systemName: "checkmark.seal.fill")
                                    }
                                }
                                
                                Button(action: {
                                    // delete the selected restaurant
                                    self.viewModel.delete(restaurant: restaurant)
                                    viewModel.fetchRestaurant()
                                }) {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                                
                                Button(action: {
                                    // mark the selected restaurant as favorite
                                    self.viewModel.setFavorite(restaurant: restaurant)
                                    viewModel.fetchRestaurant()
                                    
                                }) {
                                    HStack {
                                        Text("Favorite")
                                        Image(systemName: "star")
                                    }
                                }
                            }
                            .onTapGesture {
                                self.viewModel.selectedRestaurant = restaurant
                            }
                    }
                }
                .onDelete { (indexSet) in
                    self.viewModel.restaurants.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing:
                                    HStack{
                
                Button(action: {
                    self.viewModel.showSettings = true
                }, label: {
                    Image(systemName: "gear").font(.title)
                        .foregroundColor(.black)
                })
                Button(action:{
                    authModel.signOut()
                }){
                    (Image(systemName: "xbox.logo").font(.title)
                        .foregroundColor(.black))
                }
            }
            )
            .sheet(isPresented: $viewModel.showSettings) {
                SettingView().environmentObject(self.viewModel.settingStore)
            }
            
        }.onAppear{viewModel.fetchRestaurant()}
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RestaurantViewModel(settingStore: SettingStore()))
    }
}
