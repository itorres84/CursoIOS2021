//
//  ViewController.swift
//  ImageViewFlow
//
//  Created by Isrrael Torres Alvarado on 28/10/21.
//

import UIKit

class ViewController: UIViewController {

    //Paso 1 Declarar mi objeto visual
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.tintColor = UIColor.black
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    lazy var myTextField: UITextFieldCustom = {
        let text = UITextFieldCustom()
        text.configure(type: .password)
        text.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    @IBOutlet weak var imageFlower: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/authexample-4b515.appspot.com/o/tulipan.jpg?alt=media&token=bba44761-505c-4c29-bd7c-b478708df8f7")!
        
        //Strategia 1 (Peticion sincrona)
        /*desventajas:
            Se bloquea el hilo principal de la apicacion
            la pantalla del esta bloqueda
            no tenemos control de la descarga
        */
        
//        if let dataImage = try? Data(contentsOf: url) {
//            imageFlower.image = UIImage(data: dataImage)
//        }
        
        // estrategia 2
        
        //create data task
        let dataTask = URLSession.shared.dataTask(with: url) { dataServer, reponse, error in
        
            if let data = dataServer {
                
                DispatchQueue.main.async {
                    self.imageFlower.image = UIImage(data: data)
                }
            
            }
        
        }
        
        //Start Data Task
        dataTask.resume()
        
    }
    
    func configureUI() {
        
        //Paso 2 agregar el componente visual a la vista principal
        view.addSubview(activityIndicator)
        
        //Paso 3 declarar constraints
        let constraintsIndicator: [NSLayoutConstraint] = [
            activityIndicator.centerXAnchor.constraint(equalTo: self.imageFlower.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageFlower.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraintsIndicator)
        
        view.addSubview(myTextField)

        let constraintsMyTextField: [NSLayoutConstraint] = [
            myTextField.topAnchor.constraint(equalTo: self.imageFlower.bottomAnchor, constant: 50),
            myTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTextField.widthAnchor.constraint(equalToConstant: 200),
            myTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraintsMyTextField)
        
    }

}

