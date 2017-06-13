//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Rob Percival on 05/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = 0
    var gameOverLabel = SKLabelNode()
    var timer = Timer()
    
    // ENUM
    enum ColliderType: UInt32{
        
        case Bird = 1
        case Objects = 2
        case gap = 4
        
    }
    
    var gameOver = false
    
    
    /*                                            MAKE THE PIPES and GAPS  + THEIR TEXTURES AND ANIMATIONS                                  */
    func makePipes() {
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.run(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Objects.rawValue
        pipe1.physicsBody?.categoryBitMask = ColliderType.Objects.rawValue
        pipe1.physicsBody?.collisionBitMask = ColliderType.Objects.rawValue
        pipe1.zPosition = -1
        self.addChild(pipe1)
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe2.physicsBody!.isDynamic = false
        
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Objects.rawValue
        pipe2.physicsBody?.categoryBitMask = ColliderType.Objects.rawValue
        pipe2.physicsBody?.collisionBitMask = ColliderType.Objects.rawValue
        pipe2.zPosition = -1
        
        self.addChild(pipe2)
        
        let gap = SKNode()
        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeOffset)
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeTexture.size().width, height: gapHeight))
        gap.physicsBody!.isDynamic = false
        
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        gap.physicsBody?.categoryBitMask = ColliderType.gap.rawValue
        gap.physicsBody?.collisionBitMask = ColliderType.gap.rawValue

        self.addChild(gap)
        
        scoreLabel.fontName = "Halvetica"
        scoreLabel.fontSize = 32
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
        self.addChild(scoreLabel)
    }
    
    
    /*                          WE HAVE A CONTACT! STOP THE GAME!              */
    func didBegin(_ contact: SKPhysicsContact) {
       
        if gameOver == false {
        if contact.bodyA.categoryBitMask == ColliderType.gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.gap.rawValue{
            score += 1
            print("Add 1 to score")
        
        } else {
            
            print("We have a contact")
            self.speed = 0
            timer.invalidate()
            gameOver = true
            gameOverLabel.fontName = "Halvetica"
            gameOverLabel.text = "Game over! Tap to play again."
            gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.addChild(gameOverLabel)
        }
    }
    }
    
 /*                         SET UP GAME (MOVE BACKGROUND EVERY 3 SECONDS, ANIMATE BIRD) and GROUND                */
    
    func setUpGame(){
    
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 0)
        let moveBGForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
        
        var i: CGFloat = 0
        
        while i < 3 {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: bgTexture.size().width * i, y: self.frame.midY)
            
            bg.size.height = self.frame.height
            
            bg.run(moveBGForever)
            
            bg.zPosition = -2
            
            self.addChild(bg)
            
            i += 1
            
        }
        
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        bird.run(makeBirdFlap)
        
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        bird.physicsBody!.isDynamic = false
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Objects.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        self.addChild(bird)
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody!.isDynamic = false
        ground.physicsBody!.contactTestBitMask = ColliderType.Objects.rawValue
        ground.physicsBody?.categoryBitMask = ColliderType.Objects.rawValue
        ground.physicsBody?.collisionBitMask = ColliderType.Objects.rawValue
        
        
        self.addChild(ground)
        
        
    }
    
    
   /*                                               CALL SETUPGAME()                                */
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        setUpGame()
      
        
    }
    
    
    
    /*                                                  TOUCHES BEGAN                                       */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameOver == false {
            bird.physicsBody!.isDynamic = false
            bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 50))
        } else {
        
           
            gameOver = false
            score = 0
        self.speed = 1
            self.removeAllChildren()
        
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
