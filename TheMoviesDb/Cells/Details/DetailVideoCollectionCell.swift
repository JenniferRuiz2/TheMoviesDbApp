//
//  DetailVideoCollectionCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit
import AVKit
import YoutubeDirectLinkExtractor

class DetailVideoCollectionCell: BaseCollectionCell {
    
    var arrVideos = [MovieVideo]()
    private let extractor = LinkExtractor()
    
    override func sizeCollection() -> CGSize {
        return size_detail_video
    }
    
    override func registerCell() {
        self.collectionView.register(DetailVideoViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension DetailVideoCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailVideoViewCell.self), for: indexPath) as? DetailVideoViewCell else {
            fatalError()
        }
        cell.configure(viewModel: self.arrVideos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.arrVideos[indexPath.row]
        extractor.getUrlFromKey(key: movie.key) {(url) in
            let player = AVPlayer(url: url)
            let vc = AVPlayerViewController()
            vc.player = player
            UINavigationController.currentActiveNavigationController()?.topViewController?.present(vc, animated: true, completion: {
                vc.player?.play()
            })
        }
    }
    
}

extension DetailVideoCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: marginCell, bottom: 0, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
