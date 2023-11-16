//
//  CustomDoubleTextField.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import SwiftUI

struct CustomDoubleTextField: View {

    // Builder
    var title: String
    var placeholder: String
    @Binding var value: Double
    var unit: String
    
    // Computed Variable
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
        return formatter
    }

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading)
           TextField(placeholder, value: $value, formatter: numberFormatter)
                .font(.system(size: 16, weight: .medium))
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.backgroundComponent)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(alignment: .trailing) {
                    Text(unit)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.placeholder)
                        .padding(.trailing)
                }
        }
        .padding(8)
        .padding(.horizontal, 8)
    } // End body
} // End struct

//MARK: - Preview
#Preview {
    CustomDoubleTextField(title: "Preview", placeholder: "Placeholder", value: .constant(0), unit: "Mo/s")
}
