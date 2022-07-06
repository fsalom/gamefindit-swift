//
//  GameBuilder.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import UIKit

final class GameBuilder {
    func build() -> GameController {
        let viewController = UIViewController.instantiate(viewController: GameController.self)
        let viewModel = GameViewModel()
        viewController.viewModel = viewModel

        return viewController
    }
}
