
import SwiftUI

struct MultiplicationGameView: View {

    @State var curves: [[CGPoint]] = [[]]
    @State var pointsIntersectionsInfo: [CGPoint: (number:Int, color: Color)] = [:]
    @Binding var showGame: Bool
    @State var firstMultiplicationDigit = Int.random(in: 1...5)
    @State var secondMultiplicationDigit = Int.random(in: 1...5)
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    let sizeOfTopAnButton = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.1)
    var pointsIntersection: [CGPoint] {
        getIntersectionsOfPoints(points: curves)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            VStack(spacing: 0) {
                example
                Spacer()
                drawSection
                Spacer()
                answersView
            }
            .padding(.top, -50)
            .navigationBarItems(
                trailing:
                    HStack {
                        undoButton
                        clearButton
                        Spacer()
                    })

            Image("panda")
                .resizable()
                .scaledToFit()
                .frame(width: sizeOfTopAnButton.width, height: sizeOfTopAnButton.height, alignment: .leading)
                .position(x: sizeOfTopAnButton.width/2 + 10, y: sizeOfTopAnButton.height)
        }

    }

    var answersView: some View {

        let spacing = sizeOfTopAnButton.width * 0.2 / CGFloat(4)
        let rows: [GridItem] = [GridItem()]

        return  RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfTopAnButton.width, height: sizeOfTopAnButton.height * 0.8)
            .foregroundColor(.white)
            .onAppear {
                refreshAnswers()}
            .overlay {
                if !answers.isEmpty {
                    LazyHGrid(rows: rows, alignment: .center, spacing: spacing) {
                        ForEach(0..<answers.count) { index in
                            Button(action: {
                                if answers[index].rightAnswer {
                                    refreshGame()
                                } else {
                                    animateWrongAnswer.toggle()
                                }
                            }, label: {
                                Text(answers[index].stringValue)
                            })
                                .modifier(ButtonTextViewModifier(sizeOfButton: sizeOfTopAnButton.height * 0.7, sizeOfText: 50, rectColor: answers[index].color))
                                .offset(x: animateWrongAnswer ? 0 : -5)
                                .animation(Animation.default.repeatCount(3).speed(3), value: animateWrongAnswer)

                        }
                    }
                }
            }
    }

    var example: some View {

        Group {
            ZStack {
                Image("cloud")
                    .resizable()
                    .frame(width: sizeOfTopAnButton.width * 0.8, height: 100)
                HStack {
                    SignView(size: 50, value: firstMultiplicationDigit.stringValue)
                    SystemImageView(size: 30, systemName: "multiply")
                    SignView(size: 50, value: secondMultiplicationDigit.stringValue)
                }
            }

        }
    }

    var drawSection: some View {

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - (sizeOfTopAnButton.height * 3.5)

       return ZStack {
           Rectangle()
               .foregroundColor(.white)
                .gesture(DragGesture().onChanged( { value in
                   self.addNewPoint(value, borderX: width, borderY: height)
               }).onEnded( { value in
                   curves.append([])
               }))
            ForEach(curves.indices, id: \.self) { index in
                    DrawShape(points: curves[index])
                        .stroke(lineWidth: 5) // here you put width of lines
                        .foregroundColor(.blue)
            }

            ForEach(pointsIntersection.indices, id: \.self) { index in
                GeometryReader { proxy in

                    let point = pointsIntersection[index]
                    if let pointInfo = pointsIntersectionsInfo[point] {

                        Circle()
                            .position(x: point.x,
                                      y: point.y)
                            .frame(width: 30, height: 30)
                            .foregroundColor((pointInfo.color))
                            .overlay {
                                    Text("\(pointInfo.number)")
                                        .position(x: point.x,
                                                  y: point.y)
                            }
                            .blur(radius: 1)
                            .animation(.default, value: pointsIntersection)
                    }
                }
                .onAppear {
                    refreshArrayOfCountingOfPointsIntersections()
                }
            }
        }
        .frame(width: width, height: height)
    }

    var undoButton: some View {
        Button {
            if curves.count > 1 {
                curves.remove(at: curves.endIndex - 2)
                pointsIntersectionsInfo.removeAll()
                refreshArrayOfCountingOfPointsIntersections()
            }

            if curves.isEmpty {
                curves.append([])
            }
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
        }
    }

    var clearButton: some View {
        Button {
            clearGame()
        } label: {
            Image(systemName: "trash")
        }
    }

    private func addNewPoint(_ value: DragGesture.Value, borderX: CGFloat, borderY: CGFloat) {
        if value.location.y >= -0, value.location.y <= 630 {
            curves[curves.endIndex - 1].append(value.location)
        }
    }

    private func refreshArrayOfCountingOfPointsIntersections () {
        pointsIntersection.forEach { point in
            if pointsIntersectionsInfo[point] == nil {
                var arrayOfColors: [Color] = getArrayOfGeneralColors()
                //Excluse the blue, because drawshapes id blue
                arrayOfColors = arrayOfColors.filter{$0 != .blue}
                pointsIntersectionsInfo[point] = (number: pointsIntersectionsInfo.count + 1, color: arrayOfColors.randomElement()!)
            }
        }
    }

    private func refreshAnswers() {
        if answers.isEmpty {
            let resultOfMultiply: Int = firstMultiplicationDigit * secondMultiplicationDigit
            var arrayOfColors: [Color]? = getArrayOfGeneralColors()
            arrayOfColors?.shuffle()

            answers.append(Answer(value: resultOfMultiply, rightAnswer: true, color: arrayOfColors?.first))
            arrayOfColors?.removeFirst()
            for _ in 0...2 {
                answers.append(Answer(value: Int.randomExept(of: resultOfMultiply, range: 0...25), color: arrayOfColors?.first))
                arrayOfColors?.removeFirst()
            }
            answers.shuffle()
        }
    }

    private func refreshGame() {
        firstMultiplicationDigit = Int.random(in: 1...5)
        secondMultiplicationDigit = Int.random(in: 1...5)
        clearGame()
    }

    private func clearGame() {
        curves = [[]]
        pointsIntersectionsInfo.removeAll()
        answers.removeAll()
        refreshAnswers()
    }
}



