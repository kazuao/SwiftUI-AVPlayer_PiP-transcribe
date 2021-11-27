//
//  CustomPlayerView.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import SwiftUI
import AVFoundation

struct CustomPlayerView: View {

    // MARK: Property
    @StateObject private var playerVM = PlayerViewModel()
    @State private var playList: [Media] = Media.playlist


    // MARK: Initialize
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }


    // MARK: View
    var body: some View {
        VStack {
            VStack {
                CustomVideoPlayer(playerVM: playerVM)
                    .overlay(CustomControlsView(playerVM: playerVM), alignment: .bottom)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding()
            .overlay(playerVM.isInPipMode ? List(playList) { media in
                Button(media.title) {
                    playerVM.setCurrentItem(media.asPlayerItem)
                }
            } : nil)

            Button(action: { withAnimation { playerVM.isInPipMode.toggle() } }) {
                if playerVM.isInPipMode {
                    Label("Stop PiP", systemImage: "pip.exit")
                } else {
                    Label("Start PiP", systemImage: "pip.enter")
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            playerVM.setCurrentItem(playList.first!.asPlayerItem)
            playerVM.player.play()
        }
        .onDisappear {
            playerVM.player.pause()
        }
    }
}

struct CustomPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPlayerView()
    }
}
