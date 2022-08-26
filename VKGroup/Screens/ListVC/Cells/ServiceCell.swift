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

final class CollectionCell: ReusableCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    private var items: [[String:Any]] = []
    
    override func setUp() {
        collectionView.delegate = self
    }
    
    override func render(data: [String: Any]) {
        items = data[ad:"items"]
        CellSize(widthScale: 0.8, aspectRatio: 1).setSizeForCell(of: collectionView)
    }
    
    private var startingScrollingOffset = CGPoint.zero
}

extension CollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { items.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coll", for: indexPath)
        cell.contentView.layer.cornerRadius = 20
        return cell
    }
    
}

extension CollectionCell: UIScrollViewDelegate, UICollectionViewDelegate {
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
    }
}

struct CellSize {
    let widthScale: CGFloat
    let aspectRatio: CGFloat
    let screenSize = UIScreen.main.bounds.size
    var cellWeight: CGFloat { floor(screenSize.width * widthScale) }
    var cellHeight: CGFloat { floor(cellWeight * aspectRatio) }
    var insetX: CGFloat { (screenSize.width - cellWeight) / 2.0 }
    var insetY: CGFloat { (screenSize.height - cellWeight) / 2.0 }
    
    func setSizeForCell(of collectionView: UICollectionView?) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = screenSize.width - cellWeight
        flowLayout.itemSize = CGSize(width: cellWeight, height: cellHeight)
        collectionView?.collectionViewLayout = flowLayout
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.constraints.first { $0.identifier == "height" }?.constant = cellHeight
        collectionView?.reloadData()
    }
}
