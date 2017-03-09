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

    @IBOutlet var videoView: VideoPlay!
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
    
    
    @IBOutlet var videoControlpopup: UIView!
    
    
//    @IBOutlet var normalBtn: UIButton!
//    @IBOutlet var forwardBtn: UIButton!
    
    
    @IBOutlet var volumePopup: UIView!

    
    
    @IBOutlet var infoPopupview: UIView!
   
    @IBOutlet var infoTextview: UITextView!
    var fastBtncenter: CGPoint!
    var fireBtncenter: CGPoint!
    var infoBtncenter: CGPoint!
    var volumeBtncenter: CGPoint!
    
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
        
        attributedString.addAttribute(NSLinkAttributeName, value: "http://arjunrai.me/", range: NSRange(location: 81, length: 10))
        
        attributedString.addAttribute(NSLinkAttributeName, value: "https://itunes.apple.com/in/genre/ios/id36?mt=8", range: NSRange(location: 4, length: 33))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: 35.0)!, range: NSRange(location: 0, length: 495))
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: 495))
        
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 35.0)!, range:NSRange(location: 4, length: 33))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 35.0)!, range:NSRange(location: 81, length: 9))
        
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold",size: 35.0)!, range:NSRange(location: 473, length: 22))
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: 495))
        
        infoTextview.attributedText = attributedString
        
        /*******************************************/

       playmyVideo(myString: "normal")
        
        
        fastBtncenter = fastBtn.center
        fireBtncenter = fireBtn.center
        infoBtncenter = infoBtn.center
        volumeBtncenter = volumeBtn.center
        
        fastBtn.center = menuBtn.center
        fireBtn.center = menuBtn.center
        infoBtn.center = menuBtn.center
        volumeBtn.center = menuBtn.center
        
//        self.viewupDown.isHidden = true

        infoPopupview.isHidden = true
        videoControlpopup.isHidden = true
        volumePopup.isHidden = true
     
        self.SetUpSound()
        player.volume = 0.5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        
        //tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.selector.rawValue)]

        self.view.addGestureRecognizer(tapRecognizer)
        self.videoView.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
   
    }
    
    
    
    
    func playmyVideo(myString: String) {
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: myString, ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        
        print(movieUrl)
        
        videoView.playVideoWithURL(url: movieUrl)
        
        
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        
        if menuBtn.currentImage == #imageLiteral(resourceName: "unmenu@1x"){
            
            UIView.animate(withDuration: 0.3, animations: {
                self.fastBtn.alpha = 1
                self.fireBtn.alpha = 1
                self.infoBtn.alpha = 1
                self.volumeBtn.alpha = 1
                
                
                self.fastBtn.center = self.fastBtncenter
                self.fireBtn.center = self.fireBtncenter
                self.infoBtn.center = self.infoBtncenter
                self.volumeBtn.center = self.volumeBtncenter
                
            })
    
    }
        else {
            
            UIView.animate(withDuration: 0.3, animations: {

                self.fastBtn.alpha = 0
                self.fireBtn.alpha = 0
                self.infoBtn.alpha = 0
                self.volumeBtn.alpha = 0
                
                self.fastBtn.center = self.menuBtn.center
                self.fireBtn.center = self.menuBtn.center
                self.infoBtn.center = self.menuBtn.center
                self.volumeBtn.center = self.menuBtn.center

                
                
            })
            
            if menuBtn.isHidden == false {
                
                videoControlpopup.isHidden = true
                infoPopupview.isHidden = true
                volumePopup.isHidden = true
            }
            
        }
        
        
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "menu"), offImage: #imageLiteral(resourceName: "unmenu@1x"))

        
    }
    
    
    
    @IBAction func fastPressed(_ sender: UIButton) {
        
        if videoControlpopup.isHidden == true{
            
            videoControlpopup.isHidden = false
            
            infoPopupview.isHidden = true
            volumePopup.isHidden = true
            
        } else {
            
            videoControlpopup.isHidden = true
            infoPopupview.isHidden = true
            volumePopup.isHidden = true
        }
        
    }
    

    @IBAction func firePressed(_ sender: UIButton) {
       
        if player.isPlaying {
            
            player.pause()
            
        } else {
            
            player.numberOfLoops = -1
            player.play()
            
        }
        
        
    }

    @IBAction func infoPressed(_ sender: UIButton) {
        
        infoPopupview.layer.cornerRadius = 30
        
        if infoPopupview.isHidden == true {
            
            infoPopupview.isHidden = false
            videoControlpopup.isHidden = true
            volumePopup.isHidden = true
            
        } else {
            
            infoPopupview.isHidden = true
            
            
        }
        
    }
    
    
    @IBAction func volumePressed(_ sender: Any) {
        if self.volumePopup.isHidden == true {
            
            volumePopup.isHidden = false
            
            videoControlpopup.isHidden = true
            infoPopupview.isHidden = true
            
            
        } else {
            
            volumePopup.isHidden = true
            
        }

    }
    override func viewDidDisappear(_ animated: Bool) {
        
        avPlayer.pause()
        player.pause()
        paused = true
    }
    
    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .clear
        
        
    }
    
    func willEnterForeground() {
        // do stuff
        
        playmyVideo(myString: "normal")
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
        
        playmyVideo(myString: "normal")
    }
    
    
    @IBAction func forwardPressed(_ sender: Any) {
        
        playmyVideo(myString: "fast")
    }
    
    
    @IBAction func volumeUppressed(_ sender: Any) {
        
        if player.volume < 1.0 {
    
            player.volume = player.volume + 0.1
            print(player.volume)
        
        }
        
            
    }
    
   
    @IBAction func volumeDownpressed(_ sender: Any) {
        
        if player.volume >= 0.1 {

        
            player.volume = player.volume - 0.1
            print(player.volume)
            
        }
        
    }
    
    
    func handleTap(sender: UITapGestureRecognizer) {
        
        if self.viewupDown.isHidden {
            
            self.viewupDown.isHidden = false
            
        } else {
            
            self.viewupDown.isHidden = true
           
            self.videoControlpopup.isHidden = true
            self.infoPopupview.isHidden = true
            self.volumePopup.isHidden = true
            
            
            
        }
        
    }

       /**************** sound setup for playing background music ***********/
    
    func SetUpSound() {
        
        if let path = Bundle.main.path(forResource: "fire", ofType: "mp3") {
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
