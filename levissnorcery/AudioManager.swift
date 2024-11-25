//
//  AudioManager.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 5/1/23.
//

import Foundation
import AVKit

final class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isLooping: Bool = false
    @Published var currentChapter: String = ""
    @Published var currentBook: Int = 0
    @Published var chapters: [String] = []
    @Published private(set) var sleepTimer: Int = -1
    
    func startPlayer(track: String, isPreview: Bool = false, book: Book) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3", subdirectory: "audios/book\(book.id)") else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            // playback ignores silent mode
            // default mode only includes audio not involing any recording audio or chats
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
                currentChapter = track
                currentBook = book.id
            }
        } catch {
            print("Failed to initialize player", error)
        }
    }
    
    func playPause() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func stop() {
        guard let player = player else { return }
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func toggleLoop() {
        guard let player = player else { return }
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        sleepTimer -= 1
        if sleepTimer == 0 {
            player.stop()
            isPlaying = false
        } else { // if sleep timer != 0, it means the timer is not set, and it will continue to play the next chapter until the user stops it manually
            playNext()
        }
    }
    
    func playNext() {
        if var chapterIndex = chapters.firstIndex(of: currentChapter) {
            if chapterIndex + 1 < chapters.count {
                chapterIndex += 1
            } else {
                // jump to the next book and the first chapter of the next book
                chapterIndex = 0
                // get a list of new chapters as well
                
                if currentBook + 1 <= books.count {
                    currentBook += 1
                } else { // go back to the first book
                    currentBook = 1
                }
            }
            chapters = getChapters(bookNumber: "book\(currentBook)")
            currentChapter = chapters[chapterIndex]
            
            guard let url = Bundle.main.url(forResource: currentChapter, withExtension: "mp3", subdirectory: "audios/book\(currentBook)") else {
                print("Resource not found: \(currentChapter)")
                return
            }
            
            playTrack(url: url)
        }
    }
    
    func playPrevious() {
        if var chapterIndex = chapters.firstIndex(of: currentChapter) {
            if chapterIndex - 1 >= 0 {
                chapterIndex -= 1
            } else {
                // jump to the last chapter of the previous book
                if currentBook - 1 > 0 {
                    currentBook -= 1
                    chapters = getChapters(bookNumber: "book\(currentBook)")
                    chapterIndex = chapters.count - 1
                } else { // first chapter of the first book
                    currentBook = 1
                    chapters = getChapters(bookNumber: "book\(currentBook)")
                    chapterIndex = 0
                }
            }
            currentChapter = chapters[chapterIndex]
            
            guard let url = Bundle.main.url(forResource: currentChapter, withExtension: "mp3", subdirectory: "audios/book\(currentBook)") else {
                print("Resource not found: \(currentChapter)")
                return
            }
            
            playTrack(url: url)
        }
    }
    
    func playTrack(url: URL) {
        do {
            // playback ignores silent mode
            // default mode only includes audio not involing any recording audio or chats
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            
            player?.play()
            isPlaying = true
        } catch {
            print("Failed to initialize player", error)
        }
    }
    
    func setTimer(chap: Int) {
        sleepTimer = chap
    }
}
