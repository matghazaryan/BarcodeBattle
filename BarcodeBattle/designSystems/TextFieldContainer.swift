//
//  TextFieldContainer.swift
//  BarcodeBattle
//
//  Created by Matevos Ghazaryan on 4/30/22.
//

import SwiftUI

public struct TextFieldContainer<FieldView>: View where FieldView: View {

    var label: String

    public var body: some View {
        VStack {
            HStack {
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer()
            }
            fieldView
                .font(.system(size: 20, weight: .semibold))
            Divider()
        }
    }

    fileprivate init(label: String, fieldView: FieldView) {
        self.label = label
        self.fieldView = fieldView
    }

    private let fieldView: FieldView
}

extension TextFieldContainer where FieldView == TextField<Text> {
    public static func plain(label: String, placeholder:String, text: Binding<String>) -> some View {
        return Self(label: label, fieldView: TextField(placeholder, text: text))
    }
}

extension TextFieldContainer where FieldView == SecureField<Text> {
    public static func secure(label: String,  placeholder:String, text: Binding<String>) -> some View {
        return Self(label: label, fieldView: SecureField(placeholder, text: text))
    }
}
