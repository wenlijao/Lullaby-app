//
//  HomeView.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/17/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedBook: Book?
    @Binding var selectedChapter: String?
    
    var body: some View {
        NavigationStack{
            List(books, id: \.self, selection: $selectedBook) { book in
                NavigationLink(value: book.id, label: {
                    HomeDetailView(currentBook: book)
                })
            }
            .navigationDestination(for: Int.self) { bookNumber in
                //ChapterView(selectedBook: $selectedBook, selectedChapter: "")
                ChapterView(chapterVM: ChapterViewModel(chapter: Chapter.data, chapters: getChapters(bookNumber: "book\(getBookNumber(selectedBook: selectedBook!))")), selectedBook: $selectedBook)
                //Text(selectedBook?.name ?? "no book")
            }
            .navigationTitle("Books")
        }
    }
}

struct HomeDetailView: View {
    let currentBook: Book
    
    var body: some View {
        HStack {
            Image("Book\(currentBook.id)")
            Text(currentBook.name)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedBook: .constant(nil), selectedChapter: .constant(""))
            .environmentObject(AudioManager())
        //HomeView(selectedBook: .constant(nil))
    }
}
