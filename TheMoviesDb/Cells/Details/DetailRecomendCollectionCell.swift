//
//  DetailRecomendCollectionCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit

class DetailRecomendCollectionCell: BaseCollectionCell {
    
    var arr = [Movie]()
    
    override func sizeCollection() -> CGSize {
        return size_detail_recommend
    }
    
    override func registerCell() {
        self.collectionView.register(DetailRecomendViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension DetailRecomendCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailRecomendViewCell.self), for: indexPath) as? DetailRecomendViewCell else {
            fatalError()
        }
        cell.configure(viewModel: self.arr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailRecomendCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: marginCell, bottom: 0, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
