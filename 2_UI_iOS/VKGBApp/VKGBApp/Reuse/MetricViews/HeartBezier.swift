//
//  HeartBezier.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 11.09.2021.
//

import UIKit

func heart() -> UIBezierPath {
    let path = UIBezierPath()
    path.lineWidth = 4.0
    path.move(to: CGPoint(x: 18.0, y: 7.0))
    path.addLine(to: CGPoint(x: 10.0, y: 16.0))
    path.addLine(to: CGPoint(x: 2.0, y: 7.0))
    path.addArc(
        withCenter: CGPoint(x: 6.0, y: 7.0),
        radius: 4,
        startAngle: .pi,
        endAngle: 0,
        clockwise: true)
    path.addArc(
        withCenter: CGPoint(x: 14.0, y: 7.0),
        radius: 4,
        startAngle: .pi,
        endAngle: 0,
        clockwise: true)
    path.close()
    return path
}
