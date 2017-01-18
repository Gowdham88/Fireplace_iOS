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
   
    
    @IBOutlet weak var myImages: UIImageView!


    var item = 0

    func startTimer() {

        if item == 6 {

            item = 0

        }
        myImages.image = UIImage(named: "\(item)")

        item += 1

    }

    var mytimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         /******************** Gif image *************/


        mytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
        

        /******************** Background music *************/
       
//        do{
//            
//            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "fire", ofType: "mp3")!))
//            
//            player.prepareToPlay()
//        }
//        catch{
//
//            print(error)
//        }
//        player.play()

        
        
        
        
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
   
    @IBAction func popView(_ sender: Any) {
   
    
    
    }

}

