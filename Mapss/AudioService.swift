//
//  AudioService.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import AVFoundation

class AudioService: NSObject {
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "alarm.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

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

extension Bundle {
    static func loadFileFromBundle(_ filename: String) -> URL? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "mp3") else { return nil }
        return URL(fileURLWithPath: path)
    }
}
