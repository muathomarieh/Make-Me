//
//  TimePickerReminderView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TimePickerReminderView: View {
    @Binding var pickerSelection: Date
    @Binding var remindMe: Bool
    var body: some View {
        VStack {
            DatePicker(selection: $pickerSelection) {
                Button("Remind Me") {
                    remindMe.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(remindMe ? Color.accentColor : Color.gray)
            }
        }
        .padding()
        .background(Color.appGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    //TimePickerReminderView()
}
