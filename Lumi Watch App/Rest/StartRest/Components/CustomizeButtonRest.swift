//
//  CustomizeButtonRest.swift
//  Lumi Watch App
//
//  Created by Reynard Octavius Tan on 24/06/24.
//

import SwiftUI

struct CustomizeButtonRest: View {
    var body: some View {
        
        Button  {
            print("button rest pressed!")
        } label: {
            Circle()
        }

    }
}

#Preview {
    CustomizeButtonRest()
}
