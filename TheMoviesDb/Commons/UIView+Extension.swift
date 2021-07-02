//
//  UIView+Extension.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import Foundation
import UIKit

extension UIView {
    
    func viewShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:2)
    }
    
}
