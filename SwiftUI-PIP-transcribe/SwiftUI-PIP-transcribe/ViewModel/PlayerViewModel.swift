//
//  PlayerViewModel.swift
//  SwiftUI-PIP-transcribe
//
//  Created by kazunori.aoki on 2021/11/27.
//

import Combine
import AVFoundation

final class PlayerViewModel: ObservableObject {

    let player = AVPlayer()

    @Published var isInPipMode: Bool = false
    @Published var isPlaying = false

    @Published var isEditingCurrentTime = false
    @Published var currentTime: Double = .zero
    @Published var duration: Double?

    private var subscriptions = Set<AnyCancellable>()
    private var timeObserver: Any?


    // MARK: Initialize
    deinit {
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver)
        }
    }

    init() {
        $isEditingCurrentTime
            .dropFirst()
            .filter { $0 == false }
            .sink { [weak self] _ in
                guard let _self = self else { return }
                _self.player.seek(to: CMTime(seconds: _self.currentTime, preferredTimescale: 1),
                                  toleranceBefore: .zero,
                                  toleranceAfter: .zero)
                if _self.player.rate != 0 {
                    _self.player.play()
                }
            }
            .store(in: &subscriptions)

        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                guard let _self = self else { return }

                switch status {
                case .playing:
                    _self.isPlaying = true
                case .paused:
                    _self.isPlaying = false

                case .waitingToPlayAtSpecifiedRate: break
                @unknown default: break
                }
            }
            .store(in: &subscriptions)

        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1,
                                                                          preferredTimescale: 600),
                                                      queue: .main) { [weak self] time in
            guard let _self = self else { return }

            if _self.isEditingCurrentTime == false {
                _self.currentTime = time.seconds
            }
        }
    }

    func setCurrentItem(_ item: AVPlayerItem) {
        currentTime = .zero
        duration = nil
        player.replaceCurrentItem(with: item)

        item.publisher(for: \.status)
            .filter { $0 == .readyToPlay }
            .sink { [weak self] _ in
                guard let _self = self else { return }

                _self.duration = item.asset.duration.seconds
            }
            .store(in: &subscriptions)
    }
}
