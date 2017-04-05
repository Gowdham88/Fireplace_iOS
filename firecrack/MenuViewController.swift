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
    @IBOutlet var normalBtn: UIButton!
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var infoPopup: UIView!
    @IBOutlet var infoTextview: UITextView!
    @IBOutlet var infoTextview1: UITextView!
    @IBOutlet var volumeBtn: UIButton!
    @IBOutlet var volumePopup: UIView!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var imgaefade1: UIImageView!
    @IBOutlet var fireOnoff: UIView!
    @IBOutlet var onoffLabel: UIButton!
    @IBOutlet var music01: UIButton!
    @IBOutlet var music03: UIButton!
    @IBOutlet var music02: UIButton!
    @IBOutlet var videoSelect: UIButton!
    @IBOutlet var videoSelectview: UIView!
    @IBOutlet var videoFirst: UIButton!
    @IBOutlet var videoSecond: UIButton!

    
    var brightnessBtncenter: CGPoint!
    var fastBtncenter: CGPoint!
    var fireBtncenter: CGPoint!
    var infoBtncenter: CGPoint!
    var volumeBtncenter: CGPoint!
    var videoselectcenter:CGPoint!

    
    var appBrightness = CGFloat()
    let prefs = UserDefaults.standard
    
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    var menubool : Bool = false
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer!
    var playerView = AVPlayer()
    var videotype : String = "1"
    var videoselectNormal : String?
    var videoSelectFast : String?
    var speedtype : String = "normals"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        /***************** info popup link detection***********/
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.alignment = .justified
        
        let attributedString = NSMutableAttributedString(string: "About\n      The Common Room Virtual Fireplace App was designed with love by 5x entrepreneur, Arjun Rai. The goal of this is to create the ultimate mobile and relaxing ambience anywhere and anytime. Rai’s passion for fireplaces along with minimalism in art has led him to build several apps and startups over the years since he was a teenager. Common Room is yet another effort to bringing beautiful experiences to everyone...just a bit more relaxing this time around. :) Follow him at twitter.com/arjunraime")
        
        
        attributedString.addAttribute(NSLinkAttributeName, value: "http://arjunrai.me/", range: NSRange(location: 92, length: 10))
        
        attributedString.addAttribute(NSLinkAttributeName, value: "https://itunes.apple.com/in/genre/ios/id36?mt=8", range: NSRange(location: 14, length: 33))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-UltraLight", size: 12.0)!, range: NSRange(location: 0, length: 506))
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 506))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 0, length: 5))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 15, length: 34))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 92, length: 11))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 470, length: 36))
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 506))
        
        infoTextview.attributedText = attributedString
        
        /*************************how it works****************/
        
        let attributedString1 = NSMutableAttributedString(string: "How it Works?\n       Common Room works alongside any of your favorite music apps. Simply start Common Room app first followed by opening your favorite music app to play songs then return back. You can control the volume of the fire crackle as well as turn it on and off via the menu in Common Room. Enjoy!")
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-UltraLight", size: 12.0)!, range: NSRange(location: 0, length: 305))
        
        attributedString1.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 305))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 0, length: 13))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 60, length: 21))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 231, length: 9))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 12.0)!, range:NSRange(location: 258, length: 12))
        
        
        attributedString1.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 305))
        
        
        infoTextview1.attributedText = attributedString1
        
        /******************** Image fade ***********************/
        
        self.imgaefade1.isHidden = false
        UIView.animate(withDuration: 2, delay:0.5, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.imgaefade1.alpha = 0
        }, completion: { finished in
            self.imgaefade1.isHidden = true
        })
       /**********************/
        self.menuBtn.isHidden = false
        UIView.animate(withDuration: 2, delay:0.5, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {

            self.menuBtn.alpha = 0
     

        }, completion: { finished in
                     
                        if (self.menubool) {
            
            self.menuBtn.isHidden = true

                        }
           
        })
        
    
    

    
       /*******************************************/
        
//        playmyVideo(myString: "normalnewer")
        UserDefaults.standard.set("normalnewer", forKey: "video")
       
        let defaults = UserDefaults.standard
        let isHidden = defaults.bool(forKey: "InstructionsButtonIsHidden")

    
        brightnessBtncenter = brightnessBtn.center
        fastBtncenter = fastBtn.center
        fireBtncenter = fireBtn.center
        infoBtncenter = infoBtn.center
        volumeBtncenter = volumeBtn.center
        videoselectcenter = videoSelect.center
//        fireMusiccenter = fireMusic.center

       
        brightnessBtn.center = menuBtn.center
        fastBtn.center = menuBtn.center
        fireBtn.center = menuBtn.center
        infoBtn.center = menuBtn.center
        volumeBtn.center = menuBtn.center
        videoSelect.center = menuBtn.center
//        fireMusic.center = menuBtn.center
        
     
        
//       self.viewupDown.isHidden = true
        popViewslider.isHidden = true
        videoContolpopup.isHidden = true
        infoPopup.isHidden = true
        volumePopup.isHidden = true
        fireOnoff.isHidden = true
        videoSelectview.isHidden = true
        
//        firemusicView.isHidden = true

//        imgaefade1.setbackground = UIColor.clear
//        imgaefade1.backgroundColor = UIColor.clear
//        imgaefade1.opaque = NO
        
        
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


//    func playmyVideo(myString: String) {
//        
//        let bundle: Bundle = Bundle.main
//        let videoPlayer: String = bundle.path(forResource: myString, ofType: "mp4")!
//        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
//        
//        print(movieUrl)
//        
//        viewVideo.playVideoWithURL(url: movieUrl)
    
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "normalnewer", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        playerView = AVPlayer(url: movieUrl as URL)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem) // Add observer
        
        var playerLayer=AVPlayerLayer(player: playerView)
        playerLayer.videoGravity = AVLayerVideoGravityResize

        playerLayer.frame = viewVideo.bounds

        viewVideo.layer.addSublayer(playerLayer)

       
        
        
        playerView.play()
        
        UserDefaults.standard.set("normalnewer", forKey: "video")
        
        
        
        
    }

  
     /***************menu animation***************/
    
    @IBAction func menupressed(_ sender: UIButton) {
        
        menubool = true
        
        if menuBtn.currentImage == #imageLiteral(resourceName: "unline-4"){
            UIView.animate(withDuration: 0.3, animations: {
                self.brightnessBtn.alpha = 1
                self.fastBtn.alpha = 1
                self.fireBtn.alpha = 1
                self.infoBtn.alpha = 1
                self.volumeBtn.alpha = 1
                self.videoSelect.alpha = 1
//                self.fireMusic.alpha = 1
                
                
                self.brightnessBtn.center = self.brightnessBtncenter
                self.fastBtn.center = self.fastBtncenter
                self.fireBtn.center = self.fireBtncenter
                self.infoBtn.center = self.infoBtncenter
                self.volumeBtn.center = self.volumeBtncenter
                self.videoSelect.center = self.videoselectcenter
//                self.fireMusic.center = self.fireMusiccenter
                
                
            })
            
        }
        else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.brightnessBtn.alpha = 0
                self.fastBtn.alpha = 0
                self.fireBtn.alpha = 0
                self.infoBtn.alpha = 0
                self.volumeBtn.alpha = 0
                self.videoSelect.alpha = 0
//                self.fireMusic.alpha = 0
                
                
                
                self.brightnessBtn.center = self.menuBtn.center
                self.fastBtn.center = self.menuBtn.center
                self.fireBtn.center = self.menuBtn.center
                self.infoBtn.center = self.menuBtn.center
                self.volumeBtn.center = self.menuBtn.center
                self.videoSelect.center = self.menuBtn.center
//                self.fireMusic.center = self.menuBtn.center

            })
            
    

        }
        
        
        if menuBtn.isHidden == false {
            
            videoContolpopup.isHidden = true
            popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

        }
   toggleButton(button: sender, onImage: #imageLiteral(resourceName: "line-4"), offImage: #imageLiteral(resourceName: "unline-4"))
    
    }
    
   /**************************************/
    
    @IBAction func fastPressed(_ sender: UIButton) {
        
        
        if videoContolpopup.isHidden == true{
            
            videoContolpopup.isHidden = false
            popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

        } else {
            
            videoContolpopup.isHidden = true
             popViewslider.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

        }
        
        
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "speed"), offImage: #imageLiteral(resourceName: "unspeed"))
    }
    @IBAction func firePressed(_ sender: UIButton) {
        
        if fireOnoff.isHidden == true {
            
            fireOnoff.isHidden = false
            infoPopup.isHidden = true
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            volumePopup.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true
            
        
        }else {
            
            fireOnoff.isHidden = true

        }
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "selectedfire "), offImage: #imageLiteral(resourceName: "unselectedfire"))
    }
    
    @IBAction func fireCrackonoff(_ sender: UIButton) {
        
        if player.isPlaying {
            
            player.pause()
            

            onoffLabel.setTitle("off", for: .normal)
            let sounddefaults = UserDefaults.standard
            
            sounddefaults.set(true, forKey: "soundMute")



        } else {
            
            player.numberOfLoops = -1
            player.play()
            let sounddefaults = UserDefaults.standard
            
            sounddefaults.set(false, forKey: "soundMute")

            onoffLabel.setTitle("on", for: .normal)

            
        }

        
        
    }
   
    @IBAction func infoPressed(_ sender: UIButton) {
        infoPopup.layer.cornerRadius = 10.0

        if infoPopup.isHidden == true {
            
            infoPopup.isHidden = false
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

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
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

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
   
     
   
    @IBAction func videoSelectBtnpressed(_ sender: UIButton) {
    
        if videoSelectview.isHidden == true {
            
            videoSelectview.isHidden = false
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            infoPopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            
            
        } else {
            
            videoSelectview.isHidden = true

        }
        
    }
    
    
    
    @IBAction func normalPressed(_ sender: Any) {
        
        speedtype = "normals"
        if videotype == "1" {
            
        
 
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "normalnewer", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill

        playerView.play()
        
        UserDefaults.standard.set("normalnewer", forKey: "video")
        } else {
            
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: "newvideonormal", ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerView.play()
            UserDefaults.standard.set("newvideonormal", forKey: "video")
            
        }
           }
    
   
    @IBAction func forwardPressed(_ sender: Any) {
        
         speedtype = "fasts"
        
        if videotype == "1" {

        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "fastnewerr", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill

        playerView.play()
            
           
        
        UserDefaults.standard.set("fastnewerr", forKey: "video")
        } else {
            
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: "newvideofast", ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerView.play()

            UserDefaults.standard.set("newvideofast", forKey: "video")

            
        }
    }
    
   
    
    override var prefersStatusBarHidden: Bool {
        
        return true
   
    }
    
    @IBAction func oneVideo(_ sender: UIButton) {
       
   
        
        self.videotype = "1"
        
       if speedtype == "normals" {
        
        
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "normalnewer", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
        //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        playerView.play()
        
        UserDefaults.standard.set("normalnewer", forKey: "video")
       
       } else {
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "fastnewerr", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
        //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        playerView.play()
        
        
        
        UserDefaults.standard.set("fastnewerr", forKey: "video")

        
        
        }
        toggleButton(button: videoFirst, onImage: #imageLiteral(resourceName: "video select"), offImage: #imageLiteral(resourceName: "video unselect"))
        toggleButton(button: videoSecond, onImage: #imageLiteral(resourceName: "video unselect"), offImage: #imageLiteral(resourceName: "video unselect"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
    }
    
    @IBAction func videoTwo(_ sender: UIButton) {
    
    
    
        
        self.videotype = "2"
        if speedtype == "normals" {
            
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "newvideonormal", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
        //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        playerView.play()
         UserDefaults.standard.set("newvideonormal", forKey: "video")

        } else {
            
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: "newvideofast", ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerView.play()
            UserDefaults.standard.set("newvideofast", forKey: "video")

        }
        toggleButton(button: videoFirst, onImage: #imageLiteral(resourceName: "video unselect"), offImage: #imageLiteral(resourceName: "video unselect"))
        toggleButton(button: videoSecond, onImage: #imageLiteral(resourceName: "video select"), offImage: #imageLiteral(resourceName: "video unselect"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
    }

    @IBAction func volumeControl(_ sender: UIButton) {
        
        if self.volumePopup.isHidden == true {
            
            volumePopup.isHidden = false
            popViewslider.isHidden = true
            videoContolpopup.isHidden = true
            infoPopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            firemusicView.isHidden = true

            
            
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
            self.imgaefade1.isHidden = false
            self.imgaefade1.alpha = 1
            self.menuBtn.alpha = 1
        } else {
            
            self.viewupDown.isHidden = true
            self.imgaefade1.isHidden = true
            self.popViewslider.isHidden = true
             self.videoContolpopup.isHidden = true
            self.infoPopup.isHidden = true
            self.volumePopup.isHidden = true
            self.fireOnoff.isHidden = true
            self.videoSelectview.isHidden = true

//            self.firemusicView.isHidden = true

            
            
            
        }
        
    }

    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .clear
        
        
    }
    
   

    
    
    func willEnterForeground() {
        // do stuff
        let videoname = UserDefaults.standard.object(forKey: "video")
        
        if videoname != nil {
            
            let videoURL = UserDefaults.standard.string(forKey: "video")
            
            // do stuff
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: videoURL, ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            
            playerView.play()
            
        }
        
        
        let musicname = UserDefaults.standard.object(forKey: "music")
        
        if musicname != nil {
            
            let musicURL = UserDefaults.standard.string(forKey: "music")
            
            let path = Bundle.main.path(forResource: musicURL, ofType: "mp3")
            let filePath = NSURL(fileURLWithPath:path!)
            player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            player.numberOfLoops = -1 //logic for infinite loop
            player.prepareToPlay()
            player.play()
            
            
            let audioSession = AVAudioSession.sharedInstance()
            try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
            
        }
        
        let sounddefaults = UserDefaults.standard
        let isMute = sounddefaults.bool(forKey: "soundMute")
        
        
        
        if isMute {
            player.pause()
            
        } else{
            player.play()
            player.numberOfLoops = -1
        }

        
    }
    
    

    @IBAction func music1(_ sender: UIButton) {
        
        let path = Bundle.main.path(forResource: "fire1", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
        
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
        

        
        UserDefaults.standard.set("fire1", forKey: "music")
        toggleButton(button: music01, onImage: #imageLiteral(resourceName: "tick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        toggleButton(button: music02, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        
        toggleButton(button: music03, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")

    
    }
    
    @IBAction func music2(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "fire2", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
        
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
        
        
        
        UserDefaults.standard.set("fire2", forKey: "music")
        toggleButton(button: music02, onImage: #imageLiteral(resourceName: "tick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        toggleButton(button: music03, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        toggleButton(button: music01, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
  
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
    
    }
    @IBAction func music3(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "fire3", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
        
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
        
        
        
        UserDefaults.standard.set("fire3", forKey: "music")
        toggleButton(button: music03, onImage: #imageLiteral(resourceName: "tick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        toggleButton(button: music02, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        toggleButton(button: music01, onImage: #imageLiteral(resourceName: "untick-1"), offImage: #imageLiteral(resourceName: "untick-1"))
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
    
    }
    override func viewDidDisappear(_ animated: Bool) {
       
        
        /********************************/
        
        avPlayer.pause()
        player.pause()
        paused = true
       
        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {
            
            UIScreen.main.brightness = brightvalue as! CGFloat
            
        }
        
        
    }
    func playerItemDidReachEnd() {
        self.playerView.seek(to: kCMTimeZero)
        self.playerView.play()
    }


    /**************** sound setup for playing background music ***********/
    
    func SetUpSound() {
        
        if let path = Bundle.main.path(forResource: "firenew", ofType: "mp3") {
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
