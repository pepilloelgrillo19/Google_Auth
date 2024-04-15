//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Luis on 12/4/24.
//

import SwiftUI

struct SettingView: View {
    
    //Para llenar el Picker a partir del enum
    @State private var selectedOrder = DisplayOrderType.alphabetical
    
    /*
     Ahora ya no es necesario el array con los valore, puesto que lo podremos llenar directamente con el enum
    //Para llenar el Picker
    private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-in First"]
    //Para ver que ha seleccionado el usuario
    @State private var selectedOrder = 0
     */
    //Para almacenar el estado del "interruptor"
    @State private var showCheckInOnly = false
    //Para establecer el valor el rango de precios que elijamos
    @State private var maxPriceLevel = 5
    //Variable necesaria para añadir un botón de cierre
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var settingStore: SettingStore
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("SORT PREFERENCE")) {
                        //Para ejecutar el menú desplegable
                        Picker(selection: $selectedOrder, label: Text("Display order")) {
                            ForEach(DisplayOrderType.allCases, id: \.self) {
                                orderType in
                                Text(orderType.text)
                            }
                        }
                    }
                    Section(header: Text("FILTER PREFERENCE")) {
                        //Es el "interruptor" para elegir opciones que filtraran el listado
                        Toggle(isOn: $showCheckInOnly) {
                            Text("Show Check-in Only")
                        }
                        //Un Stepper es un elemento que permite incrementar o reducir el valor de una variable
                        //Automáticamente no crea 2 botones, y muestra la descripción que le incluyamos en un Text
                        Stepper(onIncrement: {
                            //onIncrement es la función que nos permite elevar el contador.
                            //onDecrement es la función que nos permite reducir el contador.
                            //Como queremos que el valor esté entre 1 y 5, se añade un if para que
                            //los valores que estén por encima de 5 tendrán como valor 5,
                            //y los valores que estén por debajo de 1, serán como mínimo 1
                            self.maxPriceLevel += 1
                            if self.maxPriceLevel > 5 {
                                self.maxPriceLevel = 5
                            }
                        }, onDecrement: {
                            self.maxPriceLevel -= 1
                            if self.maxPriceLevel < 1 {
                                self.maxPriceLevel = 1
                            } })
                        {
                            //Para indicar la elección, se introduce en el texto a mostrar
                            //el comando (String(repeating:"$"), que nos mostrará tantos simbolos como
                            //el valor tenga la variable (en nuestro caso, entre 1 y 5 símbolos, por los límites
                            Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                        }
                    }
                }
                .onAppear {
                    self.selectedOrder = self.settingStore.displayOrder
                    self.showCheckInOnly = self.settingStore.showCheckInOnly
                    self.maxPriceLevel = self.settingStore.maxPriceLevel
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(
                    leading: Text("Cancelar")
                        .padding(.leading,30)
                        .padding(.top)
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                        .onTapGesture{
                            self.presentationMode.wrappedValue.dismiss()
                        },
                                    trailing: Text("Guardar & Cerrar")
                        .padding(.trailing,30)
                        .padding(.top)
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                        .onTapGesture{
                            self.settingStore.showCheckInOnly = self.showCheckInOnly
                            self.settingStore.displayOrder = self.selectedOrder
                            self.settingStore.maxPriceLevel = self.maxPriceLevel
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }
                )
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(SettingStore())
    }
}
