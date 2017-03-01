//
//  MenuViewController.swift
//  Fireplay
//
//  Created by Paramesh on 17/02/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreImage



class MenuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var viewVideo: VideoPlay!
    @IBOutlet var viewupDown: UIView!
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var brightnessBtn: UIButton!
    @IBOutlet var fastBtn: UIButton!
    @IBOutlet var fireBtn: UIButton!
    @IBOutlet var infoBtn: UIButton!
    @IBOutlet var popViewslider: UIView!
    @IBOutlet var brightSlider: UISlider!
    @IBOutlet var videoContolpopup: UIView!
    @IBOutlet var lineOneview: UIView!
    @IBOutlet var lineTwoview: UIView!
    @IBOutlet var slowBtn: UIButton!
    @IBOutlet var normalBtn: UIButton!
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var infoPopup: UIView!
    @IBOutlet var infoTextview: UITextView!
    @IBOutlet var volumeBtn: UIButton!
    @IBOutlet var volumePopup: UIView!
    @IBOutlet var volumeSlider: UISlider!
    
    
    
    var brightnessBtncenter: CGPoint!
    var fastBtncenter: CGPoint!
    var fireBtncenter: CGPoint!
    var infoBtncenter: CGPoint!
    var volumeBtncenter: CGPoint!
    
    var appBrightness = CGFloat()
    let prefs = UserDefaults.standard
    
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /***************** info popup link detection***********/
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.alignment = .justified
        
        let attributedString = NSMutableAttributedString(string: "The Common Room Virtual Fireplace App was designed with love by 5x entrepreneur, Arjun Rai. The goal of this is to create the ultimate mobile and relaxing ambience anywhere and anytime. Rai’s passion for fireplaces along with minimalism in art has led him to build several apps and startups over the years since he was a teenager. Common Room is yet another effort to bringing beautiful experiences to everyone...just a bit more relaxing this time around. :) Follow him at twitter.com/arjunraime")
       
        attributedString.addAttribute(NSLinkAttributeName, value: "http://arjunrai.me/", range: NSRange(location: 81, length: 9))
        
        attributedString.addAttribute(NSLinkAttributeName, value: "https://itunes.apple.com/in/genre/ios/id36?mt=8", range: NSRange(location: 4, length: 33))
       
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: 15.0)!, range: NSRange(location: 0, length: 495))
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 494))
        
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 15.0)!, range:NSRange(location: 4, length: 33))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 15.0)!, range:NSRange(location: 81, length: 9))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 15.0)!, range:NSRange(location: 473, length: 21))
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 494))
                
        infoTextview.attributedText = attributedString
      
       /*******************************************/
        
        playmyVideo(myString: "normal")
        
       
        
    
        brightnessBtncenter = brightnessBtn.center
        fastBtncenter = fastBtn.center
        fireBtncenter = fireBtn.center
        infoBtncenter = infoBtn.center
        volumeBtncenter = volumeBtn.center

       
        brightnessBtn.center = menuBtn.center
        fastBtn.center = menuBtn.center
        fireBtn.center = menuBtn.center
        infoBtn.center = menuBtn.center
        volumeBtn.center = menuBtn.center
        
     
        
        self.viewupDown.isHidden = true
        popViewslider.isHidden = true
        videoContolpopup.isHidden = true
        infoPopup.isHidden = true
        volumePopup.isHidden = true
        
        
        
        let deviceBrightness = UIScreen.main.brightness
        
        print(deviceBrightness)
        
        prefs.set(deviceBrightness, forKey: "DeviceBrightness")
        
        //prefs.set(appBrightness, forKey: "appBrightness")
        if let appBrightness1 = prefs.value(forKey: "appBrightness") {
            
            UIScreen.main.brightness = appBrightness1 as! CGFloat
            
            brightSlider.value = Float(UIScreen.main.brightness)
        }
        self.SetUpSound()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        self.view.addGestureRecognizer(tapGesture)
        self.viewVideo.addGestureRecognizer(tapGesture)
    
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
       
        
    }


func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    UIApplication.shared.open(URL, options: [:])
    return false
}


    func playmyVideo(myString: String) {
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: myString, ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        
        print(movieUrl)
        
        viewVideo.playVideoWithURL(url: movieUrl)
        
        
    }
  
     /***************menu animation***************/
    
    @IBAction func menupressed(_ sender: UIButton) {
        
        if menuBtn.currentImage == #imageLiteral(resourceName: "unline"){
            UIView.animate(withDuration: 0.3, animations: {
                self.brightnessBtn.alpha = 1
                self.fastBtn.alpha = 1
                self.fireBtn.alpha = 1
                self.infoBtn.alpha = 1
                self.volumeBtn.alpha = 1
                
                
                self.brightnessBtn.center = self.brightnessBtncenter
                self.fastBtn.center = self.fastBtncenter
                self.fireBtn.center = self.fireBtncenter
                self.infoBtn.center = self.infoBtncenter
                self.volumeBtn.center = self.volumeBtncenter
                
                
            })
            
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                self.brightnessBtn.alpha = 0
                self.fastBtn.alpha = 0
                self.fireBtn.alpha = 0
                self.infoBtn.alpha = 0
                self.volumeBtn.alpha = 0
                
                
                
                self.brightnessBtn.center = self.menuBtn.center
                self.fastBtn.center = self.menuBtn.center
                self.fireBtn.center = self.menuBtn.center
                self.infoBtn.center = self.menuBtn.center
                self.volumeBtn.center = self.menuBtn.center

            })
            
    

        }
        
        
        if menuBtn.isHidden == false {
            
            videoContolpopup.isHidden = true
            popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
        }
   toggleButton(button: sender, onImage: #imageLiteral(resourceName: "line"), offImage: #imageLiteral(resourceName: "unline"))
    
    }
    
   /**************************************/
    
    @IBAction func fastPressed(_ sender: UIButton) {
        
        
        if videoContolpopup.isHidden == true{
            
            videoContolpopup.isHidden = false
            popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
        } else {
            
            videoContolpopup.isHidden = true
             popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
        }
        
        
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "speed"), offImage: #imageLiteral(resourceName: "unspeed"))
    }
    @IBAction func firePressed(_ sender: UIButton) {
        
        if player.isPlaying {
            
            player.pause()
            
        } else {
            
            player.numberOfLoops = -1
            player.play()
            
        }
       
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "selectedfire "), offImage: #imageLiteral(resourceName: "unselectedfire"))
    }
    
   
    @IBAction func infoPressed(_ sender: UIButton) {
        infoPopup.layer.cornerRadius = 10.0

        if infoPopup.isHidden == true {
            
            infoPopup.isHidden = false
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            volumePopup.isHidden = true
        } else {
            
            infoPopup.isHidden = true
            
            
        }
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "info"), offImage: #imageLiteral(resourceName: "uninfo"))
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func toggleButton(button: UIButton, onImage: UIImage, offImage: UIImage ){
        
        if button.currentImage == offImage{
            
            button.setImage(onImage, for: .normal)
        }else{
            
            button.setImage(offImage, for: .normal)
        }
        
    }
    @IBAction func brightPressed(_ sender: Any) {
        
        if popViewslider.isHidden == true{
            
            popViewslider.isHidden = false
            videoContolpopup.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
        } else {
            
            popViewslider.isHidden = true
            
        }

        
    }
 
    @IBAction func brightSlider(_ sender: UISlider) {
        
        
        UIScreen.main.brightness = CGFloat(sender.value)
        
        appBrightness = UIScreen.main.brightness
        
        print("appBrightness: \(appBrightness)")
        
        prefs.set(appBrightness, forKey: "appBrightness")
    }
   
     
    @IBAction func slowPressed(_ sender: Any) {
        
        playmyVideo(myString: "slow00")

        
    }
    
    
    
    @IBAction func normalPressed(_ sender: Any) {
 
        playmyVideo(myString: "normal")
 
        
    }
    
   
    @IBAction func forwardPressed(_ sender: Any) {
        
        playmyVideo(myString: "fast")
  
    }
    
   
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }

    @IBAction func volumeControl(_ sender: UIButton) {
        
        if self.volumePopup.isHidden == true {
            
            volumePopup.isHidden = false
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            infoPopup.isHidden = true
            
            
        } else {
            
            volumePopup.isHidden = true
            
        }
        
        
    }
    
    @IBAction func volumeSlidercontroller(_ sender: UISlider) {
        
        player.volume = volumeSlider.value;
        
    }
    
    
    
    
    
    func handleTap(sender: UITapGestureRecognizer) {
        
        if self.viewupDown.isHidden {
            
            self.viewupDown.isHidden = false
            
        } else {
            
            self.viewupDown.isHidden = true
            self.popViewslider.isHidden = true
             self.videoContolpopup.isHidden = true
            self.infoPopup.isHidden = true
            self.volumePopup.isHidden = true
            
            
            
        }
        
    }

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
       
        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {
            
            UIScreen.main.brightness = brightvalue as! CGFloat
            
        }
        
        
    }

    /**************** sound setup for playing background music ***********/
    
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
