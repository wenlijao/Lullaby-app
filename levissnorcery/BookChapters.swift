//
//  BookChapters.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/18/23.
//

import Foundation

struct Book: Identifiable, Hashable {
    let id: Int
    let name: String
    let chapter: String
}

let books = [ Book(id: 1, name: "Harry Potter and the Philosopher's Stone", chapter: ""),
              Book(id: 2, name: "Harry Potter and the Chamber of Secrets", chapter: ""),
              Book(id: 3, name: "Harry Potter and the Prisoner of Azkaban", chapter: ""),
              Book(id: 4, name: "Harry Potter and the Goblet of Fire", chapter: ""),
              Book(id: 5, name: "Harry Potter and the Order of the Phoenix", chapter: ""),
              Book(id: 6, name: "Harry Potter and the Half-Blood Prince", chapter: ""),
              Book(id: 7, name: "Harry Potter and the Deathly Hallows", chapter: "")
]

/*
 let books = [ Book(id: 1, name: "Harry Potter and the Philosopher's Stone", chapter: ""),
               Book(id: 2, name: "Harry Potter and the Chamber of Secrets"),
               Book(id: 3, name: "Harry Potter and the Prisoner of Azkaban"),
               Book(id: 4, name: "Harry Potter and the Goblet of Fire"),
               Book(id: 5, name: "Harry Potter and the Order of the Phoenix"),
               Book(id: 6, name: "Harry Potter and the Half-Blood Prince"),
               Book(id: 7, name: "Harry Potter and the Deathly Hallows")
 ]
 */

let chaptersInBooks = {
    
}

struct PlaybackTracking: Hashable {
}


func getChapters(bookNumber: String) -> [String]{
    if let filepath = Bundle.main.path(forResource: "\(bookNumber)-chapters", ofType: "txt", inDirectory: "chapters") {
        do {
            let file = try String(contentsOfFile: filepath)
            let text: [String] = file.components(separatedBy: "\r")
            return text
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
    }
    return []
}


func getBookNumber(selectedBook: Book) -> Int {
    return selectedBook.id
}
