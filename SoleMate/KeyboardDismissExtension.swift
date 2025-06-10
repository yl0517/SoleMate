//
//  KeyboardDismissExtension.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/9/25.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    /// Dismisses the on‑screen keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
