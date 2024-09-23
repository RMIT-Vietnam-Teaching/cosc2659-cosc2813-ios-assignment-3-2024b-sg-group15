/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 15
    - Nguyen Tran Ha Anh - 3938490
    - Bui Tuan Anh - 3970375
    - Nguyen Ha Kieu Anh - 3818552
    - Truong Hong Van - 3957034
  Created  date: 08/09/2024
  Last modified: 23/09/2024
*/

import SwiftUI
import AVFoundation

// A singleton class to manage sound playback in a SwiftUI app
class SoundManager: ObservableObject {
    // Singleton instance
    static let shared = SoundManager()
    
    // Audio players for different sounds
    private var backgroundPlayer: AVAudioPlayer?
    private var correctSoundPlayer: AVAudioPlayer?
    private var failSoundPlayer: AVAudioPlayer?
    
    // Private initializer to ensure singleton usage
    private init() {
        setupPlayers()
    }
    
    // Sets up all audio players
    private func setupPlayers() {
        // Setup background music player
        if let backgroundURL = Bundle.main.url(forResource: "background", withExtension: "mp3") {
            backgroundPlayer = try? AVAudioPlayer(contentsOf: backgroundURL)
            backgroundPlayer?.numberOfLoops = -1 // Loop indefinitely
        }
        
        // Setup correct sound player
        if let correctURL = Bundle.main.url(forResource: "correct", withExtension: "wav") {
            correctSoundPlayer = try? AVAudioPlayer(contentsOf: correctURL)
        }
        
        // Setup fail sound player
        if let failURL = Bundle.main.url(forResource: "fail", withExtension: "wav") {
            failSoundPlayer = try? AVAudioPlayer(contentsOf: failURL)
        }
    }
    
    // Plays the background music
    func playBackground() {
        backgroundPlayer?.play()
    }
    
    // Stops the background music
    func stopBackground() {
        backgroundPlayer?.stop()
    }
    
    // Plays the correct sound effect
    func correctSound() {
        correctSoundPlayer?.play()
    }
    
    // Plays the fail sound effect
    func failSound() {
        failSoundPlayer?.play()
    }
}
