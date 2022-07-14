//
//  ReusableCell.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

class ReusableCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func render(data: [String: Any]) {}
    func setUp() {}
    
    override func prepareForReuse() {
        subviews.forEach { view in
            (view as? UILabel)?.text = nil
            (view as? UILabel)?.attributedText = nil
            (view as? UIImageView)?.image = nil
        }
    }
}

