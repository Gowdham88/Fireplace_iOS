//
//  ViewController.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  
    var player:AVAudioPlayer = AVAudioPlayer()
   
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var popView1: UIView!
    @IBOutlet weak var myImages: UIImageView!

    @IBOutlet weak var slidervalue: UILabel!

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
        
        popView.isHidden = true
        popView1.isHidden = true
        
        UIScreen.main.brightness = CGFloat(1.5)

        
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

    @IBAction func slider1(_ sender: UISlider) {
        
        let selectedValue1 = Float(sender.value)
        print(selectedValue1)
        
        UIScreen.main.brightness = CGFloat(selectedValue1)
        
        
        
        
    }

}




















