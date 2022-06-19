//
// Xcore
// Copyright © 2022 Xcore
// MIT license, see LICENSE file for details
//

import Foundation
import Combine

public final class LiveSessionCounterClient: SessionCounterClient {
    public static let shared = LiveSessionCounterClient()
    @Dependency(\.pond) private var pond
    @Dependency(\.appStatus) private var appStatus
    @Dependency(\.ratingPrompt) private var ratingPrompt
    private var cancellable: AnyCancellable?

    public func start() {
        cancellable = appStatus
            .receive
            .when(.session(.unlocked))
            .sink { [weak self] in
                self?.increment()
            }
    }

    public var count: Int {
        pond.sessionCount
    }

    public func increment() {
        pond.incrementSessionCount()
        showRatingPromptIfNeeded()
    }

    private func showRatingPromptIfNeeded() {
        let multipleOfValue = FeatureFlag.ratingPromptVisitMultipleOf

        guard
            multipleOfValue > 0,
            count > 0,
            count.isMultiple(of: multipleOfValue)
        else {
            return
        }

        ratingPrompt.showIfNeeded()
    }
}

// MARK: - Dot Syntax Support

extension SessionCounterClient where Self == LiveSessionCounterClient {
    /// Returns noop variant of `SessionCounterClient`.
    public static var live: Self {
        .shared
    }
}

// MARK: - Pond

extension Pond {
    fileprivate var sessionCount: Int {
        `get`(sessionCountKey, default: 0)
    }

    fileprivate func incrementSessionCount() {
        let currentValue = sessionCount
        try? set(sessionCountKey, value: currentValue + 1)
    }

    private var sessionCountKey: PondKey {
        userDefaultsKey(#function)
    }
}