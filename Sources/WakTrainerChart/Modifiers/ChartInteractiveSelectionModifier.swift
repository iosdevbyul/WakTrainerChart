//
//  ChartInteractiveSelectionModifier.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-20.
//

import SwiftUI
import Charts

public extension View {
    /// 차트 상에서 터치/드래그 위치와 가장 가까운 데이터 포인트를 찾아 binding 상태로 전달해주는 공통 Modifier
    func chartInteractiveSelection<T: Identifiable>(
        dataPoints: [T],
        selectedPoint: Binding<T?>,
        xValueExtractor: @escaping (T) -> Double
    ) -> some View {
        self.chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                guard let plotFrame = proxy.plotFrame else { return }
                                let origin = geometry[plotFrame].origin
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                // X축 위치 값 추출
                                if let xVal: Double = proxy.value(atX: location.x) {
                                    // 가장 가까운 데이터 포인트 탐색
                                    selectedPoint.wrappedValue = dataPoints.min(by: {
                                        abs(xValueExtractor($0) - xVal) < abs(xValueExtractor($1) - xVal)
                                    })
                                }
                            }
                            .onEnded { _ in
                                // 손을 떼면 선택 해제 (필요시 손을 떼도 유지하려면 이 부분 주석 처리)
                                selectedPoint.wrappedValue = nil
                            }
                    )
            }
        }
    }
}
