//
//  View+Padding.swift
//  Test-Protocol
//
//  Created by Dương Đinh Đông Khoa on 30/4/25.
//

import SwiftUI

extension View {
    func padding(horizontal h: CGFloat, vertical v: CGFloat) -> some View {
        self
            .padding(.horizontal, h)
            .padding(.vertical, v)
    }
}
