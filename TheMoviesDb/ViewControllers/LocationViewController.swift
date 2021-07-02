//
//  LocationViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit
import MapKit
import Firebase

class LocationViewController: UIViewController{

    @IBOutlet weak var searchSB: UISearchBar!
    @IBOutlet weak var mapMK: MKMapView!
    
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    var search: CLLocation?

    let db = Firestore.firestore()
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchSB.delegate = self
        mapMK.delegate = self
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        //mejorar la presiocion de la ubicacióniu
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //Monitorear en todo momento la ubicacion
        manager.startUpdatingLocation()
    }

    @IBAction func LocationBtn(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Ubicacion", message: "Las coordenadas son: \(latitude  ?? 0) \(longitude ?? 0)", preferredStyle: .alert)
        
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alerta.addAction(accionAceptar)
        present(alerta, animated: true)
        let localizacion = CLLocationCoordinate2DMake(latitude!, longitude!)
        
        let destino = CLLocation(latitude: latitude!, longitude: longitude!)
        
        search = destino
        
        let spanMapa = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: localizacion, span: spanMapa)
        
        mapMK.setRegion(region, animated: true)
        mapMK.showsUserLocation  = true
    }
    
    
    @IBAction func addLocationBtn(_ sender: Any) {
        print("Coordenadas guardadas \(search)")
        
        let lat = search?.coordinate.latitude
        let lon = search?.coordinate.longitude
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        db.collection("locations").document(email).setData(["latitud": lat, "longitud": lon])
        
        navigationController?.popViewController(animated: true)
    }
}

extension LocationViewController: CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let ubicacion = locations.first else {
            return
        }
        latitude = ubicacion.coordinate.latitude
        longitude = ubicacion.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicacion \(error.localizedDescription)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //metodo para ocultar el teclado
        searchSB.resignFirstResponder()
        let geocoder = CLGeocoder()
       
        if let direccion = searchSB.text{
            geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error: Error?) in
                
                guard let destinoRuta = places?.first?.location else {
                    return
                }
                
                if error == nil {
                    //Buscar la direccion en el mapa
                    let lugar = places?.first
                    let anotacion = MKPointAnnotation()
                    anotacion.coordinate = (lugar?.location?.coordinate)!
                    anotacion.title = direccion
                    
                    print("Anotacion \(anotacion)")
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                    
                    self.mapMK.setRegion(region, animated: true)
                    self.mapMK.addAnnotation(anotacion)
                    self.mapMK.selectAnnotation(anotacion, animated: true)
                    
                    let long = destinoRuta.coordinate.longitude
                    let lat = destinoRuta.coordinate.latitude
                    
                    let destinoBusqueda = CLLocation(latitude: lat, longitude: long)
                    
                    self.search = destinoBusqueda
                    
                    print("Busqueda: \(self.search)")
                    
                    print("Coordenadas encontradas: \(self.search)")
                }else{
                    print("Error al encontrar la direccion \(error?.localizedDescription)")
                }
                
            }
        }
    }
    
}
