//
//  ViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 04/11/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let client = PersistenceClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if client.isOnboardingViewed() {
            performSegue(withIdentifier: "goToLoginNotAnimated", sender: nil)
        }
        
    }
    
    @IBAction func goToLogin(_ sender: Any) {
                
        client.onboardingViewed(viewwed: true)
        performSegue(withIdentifier: "goToLoginAnimated", sender: nil)
    
    }
    
}
//MARK: UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageNumber)
        
    }
    
}


