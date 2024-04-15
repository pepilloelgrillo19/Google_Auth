//
//  SettingView.swift
//  SwiftUIForm
//
//  Created by Luis on 12/4/24.
//

import SwiftUI

struct SettingView: View {
    //Para llenar el Picker
    private var displayOrders = [ "Alphabetical", "Show Favorite First", "Show Check-in First"]
    //Para ver que ha seleccionado el usuario
    @State private var selectedOrder = 0
    //Para almacenar el estado del "interruptor"
    @State private var showCheckInOnly = false
    //Para establecer el valor el rango de precios que elijamos
    @State private var maxPriceLevel = 5
    //Variable necesaria para añadir un botón de cierre
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("SORT PREFERENCE")) {
                        //Para ejecutar el menú desplegable
                        Picker(selection: $selectedOrder, label: Text("Display order")) {
                            ForEach(0 ..< displayOrders.count, id: \.self) {
                                Text(self.displayOrders[$0])
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
                            self.presentationMode.wrappedValue.dismiss()
                            //Hay que definir una acción para guardar los valores, que estará relacionada con
                            //almacenar el valor de las variables que se modifican con los botones,
                            //pero de momento no sé como hacerlo persistente.
                            //por eso voy a hacerles print, para que veamos que el botón interacciona con ellas,
                            //y un Switch case para que el texto sea más legible que el valor de la variable
                            print("El orden seleccionado es: \(selectedOrder)")
                            print("Ver los restaurante visitados: \(showCheckInOnly)")
                            print("El rango de precios seleccionado es: \(maxPriceLevel)")
                            switch selectedOrder {
                            case 0:
                                print("El orden seleccionado es: Alfabético")
                            case 1:
                                print("El orden seleccionado es: Primero favoritos")
                            case 2:
                                print("El orden seleccionado es: Primero visitados")
                            default:
                                print("No se va a usar nunca")
                            }
                            switch showCheckInOnly {
                            case false:
                                print("Muestra todos los restaurantes")
                            case true:
                                print("Muestra solo los restaurantes visitados")

                            }
                            switch maxPriceLevel {
                            case 1:
                                print("El rango de precios es MUY BARATO")
                            case 2:
                                print("El rango de precios es BARATO")
                            case 3:
                                print("El rango de precios es NORMAL")
                            case 4:
                                print("El rango de precios es CARO")
                            case 5:
                                print("El rango de precios es MUY CARO")
                            default:
                                print("No se va a usar nunca")
                            }
        
                        })
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
