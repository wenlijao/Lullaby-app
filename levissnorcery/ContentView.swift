//
//  ContentView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/17/23.
//

import SwiftUI



struct ContentView: View {
    @State private var selectedBook: Book? = nil
    @State private var selectedChapter: String? = ""
    
    var body: some View {
        /*TabView{
            HomeView(selectedBook: $selectedBook, selectedChapter: $selectedChapter)
                .tabItem{
                    Image(systemName: "book.fill")
                    Text("Home")
                }
            PlayerView(chapterVM: ChapterViewModel(chapter: Chapter.data, chapters: getChapters(bookNumber: "book\(getBookNumber(selectedBook: selectedBook!))")), selectedBook: $selectedBook, selectedChapter: $selectedChapter)
                .tabItem{
                    Image(systemName: "play.square.stack.fill")
                    Text("Play")
                }
        }*/
        HomeView(selectedBook: $selectedBook, selectedChapter: $selectedChapter)
        //.overlay(selectedChapter != "" ? MiniPlayerView() : nil)
        //.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioManager())
    }
}

