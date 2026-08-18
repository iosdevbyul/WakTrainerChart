//
//  HRZoneChart.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-18.
//

import SwiftUI
import Charts
import WakTrainerCoreModels

public struct HRZoneChart: View {
    let zoneData: [HRZonePoint]
    
    public init(zoneData: [HRZonePoint]) {
        self.zoneData = zoneData
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 차트 타이틀 및 레전드 (이미지 상단 참조)
            HStack {
                Text("Heart Rate Zone Chart")
                    .font(.subheadline.bold())
                Spacer()
                Text("[Red Line]: Heart Rate [Colors]: Intensity Zones")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 10)
            
            Chart(zoneData) { point in
                // 누적 바 그래프
                BarMark(
                    x: .value("Percentage", point.percentage),
                    stacking: .normalized
                )
                .foregroundStyle(point.color)
                .annotation(position: .overlay) {
                    Text("\(Int(point.percentage * 100))%")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
            }
            // x축 설정 (비율 0~100%)
            .chartXAxis {
                AxisMarks(values: [0.0, 0.5, 1.0]) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let decimal = value.as(Double.self) {
                            Text("\(Int(decimal * 100))%")
                        }
                    }
                }
            }
            // y축 설정 (구간 레이블 숨김 - 이미지처럼 단일 바로 표현)
            .chartYAxis(.hidden)
            .chartLegend(.hidden)
            .frame(height: 80)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
