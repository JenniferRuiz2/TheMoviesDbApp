//
//  ChatsViewController.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 21/06/21.
//

import UIKit
import Firebase

class ChatsViewController: UIViewController {

    @IBOutlet weak var tableChats: UITableView!
    @IBOutlet weak var writeMessageTF: UITextField!
    
    var messages = [Message]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MessageTableViewCell", bundle: nil)
        tableChats.register(nib, forCellReuseIdentifier: "cellMessage")
        loadMessages()
        
        if let email = Auth.auth().currentUser?.email {
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "email")
            defaults.synchronize()
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadMessages(){
        db.collection("messages").order(by: "date").addSnapshotListener(){ (querySnapshot, err) in
            self.messages = []
            
            if let e = err {
                print("Error al obtener los mensajes: \(e.localizedDescription)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for document in snapshotDocuments{
                        let data = document.data()
                        print(data)
                        guard let id = data["id"] as? String else { return }
                        guard let sender = data["sender"] as? String else { return }
                        guard let message = data["message"] as? String else { return  }
                        guard let url = data["url"] as? String else { return  }
                        
                        let messages = Message(id: id, sender: sender, message: message, url: url)
                        
                        self.messages.append(messages)
                        DispatchQueue.main.async {
                            self.tableChats.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func sendMessageBtn(_ sender: UIButton) {
        if writeMessageTF.text == ""{
            let alert = UIAlertController(title: "Error", message: "No puedes enviar mensajes vacios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }else {
            guard let email = Auth.auth().currentUser?.email else { return }
            db.collection("users").document(email).getDocument { (documentSnapshot, err) in
                if let document = documentSnapshot, err == nil{
                    if let user = document.get("userName"){
                        if let image = document.get("url"){
                            if let message = self.writeMessageTF.text{
                                self.db.collection("messages").addDocument(data: ["id": email, "sender": user, "message": message, "url": image, "date": Date().timeIntervalSince1970 ]) { (error) in
                                    if let e = error{
                                        print("Error al guardar en FS \(e.localizedDescription)")
                                    } else {
                                        print("Se guardo en FS")
                                        self.writeMessageTF.text = ""
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableChats.dequeueReusableCell(withIdentifier: "cellMessage", for: indexPath) as! MessageTableViewCell
        cell.nameTF.text = messages[indexPath.row].sender
        cell.messageTF.text = messages[indexPath.row].message
        
        if let email = messages[indexPath.row].id as? String{
            let query = Firestore.firestore().collection("messages").whereField("id", isEqualTo: email)
            query.getDocuments{ (snapshot, error) in
                if let err = error {
                    print("Error al descragar imagen: \(err.localizedDescription)")
                }
                guard let snapshot = snapshot,
                      let data = snapshot.documents.first?.data(),
                      let urlString = data["url"] as? String,
                      let url = URL(string: urlString)
                else { return }
                
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url){
                        if let image = UIImage(data: data){
                            DispatchQueue.main.async {
                                cell.imageProfile.image = image
                            }
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
