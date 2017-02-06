//
//  VideoPlayer.swift
//  AWEasyVideoPlayer
//
//  Created by Aaron Wojnowski on 2014-06-03.
//  Copyright (c) 2014 Aaron. All rights reserved.
//

import AVFoundation
import CoreMedia
import UIKit

protocol VideoPlayerDelegate {
    
    func videoPlayer(_ videoPlayer: VideoPlayer, changedState: VideoPlayerState)
    func videoPlayer(_ videoPlayer: VideoPlayer, encounteredError: NSError)
    
}

enum VideoPlayerEndAction: Int {
    
    case stop = 1
    case loop
    
}

enum VideoPlayerState: Int {
    
    case stopped = 1
    case loading, playing, paused
    
}

class VideoPlayer: UIView {
    
    // - Getters & Setters
    
    // Public
    
    var delegate : VideoPlayerDelegate?
    
    var endAction : VideoPlayerEndAction
    var state : VideoPlayerState {
        didSet {
            
            switch (self.state) {
                case .paused, .stopped:
                    
                    self._actionButton?.removeTarget(self, action: #selector(VideoPlayer.pause), for: UIControlEvents.touchUpInside)
                    self._actionButton?.addTarget(self, action: #selector(VideoPlayer.play), for: UIControlEvents.touchUpInside)
                
                case .loading, .playing:
                    
                    self._actionButton?.removeTarget(self, action: #selector(VideoPlayer.play), for: UIControlEvents.touchUpInside)
                    self._actionButton?.addTarget(self, action: #selector(VideoPlayer.pause), for: UIControlEvents.touchUpInside)
                
            }
            
        }
    }
    
    var URL : Foundation.URL? {
        didSet {
            
            self._destroyPlayer()
            
        }
    }
    
    var volume : Float {
        didSet {
            
            if (self._player != nil) {
            
                self._player!.volume = self.volume
                
            }
            
        }
    }
    
    // Private
    
    var _player : AVPlayer?
    var _playerLayer : AVPlayerLayer?
    
    var _actionButton : UIButton?
    
    var _isBufferEmpty : Bool
    var _isLoaded : Bool
    
    // - Initializing
    
    deinit {
        
        self._destroyPlayer()
        
    }

    override init(frame: CGRect) {
        
        self.endAction = VideoPlayerEndAction.stop
        self.state = VideoPlayerState.stopped;
        self.volume = 1.0;
        
        self._isBufferEmpty = false
        self._isLoaded = false
        
        super.init(frame: frame)
        
        let actionButton : UIButton = UIButton()
        self.addSubview(actionButton)
        self._actionButton = actionButton

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - Layout
    
    override func layoutSubviews() {
        
        self._actionButton!.frame = self.bounds
        
        if ((self._playerLayer) != nil) {
            self._playerLayer!.frame = self.bounds
        }

    }
    
    
    // - Setup Player
    
    
    func _setupPlayer() {
        
        if !(self.URL != nil) {
            return;
        }
        
        self._destroyPlayer()
        
        let playerItem : AVPlayerItem = AVPlayerItem(url: self.URL!)
        
        let player : AVPlayer = AVPlayer(playerItem: playerItem)
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        player.volume = self.volume
        self._player = player;
        
        let playerLayer : AVPlayerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        self._playerLayer = playerLayer
        
        player.play()
        
        self._addObservers()
        self.setNeedsLayout()

    }

    func _destroyPlayer() {
        
        self._removeObservers();
        
        self._player = nil
        
        self._playerLayer?.removeFromSuperlayer()
        self._playerLayer = nil
        
        self._setStateNotifyingDelegate(VideoPlayerState.stopped)
        
    }
    
    // - Player Notifications
    
    func playerFailed(_ notification: Notification) {
        
        self._destroyPlayer();
        self.delegate?.videoPlayer(self, encounteredError: NSError(domain: "VideoPlayer", code: 1, userInfo: [NSLocalizedDescriptionKey : "An unknown error occured."]))
        
    }
    
    func playerPlayedToEnd(_ notification: Notification) {
        
        switch self.endAction {
            
            case .loop:
                
                self._player?.currentItem?.seek(to: kCMTimeZero)
            
            case .stop:
            
                self._destroyPlayer()
            
        }
        
    }
    
    // - Observers

    func _addObservers() {

        //self._player?.addObserver(self, forKeyPath: "rate", options: nil, context: nil)

        _player?.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(), context: nil)


        self._player?.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: NSKeyValueObservingOptions(), context: nil)
        self._player?.currentItem?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(), context: nil)

        /*NSNotificationCenter.defaultCenter().addObserverForName(
         AVPlayerItemFailedToPlayToEndTimeNotification,
         object: nil,
         queue: nil,
         usingBlock: { notification in
         self.stop()
         })*/

        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayer.playerFailed(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self._player?.currentItem)

        /*NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayer.playerFailed(_:)), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: self._player?.currentItem?)*/

        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayer.playerPlayedToEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self._player?.currentItem)

            }

    func _removeObservers() {

        self._player?.removeObserver(self, forKeyPath: "rate")
        
        self._player?.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        self._player?.currentItem?.removeObserver(self, forKeyPath: "status")
        
        NotificationCenter.default.removeObserver(self)

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {



    //override func observeValueForKeyPath(_ keyPath: String!, ofObject object: AnyObject!, change: NSDictionary!, context: CMutableVoidPointer)  {

        let obj = object as? NSObject
        if obj == self._player {
            
            if keyPath == "rate" {
                
                let rate = self._player?.rate
                if !self._isLoaded {
                    
                    self._setStateNotifyingDelegate(VideoPlayerState.loading)
                    
                } else if rate == 1.0 {
                    
                    self._setStateNotifyingDelegate(VideoPlayerState.playing)
                    
                } else if rate == 0.0 {
                    
                    if self._isBufferEmpty {
                        
                        self._setStateNotifyingDelegate(VideoPlayerState.loading)
                        
                    } else {
                        
                        self._setStateNotifyingDelegate(VideoPlayerState.paused)
                        
                    }
                    
                }
                
            }
            
        } else if obj == self._player?.currentItem {
            
            if keyPath == "status" {
                
                let status : AVPlayerItemStatus? = self._player?.currentItem?.status
                if status == AVPlayerItemStatus.failed {
                    
                    self._destroyPlayer()
                    self.delegate?.videoPlayer(self, encounteredError: NSError(domain: "VideoPlayer", code: 1, userInfo: [NSLocalizedDescriptionKey : "An unknown error occured."]))
                    
                } else if status == AVPlayerItemStatus.readyToPlay {
                    
                    self._isLoaded = true
                    self._setStateNotifyingDelegate(VideoPlayerState.playing)
                    
                }

            } else if keyPath == "playbackBufferEmpty" {

                let empty : Bool? = self._player?.currentItem?.isPlaybackBufferEmpty
                if empty! {

                    self._isBufferEmpty = true

                } else {

                    self._isBufferEmpty = false
                    
                }
                
            }
            
        }

    }

    // - Actions

    func play() {

        switch self.state {

            case VideoPlayerState.paused:

                self._player?.play()

            case VideoPlayerState.stopped:

                self._setupPlayer();

            default:
                break

        }

    }

    func pause() {

        switch self.state {

            case VideoPlayerState.playing, VideoPlayerState.loading:
                
                self._player?.pause()
            
            default:
                break
            
        }
        
    }
    
    func stop() {
        
        if (self.state == VideoPlayerState.stopped) {
            
            return
            
        }
        
        self._destroyPlayer()
        
    }
    
    // - Getters & Setters
    
    func _setStateNotifyingDelegate(_ state: VideoPlayerState) {
        
        self.state = state
        self.delegate?.videoPlayer(self, changedState: state)
        
    }

}
