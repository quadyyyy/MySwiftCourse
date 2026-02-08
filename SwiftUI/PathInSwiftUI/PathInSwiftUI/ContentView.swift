//
//  ContentView.swift
//  PathInSwiftUI
//
//  Created by Куприянов Тимофей on 03.02.2026.
//

//move - Перемещается в точку, с которой вы хотите начать рисование, указав начальную точку (координаты x и y).
//addLine - Добавляет линию из точки, в которой вы сейчас находитесь, в указанную точку (координаты x и y).
//addArc - Добавляет изогнутую линию (дугу) путем указания радиуса (расстояния от центра до края дуги) и начального и конечного углов.
//addEllipse - Рисует эллипс заданного размера (высоты и ширины).
//addCurve - Добавляет линию из точки, в которой вы сейчас находитесь, в указанную точку (координаты x и y). Затем вы указываете два управляющих маркера (координаты x и y), чтобы управлять кривой этой линии.
//addLines - Добавляет множество линий, передавая массив точек (координаты x и y), с которыми будут соединяться линии.
//addPath - Вы - создаете путь, чтобы начать рисовать линии, кривые и формы. Затем вы можете добавить другой путь к существующему пути, чтобы соединить их вместе, используя addPath.
//addQuadCurve - Добавляет кривую линию от точки, в которой вы сейчас находитесь, к указанной точке (координата x и y). Вы также указываете точку, к которой должна быть изогнута кривая (координаты x и y).
//addRects - Рисует один или несколько прямоугольников, имеющих начальную точку (координаты x и y) и размер (высота и ширина).
//addRelativeArc - Добавляет кривую линию (дугу), указав радиус (расстояние от центра до края дуги), начальный угол, а затем количество градусов, на которое вы хотите продолжить от этого начального угла (так называемая «дельта»).
//addRoundedRect - Рисует закругленный прямоугольник с пользовательским размером угла.
//addRect - Рисует прямоугольник, используя начальную точку (координаты x и y) и размер (высота и ширина).
//closeSubpath - Закрывает путь, соединяя последнюю точку с самой первой точкой пути

import SwiftUI


struct TriangleView: View {
    var body: some View {
        GeometryReader { proxy in
            
            let midX = proxy.frame(in: .local).midX
            let width: CGFloat = 200.0
            
            
            Path { path in
                path.move(to: CGPoint(x: 20, y: 70))
                path.addLine(to: CGPoint(x: midX + (width / 2), y: 170))
                path.addLine(to: CGPoint(x: midX - (width / 2), y: 170))
                path.closeSubpath()
            }
            //.strokedPath(StrokeStyle(lineWidth: 5))
            .fill(.blue)
            //.foregroundStyle(.red)
        }
    }
}

struct RectangleView: View {
    var body: some View {
        GeometryReader { proxy in
        
            Path { path in
                path.addRect(CGRect(x: 10, y: 100, width: proxy.size.width - 20, height: 100))
            }
            .fill(.blue)
        }
    }
}

struct CurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startPoint = CGPoint(x: rect.width*0.65, y: 0)
        
        path.move(to: startPoint)
        
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height/2), control1: CGPoint(x: rect.width*0.85, y: 0), control2: CGPoint(x: rect.width, y: rect.height*0.1))
        
        path.addCurve(to: CGPoint(x: rect.width/2, y: rect.height), control1: CGPoint(x: rect.width, y: rect.height*0.9), control2: CGPoint(x: rect.width, y: rect.height*0.1))
        
        path.addCurve(to: CGPoint(x: 0, y: rect.height*0.7), control1: CGPoint(x: rect.width*0.35, y: rect.height), control2: CGPoint(x: rect.width*0.75, y: rect.height))
        
        return path
    }
}


struct RoundedBottomRectangle: Shape {
    
    var curveOffset: CGFloat = 10.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + curveOffset))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}

struct DomeShape: Shape {
    var progress: CGFloat = 0.1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        path.addRelativeArc(center: CGPoint(x: rect.midX, y: rect.midY),
                            radius: rect.midX,
                            startAngle: .degrees(180.0),
                            delta: .degrees(180 * progress))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}


struct ContentView: View {
    @State var progress = 0.0
    var body: some View {
        VStack {
            Spacer()
            DomeShape(progress: 1)
                .trim(from: 0, to: progress)
                .stroke(.purple, lineWidth: 5)
                .frame(height: 196)
                .background(Color(uiColor: .systemGray5))
            Spacer()
            Slider(value: $progress)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}

