//
//  ListDataSource.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

protocol Listable: UITableViewDataSource {
    var data: [[String:Any]] { set get }
    func set(data: [[String:Any]]?)
    func data(for indexPath: IndexPath) -> [String:Any]
}

extension Listable {
    func data(for indexPath: IndexPath) -> [String:Any] { data[indexPath.row] }

    func set(data: [[String:Any]]?) {
        guard let data = data else { return }
        self.data = data
    }
}

final class DataSource: NSObject, Listable {
    
    var data: [[String:Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuse = data[indexPath.row][s: .reuse]
        let data  = data[indexPath.row][d: .data]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath)
        (cell as? ReusableCell)?.render(data: data)
        return cell
    }
}

