//
//  ViewController.swift
//  ExampleUISlider
//
//  Created by Isrrael Torres Alvarado on 03/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    
    var colorRed: Float = 0
    var colorGreen: Float = 0
    var colorBlue: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewColor.layer.cornerRadius = 120
    }
    
    @IBAction func changeRedColor(_ sender: UISlider) {
        colorRed = sender.value
        changeColorView()
    }
    
    
    @IBAction func changeGreenColor(_ sender: UISlider) {
        colorGreen = sender.value
        changeColorView()
    }
    
    @IBAction func changeBlueColor(_ sender: UISlider) {
        colorBlue = sender.value
        changeColorView()
    }
    
    func changeColorView() {
        
        let red = CGFloat(colorRed/100)
        let green = CGFloat(colorGreen/100)
        let blue = CGFloat(colorBlue/100)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        viewColor.backgroundColor = color
        
    }
    
}

