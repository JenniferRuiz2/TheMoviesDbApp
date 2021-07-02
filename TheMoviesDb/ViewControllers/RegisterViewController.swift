//
//  RegisterViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit
import Firebase
import FirebaseStorage

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let db = Firestore.firestore()
    var uidImagen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func alertaMensaje(msj:String){
        let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text, let name = nameTF.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            
                //MARK:Imagen
                let imageTmp = UIImageView(image:  #imageLiteral(resourceName: "avatar"))
                
                //Convertir la imagen en datos()
                guard let image = imageTmp.image, let datosImagen = image.jpegData(compressionQuality: 1.0) else {
                    print("Error")
                    return
                }
                //asignar un id unico para esos datos
                let imageNombre = UUID().uuidString
                self.uidImagen = imageNombre
                
                let imageReferencia = Storage.storage()
                    .reference()
                    .child("users")
                    .child(imageNombre)
                
                //Poner los datos en Firestore
                imageReferencia.putData(datosImagen, metadata: nil) { (metaData, error) in
                    if let err = error {
                        print("Error al subir imagen \(err.localizedDescription)")
                    }
                    
                    imageReferencia.downloadURL { (url, error) in
                        if let err = error {
                            print("Error al subir imagen \(err.localizedDescription)")
                            return
                        }
                        
                        guard let url = url else {
                            print("Error al crear url de la imagen")
                            return
                        }
                        
                        let dataReferencia = Firestore.firestore().collection("users").document(email)
                        let documentoID = dataReferencia.documentID
                        
                        let urlString = url.absoluteString
                        
                        let datosEnviar = ["id": documentoID,
                                           "userName": name,
                                           "url": urlString]
                        
                        dataReferencia.setData(datosEnviar) { (error) in
                            if let err = error {
                                print("Error al mandar datos de imagen \(err.localizedDescription)")
                                return
                            } else {
                                //Se subio a Firestore
                                print("Se guardó correctamente en FS")
                                //Ahora que harás cuando se guarde ?
                            }
                            
                            
                        }
                    }
                }
                //MARK: if de errores
                if let e = error {
                    print("Error al crear usuario \(e.localizedDescription)")
                    if e.localizedDescription == "The email address is already in use by another account." {
                        self.alertaMensaje(msj: "Ese correo ya esta en uso, favor de crear otro")
                    } else if e.localizedDescription == "The email address is badly formatted." {
                        self.alertaMensaje(msj: "Verifica el formato de tu email")
                    } else if e.localizedDescription == "The password must be 6 characters long or more." {
                        self.alertaMensaje(msj: "Tu contraseña debe de ser de 6 caracteres o mas")
                    }
                    
                } else {
                    //Navegar al siguiente VC
                    self.performSegue(withIdentifier: "registroInicio", sender: self)
                }
                
            }
        }
    }
    
}
