//
//  SoundManager.swift
//  Day2_Intro
//
//  Created by Евгений Сердюков on 07.10.2021.
//

import Foundation
import AVKit
import SwiftUI

class SoundManager {

    static let instance = SoundManager()
    private var soundPlayer: AVAudioPlayer?

    enum SoundOption: String {
       case music
    }

    func playSound(sound: SoundOption) -> Void {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }

        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.numberOfLoops = -1
            soundPlayer?.play()
            soundPlayer?.volume = 0.1
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }

    }

}

class AdditionalSoundsEffect {

    static let instance = AdditionalSoundsEffect()
    private var soundPlayer: AVAudioPlayer?

    enum AdditionalSoundOption: String {
       case click
    }

    func playSound(sound: AdditionalSoundOption, volume: Float = 1, duration: Float? = nil, setVolume: Bool = false) -> Void {

        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }

        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
           soundPlayer?.play()

            if let x = duration {
                if setVolume {
                    soundPlayer?.setVolume(volume, fadeDuration: TimeInterval(x))
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(x)) {
                    self.soundPlayer?.stop()
                }
            } else {
                soundPlayer?.volume = volume
            }
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }

    }

}

struct GagaPlayer: UIViewControllerRepresentable {
    var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
}
