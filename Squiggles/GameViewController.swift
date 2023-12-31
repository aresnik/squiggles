//
//  GameViewController.swift
//  Unscramble
//
//  Created by Alex Resnik on 1/4/23.
//


import UIKit
import SpriteKit
import GameplayKit
import GameKit

var gameWidth: CGFloat = UIScreen.main.bounds.width
var gameHeight: CGFloat = UIScreen.main.bounds.height
var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
var long: CGFloat = 50
var longButton: CGFloat = 18

class GameViewController: UIViewController, GameKitHelperDelegate {
    
    private var currentGame: GameScene!
    private var gameKitHelper: GameKitHelper!
    
    func didChangeAuthStatus(isAuthenticated: Bool) {
        
    }

    func presentGameCenterAuth(viewController: UIViewController?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameKitHelper = GameKitHelper()
        gameKitHelper.delegate = self
        gameKitHelper.authenticatePlayer()
        
        if gameHeight/gameWidth > 2 { long = 100; longButton = 50 }
        
        if idiom == .phone { gameWidth *= 1.0; gameHeight *= 1.0 }
        if idiom == .pad { gameWidth *= 0.6; gameHeight *= 0.6 }
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let scene = StartScene(size: CGSize(width: gameWidth, height: gameHeight))
        
        // Configure the view.
        let skView = self.view as! SKView
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        // Sprite Kit applies additional optimizations to improve rendering performance
        skView.ignoresSiblingOrder = true
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
    }
    
    
    override var shouldAutorotate: Bool {
        
        return true
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            return .allButUpsideDown
        }
        else{
            
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

