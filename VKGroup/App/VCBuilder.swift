//
//  VCBuilder.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

struct VCBuilder {
    
    static func getListVC(dataSource: Listable = DataSource(), network: API = APIManager()) -> UIViewController {
        guard let vc = ListVC.instantiateWithNav() as? ListVC else { return  UIViewController() }
        vc.set(dataSource: dataSource, network: network)
        return vc
    }
}
