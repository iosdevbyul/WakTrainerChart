//
//  LineChartView.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-17.
//

import SwiftUI
import Charts
import WakTrainerCoreModels

public struct LineChartView: View {
    let dataPoints: [ChartDataPoint]
    let style: LineChartStyle
    
    public init(
        dataPoints: [ChartDataPoint],
        style: LineChartStyle = .defaultStyle
    ) {
        self.dataPoints = dataPoints
        self.style = style
    }
    
    public var body: some View {
        Chart(dataPoints) { point in
            // 1. 하단 영역 채우기 (옵션)
            if style.isFilled {
                AreaMark(
                    x: .value("시간", point.date),
                    y: .value("값", point.value)
                )
                .foregroundStyle(style.lineColor.opacity(0.15))
                .interpolationMethod(style.isCurved ? .catmullRom : .linear)
            }
            
            // 2. 꺾은선
            LineMark(
                x: .value("시간", point.date),
                y: .value("값", point.value)
            )
            .foregroundStyle(style.lineColor)
            .lineStyle(StrokeStyle(lineWidth: style.lineWidth))
            .interpolationMethod(style.isCurved ? .catmullRom : .linear)
            
            // 3. 데이터 지점 정점 포인트 (옵션)
            if style.showPoints {
                PointMark(
                    x: .value("시간", point.date),
                    y: .value("값", point.value)
                )
                .foregroundStyle(style.lineColor)
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.hour().minute())
            }
        }
        .padding()
    }
}
