//
//  PlayerView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/17/23.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var chapterVM: ChapterViewModel
    var isPreview: Bool = false
    @Binding var selectedBook: Book?
    @Binding var selectedChapter: String?
    @State private var startingValue: Double = 0.0
    @State private var isEditing: Bool = false
    @State private var isTimerView: Bool = false
    @Environment(\.dismiss) var dismiss
    
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        if selectedChapter == "" {
            Text("No chapter is selected yet. Book: \(getBookName())")
        } else {
            //Text("\(selectedBook?.name ?? "Nothing")")
            ZStack {
                Image("Book\(audioManager.currentBook)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                // Blur image
                Rectangle()
                    .backgroundStyle(.thinMaterial)
                    //.foregroundColor(.white)
                    .opacity(0.10)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    
                    Text(audioManager.currentChapter)
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // playback
                    if let player = audioManager.player {
                        VStack(spacing: 5) {
                            // playback timeline
                            Slider(value: $startingValue, in: 0...player.duration) { editing in
                                isEditing = editing
                                if !editing {
                                    player.currentTime = startingValue
                                }
                            }
                            .accentColor(.white)
                            // playback time
                            HStack {
                                Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                                Spacer()
                                Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00") // change this later
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            
                        }
                        // Playback controll
                        HStack {
                            let color: Color = audioManager.isLooping ? .teal : .white
                            // repeat button
                            PlaybackControlButton(systemName: "repeat", color: color) {
                                // action
                                audioManager.toggleLoop()
                            }
                            Spacer()
                            
                            PlaybackControlButton(systemName: "backward.end.fill") {
                                // action
                                audioManager.playPrevious()
                                selectedBook = books[audioManager.currentBook - 1]
                                selectedChapter = audioManager.currentChapter
                            }
                            Spacer()
                            
                            PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                                // action
                                audioManager.playPause()
                            }
                            Spacer()
                            
                            PlaybackControlButton(systemName: "forward.end.fill") {
                                // action
                                audioManager.playNext()
                                selectedBook = books[audioManager.currentBook - 1]
                                selectedChapter = audioManager.currentChapter
                            }
                            Spacer()
                            // repeat button
                            PlaybackControlButton(systemName: "timer", color: audioManager.sleepTimer > 0 ? .green : .white) {
                                // action
                                isTimerView = true
                            }
                        }
                    }
                }
                .padding(20)
            }
            .onAppear{
                if let bookNumber = selectedBook?.id {
                    audioManager.currentBook = bookNumber
                }
                if let chapterName = selectedChapter {
                    audioManager.currentChapter = chapterName
                }
                // reset chapter list
                audioManager.chapters = chapterVM.chapters
                
                audioManager.startPlayer(track: selectedChapter!, isPreview: isPreview, book: selectedBook!)
            }
            .onReceive(timer) { _ in
                guard let player = audioManager.player, !isEditing else { return }
                startingValue = player.currentTime
            }
            .fullScreenCover(isPresented: $isTimerView, content: {
                TimerSelectView().environmentObject(audioManager)
            })
        }
    }
    
    func getBookName() -> String {
        if let book = self.selectedBook {
            return "Book\(book.id)"
        }
        return ""
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let chapterVM = ChapterViewModel(chapter: Chapter.data, chapters: [])
    
    static var previews: some View {
        PlayerView(chapterVM: chapterVM, isPreview: true, selectedBook: .constant(books[0]), selectedChapter: .constant("CH01 THE BOY WHO LIVED"))
            .environmentObject(AudioManager())
    }
}
