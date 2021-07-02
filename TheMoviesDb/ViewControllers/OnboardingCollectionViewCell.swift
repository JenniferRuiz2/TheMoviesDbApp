//
//  OnboardingCollectionViewCell.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 30/06/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagenDiapositivaIV: UIImageView!
    
    @IBOutlet weak var tituloDiapositivaIV: UILabel!
    @IBOutlet weak var descipcionDiapositivasLbl: UILabel!
    
    func configurar(diapositiva: OnboardingSlide){
        imagenDiapositivaIV.image = diapositiva.imagen
        tituloDiapositivaIV.text = diapositiva.titulo
        descipcionDiapositivasLbl.text = diapositiva.descripcion
    }
    
}
