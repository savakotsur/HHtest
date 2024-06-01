//
//  ToolbarActions.swift
//  HHtest
//
//  Created by Савелий Коцур on 01.06.2024.
//

import SwiftUI

struct ToolbarActions: View {
    var isFavorite: Bool
    var removeFromFavorites: () -> Void
    var saveToCoreData: () -> Void
    var body: some View {
        HStack {
            Image("share")
            Image("eye")
            if isFavorite == true {
                Image("favorites.active")
                    .onTapGesture {
                        removeFromFavorites()
                    }
            } else {
                Image("favorites")
                    .onTapGesture {
                        saveToCoreData()
                    }
            }
        }
    }
}
