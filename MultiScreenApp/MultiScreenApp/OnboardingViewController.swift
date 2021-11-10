//
//  ViewController.swift
//  MultiScreenApp
//
//  Created by Abdiel Molina on 04/11/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
      
    }

}
//MARK: UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
}
