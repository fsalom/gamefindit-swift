//
//  UITableViewCell.swift
//  OptimusPlan
//
//  Created by David Alhambra on 5/10/20.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func forNavigation(with title: String) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    static func simpleCell(with title: String) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = title
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none

        return cell
    }

    static func simpleCellError(with title: String) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = title
        cell.textLabel?.textColor = #colorLiteral(red: 0.9232674241, green: 0.3414149284, blue: 0.3349038959, alpha: 1)
        cell.selectionStyle = .none

        return cell
    }
}
