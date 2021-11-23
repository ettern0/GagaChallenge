
//
//  GameScene.swift
//  JumpTest
//
//  Created by Livingston on 4/6/19.
//  Copyright © 2019 Livingston. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    let playerBit: UInt32 = 0x1
    let groundBit: UInt32 = 0x1 << 1
    let allCategory: UInt32 = UInt32.max

    var bottom: SKShapeNode!
    var player: SKShapeNode!

    var pressed: Bool = false
    var on_ground: Bool = false

    var force: CGFloat = 0.0
    let min_force: CGFloat = 0
    let max_force: CGFloat = 100
    let delta_force: CGFloat = 2
    let delta_force_time: CGFloat = 0.05

    override func didMove(to view: SKView) {

        view.showsPhysics = true

        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)

        let bottom = SKShapeNode(rect: CGRect(x: -scene!.frame.width/2, y: -scene!.frame.height/2, width: scene!.frame.width, height: 0.1*scene!.frame.height))
        bottom.fillColor = .white
        addChild(bottom)

        bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scene!.frame.width, height: 0.1*scene!.frame.height), center: CGPoint(x: 0, y: -scene!.frame.height/2+0.1*scene!.frame.height/2))
        bottom.physicsBody?.affectedByGravity = false
        bottom.physicsBody?.allowsRotation = false
        bottom.physicsBody?.isDynamic = false
        bottom.physicsBody!.restitution = 0.0
        bottom.physicsBody?.categoryBitMask = groundBit
        bottom.physicsBody?.collisionBitMask = playerBit | groundBit
        bottom.physicsBody?.contactTestBitMask = playerBit | groundBit

        player = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: 40, height: 400))
        player.fillColor = .red
        player.zPosition = 10

        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size, center: CGPoint(x: 20, y: 20))
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.restitution = 0.0
        player.physicsBody?.categoryBitMask = playerBit
        player.physicsBody?.collisionBitMask =  groundBit
        player.physicsBody?.contactTestBitMask =  allCategory
        player.physicsBody?.usesPreciseCollisionDetection = true

        addChild(player)
    }

    func jump(force: CGFloat) {
        if (self.on_ground) {
            self.player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: force))
            self.player.physicsBody?.collisionBitMask = groundBit
            self.on_ground = false
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        print("touches began")

        self.pressed = true
        let timerAction = SKAction.wait(forDuration: TimeInterval(delta_force_time))

        let update = SKAction.run {
            if (self.force < self.max_force) {
                self.force += self.delta_force
            } else {
                self.jump(force: self.max_force)
                self.force = self.max_force
            }
        }

        let sequence = SKAction.sequence([timerAction, update])
        let jumpAction = SKAction.repeatForever(sequence)
        self.run(jumpAction, withKey:"jumpAction")

        print("force = \(force)")

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches moved")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        print("touches ended")

        self.removeAction(forKey: "jumpAction")
        self.jump(force: self.force)
        self.force = min_force
        self.pressed = false
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches cancelled")
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    func didBegin(_ contact: SKPhysicsContact) {
        on_ground = true
    }

    func didEnd(_ contact: SKPhysicsContact) {
        on_ground = false
    }
}
