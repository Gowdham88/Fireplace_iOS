//
//  videoPlay.swift
//  videodemo
//
//  Created by Paramesh on 08/02/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import AVFoundation



class VideoPlay: UIView {
    
    
    private var player : AVPlayer!
    
    private var playerLayer : AVPlayerLayer!
    
    init() {
        
        super.init(frame: CGRect.zero)
        self.initializePlayerLayer()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializePlayerLayer()
        self.autoresizesSubviews = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializePlayerLayer()
        
    }
    
    
    
    private func initializePlayerLayer() {
        
        playerLayer = AVPlayerLayer()
        playerLayer.backgroundColor = UIColor.clear.cgColor

      

        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        

        self.layer.addSublayer(playerLayer)
      
        playerLayer.frame = UIScreen.main.bounds
        
        
    }
    
    func playVideoWithURL(url: NSURL) {
        
        player = AVPlayer(url: url as URL)
        player.isMuted = false
        
        playerLayer.player = player
        
        player.play()
        
        loopVideo(videoPlayer: player)
    }
    
    func toggleMute() {
        player.isMuted = !player.isMuted
    }
    
    func isMuted() -> Bool
    {
        return player.isMuted
    }
    
    func loopVideo(videoPlayer: AVPlayer) {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            let t1 = CMTimeMake(5, 100);
            self.player.seek(to: t1)
            videoPlayer.seek(to: kCMTimeZero)
            self.player.play()
        }
    }
    
}
