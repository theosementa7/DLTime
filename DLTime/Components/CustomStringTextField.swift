//
//  CustomStringTextField.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import SwiftUI

struct CustomStringTextField: View {
    
    // Builder
    var title: String
    var placeholder: String
    @Binding var value: String

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading)
            TextField(placeholder, text: $value)
                .padding()
                .background(Color.backgroundComponent)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(8)
        .padding(.horizontal, 8)
    } // End body
} // End struct

//MARK: - Preview
#Preview {
    CustomStringTextField(title: "Preview", placeholder: "Placeholder", value: .constant(""))
}
