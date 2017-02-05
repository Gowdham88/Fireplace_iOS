//
//  ViewController.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate {

  
    var player:AVAudioPlayer = AVAudioPlayer()
    //var player1: AVPlayer?

    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false

    @IBOutlet weak var viewUpdown: UIView!
    @IBOutlet weak var brightness: UILabel!
    @IBOutlet weak var popView1: UIView!

    @IBOutlet weak var uiSlider: UISlider!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewUpdown.isHidden = true

        popView1.isHidden = true
        uiSlider.isHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

        self.view.addGestureRecognizer(tapGesture)

        self.SetUpSound()

        flamespeed(speed: "normal")

    }

    func flamespeed(speed: String) {

        let theURL: URL = Bundle.main.url(forResource: speed, withExtension: "mp4")!

        avPlayer = AVPlayer(url: theURL)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)


    }

    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        player.pause()
        paused = true
    }
//
//    func restartVideoFromBeginning()  {
//
//        //create a CMTime for zero seconds so we can go back to the beginning
//        let seconds : Int64 = 0
//        let preferredTimeScale : Int32 = 1
//        let seekTime : CMTime = CMTimeMake(seconds, preferredTimeScale)
//
//        player1!.seek(to: seekTime)
//
//        player1!.play()
//
//    }
//
//    func loopVideo() {
//        player1?.seek(to: kCMTimeZero)
//        player1?.play()
//    }


    func handleTap(sender: UITapGestureRecognizer) {

        if self.viewUpdown.isHidden {

          self.viewUpdown.isHidden = false
            self.popView1.isHidden = false
            self.uiSlider.isHidden = false
            
        } else {

            self.viewUpdown.isHidden = true
            self.popView1.isHidden = true
            self.uiSlider.isHidden = true
            
        }

    }
    
    
    override var prefersStatusBarHidden: Bool {

        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Pause(_ sender: Any) {
        
        if player.isPlaying {

            player.pause()

        } else {

        player.numberOfLoops = -1
        player.play()
            
        }
    }

    @IBAction func slider(_ sender: UISlider) {

        /*let step: Float = 10
         let roundedValue = round(sender.value / step) * step
         sender.value = roundedValue
         label.text = "\(Int(roundedValue))"
         }*/
      /*
        print("sender.value: \(sender.value)")
        
        if sender.value > 2 && sender.value < 4 {
            
            mygif.removeAll()
            
            
            for i in 0..<mygifNames1.count{
                
                
                mygif.append(UIImage(named: mygifNames1[i])!)

                //let jeremyGif = UIImage.gifWithName("fireslow")

                // Use the UIImage in your UIImageView
                //let imageView = UIImageView(image: jeremyGif)

                
            }
         
            myImages.animationImages = mygif
            let selectValue = Float(10.0 - sender.value)
            myImages.animationDuration = TimeInterval(selectValue)
            self.myImages.startAnimating()
            
        } else if sender.value > 4 && sender.value < 7 {
            
            mygif.removeAll()

            for i in 0..<mygifNames.count{
                
                
                mygif.append(UIImage(named: mygifNames[i])!)
                
            }
            
            myImages.animationImages = mygif
            let selectValue = Float(10.0 - sender.value)
            myImages.animationDuration = TimeInterval(selectValue)
            self.myImages.startAnimating()
            
            
            
     }
//        else if sender.value > 5 && sender.value < 10 {
//
//            mygif.removeAll()
//            for i in 0..<mygifNames2.count{
//                
//                
//                mygif.append(UIImage(named: mygifNames2[i])!)
//                
//            }
//            
//            myImages.animationImages = mygif
//            let selectValue = Float(10.0 - sender.value)
//            myImages.animationDuration = TimeInterval(selectValue)
//            self.myImages.startAnimating()
//
//    
//            
//            
//            
//        }
        
//        let selectedValue = Float(10.0 - sender.value)
//        
//        myImages.animationDuration = TimeInterval(selectedValue)
//        self.myImages.startAnimating()
        
        
    */
    }
    
    @IBAction func bright(_ sender: UIButton) {

        brightness.text = "Brightness"


        

        self.popView1.layer.borderWidth = 1.0
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
   
     popView1.layer.cornerRadius = 15

        if popView1.isHidden {

            popView1.isHidden = false

        } else {
            popView1.isHidden = true
            
        }
    }
    

    @IBAction func fastForward(_ sender: Any) {


        brightness.text = "Adjust Speed"


        self.popView1.layer.borderWidth = 1.0
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
        popView1.layer.cornerRadius = 15

        if popView1.isHidden {

            popView1.isHidden = false

        } else {
            popView1.isHidden = true
            
        }

    }
    



    @IBAction func sliderBrht(_ sender: UISlider) {
        
        UIScreen.main.brightness = CGFloat(sender.value)
      
    }
    
    
    func SetUpSound() {
        
        if let path = Bundle.main.path(forResource: "firecrack", ofType: "mp3") {
            let filePath = NSURL(fileURLWithPath:path)
            player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            player.numberOfLoops = -1 //logic for infinite loop
            player.prepareToPlay()
            player.play()
        }

        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
    }

}
