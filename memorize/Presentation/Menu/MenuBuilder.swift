//
//  MenuBuilder.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import UIKit

final class MenuBuilder {
    func build() -> MenuController {
        let viewController = UIViewController.instantiate(viewController: MenuController.self)
        let viewModel = MenuViewModel()
        viewController.viewModel = viewModel

        return viewController
    }
}
