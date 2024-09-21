//
//  VoNhaiView.swift
//  SG-Group15
//
//  Created by Nguyen Ha Kieu Anh on 14/9/24.
//

import SwiftUI


struct VoNhaiView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape // Track if the device is in landscape

    let mapPoints: [(name: String, compactX: CGFloat, compactY: CGFloat, regularX: CGFloat, regularY: CGFloat, sizeMultiplier: CGFloat)] = [
           ("Quỳnh Sơn", 0.7, 0.06, 0.7, 0.095, 2.0),
           ("Tân Hương", 0.16, 0.27, 0.14, 0.45, 2.0),
           ("Bắc Sơn", 0.67, 0.13, 0.68, 0.19, 2.0),
           ("Tân lập", 0.29, 0.15, 0.28, 0.25, 2.0),
           ("Hữu Vĩnh", 0.47, 0.12, 0.48, 0.2, 2.0),
           ("Hưng Vũ", 0.74, 0.22, 0.75, 0.35, 2.0),
           ("Vũ Làng", 0.38, 0.32, 0.38, 0.52, 2.0)
       ]

    var body: some View {
        MapComponent2( mapImage: "VoNhai", mapPoints: mapPoints, correctAnswer: "Quỳnh Sơn")
                }
        }

struct VoNhaiView_Previews: PreviewProvider {
    static var previews: some View {
        VoNhaiView()
          
    }
}
