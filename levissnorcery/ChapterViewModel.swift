//
//  ChapterViewModel.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/25/23.
//

import Foundation

final class ChapterViewModel: ObservableObject {
    private(set) var chapter: Chapter
    private(set) var chapters: [String]
    
    init(chapter: Chapter, chapters: [String]) {
        self.chapter = chapter
        self.chapters = chapters
    }
}


struct Chapter {
    let id = UUID()
    let chapterTitle: String
    let duration: TimeInterval
    let track: String
    
    static let data = Chapter(chapterTitle: "CH01 THE BOY WHO LIVED", duration: 70, track: "CH01 THE BOY WHO LIVED")
}


