//
//  Copyright © 2017년 INKA ENTWORKS INC. All rights reserved.
//
//  PallyCon Team (http://www.pallycon.com)
//
//  A PlaybackManager class handles playback in the AVPlayerViewController.
//


import UIKit
import AVFoundation
import MediaPlayer

class PlaybackManager: NSObject {
    // MARK: Properties
    
    /// Singleton for playbackManager.
    static let sharedManager = PlaybackManager()
    
    private var observerContext = 0
    
    weak var delegate: PlaybackDelegate?
    
    /// The instance of AVPlayer that will be used for playback of PlaybackManager.playerItem.
    private let player = AVPlayer()
    
    /// A Bool tracking if the AVPlayerItem.status has changed to .readyToPlay for the current PlaybackManager.playerItem.
    private var readyForPlayback = false
    
    private let notificationCenter = NotificationCenter.default
    
    /// The AVPlayerItem associated with PlaybackManager.urlAsset
    private var playerItem: AVPlayerItem? {
        willSet {
            playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: &observerContext)
            notificationCenter.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil)
        }
        
        didSet {
            playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.initial, .new], context: &observerContext)
            notificationCenter.addObserver(self, selector: #selector(addMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        }
    }
    
    /// The Asset that is currently being loaded for playback.
    private var content: AVAsset? {
        willSet {
            content?.removeObserver(self, forKeyPath: #keyPath(AVURLAsset.isPlayable), context: &observerContext)
        }
        
        didSet {
            if let content = content {
                content.addObserver(self, forKeyPath: #keyPath(AVURLAsset.isPlayable), options: [.initial, .new], context: &observerContext)
            }
            else {
                playerItem = nil
                player.replaceCurrentItem(with: nil)
                readyForPlayback = false
            }
        }
    }
    
    // MARK: Intitialization
    
    override private init() {
        super.init()
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem), options: [.new], context: &observerContext)
    }
    
    deinit {
        player.removeObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem))
    }
    
    /**
     Replaces the currently playing `Content`, if any, with a new `Content`. If nil
     is passed, `PlaybackManager` will handle unloading the existing `Content`
     and handle KVO cleanup.
     */
    func setContentForPlayback(_ content: AVAsset?) {
        readyForPlayback = false
        self.content = content
    }
    
    func addMovedToBackground() {
        readyForPlayback = false
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &observerContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        guard let keyPath = keyPath else {
            return
        }
        
        switch keyPath {
        case #keyPath(AVURLAsset.isPlayable):
            guard let content = content, content.isPlayable == true else { return }
            playerItem = AVPlayerItem(asset: content)
            player.replaceCurrentItem(with: playerItem)
        case #keyPath(AVPlayerItem.status):
            guard let playerItem = playerItem else { return }
            
            if playerItem.status == .readyToPlay {
                if !readyForPlayback {
                    readyForPlayback = true
                    delegate?.playbackManager(self, playerReadyToPlay: player)
                }
            } else if playerItem.status == .failed {
                readyForPlayback = false
                delegate?.playbackManager(self, playerFail: player, content: self.content, error: playerItem.error)
            }
            
        case #keyPath(AVPlayer.currentItem):
            delegate?.playbackManager(self, playerCurrentItemDidChange: player)
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

/// PlaybackDelegate provides a common interface for PlaybackManager to provide callbacks to its delegate.
protocol PlaybackDelegate: class {
    
    /// This is called when the internal AVPlayer in PlaybackManager is ready to start playback.
    func playbackManager(_ playbackManager: PlaybackManager, playerReadyToPlay player: AVPlayer)
    
    /// This is called when the internal AVPlayer's currentItem has changed.
    func playbackManager(_ playbackManager: PlaybackManager, playerCurrentItemDidChange player: AVPlayer)
    
    /// This is called when the internal AVPlayer in PlaybackManager is failed to play playback
    func playbackManager(_ playbackManager: PlaybackManager, playerFail player: AVPlayer, content: AVAsset?, error: Error?)
}
