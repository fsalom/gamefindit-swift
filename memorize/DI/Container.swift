//
//  Container.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import Foundation
import UIKit

class Container {
    static let shared = Container()
    var window: UIWindow?
}

extension Container {
    func gameBuilder() -> GameBuilder {
        return GameBuilder()
    }

    func menuBuilder() -> MenuBuilder {
        return MenuBuilder()
    }
}
