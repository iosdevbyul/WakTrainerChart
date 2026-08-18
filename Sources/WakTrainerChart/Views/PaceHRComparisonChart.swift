//
//  PaceHRComparisonChart.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-18.
//

import SwiftUI
import Charts
import WakTrainerCoreModels

public struct PaceHRComparisonChart: View {
    let dataPoints: [PaceHRDataPoint]
    
    public init(dataPoints: [PaceHRDataPoint]) {
        self.dataPoints = dataPoints
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 차트 타이틀 및 이중 레전드 
            Text("Pace vs Heart Rate Comparison Chart")
                .font(.subheadline.bold())
            
            HStack(spacing: 15) {
                HStack {
                    Circle().fill(Color.blue).frame(width: 8, height: 8)
                    Text("Pace (min/km)").font(.caption).foregroundColor(.blue)
                }
                HStack {
                    Circle().fill(Color.red).frame(width: 8, height: 8)
                    Text("Heart Rate (bpm)").font(.caption).foregroundColor(.red)
                }
            }
            .padding(.bottom, 10)
            
            Chart {
                // 1. 페이스: 파란색 선 (좌측 Axis)
                ForEach(dataPoints) { point in
                    LineMark(
                        x: .value("Distance", point.distanceKm),
                        y: .value("Pace", point.paceMinKm),
                        series: .value("Metrics", "Pace")
                    )
                    .foregroundStyle(.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .interpolationMethod(.catmullRom)
                }
                
                // 2. 심박수: 빨간색 선 (우측 Axis)
                ForEach(dataPoints) { point in
                    LineMark(
                        x: .value("Distance", point.distanceKm),
                        y: .value("HR", point.heartRateBpm),
                        series: .value("Metrics", "HR")
                    )
                    .foregroundStyle(.red)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .interpolationMethod(.catmullRom)
                }
            }
            // x축 설정: 거리 (km)
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            // y축 설정 (이중 Axis)
            .chartYAxis {
                // 좌측: 페이스 (분/km)
                AxisMarks(position: .leading, values: [4.0, 5.0, 6.0]) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let pace = value.as(Double.self) {
                            Text(String(format: "%.1f", pace)) // "4.0", "5.0" 형식
                        }
                    }
                }
                
                // 우측: 심박수 (bpm)
                AxisMarks(position: .trailing, values: [120, 140, 160, 180]) { value in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            .chartLegend(.hidden)
            .frame(height: 250)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
