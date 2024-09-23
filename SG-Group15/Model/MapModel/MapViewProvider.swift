/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 15
    - Nguyen Tran Ha Anh - 3938490
    - Bui Tuan Anh - 3970375
    - Nguyen Ha Kieu Anh - 3818552
    - Truong Hong Van - 3957034
  Created  date: 08/09/2024
  Last modified: 23/09/2024
*/

import SwiftUI

// Render the Map data base on map type
struct MapDataProvider {
    static func mapData(for type: MapType) -> MapData {
        switch type {
            // Bac Giang map
        case .bacGiang:
            return MapData(
                mapImage: "BacGiang",
                mapPoints: [
                    ("Bắc Giang", 0.19, 0.155, 0.18, 0.25, 2.0),
                    ("Lạng Sơn", 0.48, 0.13, 0.48, 0.22, 2.0),
                    ("Thái Nguyên", 0.42, 0.223, 0.42, 0.344, 2.0),
                    ("Quảng Ninh", 0.62, 0.267, 0.61, 0.395, 2.0)
                ],
                correctAnswer: "Bắc Giang",
                config: MapComponentConfig(
                    animationGifName: "shield",
                    animationDuration: 5,
                    animationSize: (compact: CGSize(width: 80, height: 80), regular: CGSize(width: 400, height: 400)),
                    animationPosition: (compact: CGPoint(x: 60, y: 135), regular: CGPoint(x: 160, y: 450)),
                    animationOffset: CGSize(width: -10, height: 0)
                )
            )
            // Hoc Mon map
        case .hocMon:
            return MapData(
                mapImage: "HocMon",
                mapPoints: [
                    ("Xuân Thới Thượng", 0.35, 0.212, 0.35, 0.32, 2.0),
                    ("Bà Điểm", 0.7, 0.28, 0.7, 0.42, 2.0),
                    ("Tân Xuân", 0.7, 0.14, 0.72, 0.21, 2.0),
                    ("Xuân Thới Sơn", 0.25, 0.112, 0.25, 0.16, 2.0)
                ],
                correctAnswer: "Bà Điểm",
                config: MapComponentConfig(
                    animationGifName: "fight",
                    animationDuration: 5,
                    animationSize: (compact: CGSize(width: 500, height: 500), regular: CGSize(width: 800, height: 500)),
                    animationPosition: (compact: CGPoint(x: 300, y: 420), regular: CGPoint(x: 650, y: 650)),
                    animationOffset: CGSize(width: -40, height: 0)
                )
            )
            // Doi A1 map
        case .doiA1:
            return MapData(
                mapImage: "DoiA1",
                mapPoints: [
                    ("Đồi D1", 0.65, 0.27, 0.52, 0.37, 2.0),
                    ("Đồi Him Lam", 0.57, 0.185, 0.47, 0.25, 2.0),
                    ("Đồi Độc Lập", 0.6, 0.08, 0.51, 0.1, 2.0),
                    ("Đồi A1", 0.62, 0.36, 0.51, 0.49, 2.0)
                ],
                correctAnswer: "Đồi A1",
                config: MapComponentConfig(
                    animationGifName: "explosion",
                    animationDuration: 8,
                    animationSize: (compact: CGSize(width: 100, height: 100), regular: CGSize(width: 300, height: 300)),
                    animationPosition: (compact: CGPoint(x: 210, y: 210), regular: CGPoint(x: 490, y: 490)),
                    animationOffset: CGSize.zero
                )
            )
            // Dong Nai Thuong map
        case .dongNaiThuong:
            return MapData(
                mapImage: "DongNaiThuong",
                mapPoints: [
                    ("Tiên Hoàng", 0.45, 0.31, 0.45, 0.45, 2.0),
                    ("Đồng Nai Thượng", 0.6, 0.185, 0.55, 0.275, 2.0),
                    ("Gia Viễn", 0.18, 0.41, 0.18, 0.6, 2.0),
                    ("Nam Ninh", 0.43, 0.405, 0.43, 0.6, 2.0)
                ],
                correctAnswer: "Đồng Nai Thượng",
                config: MapComponentConfig(
                    animationGifName: "tank",
                    animationDuration: 1.5,
                    animationSize: (compact: CGSize(width: 80, height: 80), regular: CGSize(width: 80, height: 80)),
                    animationPosition: (compact: CGPoint(x: 165, y: 165), regular: CGPoint(x: 310, y: 310)),
                    animationOffset: CGSize(width: -165, height: 0)
                )
            )
            // Hong Cum map
        case .hongCum:
            return MapData(
                mapImage: "HongCum",
                mapPoints: [
                    ("Bản Hồng Cúm", 0.7, 0.7, 0.6, 0.9, 2.0),
                    ("Bản Ta Po", 0.63, 0.1, 0.53, 0.14, 2.0),
                    ("Bản Ban", 0.84, 0.25, 0.7, 0.32, 2.0),
                    ("Bản Tem", 0.155, 0.4, 0.12, 0.53, 2.0),
                    ("Bản Hồng Lai", 0.85, 0.4, 0.75, 0.5, 2.0)
                ],
                correctAnswer: "Bản Hồng Cúm",
                config: MapComponentConfig(
                    animationGifName: "explosion",
                    animationDuration: 8,
                    animationSize: (compact: CGSize(width: 80, height: 80), regular: CGSize(width: 300, height: 300)),
                    animationPosition: (compact: CGPoint(x: 210, y: 210), regular: CGPoint(x: 490, y: 490)),
                    animationOffset: CGSize.zero
                )
            )
            // Tan Trao map
        case .tanTrao:
            return MapData(
                mapImage: "TanTrao",
                mapPoints: [
                    ("Bình Yên", 0.4, 0.31, 0.4, 0.51, 2.0),
                    ("Tân Trào", 0.6, 0.185, 0.6, 0.3, 2.0),
                    ("Trung Yên", 0.5, 0.09, 0.5, 0.15, 2.0),
                    ("Minh Thanh", 0.155, 0.22, 0.15, 0.35, 2.0),
                    ("Lương Thiện", 0.68, 0.35, 0.68, 0.55, 2.0)
                ],
                correctAnswer: "Tân Trào",
                config: MapComponentConfig(
                    animationGifName: "explosion",
                    animationDuration: 8,
                    animationSize: (compact: CGSize(width: 100, height: 100), regular: CGSize(width: 100, height: 100)),
                    animationPosition: (compact: CGPoint(x: 210, y: 210), regular: CGPoint(x: 490, y: 490)),
                    animationOffset: CGSize.zero
                )
            )
            // Vo Nhai map 
        case .voNhai:
            return MapData(
                mapImage: "VoNhai",
                mapPoints: [
                    ("Quỳnh Sơn", 0.7, 0.06, 0.7, 0.09, 2.0),
                    ("Tân Hương", 0.16, 0.27, 0.14, 0.4, 2.0),
                    ("Bắc Sơn", 0.67, 0.13, 0.68, 0.19, 2.0),
                    ("Tân lập", 0.29, 0.15, 0.28, 0.22, 2.0),
                    ("Hữu Vĩnh", 0.47, 0.12, 0.48, 0.19, 2.0),
                    ("Hưng Vũ", 0.74, 0.22, 0.75, 0.35, 2.0),
                    ("Vũ Làng", 0.38, 0.32, 0.38, 0.48, 2.0)
                ],
                correctAnswer: "Quỳnh Sơn",
                config: MapComponentConfig(
                    animationGifName: "swords",
                    animationDuration: 3,
                    animationSize: (compact: CGSize(width: 70, height: 70), regular: CGSize(width: 100, height: 100)),
                    animationPosition: (compact: CGPoint(x: 210, y: 210), regular: CGPoint(x: 490, y: 490)),
                    animationOffset: CGSize(width: -40, height: 0)
                )
            )
        }
    }
}
