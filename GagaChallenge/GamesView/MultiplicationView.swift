
import SwiftUI

struct MultiplicationGameView: View {

    var body: some View {
        DrawView()
    }
}

struct DrawView: View {

    @State var curves: [[CGPoint]] = [[]]

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

        VStack{
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
//                        .overlay {
//                            if !curves[index].isEmpty {
//                                Circle()
//                                    .position(
//                                        x: curves[index][0].x - proxy.size.width / 2 + 15,
//                                        y: curves[index][0].y - proxy.size.height / 2 + 15)
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(.red)
//                            }
//                        }
                }
            }


            ForEach(pointsIntersection.indices, id: \.self) { index in
                GeometryReader { proxy in
                    Circle()
                        .position(x: pointsIntersection[index].x,
                                  y: pointsIntersection[index].y)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .opacity(0.5)
                        .animation(.easeIn, value: 1)
                    }
                }
        }
            Text("\(countOfIntersection)")
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

