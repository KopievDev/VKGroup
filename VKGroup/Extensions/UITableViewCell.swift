//
//  UITableViewCell.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

protocol IdentifiableCell {
    static var reuseId: String { get }
}

extension IdentifiableCell {
    static var reuseId: String { "\(self)" }
}

extension UITableViewCell: IdentifiableCell {}
extension UICollectionViewCell: IdentifiableCell {}
