import Foundation
import SwiftUI
import CoreData
import ClippingBezier
import AVFAudio

func getUIDataFromColor(color: Color) -> Data {
    do {
        return try NSKeyedArchiver.archivedData(withRootObject: UIColor(color), requiringSecureCoding: false)
    } catch {
        return Data()
    }
}

func getColor(data: Data) -> Color {
    do {
        return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)!)
    } catch {
        print(error)
    }

    return Color.clear
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension UIBezierPath {
    convenience init?(points: [CGPoint]) {
        let path = UIBezierPath()
        guard points.count >= 2 else {
            return nil
        }
        for i in 0 ... points.count - 2 {
            path.move(to: points[i])
            path.addLine(to: points[i + 1])
        }

        self.init(cgPath: path.cgPath)
    }
}

extension Array where Element == CGPoint {

    func intersections(with points: [CGPoint]) -> [CGPoint] {

        guard  let firstPath = UIBezierPath(points: self),
              let secondPath = UIBezierPath(points: points)
        else {
            return []
        }

        let intersections = firstPath.findIntersections(withClosedPath: secondPath, andBeginsInside: nil)

        let result = intersections?.map {
            $0.location1()
        } ?? []
        return result
    }
}

func getIntersectionBetweenArrayOfCGPoints(points: [CGPoint]) -> [CGPoint] {

    var resultOfIntersection:[CGPoint] = []

    if points.count < 2 {
        return resultOfIntersection
    }

    let n = points.count - 1

    for i in 1 ..< n {
        for j in 0 ..< i-1 {
            if let intersection = intersectionBetweenSegments(p0: points[i],
                                                              points[i+1],
                                                              points[j],
                                                              points[j+1]) {
                resultOfIntersection.append(intersection)
            }
        }
    }
    return resultOfIntersection
}

func intersectionBetweenSegments(p0: CGPoint, _ p1: CGPoint, _ p2: CGPoint, _ p3: CGPoint) -> CGPoint? {
    var denominator = (p3.y - p2.y) * (p1.x - p0.x) - (p3.x - p2.x) * (p1.y - p0.y)
    var ua = (p3.x - p2.x) * (p0.y - p2.y) - (p3.y - p2.y) * (p0.x - p2.x)
    var ub = (p1.x - p0.x) * (p0.y - p2.y) - (p1.y - p0.y) * (p0.x - p2.x)
    if (denominator < 0) {
        ua = -ua; ub = -ub; denominator = -denominator
    }

    if ua >= 0.0 && ua <= denominator && ub >= 0.0 && ub <= denominator && denominator != 0 {
        return CGPoint(x: p0.x + ua / denominator * (p1.x - p0.x), y: p0.y + ua / denominator * (p1.y - p0.y))
    }
    return nil
}

extension CGPoint : Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

extension Int {
    var stringValue: String {
        "\(self)"
    }

    public static func randomExept(of exception:Int, range: ClosedRange<Int>) -> Int {
        if range.isEmpty {
            assertionFailure()
            return exception
        }
        if range.count == 1 {
            return range.first ?? exception
        }

        while true {
            let rElement = Int.random(in: range)
            if rElement != exception {
                return rElement
            }
        }
    }
}
