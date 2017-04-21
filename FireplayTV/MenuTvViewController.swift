//
//  MenuTvViewController.swift
//  Fireplay
//
//  Created by Gowdhaman on 04/03/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreImage


class MenuTvViewController: UIViewController, UITextFieldDelegate {

   
    @IBOutlet var videoView: UIView!
    @IBOutlet var viewupDown: UIView!

    @IBOutlet var menuBtn: CustomFocusButton!
    @IBOutlet var fireBtn: CustomFocusButton!
    @IBOutlet var fastBtn: CustomFocusButton!
    @IBOutlet var infoBtn: CustomFocusButton!
    @IBOutlet var volumeBtn: CustomFocusButton!
    @IBOutlet var volumeupBtn: CustomFocusButton!
    @IBOutlet var volumedownBtn: CustomFocusButton!
    @IBOutlet var normalBtn: CustomFocusButton!
    @IBOutlet var forwardBtn: CustomFocusButton!
    @IBOutlet var imageFade: UIImageView!
    @IBOutlet var music1Btn: CustomFocusButton!
    @IBOutlet var music2Btn: CustomFocusButton!
    @IBOutlet var music3Btn: CustomFocusButton!
    @IBOutlet var videoSelect: CustomFocusButton!
    @IBOutlet var videoFirst: CustomFocusButton!
    @IBOutlet var videoSecond: CustomFocusButton!
    @IBOutlet var videoSelectview: UIView!

    @IBOutlet var fireOnoff: UIView!
    @IBOutlet var fireCrackingOnoffsound: CustomFocusButton!
    @IBOutlet var musicView: UIView!
    @IBOutlet var fireonoffLabel: UILabel!
    @IBOutlet var videoControlpopup: UIView!
    @IBOutlet var volumePopup: UIView!
    @IBOutlet var infoPopupview: UIView!
    @IBOutlet var infoTextview: UITextView!
    @IBOutlet var infoTextview1: UITextView!
    
    var fastBtncenter: CGPoint!
    var fireBtncenter: CGPoint!
    var infoBtncenter: CGPoint!
    var volumeBtncenter: CGPoint!
    var musiccenter: CGPoint!
    var videoselectcenter:CGPoint!
    
    var playerView = AVPlayer()
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    var play: Bool = true
    var isPlaying: Bool = true
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer?
    var audioStuffed = false
    
    var videotype : String = "1"
    var videoselectNormal : String?
    var videoSelectFast : String?
    var speedtype : String = "normals"
    var volumeControl : Float = 0.5
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /***************** info popup link detection***********/
        
        let paragraph = NSMutableParagraphStyle()
        
        paragraph.alignment = .justified
       
        
        let attributedString = NSMutableAttributedString(string: "About\n      The Common Room Modern Fireplace App was designed with love by 5x entrepreneur, Arjun Rai. The goal of this is to create the ultimate mobile and relaxing ambience anywhere and anytime. Rai’s passion for fireplaces along with minimalism in art has led him to build several apps and startups over the years since he was a teenager. Common Room is yet another effort to bringing beautiful experiences to everyone...just a bit more relaxing this time around. :) Follow him at twitter.com/arjunraime")
        
        
        attributedString.addAttribute(NSLinkAttributeName, value: "http://arjunrai.me/", range: NSRange(location: 91, length: 10))
        
       attributedString.addAttribute(NSLinkAttributeName, value: "http://commonroomfireplace.com/", range: NSRange(location: 16, length: 32))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-UltraLight", size: 34.0)!, range: NSRange(location: 0, length: 506))
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 506))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 0, length: 5))

        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 16, length: 33))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 92, length: 10))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 470, length: 36))
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 506))
 
        infoTextview.attributedText = attributedString
        
    /*************************how it works****************/
        
        let attributedString1 = NSMutableAttributedString(string: "How it Works?\n     Common Room works alongside any of your favorite music apps. Simply start Common Room app first followed by opening your favorite music app to play songs then return back. You can control the volume of the fire crackle as well as turn it on and off via the menu in Common Room. Enjoy!")
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-UltraLight", size: 34.0)!, range: NSRange(location: 0, length: 303))
        
        attributedString1.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 303))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 0, length: 13))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 58, length: 21))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 229, length: 9))
        
        attributedString1.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNext-Medium",size: 34.0)!, range:NSRange(location: 256, length: 12))
        
        
        attributedString1.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 303))
        
        
        infoTextview1.attributedText = attributedString1
      
        /******************** Image fade ***********************/
       
        self.imageFade.isHidden = false
        UIView.animate(withDuration: 3, delay:1, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.imageFade.alpha = 0
        }, completion: { finished in
            self.imageFade.isHidden = true
        })

        
        /*******************************************/
        
        
        
        
        let defaults = UserDefaults.standard
        let isHidden = defaults.bool(forKey: "InstructionsButtonIsHidden")
        
        
       


      
        
        
        fastBtncenter = fastBtn.center
        fireBtncenter = fireBtn.center
        infoBtncenter = infoBtn.center
        volumeBtncenter = volumeBtn.center
        videoselectcenter = videoSelect.center

//        musiccenter = musicBtn.center
        
        fastBtn.center = menuBtn.center
        fireBtn.center = menuBtn.center
        infoBtn.center = menuBtn.center
        volumeBtn.center = menuBtn.center
        videoSelect.center = menuBtn.center

//        musicBtn.center = menuBtn.center
        
//        self.viewupDown.isHidden = true

        infoPopupview.isHidden = true
        videoControlpopup.isHidden = true
        volumePopup.isHidden = true
        fireOnoff.isHidden = true
        videoSelectview.isHidden = true

//        musicView.isHidden = true
     
        self.SetUpSound()
//        self.setImageView()
        player.volume = 0.5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(swipedDown(sender:)))
        
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.playPause.rawValue)];

//        self.view.addGestureRecognizer(tapRecognizer)
        self.videoView.addGestureRecognizer(tapRecognizer)
        
        
        
//        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector(("swipedDown:")))
//        swipeDown.direction = .down
//        videoView.addGestureRecognizer(swipeDown)
        
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
   
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "normalnewest", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
       
        playerView = AVPlayer(url: movieUrl as URL)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem) // Add observer
        
        
        var playerLayer=AVPlayerLayer(player: playerView)
        
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        
        
        playerView.play()
        
        UserDefaults.standard.set("normalnewest", forKey: "video")
        toggleButton(button: videoFirst, onImage:  #imageLiteral(resourceName: "video select1"), offImage:  #imageLiteral(resourceName: "video select1"))
        toggleButton(button: videoSecond, onImage: #imageLiteral(resourceName: "video unselect1"), offImage: #imageLiteral(resourceName: "video unselect1"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")

        /***********************************************/
        let path = Bundle.main.path(forResource: "fire1", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
        
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

        
        
        
        UserDefaults.standard.set("fire1", forKey: "music")
        toggleButton(button: music1Btn, onImage: #imageLiteral(resourceName: "music select-4"), offImage: #imageLiteral(resourceName: "music select-4"))
        toggleButton(button: music2Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        
        toggleButton(button: music3Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
//        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")

        
        
        
    }

    
    /*************************menu button animation*********************/
  
    
    @IBAction func menuPressed(_ sender: UIButton) {
        
        
        if menuBtn.currentImage == #imageLiteral(resourceName: "unmenu"){
            
            UIView.animate(withDuration: 0.3, animations: {
                self.fastBtn.alpha = 1
                self.fireBtn.alpha = 1
                self.infoBtn.alpha = 1
                self.volumeBtn.alpha = 1
                self.videoSelect.alpha = 1

//                self.musicBtn.alpha = 1
                
                
                self.fastBtn.center = self.fastBtncenter
                self.fireBtn.center = self.fireBtncenter
                self.infoBtn.center = self.infoBtncenter
                self.volumeBtn.center = self.volumeBtncenter
                self.videoSelect.center = self.videoselectcenter

//                self.musicBtn.center = self.musiccenter
                
            })
            
             self.imageFade.alpha = 1
             self.imageFade.isHidden = false
    
    }
        else {
            
            
            UIView.animate(withDuration: 0.3, animations: {

                self.fastBtn.alpha = 0
                self.fireBtn.alpha = 0
                self.infoBtn.alpha = 0
                self.volumeBtn.alpha = 0
                self.videoSelect.alpha = 0

//                self.musicBtn.alpha = 0
                
                
                self.fastBtn.center = self.menuBtn.center
                self.fireBtn.center = self.menuBtn.center
                self.infoBtn.center = self.menuBtn.center
                self.volumeBtn.center = self.menuBtn.center
                self.videoSelect.center = self.menuBtn.center

//                self.musicBtn.center = self.menuBtn.center
                
                
                
            })
           

            if menuBtn.isHidden == false {
                
                videoControlpopup.isHidden = true
                infoPopupview.isHidden = true
                volumePopup.isHidden = true
                fireOnoff.isHidden = true
                self.imageFade.alpha = 0
                self.imageFade.isHidden = true
                videoSelectview.isHidden = true

                
                
            }
            
        }
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "menu"), offImage: #imageLiteral(resourceName: "unmenu"))

        
    }
    
    
    
    @IBAction func fastPressed(_ sender: UIButton) {
        
        if videoControlpopup.isHidden == true{
            
            videoControlpopup.isHidden = false
            
            infoPopupview.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            musicView.isHidden = true
            
        } else {
            
            videoControlpopup.isHidden = true
            infoPopupview.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            musicView.isHidden = true
        }
        
    }
    

    @IBAction func firePressed(_ sender: UIButton) {
        
        if fireOnoff.isHidden == true {
            
            fireOnoff.isHidden = false
            infoPopupview.isHidden = true
            videoControlpopup.isHidden = true
            volumePopup.isHidden = true
            videoSelectview.isHidden = true

//            musicView.isHidden = true
            
        } else {
            
             fireOnoff.isHidden = true
            
        }

//        if audioStuffed == true && player.isPlaying
//        {
//            player.pause()
//            fireonoffLabel.text = "Off"
//            fireonoffLabel.textAlignment = .center
//        } else if audioStuffed == true && player.isPlaying == false
//        {
//            player.play()
//            player.numberOfLoops = -1
//            fireonoffLabel.text = "On"
//            fireonoffLabel.textAlignment = .center
//        }
//       
        
        
    }
    @IBAction func firecrackingOnoff(_ sender: UIButton) {
        
        if player.isPlaying {
            
            player.pause()

            fireCrackingOnoffsound.setTitle("off", for: .normal)

            let sounddefaults = UserDefaults.standard
            
            sounddefaults.set(true, forKey: "soundMute")
            


            
        } else {
            
            player.numberOfLoops = -1
            player.play()

            fireCrackingOnoffsound.setTitle("on", for: .normal)
            let sounddefaults = UserDefaults.standard
            
            sounddefaults.set(false, forKey: "soundMute")
        }
 
        
    }

    @IBAction func infoPressed(_ sender: UIButton) {
        
        infoPopupview.layer.cornerRadius = 30
        
        if infoPopupview.isHidden == true {
            
            infoPopupview.isHidden = false
            videoControlpopup.isHidden = true
            volumePopup.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            musicView.isHidden = true
            
        } else {
            
            infoPopupview.isHidden = true
            
            
        }
        
    }
    
    
    @IBAction func oneVideo(_ sender: Any) {
        
        self.videotype = "1"
        
        if speedtype == "normals" {
            
            
            
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: "normalnewest", ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerView.play()
            
            UserDefaults.standard.set("normalnewest", forKey: "video")
            
        } else {
            let bundle: Bundle = Bundle.main
            let videoPlayer: String = bundle.path(forResource: "fasternew", ofType: "mp4")!
            let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
            let videoAssetURL = AVURLAsset(url: movieUrl as URL)
            let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
            playerView.replaceCurrentItem(with: videoAssetItem)
            
            NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
            //        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            playerView.play()
            
            
            
            UserDefaults.standard.set("fasternew", forKey: "video")
            
            
            
        }
        toggleButton(button: videoFirst, onImage:  #imageLiteral(resourceName: "video select1"), offImage:  #imageLiteral(resourceName: "video select1"))
        toggleButton(button: videoSecond, onImage: #imageLiteral(resourceName: "video unselect1"), offImage: #imageLiteral(resourceName: "video unselect1"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
   
        
        
    }
    
    
    @IBAction func videoTwo(_ sender: Any) {
        
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
        toggleButton(button: videoFirst, onImage: #imageLiteral(resourceName: "video unselect1"), offImage: #imageLiteral(resourceName: "video unselect1"))
        toggleButton(button: videoSecond, onImage: #imageLiteral(resourceName: "video select1"), offImage: #imageLiteral(resourceName: "video select1"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")

        
        
        
    }
    
    @IBAction func volumePressed(_ sender: Any) {
        if self.volumePopup.isHidden == true {
            
            volumePopup.isHidden = false
            
            videoControlpopup.isHidden = true
            infoPopupview.isHidden = true
            fireOnoff.isHidden = true
            videoSelectview.isHidden = true

//            musicView.isHidden = true
            
            
        } else {
            
            volumePopup.isHidden = true
            
        }

    }
    @IBAction func videoSelectBtnpressed(_ sender: Any) {
        
        if self.videoSelectview.isHidden == true {
            
            videoSelectview.isHidden = false
            volumePopup.isHidden = true
            videoControlpopup.isHidden = true
            infoPopupview.isHidden = true
            fireOnoff.isHidden = true
            
            
        } else {
            
            videoSelectview.isHidden = true

        
        
    }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
        avPlayer?.pause()
        player.pause()
        paused = true
    }
    
    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .clear
        
        
    }
    
    func willEnterForeground() {
        
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
//            do {
//                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//            } catch _ {
//            }

            
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
        player.volume = volumeControl
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

        
        
        
        UserDefaults.standard.set("fire1", forKey: "music")
        toggleButton(button: music1Btn, onImage: #imageLiteral(resourceName: "music select-4"), offImage: #imageLiteral(resourceName: "music select-4"))
        toggleButton(button: music2Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        
        toggleButton(button: music3Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
        fireCrackingOnoffsound.setTitle("on", for: .normal)
       
    }
    
    @IBAction func music2(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "fire2", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.volume = player.volume
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
         player.volume = volumeControl
        
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

        
        
        
        UserDefaults.standard.set("fire2", forKey: "music")
        
        toggleButton(button: music2Btn, onImage: #imageLiteral(resourceName: "music select-4"), offImage: #imageLiteral(resourceName: "music select-4"))

        toggleButton(button: music1Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage:#imageLiteral(resourceName: "music unselect-4") )
        
        toggleButton(button: music3Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
        
        fireCrackingOnoffsound.setTitle("on", for: .normal)
    }
    
   
    @IBAction func music3(_ sender: UIButton) {
    
        
        let path = Bundle.main.path(forResource: "fire3", ofType: "mp3")
        let filePath = NSURL(fileURLWithPath:path!)
        player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        player.volume = player.volume
        player.numberOfLoops = -1 //logic for infinite loop
        player.prepareToPlay()
        player.play()
         player.volume = volumeControl
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

        
        toggleButton(button: music2Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        
        toggleButton(button: music1Btn, onImage: #imageLiteral(resourceName: "music unselect-4"), offImage: #imageLiteral(resourceName: "music unselect-4"))
        
        toggleButton(button: music3Btn, onImage: #imageLiteral(resourceName: "music select-4"), offImage: #imageLiteral(resourceName: "music select-4"))
        
        UserDefaults.standard.set("fire3", forKey: "music")
        
        
        
       
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "InstructionsButtonIsHidden")
        
        fireCrackingOnoffsound.setTitle("on", for: .normal)
        
    }
    
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleButton(button: UIButton, onImage: UIImage, offImage: UIImage ){
        
        if button.currentImage == offImage{
            
            button.setImage(onImage, for: .normal)
        }else{
            
            button.setImage(offImage, for: .normal)
        }
        
    }

    
    
    @IBAction func normalPressed(_ sender: Any) {
        speedtype = "normals"
        if videotype == "1" {
       
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: "normalnewest", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
        
        playerView.play()
        
        UserDefaults.standard.set("normalnewest", forKey: "video")
        
//        playVideoWithURL.rate = 1.0
   
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
        let videoPlayer: String = bundle.path(forResource: "fasternew", ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        let videoAssetURL = AVURLAsset(url: movieUrl as URL)
        let videoAssetItem = AVPlayerItem(asset: videoAssetURL)
        playerView.replaceCurrentItem(with: videoAssetItem)
        
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,object: self.playerView.currentItem)
        
        playerView.play()
        
        UserDefaults.standard.set("fasternew", forKey: "video")
        
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
    
    
    @IBAction func volumeUppressed(_ sender: Any) {
        
        if player.volume < 1.0 {
    
            player.volume = player.volume + 0.1
            print(player.volume)
            volumeControl = player.volume
            
        }
        
            
    }
    
   
    @IBAction func volumeDownpressed(_ sender: Any) {
        
        if player.volume >= 0.1 {

        
            player.volume = player.volume - 0.1
            print(player.volume)
            volumeControl = player.volume
            
        }
        
    }
    
    @IBAction func btnhideshowPressed(_ sender: UIButton) {
        
                if self.viewupDown.isHidden {
            
                        self.viewupDown.isHidden = false
            
                    } else {
            
                        self.viewupDown.isHidden = true
            
                        self.videoControlpopup.isHidden = true
                        self.infoPopupview.isHidden = true
                        self.volumePopup.isHidden = true
                        self.fireOnoff.isHidden = true
                        self.musicView.isHidden = true
                        
                        
                        
                    }
        
    }
    
    
    func swipedDown(sender:UITapGestureRecognizer){
        NSLog("It worked")
        
        if self.viewupDown.isHidden {
            
            self.viewupDown.isHidden = false
            
        } else {
            
            self.viewupDown.isHidden = true
            
            self.videoControlpopup.isHidden = true
            self.infoPopupview.isHidden = true
            self.volumePopup.isHidden = true
            self.musicView.isHidden = true
            
            
            
        }

    }
    
    func playerItemDidReachEnd() {
        self.playerView.seek(to: kCMTimeZero)
        self.playerView.play()
    }
//    func handleTap(sender: UITapGestureRecognizer) {
//        
//        
//    }
    
    

       /**************** sound setup for playing background music ***********/
    
    func SetUpSound() {
        
        if let path = Bundle.main.path(forResource: "fire1", ofType: "mp3") {
            let filePath = NSURL(fileURLWithPath:path)
            player = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            player.numberOfLoops = -1 //logic for infinite loop
            player.prepareToPlay()
            player.play()
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
//        do {
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
//        } catch _ {
//        }

    }
    
    
   

   }
