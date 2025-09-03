//
//  BadgeModifier.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI

struct BadgeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(horizontal: 8, vertical: 4)
            .background(.grayWarm100, in: RoundedRectangle(cornerRadius: .infinity))
            .overlay(
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(.grayWarm200, lineWidth: 1.5)
            )
            .foregroundStyle(.grayWarm600)
            .font(.callout)
    }
}

extension View {
    func badgeStyle() -> some View {
        modifier(BadgeModifier())
    }
}
