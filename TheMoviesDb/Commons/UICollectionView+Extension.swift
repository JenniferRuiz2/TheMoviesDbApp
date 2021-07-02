//
//  UICollectionView+Extension.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func register<T>(_ cellClass: T.Type, _ collection: UICollectionView) where T: UICollectionViewCell {
        collection.register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }
    
    func registerHeader<T>(_ cellClass: T.Type, _ collection: UICollectionView) where T: UICollectionReusableView {
        collection.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "\(cellClass)")
    }
    
}
