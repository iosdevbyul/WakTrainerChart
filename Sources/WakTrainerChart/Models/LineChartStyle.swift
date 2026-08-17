//
//  LineChartStyle.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-17.
//

import SwiftUI

public struct LineChartStyle: Sendable {
    public var lineColor: Color
    public var lineWidth: CGFloat
    public var isCurved: Bool     // 곡선(.catmullRom) vs 직선(.linear)
    public var showPoints: Bool   // 데이터 지점 점(Point) 표시 여부
    public var isFilled: Bool     // 차트 하단 배경 색 채우기 여부
    
    public init(
        lineColor: Color = .blue,
        lineWidth: CGFloat = 2,
        isCurved: Bool = true,
        showPoints: Bool = true,
        isFilled: Bool = false
    ) {
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        self.isCurved = isCurved
        self.showPoints = showPoints
        self.isFilled = isFilled
    }
    
    // 기본으로 제공하는 프리셋 스타일
    public static let defaultStyle = LineChartStyle()
    public static let smoothArea = LineChartStyle(lineColor: .blue, lineWidth: 2, isCurved: true, showPoints: false, isFilled: true)
    public static let sharpLine = LineChartStyle(lineColor: .red, lineWidth: 2, isCurved: false, showPoints: true, isFilled: false)
}
