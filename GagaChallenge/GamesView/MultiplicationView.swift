
import SwiftUI

struct MultiplicationGameView: View {

    var body: some View {
        DrawView()
    }
}

struct DrawView: View {

    @State var curves: [[CGPoint]] = [[]]
    @State var arrayOfCountingOfPointsIntersections: [CGPoint: Int] = [:]

    var pointsIntersection: [CGPoint] {
        guard curves.count >= 2 else { return [] }

        var intersections = [CGPoint]()
        for i in 0 ... curves.count - 2 {
            for j in i + 1 ... curves.count - 1 {
                let (line1, line2) = (curves[i], curves[j])
                let intersection = line1.intersections(with: line2)
                intersections.append(contentsOf: intersection)
            }
        }

        return intersections
    }

    var countOfIntersection: Int {
        pointsIntersection.count
    }

    var body: some View {

        ZStack {
            Rectangle() // replace it with what you need
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
                .gesture(DragGesture().onChanged( { value in
                    self.addNewPoint(value)
                })
                .onEnded( { value in
                    curves.append([])
                }))
                .onLongPressGesture {
                    curves = [[]]
                }
            ForEach(curves.indices, id: \.self) { index in
                GeometryReader { proxy in
                    DrawShape(points: curves[index])
                        .stroke(lineWidth: 5) // here you put width of lines
                        .foregroundColor(.blue)
                }
            }


            ForEach(pointsIntersection.indices, id: \.self) { index in
                GeometryReader { proxy in

                    let point = pointsIntersection[index]
                    let numberOfPoint = arrayOfCountingOfPointsIntersections[point]

                    Circle()
                        .position(x: point.x,
                                  y: point.y)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                        .overlay {
                            if let number = numberOfPoint {
                                Text("\(number)")
                                    .position(x: point.x,
                                              y: point.y)
                            }
                        }
                }
                .onAppear {
                    pointsIntersection.forEach { point in
                        if arrayOfCountingOfPointsIntersections[point] == nil {
                            arrayOfCountingOfPointsIntersections[point] = arrayOfCountingOfPointsIntersections.count + 1
                        }
                    }
                }
            }
        }
    }

    private func addNewPoint(_ value: DragGesture.Value) {
        curves[curves.endIndex - 1].append(value.location)
    }

}

struct DrawShape: Shape {

    var points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])

        }
        return path
    }
}

