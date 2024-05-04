//
//  Application.swift
//  SwiftUIForm
//
//  Created by Luis on 4/5/24.
//

import Foundation
import SwiftUI
import UIKit

//Esta clase permite generar un vista

final class Application_Utility{
    static var rootViewController:UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
