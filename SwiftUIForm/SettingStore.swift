//
//  SettingStore.swift
//  SwiftUIForm
//
//  Created by Luis on 15/4/24.
//

import Foundation
import Combine

enum DisplayOrderType: Int, CaseIterable {
    case alphabetical = 0
    case favoriteFirst = 1
    case checkInFirst = 2
    //Se requiere inicializar las variables
    init(type: Int) {
        switch type {
        case 0: self = .alphabetical
        case 1: self = .favoriteFirst
        case 2: self = .checkInFirst
        default: self = .alphabetical
        }
    }
    //Esta variable permite devolver un resultado en concreto a partir de un valor del enum
    var text: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .favoriteFirst: return "Show Favorite First"
        case .checkInFirst: return "Show Check-in First"
        }
    }
    func predicate() -> ((Restaurant, Restaurant) -> Bool) {
        switch self {
        case .alphabetical: return { $0.name < $1.name }
        case .favoriteFirst: return { $0.isFavorite && !$1.isFavorite }
        case .checkInFirst: return { $0.isCheckIn && !$1.isCheckIn }
    }
    }
}

final class SettingStore: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly" : false,
            "view.preferences.displayOrder" : 0,
            "view.preferences.maxPriceLevel" : 5
            ]
        )
    }
    @Published var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferenc es.showCheckInOnly") {
        didSet {
            UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }
    @Published var displayOrder: DisplayOrderType = DisplayOrderType(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")) {
        //Comprueba si en la minibase de UserDefaults tiene algún valor, y en caso afirmativo, que
        //lo meta en la variable
        didSet {
            UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
    }
    @Published var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferenc es.maxPriceLevel") {
        didSet {UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
        }
    }
}
