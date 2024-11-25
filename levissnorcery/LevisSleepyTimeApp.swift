//
//  LevisSleepyTimeApp.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/17/23.
//

import SwiftUI

@main
struct LevisSleepyTimeApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
