//
//  CustomControlsView.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import SwiftUI

struct CustomControlsView: View {
    @ObservedObject var playerVM: PlayerViewModel

    var body: some View {
        HStack {
            if playerVM.isPlaying == false {
                Button(action: { playerVM.player.play() }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: { playerVM.player.pause() }) {
                    Image(systemName: "pause.circle")
                        .imageScale(.large)
                }
            }

            if let duration = playerVM.duration {
                Slider(value: $playerVM.currentTime,
                       in: 0...duration,
                       onEditingChanged: { isEditing in
                    playerVM.isEditingCurrentTime = isEditing
                })
            } else {
                Spacer()
            }
        }
        .padding()
        .background(.thinMaterial)
    }
}

struct CustomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomControlsView(playerVM: PlayerViewModel())
    }
}
