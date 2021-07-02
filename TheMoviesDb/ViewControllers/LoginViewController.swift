//
//  LoginViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    func alertaErrores(msj:String){
        let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    switch e.localizedDescription {
                        case "There is no user record corresponding to this identifier. The user may have been deleted.":
                            self.alertaErrores(msj: "Este usuario no está registrado o ha sido borrado")
                        case "The password is invalid or the user does not have a password.":
                            self.alertaErrores(msj: "La contrseña es incorrecta.")
                        case "The email address is badly formatted.":
                            self.alertaErrores(msj: "El formato del correo es incorrecto")
                    default:
                        self.alertaErrores(msj: "El correo y contraaseña no coinciden")
                    }
                } else {
                    //NAvegar al inicio
                    self.performSegue(withIdentifier: "loginInicio", sender: self)
                }
                
            }
        }
        
    }
    
    @IBAction func GoogleLoginBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil{
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ (result, error) in
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "loginInicio", sender: self)
                    print("Inicio sesion con Google")
                } else {
                    print("Error al iniciar sesión con google")
                }
                
            }
            
        }
    }
    
    
}
