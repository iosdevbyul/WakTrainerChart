//
//  ChartInteractiveSelectionModifier.swift
//  WakTrainerChart
//
//  Created by COMATOKI on 2026-08-20.
//

import SwiftUI
import Charts

public extension View {
    /// iOS 16 및 iOS 17+ 버전을 모두 지원하는 차트 인터랙션 Modifier
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
                                // OS 버전에 따른 plot frame 오프셋 계산
                                let originX: CGFloat = {
                                    if #available(iOS 17.0, *) {
                                        return proxy.plotFrame.map { geometry[$0].origin.x } ?? 0
                                    } else {
                                        return geometry[proxy.plotAreaFrame].origin.x
                                    }
                                }()
                                
                                let xLocation = value.location.x - originX
                                
                                // X축 값 추출 및 가장 가까운 데이터 포인트 탐색
                                if let xVal: Double = proxy.value(atX: xLocation) {
                                    selectedPoint.wrappedValue = dataPoints.min(by: {
                                        abs(xValueExtractor($0) - xVal) < abs(xValueExtractor($1) - xVal)
                                    })
                                }
                            }
                            .onEnded { _ in
                                selectedPoint.wrappedValue = nil
                            }
                    )
            }
        }
    }
}
