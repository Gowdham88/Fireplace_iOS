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

class ViewController: UIViewController, UINavigationControllerDelegate {

    
  
    var player:AVAudioPlayer = AVAudioPlayer()
   
    @IBOutlet weak var brightness: UILabel!
   
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var popView1: UIView!
   
    @IBOutlet weak var myImages: UIImageView!
    @IBOutlet weak var uiSlider: UISlider!

   
    @IBOutlet weak var slidervalue: UILabel!
    var mygifNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"]
    
    var mygif = [UIImage]()
    
    fileprivate var colorControlsFilter : CIFilter!
    fileprivate var ciImageContext: CIContext!
    fileprivate var colorControl = ColorControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorControl.input(myImages.image!)
        
        
        
        UIScreen.main.brightness = CGFloat(0.5)
        
        
        
        popView.isHidden = true
        popView1.isHidden = true
        /******************** Gif image *************/
        
        
        for i in 0..<mygifNames.count{
            
            
            mygif.append(UIImage(named: mygifNames[i])!)
            
        }
        
        myImages.animationImages = mygif
        myImages.animationDuration = 2.20
        self.myImages.startAnimating()
        
        /******************** Background music *************/
        
        do{
            
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "firecrack", ofType: "mp3")!))
            
            player.prepareToPlay()
        }
        catch{
            
            print(error)
        }
        player.numberOfLoops = -1
        player.play()
        
        
        
        
        
    }
    
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
            popView1.isHidden = true
        }
            else{
            popView.isHidden = true
                
            }
        
        
    }
  
       

    @IBAction func slider(_ sender: UISlider) {
        
        let selectedValue = Float(10.0 - sender.value)
        
        myImages.animationDuration = TimeInterval(selectedValue)
        self.myImages.startAnimating()
        
        
    }
    
    
    @IBAction func bright(_ sender: UIButton) {
        if popView1.isHidden{
            popView1.isHidden = false
            popView.isHidden = true
        }
        else{
            popView1.isHidden = true
            
        }
    }
    
    


    @IBAction func sliderBrht(_ sender: UISlider) {
        

        UIScreen.main.brightness = CGFloat(0.5)
     

       
        
    }
    
}
















