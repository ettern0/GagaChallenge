import SwiftUI
import SpriteKit
import Foundation


struct DivisionView: View {

    var body: some View {
        SpriteView(scene: DivisionScene(size: UIScreen.main.bounds.size), options: [.allowsTransparency])
       // SpriteView(scene: GameScene(size: UIScreen.main.bounds.size), options: [.allowsTransparency])
    }
}

enum CollisionType: UInt32 {
    case digit = 1
    case bin = 2
}

class DivisionScene: SKScene, SKPhysicsContactDelegate {

    @State var result = Int.random(in: 1...5)
    @State var secondDivisionDigit = Int.random(in: 1...5)
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    @State var bins: [SKSpriteNode] = [SKSpriteNode(imageNamed: "bin")]
    let widthOfScreen = UIScreen.main.bounds.width
    let heigtOfScreen = UIScreen.main.bounds.height
    var firstDivisionDigit: Int {
        result * secondDivisionDigit
    }
    var safeArea: Int {
        Int(widthOfScreen * 0.009 * CGFloat(secondDivisionDigit))
    }
    var safeWidth: Int {
        Int(widthOfScreen) - safeArea
    }
    var safeHeight: Int {
        Int(heigtOfScreen) - 50
    }
    var widthOfSprites: CGFloat {
        CGFloat(safeWidth/secondDivisionDigit)
    }


    override func didMove(to view: SKView) {

        view.showsPhysics = true

        self.backgroundColor = .white
        refreshBins()
        generateArrayOfFirstDivisionSprites()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        refreshBins()
        let touch = touches.first

        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)

            if let node = nodesArray.first, nodesArray.first?.name == "digit" {
                let xTouchPosition: CGFloat = location.x
                let yPosition: CGFloat = location.y
                node.physicsBody?.isDynamic.toggle()
                node.physicsBody?.allowsRotation.toggle()
            }
        }
    }

    func generateArrayOfFirstDivisionSprites() {

        // max 5 in a raw
        let _columsCountDouble = Double(Double(firstDivisionDigit) / Double(5)).rounded(.awayFromZero)
        let _columsCount = Int(_columsCountDouble)
        let space = Int(safeWidth/5)
        print("strawberries \(firstDivisionDigit)")
        print("bins \(secondDivisionDigit)")
        print("result \(result)")
        print("colums \(_columsCount)")
        print("heigtOfScreen \(safeHeight)")
        print("----------------------")


        var spriteRemains = firstDivisionDigit

        for i in 0..<_columsCount {
            for x in 0..<5 {
                if spriteRemains > 0 {
                    let node = SKSpriteNode(imageNamed: "strawberry")

                    node.name = "digit"
                    node.position = CGPoint(x: 40 + x * space, y: Int(safeHeight) - (i * space))
                    node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.texture!.size())
                    node.physicsBody?.categoryBitMask = CollisionType.digit.rawValue
                    node.physicsBody?.collisionBitMask = CollisionType.bin.rawValue | CollisionType.digit.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionType.bin.rawValue | CollisionType.digit.rawValue
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.allowsRotation = false
                    self.addChild(node)
                    spriteRemains -= 1
                }
            }
        }
    }

    func refreshBins() {

        let sizeOfBin = SKSpriteNode(imageNamed: "bin").size
        let posiibleCountOfBinsOnScreen = safeWidth / Int(sizeOfBin.width)

        var p = posiibleCountOfBinsOnScreen / secondDivisionDigit
        p = p > 1 ? 1 : p
        let binWidth = sizeOfBin.width * CGFloat(p)
        let binHeight = sizeOfBin.height * CGFloat(p)


        for x in 1...secondDivisionDigit {

            let xPosition = CGFloat(x) * binWidth
            let bin = SKSpriteNode(imageNamed: "bin")
            bin.size.width = binWidth
            bin.size.height = binHeight
            bin.position.x = CGFloat(xPosition)
            bin.position.y = UIScreen.main.bounds.height/2 - 100
            bin.physicsBody = SKPhysicsBody(texture: bin.texture!, alphaThreshold: 0, size: bin.size)
            bin.physicsBody?.categoryBitMask = CollisionType.bin.rawValue
            bin.physicsBody?.collisionBitMask = CollisionType.digit.rawValue
            bin.physicsBody?.contactTestBitMask = CollisionType.digit.rawValue
            bin.physicsBody?.isDynamic = false
            bin.physicsBody?.allowsRotation = false

            self.addChild(bin)
            bins.append(bin)
        }

    }

}
