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


class ViewController: UIViewController {

   
    
//    @IBOutlet var brightnesslabel: UILabel!
  
    
    
   
   
    @IBOutlet var videoView: VideoPlay!
    
    

    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer!
   
   
    @IBOutlet var slideView: UIView!
   
    @IBOutlet var slowwBtn: UIButton!
    @IBOutlet var normallBtn: UIButton!
    @IBOutlet var fasttBtn: UIButton!
       
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
     
    @IBOutlet weak var viewUpdown: UIView!
    @IBOutlet weak var brightness: UILabel!
    @IBOutlet weak var popView1: UIView!
//    @IBOutlet weak var sliderStep: G8SliderStep!
    @IBOutlet weak var brightnessSlider: UISlider!

    var appBrightness = CGFloat()
    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let deviceBrightness = UIScreen.main.brightness
        
        print(deviceBrightness)

        prefs.set(deviceBrightness, forKey: "DeviceBrightness")

        //prefs.set(appBrightness, forKey: "appBrightness")
        if let appBrightness1 = prefs.value(forKey: "appBrightness") {

            UIScreen.main.brightness = appBrightness1 as! CGFloat
            
            brightnessSlider.value = Float(UIScreen.main.brightness)
        }

        
        self.viewUpdown.isHidden = true
        popView1.isHidden = true
        slideView.isHidden = true
//        slideView1.isHidden = true
        brightnessSlider.isHidden = true
//        slowwBtn.isHidden = true
//        normallBtn.isHidden = true
//        fasttBtn.isHidden = true
      

//        sliderStep.stepImages = [UIImage(named:"forward1")!, UIImage(named:"forward2")!, UIImage(named:"forward3")!]
//
//        sliderStep.tickTitles = ["SLOW", "NORMAL", "FAST"]
////        let shape = UIImage(named:"Oval")!
//        
////        sliderStep.tickImages = [shape, shape, shape]
//        sliderStep.minimumValue = 2
//        sliderStep.maximumValue = Float(sliderStep.stepImages!.count) + sliderStep.minimumValue - 1.0
//        
//        sliderStep.trackColor = UIColor.white
//        sliderStep.stepTickColor = UIColor.white
//        sliderStep.stepTickWidth = 27
//        sliderStep.stepTickHeight = 27
//        sliderStep.trackHeight = 2
//        sliderStep.value = 3
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

        self.view.addGestureRecognizer(tapGesture)
        self.videoView.addGestureRecognizer(tapGesture)

        self.SetUpSound()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        playmyVideo(myString: "normal")
        
      
    }

    func playmyVideo(myString: String) {

        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: myString, ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        
        videoView.playVideoWithURL(url: movieUrl)
       
        
    }

    override func viewDidAppear(_ animated: Bool) {

        

    }
//    @IBAction func flamesspeedSlider(_ sender: UISlider) {
//
//        print("Flames slider sender.value\(sender.value)")
//
//        if sender.value < 2.5 {
//
//            // flamespeed(speed: "slow00")
//            playmyVideo(myString: "slow00")
//            
//           
//
//        } else if sender.value > 2.5 && sender.value < 3.5 {
//
//            //flamespeed(speed: "normal")
//            playmyVideo(myString: "normal")
//            
//           
//        } else if sender.value > 3 {
//
//            //flamespeed(speed: "fast")
//            playmyVideo(myString: "fast")
//            
//
//
//        }
//    }

    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()

        view.backgroundColor = .clear
        

           }

    func willEnterForeground() {
        // do stuff
        
         playmyVideo(myString: "normal")
    }
   
    


    override func viewDidDisappear(_ animated: Bool) {
        
       
        avPlayer.pause()
        player.pause()
        paused = true
//        videoView.isMuted()
//        playmyVideo(myString: "normal")
        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {

        UIScreen.main.brightness = brightvalue as! CGFloat

        }

        
    }

    func handleTap(sender: UITapGestureRecognizer) {

        if self.viewUpdown.isHidden {

            self.viewUpdown.isHidden = false

        } else {

            self.viewUpdown.isHidden = true
            popView1.isHidden = true
            slideView.isHidden = true
//            slideView1.isHidden = true
            brightnessSlider.isHidden = true

        }

    }
    
    
    @IBAction func slowBtn(_ sender: Any) {
        playmyVideo(myString: "slow00")
    }
    
    @IBAction func normalBtn(_ sender: Any) {
        playmyVideo(myString: "normal")
    }
    
    @IBAction func fastBtn(_ sender: Any) {
        
        playmyVideo(myString: "fast")
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

    //UIScreen.mainScreen().setBrightness(0.5)

    @IBAction func brightnessSlider(_ sender: UISlider) {

        UIScreen.main.brightness = CGFloat(sender.value)

        appBrightness = UIScreen.main.brightness

        print("appBrightness: \(appBrightness)")

        prefs.set(appBrightness, forKey: "appBrightness")
        

}

    @IBAction func brightnessPressed(_ sender: UIButton) {

        brightness.text = "Brightness"
        
        self.popView1.layer.borderWidth = 1.0
        
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
   
     popView1.layer.cornerRadius = 15

        if popView1.isHidden == true {

            popView1.isHidden = false
            brightnessSlider.isHidden = false
//            sliderStep.isHidden = true
            slideView.isHidden = true
//            slideView1.isHidden = true
            slowwBtn.isHidden = true
            normallBtn.isHidden = true
            fasttBtn.isHidden = true
        } else {

//            pop view not hidden

            if slideView.isHidden == false {

                //fast forward slider not hidden
                slideView.isHidden = true
//                slideView1.isHidden = true
                brightnessSlider.isHidden = false
                slowwBtn.isHidden = true
                normallBtn.isHidden = true
                fasttBtn.isHidden = true
                

            } else {

                popView1.isHidden = true
                brightnessSlider.isHidden = true
                slideView.isHidden = true
//                slideView1.isHidden = true
                slowwBtn.isHidden = true
                normallBtn.isHidden = true
                fasttBtn.isHidden = true
                
            }

        }
    }
    

    @IBAction func fastForward(_ sender: Any) {

        brightness.text = "Flame Speed"
        brightness.textColor = UIColor.white

        self.popView1.layer.borderWidth = 1.0
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
        popView1.layer.cornerRadius = 15

        if popView1.isHidden == true {

            popView1.isHidden = false
            brightnessSlider.isHidden = true
            slideView.isHidden = false
//            slideView1.isHidden = false
            slowwBtn.isHidden = false
            normallBtn.isHidden = false
            fasttBtn.isHidden = false

        } else {

            //pop view not hidden

            if brightnessSlider.isHidden == false {

                brightnessSlider.isHidden = true
                slideView.isHidden = false
//                slideView1.isHidden = false
                slowwBtn.isHidden = false
                normallBtn.isHidden = false
                fasttBtn.isHidden = false

            } else {

                popView1.isHidden = true
                slideView.isHidden = true
//                slideView1.isHidden = true
                slowwBtn.isHidden = true
                normallBtn.isHidden = true
                fasttBtn.isHidden = true
                brightnessSlider.isHidden = true

            }

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
