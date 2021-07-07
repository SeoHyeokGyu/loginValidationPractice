//
//  Coordinator.swift
//  loginValidationPractice
//
//  Created by 서혁규 on 2021/07/07.
//

import UIKit

class Coordinator {
    let window:UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()
    }
}
