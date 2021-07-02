//
//  HomeCategoryViewCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit
import SnapKit

class HomeCategoryViewCell: UICollectionViewCell {
    
    public lazy var imgBg: UIImageView = {
        let img = UIImageView()
        self.addSubview(img)
        return img
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 16)
        labelTitle.textColor = .white
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 1
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.imgBg.normalShadow()
    }
    
    func configure(viewModel: GenreViewViewModel) {
        self.title.text = viewModel.title
    }
    
}
