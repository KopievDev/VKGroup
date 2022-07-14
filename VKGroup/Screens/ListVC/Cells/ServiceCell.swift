//
//  ServiceCell.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

class ServiceCell: ReusableCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descLabel: UILabel!
    @IBOutlet private var imgView: UIImageView!

    override func render(data: [String: Any]) {
        titleLabel.text = data[s: .name]
        descLabel.text = data[s:. description]
        imgView.setImage(urlString: data[s: .icon_url])
    }
}
