//
//  ViewController.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate {

    
  
    var player:AVAudioPlayer = AVAudioPlayer()
   
    @IBOutlet weak var viewUpdown: UIView!
    
    
    @IBOutlet weak var brightness: UILabel!
   
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var popView1: UIView!
   
    @IBOutlet weak var myImages: UIImageView!
    @IBOutlet weak var uiSlider: UISlider!

   
    @IBOutlet weak var slidervalue: UILabel!
    
    
   var mygifNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    
    var mygifNames1 = ["image36", "image37", "image38", "image39", "image40", "image41", "image42", "image43", "image44", "image45", "image46", "image47", "image48", "image49", "image50", "image51", "image52", "image53", "image54", "image55", "image56", "image57", "image58", "image59", "image60", "image61", "image62", "image63", "image64", "image65", "image66", "image67", "image68", "image69", "image70"]
    
//    var mygifNames2 = ["11","22","33","44","55"]
    
    //, "image36", "image37", "image38", "image39", "image40", "image41", "image42", "image43", "image44", "image45", "image46", "image47", "image48", "image49", "image50", "image51", "image52", "image53", "image54", "image55", "image56", "image57", "image58", "image59", "image60", "image61", "image62", "image63", "image64", "image65", "image66", "image67", "image68", "image69", "image70", "image71", "image72", "image73", "image74", "image75", "image76", "image77", "image78", "image79", "image80", "image81", "image82", "image83", "image84", "image85", "image86", "image87", "image88", "image89", "image90", "image91", "image92", "image93", "image94", "image95", "image96", "image97", "image98", "image99", "image100"
    
    //, "image101", "image102", "image103", "image104", "image105", "image106", "image107", "image108", "image109", "image110", "image111", "image112", "image113", "image114", "image115", "image116", "image117", "image118", "image119", "image120", "image121", "image122", "image123", "image124", "image125", "image126", "image127", "image128", "image129", "image130", "image131", "image132", "image133", "image134", "image135", "image136", "image137", "image138", "image139", "image140", "image141", "image142", "image143", "image144", "image145", "image146", "image147", "image148", "image149", "image150", "image151", "image152", "image153", "image154", "image155", "image156", "image157", "image158", "image159", "image160", "image161", "image162", "image163", "image164", "image165", "image166", "image167", "image168", "image169", "image170", "image171", "image172", "image173", "image174", "image175", "image176", "image177", "image178", "image179", "image180", "image181", "image182", "image183", "image184", "image185", "image186", "image187", "image188", "image189", "image190", "image191", "image192", "image193", "image194", "image195", "image196", "image197", "image198", "image199", "image200"]
   
    
    
    
    var mygif = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.viewUpdown.isHidden = true
        
        popView.isHidden = true
        popView1.isHidden = true
        /******************** Gif image *************/
        
        
        for i in 0..<mygifNames.count{
            
            
            mygif.append(UIImage(named: mygifNames[i])!)
            
        }
        
        myImages.animationImages = mygif
        myImages.animationDuration = 2.20
        self.myImages.startAnimating()
        
        
        
        
       

        /******************** Background music *************/
        
//        do{
//            
//            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "firecrack", ofType: "mp3")!))
//            
//            player.prepareToPlay()
//        }
//        catch{
//            
//            print(error)
//        }
//        player.numberOfLoops = -1
//        player.play()
        
        
         UIScreen.main.brightness = CGFloat(0.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        myImages.addGestureRecognizer(tapGesture)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.SetUpSound()
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if self.viewUpdown.isHidden{
          self.viewUpdown.isHidden = false
            
        }
        else{
            self.viewUpdown.isHidden = true
            
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
        }
        else{
        player.numberOfLoops = -1
        player.play()
            
        }
        
        
    }
   
    @IBAction func fastForward(_ sender: Any) {
        
        if popView.isHidden{
            popView.isHidden = false
            popView1.isHidden = true
        }
            else{
            popView.isHidden = true
                
            }
        self.popView.layer.borderWidth = 1.0
        self.popView.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
       popView.layer.cornerRadius = 15
    }
  
       

    @IBAction func slider(_ sender: UISlider) {
        
        
        if sender.value > -4 && sender.value < 0 {
            
            mygif.removeAll()
            
            
            for i in 0..<mygifNames.count{
                
                
                mygif.append(UIImage(named: mygifNames[i])!)
                
            }
         
            myImages.animationImages = mygif
            let selectValue = Float(10.0 - sender.value)
            myImages.animationDuration = TimeInterval(selectValue)
            self.myImages.startAnimating()
            
        } else if sender.value > 0 && sender.value < 10 {
            
            mygif.removeAll()
            for i in 0..<mygifNames1.count{
                
                
                mygif.append(UIImage(named: mygifNames1[i])!)
                
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
        
        
    
    }
    
    @IBAction func bright(_ sender: UIButton) {
        if popView1.isHidden{
            popView1.isHidden = false
            popView.isHidden = true
        }
        else{
            popView1.isHidden = true
            
        }
        

        self.popView1.layer.borderWidth = 1.0
        self.popView1.layer.borderColor = UIColor(red:216/255.0, green:216/255.0, blue:216/255.0, alpha: 1.0).cgColor
   
     popView1.layer.cornerRadius = 15
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















