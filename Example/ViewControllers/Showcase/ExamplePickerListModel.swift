//
// ExamplePickerListModel.swift
//
// Copyright © 2019 Xcore
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

final class ExamplePickerListModel: PickerListModel {
    private var timer: Timer?
    private var count = 0
    private var _didChange: (() -> Void)?

    var items: [DynamicTableModel] {
        return [
            DynamicTableModel(title: "Option 1", subtitle: "List has been shown for \(count) second(s)"),
            DynamicTableModel(title: "Option 1", subtitle: "PickerList demonstration")]
    }

    func didChange(_ callback: @escaping () -> Void) {
        _didChange = callback
    }

    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateCount()
        }
    }

    deinit {
        timer?.invalidate()
    }

    private func updateCount() {
        count += 1
        _didChange?()
    }
}