//
//  GradientBackground.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 02/04/2023.
//

import SwiftUI
import UIKit

struct GradientBackground: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            RadialGradient(
                gradient: Gradient(colors: [.blue, .black]),
                center: .center,
                startRadius: 5,
                endRadius: 1000)
        } else {
            RadialGradient(
                gradient: Gradient(colors: [.blue, .black]),
                center: .center,
                startRadius: 1,
                endRadius: 650)
        }
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
