//
//  HolderView.swift
//  SwiftUIForm
//
//  Created by Luis on 25/4/24.
//

import SwiftUI

struct HolderView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        Group {
        if authModel.user == nil {
            SignUpView()
        } else {
            //Necesitamos añadir estas var porque nuestra app tiene más opciones que las del manual
            let settingStore = SettingStore()
            let viewModel = RestaurantViewModel(settingStore: SettingStore())
            //Y por nuestra app, necesitamos modificar la llamada al ContenView
            ContentView(viewModel: viewModel).environmentObject(settingStore)
            }
        }
        .onAppear {
                 authModel.listenToAuthState()
        }
    }
}

struct HolderView_Previews: PreviewProvider {
    static var previews: some View {
        HolderView()
    }
}
