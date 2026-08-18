//
//  WorkoutDualChartView.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-17.
//

import SwiftUI
import Charts
import WakTrainerCoreModels

public struct WorkoutDualChartView: View {
    let dataPoints: [WorkoutChartDataPoint]
    let heartRateColor: Color
    let calorieColor: Color
    
    public init(
        dataPoints: [WorkoutChartDataPoint],
        heartRateColor: Color = .red,
        calorieColor: Color = .orange
    ) {
        self.dataPoints = dataPoints
        self.heartRateColor = heartRateColor
        self.calorieColor = calorieColor
    }
    
    public var body: some View {
        Chart {
            // 1. 칼로리: 0부터 점점 올라가는 누적 영역(Area)
            ForEach(dataPoints) { point in
                AreaMark(
                    x: .value("시간", point.date),
                    y: .value("칼로리", point.calorie)
                )
                .foregroundStyle(calorieColor.opacity(0.2))
                .interpolationMethod(.catmullRom)
                
                LineMark(
                    x: .value("시간", point.date),
                    y: .value("칼로리", point.calorie),
                    series: .value("지표", "칼로리")
                )
                .foregroundStyle(calorieColor)
                .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 4])) // 점선 처리로 심박수와 구분
                .interpolationMethod(.catmullRom)
            }
            
            // 2. 심박수: 변동이 잘 보이는 메인 꺾은선(Line)
            ForEach(dataPoints) { point in
                LineMark(
                    x: .value("시간", point.date),
                    y: .value("심박수", point.heartRate),
                    series: .value("지표", "심박수")
                )
                .foregroundStyle(heartRateColor)
                .lineStyle(StrokeStyle(lineWidth: 2.5))
                .interpolationMethod(.catmullRom)
            }
        }
        // 좌측/우측 축 분리 시각화 설정
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisGridLine()
                AxisValueLabel() // 심박수 축 (좌측)
            }
        }
        .padding()
    }
}

