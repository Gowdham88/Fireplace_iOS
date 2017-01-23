//
//  ViewController.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate  {

    
 
    
  
    var player:AVAudioPlayer = AVAudioPlayer()
   
    @IBOutlet weak var brightness: UILabel!
   
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var popView1: UIView!
    @IBOutlet weak var myImages: UIImageView!
    @IBOutlet weak var uiSlider: UISlider!

   
    @IBOutlet weak var slidervalue: UILabel!

//    fileprivate var colorControlsFilter : CIFilter!
//    fileprivate var ciImageContext: CIContext!
//      fileprivate var colorControl = ColorControl()
    
    
    var item = 0

    func startTimer() {

        if item == 60 {

            item = 0

        }
        myImages.image = UIImage(named: "\(item)")

        item += 1

    }

    var mytimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
//        colorControl.input(myImages.image!)
        
      
//        self.brightness.text = "Brightness \(uiSlider.value)"
        
//        let openGLContext = EAGLContext(api: .openGLES3)!
//        ciImageContext = CIContext(eaglContext: openGLContext)
//        colorControlsFilter = CIFilter(name: "CIColorControls")!
//        UIScreen.main.brightness = CGFloat(0.5)
//
//        self.setDefaultValueOfSliders()
        popView.isHidden = true
        popView1.isHidden = true
        
        

        
        /******************** Gif image *************/


        mytimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
        

        /******************** Background music *************/
       
        do{
            
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "firecrack", ofType: "mp3")!))
            
            player.prepareToPlay()
        }
        catch{

            print(error)
        }
        player.play()

        
        
        
        
    }

    
//    fileprivate func setUISLidersValues() {
//        
//        
//        uiSlider.value = colorControl.currentBrightnessValue
//        uiSlider.maximumValue = colorControl.maxBrightnessValue
//        uiSlider.minimumValue = colorControl.minBrightnessValue
//        
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Pause(_ sender: Any) {
        
        if player.isPlaying {
            player.pause()
        }
        else{
        player.numberOfLoops = -1
        player.play()
            
        }
        
        
    }
   
    @IBAction func fastForward(_ sender: Any) {
        
        if popView.isHidden{
            popView.isHidden = false
        }
            else{
            popView.isHidden = true
                
            }
        
        
    }
  
   

    @IBAction func slider(_ sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        print(selectedValue)
        
        mytimer = Timer.scheduledTimer(timeInterval: TimeInterval(selectedValue), target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
        
        
    }
    @IBAction func bright(_ sender: UIButton) {
        if popView1.isHidden{
            popView1.isHidden = false
        }
        else{
            popView1.isHidden = true
            
        }
    }
    
    


    @IBAction func sliderBrht(_ sender: UISlider) {
        

        UIScreen.main.brightness = CGFloat(0.5)
     
        
//        self.brightness.text = "Brightness \(sender.value)"
//        self.colorControl.brightness(sender.value)
//        self.myImages.image = self.colorControl.outputUIImage()
//        UIScreen.main.brightness = CGFloat(0.5)
//
//
//        
//            if let outputImage = self.colorControlsFilter.outputImage {
//               if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
//                    let newImg = UIImage(cgImage: cgImageNew)
//                   myImages.image = newImg
//                }
//          }
//        

       
        
    }
    
}



//extension ViewController {
//    @IBAction func sliderBrht(_ sender: UISlider) {
//
//        self.brightness.text = "Brightness \(sender.value)"
//        self.colorControl.brightness(sender.value)
//        self.myImages.image = self.colorControl.outputUIImage()
//        UIScreen.main.brightness = CGFloat(0.5)
//
//
//
//            if let outputImage = self.colorControlsFilter.outputImage {
//               if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
//                    let newImg = UIImage(cgImage: cgImageNew)
//                   myImages.image = newImg
//                }
//          }
//
//
//
//
//    }
//
//
//}

//
//extension ViewController {
//    
//    func setDefaultValueOfSliders() {
//        colorControlsFilter.setDefaults()
//        let brightnessValue = self.colorControlsFilter.value(forKey: kCIInputBrightnessKey) as? Float
//        
//        
//        print((brightnessValue));
//        
//        uiSlider.value = brightnessValue ?? 0.0
//        uiSlider.maximumValue = 1.00
//        uiSlider.minimumValue = -1.00
//        
//       
//    }
//}
//














