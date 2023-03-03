//
//  AudioManager.swift
//  AliloBunny
//
//  Created by Андрей on 19.8.22.
//

import Foundation
import UIKit
import AVFoundation

class AudioManager {
    
    enum Mode {
        case songs
        case sounds
        case englishSongs
    }
    
    private var player = AVQueuePlayer()
    private var playerItems = [AVPlayerItem]()
    private var soundMode: Mode = .sounds
    
    private let SoundsNamesArray = [
        "mixkit-cartoon-dazzle-hit-and-birds-746",
        "mixkit-cartoon-failure-piano-473",
        "mixkit-cartoon-falling-whistle-395",
        "mixkit-cartoon-fart-sound-2891",
        "mixkit-cartoon-toy-whistle-616",
        "mixkit-cartoon-voice-laugh-343",
        "mixkit-clown-horn-at-circus-715",
        "mixkit-drum-joke-accent-579",
        "mixkit-falling-male-scream-391",
        "mixkit-funny-break-engine-2944",
        "mixkit-funny-cartoon-melody-2881",
        "mixkit-happy-party-horn-sound-530",
        "mixkit-joke-drums-578",
        "mixkit-laughing-teenagers-429",
        "mixkit-metallic-boing-hit-2895",
        "mixkit-quick-funny-kiss-2193",
        "mixkit-sad-game-over-trombone-471",
    ]
    
    private let russionSongNamesArray = [
        "deti-online.com_-_pesnya-mamontenka",
        "deti-online.com_-_ulybka-kroshka-enot",
        "deti-online.com_-_bu-ra-ti-no-priklyucheniya-buratino",
        "deti-online.com_-_kaby-ne-bylo-zimy-zima-v-prostokvashino",
        "deti-online.com_-_pesenka-vinni-puha-vinni-puh-i-vse-vse-vse",
        "deti-online.com_-_pesenka-krokodila-geny-pust-begut-neuklyuzhe",
        "deti-online.com_-_pesenka-lvenka-i-cherepahi-kak-lvenok-i-cherepaha-peli-pesnyu"
    ]
    
    private let englishSongNamesArray = [
        "12345_(allmp3.su)",
        "ClassicDisney-IfYoureHappyandYouKnowIt_(allmp3.su)",
        "IfYoureHappyAndYouKnowItyourface_(allmp3.su)",
        "OldMacDonaldHadAFarm_(allmp3.su)",
        "TheMuffinMan_(allmp3.su)"
    ]
    
    private func getSounds() -> [URL?] {
        var sounds = [URL?]()
        for soundName in SoundsNamesArray {
            sounds.append(Bundle.main.url(forResource: soundName, withExtension: "wav"))
        }
        return sounds
    }
    
    private func getRussionSong()  -> [URL?] {
        var russionSons = [URL?]()
        for songName in russionSongNamesArray {
            russionSons.append(Bundle.main.url(forResource: songName, withExtension: "mp3"))
        }
        return russionSons
    }
    
    private func getEnglishSongs() -> [URL?] {
        var englishSong = [URL?]()
        for songName in englishSongNamesArray {
            englishSong.append(Bundle.main.url(forResource: songName, withExtension: "mp3"))
        }
        return englishSong
    }
    
    // MARK: cheking soundMode state
    func checkSoundMode() -> Mode {
        return soundMode
    }
    
    // MARK: updating soundMode state
    func changeSoundMode() {
        switch soundMode {
        case .sounds:
            soundMode = .songs
            play(.songs)
        case .songs:
            soundMode = .englishSongs
            play(.englishSongs)
        case .englishSongs:
            soundMode = .sounds
            play(.sounds)
        }
    }
    
    private func switchModeIfTheLastAudio() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerItems.last, queue: .main) { (notification) in
            self.changeModeAndPlayNextAudio()
            NotificationCenter.default.removeObserver(notification.name)
        }
    }
    
    // MARK: Play
    func play(_ mode: Mode) {
        switch soundMode {
        case .sounds:
            playSounds()
        case .songs:
            playSongs()
        case .englishSongs:
            playEnglishSongs()
        }
    }
    
    // MARK: Play Next
    func playNextAudio() {
        var necessaryIndex: Int?
        for item in 0..<playerItems.count {
            if player.currentItem == playerItems[item] {
                necessaryIndex = item
            }
        }
        
        if necessaryIndex != nil {
            if (necessaryIndex! + 1) < playerItems.count {
                player.advanceToNextItem()
            } else {
                changeModeAndPlayNextAudio()
            }
        }
    }
    
    func pause() {
        if player.isMuted == false {
            player.pause()
        }
    }
}

private extension AudioManager {
    
    func getSoundsItems() {
        var soundsItems = [AVPlayerItem]()
        for item in 0..<getSounds().count {
            soundsItems.append(AVPlayerItem(url: getSounds()[item]!))
        }
        playerItems = soundsItems
    }
    
    func getSongItems() {
        var songsItems = [AVPlayerItem]()
        for item in 0..<getRussionSong().count {
            songsItems.append(AVPlayerItem(url: getRussionSong()[item]!))
        }
        playerItems = songsItems
    }
    
    func getEnglishSongItems() {
        var songsItems = [AVPlayerItem]()
        for item in 0..<getEnglishSongs().count {
            songsItems.append(AVPlayerItem(url: getEnglishSongs()[item]!))
        }
        playerItems = songsItems
    }
    
    func changeModeAndPlayNextAudio() {
        switch soundMode {
        case .sounds:
            playSongs()
            soundMode = .songs
        case .songs:
            playEnglishSongs()
            soundMode = .englishSongs
        case .englishSongs:
            playSounds()
            soundMode = .sounds
        }
    }
    
    // MARK: Play Sounds
    func playSounds() {
        getSoundsItems()
        if playerItems.count > 0 {
            player = AVQueuePlayer(items: playerItems)
            player.play()
        }
        switchModeIfTheLastAudio()
    }
    
    // MARK: Play Songs
    func playSongs() {
        getSongItems()
        if playerItems.count > 0 {
            player = AVQueuePlayer(items: playerItems)
            player.play()
        }
        switchModeIfTheLastAudio()
    }
    
    // MARK: Play English Sounds
    func playEnglishSongs() {
        getEnglishSongItems()
        if playerItems.count > 0 {
            player = AVQueuePlayer(items: playerItems)
            player.play()
        }
        switchModeIfTheLastAudio()
    }
}
