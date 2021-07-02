//
//  DetailSeriesCastCollectionCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit

class DetailSeriesCastCollectionCell: BaseCollectionCell {
    
    var arrCasts = [MovieCast]()
    
    override func sizeCollection() -> CGSize {
        return size_detail_series
    }
    
    override func registerCell() {
        self.collectionView.register(DetailSeriesCastViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension DetailSeriesCastCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailSeriesCastViewCell.self), for: indexPath) as? DetailSeriesCastViewCell else {
            fatalError()
        }
        cell.configure(viewModel: self.arrCasts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailSeriesCastCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: marginCell, bottom: 0, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
