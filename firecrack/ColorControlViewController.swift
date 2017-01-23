//
//  ColorControlViewController.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class ColorControlViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var contrastLabel: UILabel!
    @IBOutlet weak var saturationLabel: UILabel!
    
    @IBOutlet weak var brightnessUISlider: UISlider!
    @IBOutlet weak var contrastUISlider: UISlider!
    @IBOutlet weak var saturationUISlider: UISlider!
    
    fileprivate var colorControl = ColorControl()

    
    
    // MARK: - LyfeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.brightnessLabel.text = "Brightness \(brightnessUISlider.value)"
       
        
        colorControl.input(imageView.image!)
        
        ///
        self.setUISLidersValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setUISLidersValues() {
        
        
        brightnessUISlider.value = colorControl.currentBrightnessValue
        brightnessUISlider.maximumValue = colorControl.maxBrightnessValue
        brightnessUISlider.minimumValue = colorControl.minBrightnessValue
        
      
    }
}


// MARK: - UISlider @IBAction

extension ColorControlViewController {
    
    @IBAction func brightnessUISliderPressed(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.brightnessLabel.text = "Brightness \(sender.value)"
            self.colorControl.brightness(sender.value)
            self.imageView.image = self.colorControl.outputUIImage()
        }
    }
    
    
    }
