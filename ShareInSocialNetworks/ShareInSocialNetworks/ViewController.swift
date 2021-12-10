//
//  ViewController.swift
//  ShareInSocialNetworks
//
//  Created by Isrrael Torres Alvarado on 09/12/21.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var imageShare: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func shareInFacebook(_ sender: Any) {
        
        guard let facebookViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook),
              let message = txtMessage.text, !message.isEmpty else {  return }
        
        facebookViewController.setInitialText(message)
        facebookViewController.add(imageShare.image)
        facebookViewController.modalTransitionStyle = .coverVertical
        facebookViewController.modalPresentationStyle = .formSheet
        self.present(facebookViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareInTwitter(_ sender: Any) {
        
        guard let twitterViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter),
              let message = txtMessage.text, !message.isEmpty else { return  }
        
        twitterViewController.setInitialText(message)
        twitterViewController.add(imageShare.image)
        twitterViewController.modalTransitionStyle = .coverVertical
        twitterViewController.modalPresentationStyle = .formSheet
        self.present(twitterViewController, animated: true, completion: nil)
        
    }
    
    @objc func handleTap(_ notifation: NSNotification) {
        txtMessage.resignFirstResponder()
    }
    
}

