//
//  CustomPlainButton.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import SwiftUI

struct CustomPlainButton: View {

    // Builder
    var icon: String
    var text: String
    var action: () -> Void
    var color: Color

    //MARK: - Body
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Label(text, systemImage: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding()
            .background(color)
            .clipShape(Capsule())
        })
    } // End body
} // End struct

//MARK: - Preview
#Preview {
    CustomPlainButton(icon: "person.fill", text: "Preview", action: {}, color: .green)
}
