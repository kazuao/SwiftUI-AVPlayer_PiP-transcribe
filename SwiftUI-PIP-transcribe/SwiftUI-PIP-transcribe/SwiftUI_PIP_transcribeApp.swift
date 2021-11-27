//
//  SwiftUI_PIP_transcribeApp.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import SwiftUI

@main
struct SwiftUI_PIP_transcribeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CustomPlayerView()
                    .navigationTitle("CustomVideoPlayer")
            }
        }
    }
}
