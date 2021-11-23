import SwiftUI
import SpriteKit


struct DivisionView: View {

    var body: some View {

        SpriteView(scene: DivisionScene(size: UIScreen.main.bounds.size),options: [.allowsTransparency])
        Rectangle()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 30)
            .foregroundColor(.yellow)
    }
}

class DivisionScene: SKScene {

    @State var firstDivisionDigit = Int.random(in: 1...5)
    @State var secondDivisionDigit = Int.random(in: 1...5)
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    @State var bins: [SKSpriteNode] = [SKSpriteNode(imageNamed: "bin")]

    let widthOfScreen = UIScreen.main.bounds.width
    let heigtOfScreen = UIScreen.main.bounds.width

    override func didMove(to view: SKView) {

        self.backgroundColor = .white

        refreshBins()

    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        refreshBins()
//        let touch = touches.first
//
//        if let location = touch?.location(in: self) {
//
//            let bin = SKSpriteNode(imageNamed: "bin")
//            bin.size = CGSize(width: 100, height: 80)
//            bin.position.x = location.x
//            bin.position.y = location.y
//            self.addChild(bin)
//
//        }

    }

    func refreshBins() {

        self.removeChildren(in: bins)
        bins.removeAll()
        self.secondDivisionDigit = Int.random(in: 1...5)

        var safeArea = Int(widthOfScreen * 0.009 * CGFloat(secondDivisionDigit))
        let safeWidth = Int(widthOfScreen) - safeArea
        let widthOfBin = CGFloat(safeWidth/secondDivisionDigit)

        for x in 0..<secondDivisionDigit {

            let xPosition = CGFloat(x) * widthOfBin
            let bin = SKSpriteNode(imageNamed: "bin")
            bin.anchorPoint = CGPoint(x: 0, y: 0.5)
            bin.size.width = widthOfBin
            bin.size.height = widthOfBin
            bin.position.x = CGFloat(xPosition)
            bin.position.y = UIScreen.main.bounds.height/2
            self.addChild(bin)
            bins.append(bin)
        }

    }

}
