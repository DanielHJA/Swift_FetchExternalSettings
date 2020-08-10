//
//  AudioService.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import AVFoundation

enum Sound: String {
    case alarm = "alarm.mp3"
    
    var url: URL? {
        guard let path = Bundle.main.path(forResource: self.rawValue, ofType: nil) else { return nil }
        return URL(fileURLWithPath: path)
    }
    
}

class AudioService: NSObject {
    static let shared = AudioService()
    override private init() { } 
    
    var player: AVAudioPlayer?
    
    func playSound(_ sound: Sound) {
        guard let url = sound.url else { return }

        do {
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error)
        }
    }
    
    func stopSound() {
        player?.stop()
        player = nil
    }
    
//    class func play(_ soundID: SystemSoundID = 1016) {
//        AudioServicesPlaySystemSound(soundID)
//    }
    
}
