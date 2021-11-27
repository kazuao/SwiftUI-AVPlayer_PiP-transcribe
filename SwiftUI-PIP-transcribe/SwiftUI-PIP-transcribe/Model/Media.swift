//
//  Media.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import Foundation
import AVFoundation

struct Media: Identifiable {
    let id = UUID()
    let title: String
    let url: String
}

extension Media {
    var asPlayerItem: AVPlayerItem {
        AVPlayerItem(url: URL(string: url)!)
    }

    static var playlist: [Media] = [
        .init(title: "First video", url: "movie1.mp4"),
        .init(title: "Second video", url: "https://d.kuku.lu/3467bb6cb"),
        .init(title: "Third video", url: "URL_TO_THIRD_VIDEO.m3u8"),
        .init(title: "Fourth video", url: "URL_TO_FOURTH_VIDEO.m3u8"),
        .init(title: "Fifth video", url: "URL_TO_FIFTH_VIDEO.mp4")
        // ...
    ]
}
