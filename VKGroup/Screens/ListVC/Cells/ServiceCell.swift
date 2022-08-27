//
//  ServiceCell.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

final class ServiceCell: ReusableCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descLabel: UILabel!
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet private var button: UIButton!

    override func render(data: [String: Any]) {
        titleLabel.text = data[s: .name]
        descLabel.text = data[s:. description]
        imgView.setImage(urlString: data[s: .icon_url])
        button.accessibilityLabel = data[s: .link]
    }
}

class TitleCell: ReusableCell {
    @IBOutlet var titleLabel: UILabel!
    
    override func render(data: [String: Any]) {
        titleLabel.text = data[s: .name]
    }
}


class EnumeratedCell: TitleCell {
    @IBOutlet private var numberLabel: UILabel!
    
    override func setUp() {
        numberLabel.layer.cornerRadius = 16
        numberLabel.clipsToBounds = true
    }
    override func render(data: [String: Any]) {
        titleLabel.text = data[s: .name]
        numberLabel.text = data[s: "number"]
    }
}


class ButtonCell: ReusableCell {
    @IBOutlet private var button: UIButton!
    
    override func setUp() {
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
    }
    
    override func render(data: [String: Any]) {
        button.setTitle(data[s: .name], for: .normal)
        guard let selector = data["selector"] as? Selector else { return }
        button.addTarget(nil, action: selector, for: .touchUpInside)
    }
}

class NavCell: TitleCell {
    @IBOutlet private var leftButton: UIButton!
    
    override func render(data: [String: Any]) {
        titleLabel.text = data[s: .name]
    }
}
