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

class ViewController: UIViewController, UINavigationControllerDelegate, VideoPlayerDelegate {

    @IBOutlet weak var dummyView: UIView!
  var videoPlayer : VideoPlayer?
    var player:AVAudioPlayer = AVAudioPlayer()
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false

    @IBOutlet weak var viewUpdown: UIView!
    @IBOutlet weak var brightness: UILabel!
    @IBOutlet weak var popView1: UIView!
    @IBOutlet weak var sliderStep: G8SliderStep!
    @IBOutlet weak var brightnessSlider: UISlider!

    var appBrightness = CGFloat()
    let prefs = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let deviceBrightness = UIScreen.main.brightness

        prefs.set(deviceBrightness, forKey: "DeviceBrightness")

        //prefs.set(appBrightness, forKey: "appBrightness")
        if let appBrightness1 = prefs.value(forKey: "appBrightness") {

            UIScreen.main.brightness = appBrightness1 as! CGFloat

            brightnessSlider.value = Float(UIScreen.main.brightness)
        }

        self.viewUpdown.isHidden = true
        //popView1.isHidden = true
        sliderStep.isHidden = true
        brightnessSlider.isHidden = true

        sliderStep.stepImages = [UIImage(named:"forward")!, UIImage(named:"forward")!, UIImage(named:"forward")!]

        sliderStep.tickTitles = ["SLOW", "NORMAL", "FAST"]

        sliderStep.minimumValue = 2
        sliderStep.maximumValue = Float(sliderStep.stepImages!.count) + sliderStep.minimumValue - 1.0
        sliderStep.trackColor = UIColor.darkGray
        sliderStep.stepTickColor = UIColor.orange
        sliderStep.stepTickWidth = 30
        sliderStep.stepTickHeight = 30
        sliderStep.trackHeight = 10
        sliderStep.value = 3
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

        //self.view.addGestureRecognizer(tapGesture)
        self.dummyView.addGestureRecognizer(tapGesture)

        self.SetUpSound()

        playmyVideo(myString: "normal")
        //flamespeed(speed: "normal")


    }

    func playmyVideo(myString: String) {


        var videoPlayer = VideoPlayer(frame: .zero)
        self.view!.addSubview(videoPlayer)
        self.videoPlayer = videoPlayer

        videoPlayer.URL = Bundle.main.url(forResource: myString, withExtension: "mp4")!

        //NSURL(string: "http://uploadingit.com/file/pkgz6mplwtodlzl6/Mac%20OS%20X%20Snow%20Leopard%20Intro%20Movie%20HD.mp4") as URL?

        videoPlayer.endAction = VideoPlayerEndAction.loop
        
        videoPlayer.play()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer)

        
        
    }




    func videoPlayer(_ videoPlayer: VideoPlayer, changedState: VideoPlayerState) {



    }

    func videoPlayer(_ videoPlayer: VideoPlayer, encounteredError: NSError) {

        UIAlertView(title: "Error", message: encounteredError.localizedDescription, delegate: nil, cancelButtonTitle: "Dismiss").show()
        
    }


    /*func flamespeed(speed: String) {

        avPlayer = AVPlayer()
        avPlayerLayer = AVPlayerLayer()
        print("speed: \(speed)")

        var theURL: URL = Bundle.main.url(forResource: speed, withExtension: "mp4")!

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

    */

    func playerItemDidReachEnd(notification: NSNotification) {
        let p: VideoPlayer = notification.object as! VideoPlayer
        //p.seek(to: kCMTimeZero)
        p.play()
    }

    override func viewDidAppear(_ animated: Bool) {

//        player.play()
//        avPlayer.play()
//        paused = false

    }
    @IBAction func flamesspeedSlider(_ sender: UISlider) {

        print("Flames slider sender.value\(sender.value)")

        if sender.value < 2.5 {

            // flamespeed(speed: "slow00")
            playmyVideo(myString: "slow00")

        } else if sender.value > 2.5 && sender.value < 3.5 {

            //flamespeed(speed: "normal")
            playmyVideo(myString: "normal")

        } else if sender.value > 3.5 {

            //flamespeed(speed: "fast")
            playmyVideo(myString: "fast")

        }
    }

    override func viewDidLayoutSubviews()  {
        super.viewDidLayoutSubviews()

        //self.videoPlayer!.frame = CGRect(x: (self.view!.bounds.width - 280) / 2.0, y: (self.view!.bounds.height - 280) / 2.0, width: 280, height: 280)

        //self.videoPlayer!.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height:self.view.bounds.height)

        self.videoPlayer!.frame = view.layer.bounds
        view.backgroundColor = .clear

        view.insertSubview(videoPlayer!, at: 0)

        view.insertSubview(dummyView, at: 1)

        //videoPlayer?.layer.zPosition = 1

        //view.insertSubview(videoPlayer!, belowSubview: view)
        //videoPlayer?.sendSubview(toBack: videoPlayer!)




        /*  avPlayer = AVPlayer()
         avPlayerLayer = AVPlayerLayer()
         print("speed: \(speed)")

         var theURL: URL = Bundle.main.url(forResource: speed, withExtension: "mp4")!

         avPlayer = AVPlayer(url: theURL)
         avPlayerLayer = AVPlayerLayer(player: avPlayer)
         avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
         avPlayer.volume = 0
         avPlayer.actionAtItemEnd = .none

         avPlayerLayer.frame = view.layer.bounds
         view.backgroundColor = .clear
         view.layer.insertSublayer(avPlayerLayer, at: 0)
*/
    }



    override func viewDidDisappear(_ animated: Bool) {

        avPlayer.pause()
        player.pause()
        paused = true

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
            sliderStep.isHidden = true
            brightnessSlider.isHidden = true

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

    //UIScreen.mainScreen().setBrightness(0.5)

    @IBAction func brightnessSlider(_ sender: UISlider) {

        UIScreen.main.brightness = CGFloat(sender.value)

        appBrightness = UIScreen.main.brightness

        print("appBrightness: \(appBrightness)")

        prefs.set(appBrightness, forKey: "appBrightness")

        /*var filter = CIFilter(name: "CIColorControls");
         filter.setValue(NSNumber(float: sender.value), forKey: "inputBrightness")
         var image = self.imageView.image
         var rawimgData = CIImage(image: image)
         filter.setValue(rawimgData, forKey: "inputImage")
         var outpuImage = filter.valueForKey("outputImage")
         imageView.image = UIImage(CIImage: outpuImage as CIImage)*/
    }

    @IBAction func brightnessPressed(_ sender: UIButton) {

        brightness.text = "Brightness"
        
        self.popView1.layer.borderWidth = 1.0
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
   
     popView1.layer.cornerRadius = 15

        if popView1.isHidden == true {

            popView1.isHidden = false
            brightnessSlider.isHidden = false
            sliderStep.isHidden = true

        } else {

            //pop view not hidden

            if sliderStep.isHidden == false {

                //fast forward slider not hidden
                sliderStep.isHidden = true
                brightnessSlider.isHidden = false

            } else {

                popView1.isHidden = true
                brightnessSlider.isHidden = true
                sliderStep.isHidden = true
                
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
            sliderStep.isHidden = false

        } else {

            //pop view not hidden

            if brightnessSlider.isHidden == false {

                brightnessSlider.isHidden = true
                sliderStep.isHidden = false

            } else {

                popView1.isHidden = true
                sliderStep.isHidden = true
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
