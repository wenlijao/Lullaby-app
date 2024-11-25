//
//  FileManagerController.swift
//  LevisSleepyTime
//
//  Created by Winnie Jao on 4/18/23.
//

import Foundation

class FileController: ObservableObject {
    func getContentOfDirectory(url: String) -> [URL] {
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(url)
        print(url)
        print(bundleURL)
        print(assetURL)
        do {
            return try FileManager.default.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: nil)
        } catch {
            print(error)
            return []
        }
    }
}
