//
//  GSAudio.swift
//  Komorebi
//
//  Created by riccardo ruocco on 22/11/21.
//

import Foundation
import AVFoundation

import Foundation
import AVFoundation

class GSAudio: NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = GSAudio()

    private override init() { }

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    func playSound(soundFileName: String,volume:Double) {

        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "aac") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { //player for sound has been found

            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.play()
                player.volume = Float(volume)
            } else { // player is in use, create a new, duplicate, player and use that instead

                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)

                    duplicatePlayer.delegate = self
                    //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

                    duplicatePlayers.append(duplicatePlayer)
                    //add duplicate to array so it doesn't get removed from memory before finishing

                    duplicatePlayer.prepareToPlay()
                    duplicatePlayer.play()
                    duplicatePlayer.volume = Float(volume)
                } catch let error {
                    print(error.localizedDescription)
                }

            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.prepareToPlay()
                player.play()
                player.volume = Float(volume)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
    }


    func playSounds(soundFileNames: [String],volumes:[Double]) {
//        for soundFileName in soundFileNames {
//            playSound(soundFileName: soundFileName)
//        }
        
        for i in 0..<soundFileNames.count {
            playSound(soundFileName: soundFileNames[i],volume:volumes[i])
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.index(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
    func stop(){
        for i in duplicatePlayers{
            i.stop()
        }
        for i in players{
            i.value.stop()
        }
    }

}
