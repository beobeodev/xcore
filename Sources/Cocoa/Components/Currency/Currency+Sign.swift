//
// Xcore
// Copyright © 2017 Xcore
// MIT license, see LICENSE file for details
//

import Foundation

extension Currency {
    public struct Sign: Equatable {
        public let plus: String
        public let minus: String

        public init(plus: String, minus: String) {
            self.plus = plus
            self.minus = minus
        }
    }
}

// MARK: - Built-in

extension Currency.Sign {
    public static var none: Self {
        .init(plus: "", minus: "")
    }

    public static var both: Self {
        .init(plus: "+", minus: "-")
    }

    public static var standard: Self {
        .init(plus: "", minus: "-")
    }
}