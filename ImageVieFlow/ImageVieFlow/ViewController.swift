//
//  ViewController.swift
//  ImageVieFlow
//
//  Created by Abdiel Molina on 28/10/21.
//

import UIKit


    
class ViewController: UIViewController {
    
    //Paso 1 declarar mi objeto visual
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
    }
    
    @IBOutlet weak var imageflower: UIImageView!
    
    override func viewDidLoad() {
       
        configureUI()
    
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/authexample-4b515.appspot.com/o/tulipan.jpg?alt=media&token=bba44761-505c-4c29-bd7c-b478708df8f7")!
        
        //Estrategia 1 (petición sincrona)
        /*desventajas
         Se bloquea el hilo principl de la aplicación
         la pantalla del esta bloqueada
         no tenemos control de la descarga
         */
        
        //if let dataImage = try? Data(contentsOf: url) {
          //  imageflower.image = UIImage(data: dataImage)
        //}
        
        //estretegia 2
        //create data task
        
        let dataTask = URLSession.shared.dataTask(with: url) { dataServer, response, Error in
        
            if let Data = dataServer {
                
                DispatchQueue.main.async {
                self.imageflower.image = UIImage(data: Data)
            }
                
                
                
        }
        }
//start data task
        dataTask.resume()

    }
    
    func configureUI() {
        //paso 2 agregar componente visual a la vista principal
        view.addSubview(activityIndicator)
        
        //paso 3 declarar constraints
        let constraintsIndicator: [NSLayoutConstraint] = [
            activityIndicator.centerXAnchor.constraint(equalTo: self.imageflower.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageflower.centerYAnchor)
        
        ]
        
        NSLayoutConstraint.activate(constraintsIndicator)
        
        view.addSubview(myTextField)
        
        let constraintMyTextField: [NSLayoutConstraint] = [
            myTextField.topAnchor.constraint(equalTo: self.imageflower.bottomAnchor, constant: 50),
            myTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTextField.widthAnchor.constraint(equalToConstant: 200),
            myTextField.heightAnchor.constraint(equalToConstant: 50)
            ]
        
        NSLayoutConstraint.activate(constraintsIndicator)
    }
}

