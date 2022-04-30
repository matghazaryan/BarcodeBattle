//
//  BaseButtonStyle.swift
//  BarcodeBattle
//
//  Created by Matevos Ghazaryan on 4/30/22.
//

import SwiftUI

public struct BaseButtonStyle: ButtonStyle {
    public init () {}
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .lineLimit(1)
            .frame(maxWidth: 220, maxHeight: 40, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(.white)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.spring())
    }
}
