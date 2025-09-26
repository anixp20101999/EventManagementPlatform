//
//  GlobalBackButton.swift
//  EventManagementPlatform
//
//  Created by Mansi Laad on 25/09/25.
//

import SwiftUI

struct GlobalBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var color: Color?
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName:"chevron.left")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(color ?? .black)
        })
        .contentShape(Rectangle())
        .frame(width: 50)
    }
}

