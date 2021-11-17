
import SwiftUI

struct MultiplicationGameView: View {

    var body: some View {
        DrawView()
    }
}

struct DrawView: View {

    @State var points: [[CGPoint]] = [[]]

    var pointsIntersection: [CGPoint] {

        var mergedArrayOfPoints: [CGPoint] = []

        for index in points.indices {
            mergedArrayOfPoints += points[index]
        }

        return getIntersectionBetweenArrayOfCGPoints(points: mergedArrayOfPoints)

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
                    points.append([])
                }))

            ForEach(points.indices, id: \.self) { index in
                DrawShape(points: points[index])
                    .stroke(lineWidth: 5) // here you put width of lines
                    .foregroundColor(.blue)
//                    .overlay {
//                        if points[index].count > 0 {
//                            Circle()
//                            .position(x: points[index][0].x,
//                                      y: points[index][0].y)
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.red)
//                        }
//                    }
            }


//            ForEach(pointsIntersection.indices, id: \.self) { index in
//                Circle()
//                    .position(x: pointsIntersection[index].x,
//                              y: pointsIntersection[index].y)
//                    .frame(width: 30, height: 30)
//            }
//
        }
//            Text("\(countOfIntersection)")
        }

    }

    private func addNewPoint(_ value: DragGesture.Value) {
        points[points.endIndex - 1].append(value.location)
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

