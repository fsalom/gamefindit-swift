//
//  Window.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

func topMostController() -> UIViewController? {
    guard let window = keyWindow, let rootViewController = window.rootViewController else {
        return nil
    }

    var topController = rootViewController

    while let newTopController = topController.presentedViewController {
        topController = newTopController
    }

    return topController
}

let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.height ?? 0
let safeAreaWidth = keyWindow?.safeAreaLayoutGuide.layoutFrame.width ?? 0
let screenHeight = keyWindow?.frame.height ?? 0
let screenWidth = keyWindow?.frame.width ?? 0

func changeRoot(to viewController: UIViewController) {
    UIView.transition(with: keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
        keyWindow?.rootViewController = viewController
    })
}

func showAlert(title: String, message: String = "", completion: (() -> Void)? = nil) {
    if topMostController() is UIAlertController { return }

    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let accept = UIAlertAction(title: "Aceptar", style: .default) { _ in
        if let completion = completion { completion() }
    }

    alert.addAction(accept)

    topMostController()?.present(viewController: alert)
}
