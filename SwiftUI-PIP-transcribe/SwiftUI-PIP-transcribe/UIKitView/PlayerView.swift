//
//  PlayerView.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    override static var layerClass: AnyClass { AVPlayerLayer.self }

    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }

    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
