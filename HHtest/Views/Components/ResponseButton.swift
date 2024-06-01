//
//  ResponseButton.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI

struct ResponseButton: View {
    var body: some View {
        Button(action: {
            print("Кнопка отклика нажата")
        })
        {
            Text("Откликнуться")
                .foregroundColor(Color("white"))
        }
        .frame(maxWidth: .infinity, minHeight: screenSize.height / 18)
        .background(Color("green"))
        .cornerRadius(10)
        .padding(.vertical, 10)
    }
}
