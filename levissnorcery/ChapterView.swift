//
//  ChapterView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/18/23.
//

import SwiftUI

struct ChapterView: View {
    @StateObject var chapterVM: ChapterViewModel
    @Binding var selectedBook: Book?
    @State private var selectedChapter: String?
    @State private var showPlayer = false
    
    var body: some View {
        VStack{
            Text(selectedBook?.name ?? "No book is selected.")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            List(chapterVM.chapters, id: \.self) {
                chapter in
                HStack {
                    Text(chapter)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedChapter = chapter
                    showPlayer = true
                }
            }
        }
        .fullScreenCover(isPresented: $showPlayer, content: {
            PlayerView(chapterVM: chapterVM, selectedBook: $selectedBook, selectedChapter: $selectedChapter)
        })
    }
}

struct ChapterView_Previews: PreviewProvider {
    static let chapterVM = ChapterViewModel(chapter: Chapter.data, chapters: ["CH01 THE BOY WHO LIVED", "CH02 THE VANISHING GLASS", "CH03 THE LETTERS FROM NO ONE", "CH04 THE KEEPER OF THE KEYS"])
    static var previews: some View {
        //ChapterView(chapterVM: chapterVM, selectedBook: .constant(books[0]), selectedChapter: "")
        ChapterView(chapterVM: chapterVM, selectedBook: .constant(books[0]))
            .environmentObject(AudioManager())
    }
}
