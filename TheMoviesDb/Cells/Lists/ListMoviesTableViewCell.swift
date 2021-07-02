//
//  ListMoviesTableViewCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Nuke

class ListMoviesTableViewCell: UITableViewCell {
    
    private lazy var viewBg: UIView = {
        let outerView = UIView()
        self.addSubview(outerView)
        return outerView
    }()
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = imgCornerRadius
        self.viewBg.addSubview(img)
        return img
    }()
    
    private lazy var viewTitle: UIView = {
        let outerView = UIView()
        outerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        outerView.clipsToBounds = true
        self.viewBg.addSubview(outerView)
        return outerView
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 16)
        labelTitle.textColor = .white
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 2
        self.viewTitle.addSubview(labelTitle)
        return labelTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupLayout() {
        self.viewBg.snp.makeConstraints {
            $0.top.left.equalTo(marginCell)
            $0.right.equalTo(-marginCell)
            $0.bottom.equalToSuperview()
        }
        self.viewBg.viewShadow()
        
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.viewTitle.snp.makeConstraints {
            $0.bottom.left.right.equalTo(0)
            $0.height.equalTo(50)
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func configure(viewModel: MovieViewViewModel) {
        Nuke.loadImage(
            with: viewModel.backdropURL,
            options: ImageLoadingOptions(
                transition: .fadeIn(duration: 0.33)
            ),
            into: self.imgBg
        )
        self.title.text = viewModel.title
    }
}
