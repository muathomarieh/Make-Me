//
//  PomodoroAudio.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import Foundation
import AVFoundation

enum PomodoroAudioSounds: String {
    case done = "bell.wav"
    case tick = "tick.wav"
}

class PomodoroAudio {
    
    private var audioPlayer: AVAudioPlayer?
    
    func playe(sound: PomodoroAudioSounds) {
        
        let path = Bundle.main.path(forResource: sound.rawValue, ofType: nil)!
        let url = URL(filePath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}




