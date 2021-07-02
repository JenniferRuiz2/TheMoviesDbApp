//
//  WelcomeViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 27/06/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    
   
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var CollectionViewOn: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var diapositivas: [OnboardingSlide] = []
    
    
    var paginaActual = 0 {
        didSet {
            pageControl.currentPage = paginaActual
            if paginaActual == diapositivas.count - 1 {
                btnNext.setTitle("Empezar", for: .normal)
            } else {
                btnNext.setTitle("Siguiente", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionViewOn.delegate = self
        CollectionViewOn.dataSource = self
        
        diapositivas = [
            OnboardingSlide(titulo: "Hola, y bienvenido a la app oficial de las reseñas y criticas de las peliculas del momento", descripcion: "En esta applicación podras encontrar las peliculas más actuales y más reconocidas del momento", imagen: #imageLiteral(resourceName: "movie")),
            OnboardingSlide(titulo: "Chatea con las personas y compartan sus opiniones", descripcion: "Tendras acceso a un chat para compartir las películas que más te gustan con tus amigos", imagen: #imageLiteral(resourceName: "chat")),
            OnboardingSlide(titulo: "Agrega tu ubicación", descripcion: "Comparte tu ubicación para que puedas encontrar nuevos amigos con tus mismos gustos en las películas", imagen: #imageLiteral(resourceName: "ubicacion"))
        ]
       
    }
    
    
    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        if paginaActual == diapositivas.count - 1{
            let controlador = storyboard?.instantiateViewController(identifier: "FirstVC") as! UIViewController
            controlador.modalPresentationStyle = .fullScreen
            controlador.modalTransitionStyle = .crossDissolve
            
            present(controlador, animated: true, completion: nil)
        }else{
            paginaActual += 1
            let indexPath = IndexPath(item: paginaActual, section: 0)
            CollectionViewOn.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diapositivas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = CollectionViewOn.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        celda.configurar(diapositiva: diapositivas[indexPath.row])
        return celda

    }
    
    
}


extension WelcomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CollectionViewOn.frame.width, height: CollectionViewOn.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ancho = scrollView.frame.width
        paginaActual = Int(scrollView.contentOffset.x/ancho)
        
    }
}
