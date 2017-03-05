//
//  ViewController.swift
//  FireplayTV
//
//  Created by Mac on 2/12/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//


import UIKit
import AVKit
import AVFoundation
import CoreImage

class tvOsViewController: UIViewController {

//   
    //@IBOutlet var forwardSlider: UIView!
   // @IBOutlet var videoView: VideoPlay!
//    @IBOutlet var popView1: UIView!
//   
//    @IBOutlet var flamespeedLabel: UILabel!
//    @IBOutlet var brightLabel: UILabel!
//    @IBOutlet var slowlabel: UILabel!
//    @IBOutlet var normallabel: UILabel!
//    @IBOutlet var fastlabel: UILabel!
//    @IBOutlet var oneHour: UIButton!
//    @IBOutlet var timerMin: UIButton!
//    @IBOutlet var fiveHour: UIButton!
//    @IBOutlet var threeHour: UIButton!
//    @IBOutlet var viewUpdownn: UIView!
//    @IBOutlet var downBtn: UIButton!
//    @IBOutlet var upBtnn: UIButton!
    
    
    
    @IBOutlet var videoView: VideoPlay!
    
    @IBOutlet var menuView: UIView!
    
    @IBOutlet var mainMenu: UIButton!
    
    @IBOutlet var volumeBtn: UIButton!
    
    @IBOutlet var speedBtn: UIButton!
    
    @IBOutlet var soundBtn: UIButton!
    
//    
//    var fastBtncenter: CGPoint!
//    var fireBtncenter: CGPoint!
//    var infoBtncenter: CGPoint!
//    var volumeBtncenter: CGPoint!
//    
//    var appBrightness = CGFloat()
//    let prefs = UserDefaults.standard
//    
//    var avPlayerLayer: AVPlayerLayer!
//    var paused: Bool = false
//    
//    var player:AVAudioPlayer = AVAudioPlayer()
//    var avPlayer: AVPlayer!

    
    
    @IBAction func playCrackle(_ sender: Any) {
                if player.isPlaying {
        
                    player.pause()
        
                } else {
        
                    player.numberOfLoops = -1
                    player.play()
                    
                }
    }
    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    //private var brightness: CGFloat?
    //var scale: Float = 0
    //let maxScale: Float = 1
//    var brightness = CGFloat()
//    var appBrightness = CGFloat()
//    let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//       self.videoView.addGestureRecognizer(tapGesture)
//
//        self.SetUpSound()
       // popView1.isHidden = true
       menuView.isHidden = false
         playmyVideo(myString: "normal")

        }
    func playmyVideo(myString: String) {
        
        
        
        //videoPlayer.URL = Bundle.main.url(forResource: myString, withExtension: "mp4")!
        
        // NSURL(string: "http://uploadingit.com/file/pkgz6mplwtodlzl6/Mac%20OS%20X%20Snow%20Leopard%20Intro%20Movie%20HD.mp4") as URL?
        
        let bundle: Bundle = Bundle.main
        let videoPlayer: String = bundle.path(forResource: myString, ofType: "mp4")!
        let movieUrl : NSURL = NSURL.fileURL(withPath: videoPlayer) as NSURL
        
        videoView.playVideoWithURL(url: movieUrl)
        
        
    }
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
        override func viewDidDisappear(_ animated: Bool) {
    
            avPlayer.pause()
            player.pause()
            paused = true
    
    
            
        }

    
    
    
    
    //    @IBAction func speedBtn(_ sender: Any) {
    
        
       // self.popView1.layer.borderWidth = 1.0
        //self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
//        popView1.layer.cornerRadius = 15
//       
//        timerMin.isHidden = true
//        oneHour.isHidden = true
//        threeHour.isHidden = true
//        fiveHour.isHidden = true
//        
//        if popView1.isHidden == true {
//            
//            flamespeedLabel.isHidden = false
//            forwardSlider.isHidden = false
//            popView1.isHidden = false
//             brightLabel.isHidden = true
//            downBtn.isHidden = true
//            upBtnn.isHidden = true
       
//        } else {
//            
//            popView1.isHidden = true
//            forwardSlider.isHidden = true
//            flamespeedLabel.isHidden = true
//        }

        
    }
//    

//
//    func handleTap(sender: UITapGestureRecognizer) {
//        
//        if self.menuView.isHidden {
//            
//            menuView.isHidden = true
//             //popView1.isHidden = true
//        }else{
//            
//           menuView.isHidden = false
//        
//        }
//        
//    }



//

//
//    @IBAction func slowBtn(_ sender: Any) {
//    
////    @IBAction func slowBtn(_ sender: Any) {
//        
//        slowlabel.text = "Slow"
//        
//        playmyVideo(myString: "slow00")
//        
//        
//    }
////    @IBAction func normalBtn(_ sender: Any) 
//    @IBAction func normalBtn(_ sender: Any) {
//    
//    
//    
//        normallabel.text = "Normal"
//        playmyVideo(myString: "normal")
//        
//        
//    }
//   
//        @IBAction func fastBtn(_ sender: Any) {
//        
//        
//        fastlabel.text = "Fast"
//        playmyVideo(myString: "fast")
//        
//    }

//
//
//}
















