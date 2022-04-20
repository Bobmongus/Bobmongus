//
//  RoomCellShape.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/07.
//

import SwiftUI

struct RoomCellShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let a = (rect.maxX / 90)
        let b = (rect.maxX / 90) * 2
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + b, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + b, y: rect.minY + a))
        path.addLine(to: CGPoint(x: rect.minX + a, y: rect.minY + a))
        path.addLine(to: CGPoint(x: rect.minX + a, y: rect.minY + b))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + b))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - b))
        path.addLine(to: CGPoint(x: rect.minX + a, y: rect.maxY - b))
        path.addLine(to: CGPoint(x: rect.minX + a, y: rect.maxY - a))
        path.addLine(to: CGPoint(x: rect.minX + b, y: rect.maxY - a))
        path.addLine(to: CGPoint(x: rect.minX + b, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX - b, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - b, y: rect.maxY - a))
        path.addLine(to: CGPoint(x: rect.maxX - a, y: rect.maxY - a))
        path.addLine(to: CGPoint(x: rect.maxX - a, y: rect.maxY - b))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - b))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + b))
        path.addLine(to: CGPoint(x: rect.maxX - a, y: rect.minY + b))
        path.addLine(to: CGPoint(x: rect.maxX - a, y: rect.minY + a))
        path.addLine(to: CGPoint(x: rect.maxX - b, y: rect.minY + a))
        path.addLine(to: CGPoint(x: rect.maxX - b, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.minX + b, y: rect.minY))
        
        path.closeSubpath()
        
        return path
    }
}
