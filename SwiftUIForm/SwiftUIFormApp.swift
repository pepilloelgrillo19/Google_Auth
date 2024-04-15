//
//  SwiftUIFormApp.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

@main
struct SwiftUIFormApp: App {
    var settingStore = SettingStore()
    var viewModel = RestaurantViewModel(settingStore: SettingStore())
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel).environmentObject(settingStore)
        }
    }
}
