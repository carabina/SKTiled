//
//  SKTiledScene.swift
//  SKTiled
//
//  Created by Michael Fessenden on 6/22/16.
//  Copyright (c) 2016 Michael Fessenden. All rights reserved.
//

import SpriteKit


/**
 Delegate for managing `SKTilemap` nodes in an `SKScene`. This protocol and the `SKTiledScene` objects are included as a suggested way to use the `SKTilemap` class, but are not required.
 
 In this configuration, the tile map is a child of the world node and reference the custom `SKTiledSceneCamera` camera.
 
 - parameter worldNode:  `SKNode!` world container node.
 - parameter cameraNode: `SKTiledSceneCamera!` scene camera node.
 - parameter tilemap:    `SKTilemap!` tile map node.
 */
protocol SKTiledSceneDelegate {
    /// World container node
    var worldNode: SKNode! { get set }
    /// Custom scene camera.
    var cameraNode: SKTiledSceneCamera! { get set }
    /// Tile map node.
    var tilemap: SKTilemap! { get set }
}


/**
 Custom scene type for managing `SKTilemap` nodes.
 
 - parameter worldNode:  `SKNode!` world container node.
 - parameter cameraNode: `SKTiledSceneCamera!` scene camera node.
 - parameter tilemap:    `SKTilemap!` tile map node.
 */
public class SKTiledScene: SKScene, SKTiledSceneDelegate {
    
    /// World container node
    public var worldNode: SKNode!
    /// Custom scene camera.
    public var cameraNode: SKTiledSceneCamera!
    /// Tile map node.
    public var tilemap: SKTilemap!
    /// Current tmx file name.
    public var tmxFilename: String!
    
    // MARK: - Init
    /**
     Initialize without a tiled map.
     
     - parameter size: `CGSize` scene size.     
     - returns: `SKTiledScene` scene.
     */
    override public init(size: CGSize) {
        super.init(size: size)
        setupWorld()
    }
    
    /**
     Initialize with a tiled file name.
     
     - parameter size:    `CGSize` scene size.
     - parameter tmxFile: `String` tiled file name.
     */
    public init(size: CGSize, tmxFile: String) {
        super.init(size: size)
        setupWorld()
        tmxFilename = tmxFile
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToView(view: SKView) {
        guard let worldNode = worldNode else { return }
        
        // setup the camera
        setupCamera()
        
        // load the current tmx file name
        guard let tmxFilename = tmxFilename else { return }
        
        if let tilemapNode = load(fromFile: tmxFilename) {
            // add the tilemap to the world container node.
            worldNode.addChild(tilemapNode)
            self.tilemap = tilemapNode
            
            // set the camera world scale to the tilemap worldScale
            cameraNode.setWorldScale(self.tilemap.worldScale)
            cameraNode.allowMovement = self.tilemap.allowMovement
            cameraNode.allowZoom = self.tilemap.allowZoom
        }
    }
    
    // MARK: - Setup
    
    /**
     Setup the world container node.
     */
    public func setupWorld(){
        if (worldNode != nil){
            worldNode.removeFromParent()
        }
        // set up world node
        worldNode = SKNode()
        worldNode.name = "World"
        addChild(worldNode)
    }
    
    /**
     Setup scene camera.
     */
    public func setupCamera(){
        guard let view = self.view else { return }
        cameraNode = SKTiledSceneCamera(view: view, world: worldNode)
        addChild(cameraNode)
        camera = cameraNode
    }
    
    /**
     Load a named tmx file.
     
     - parameter fileNamed: `String` tmx file name.
     - returns: `SKTilemap?` tile map node.
     */
    public func load(fromFile filename: String) -> SKTilemap? {
        if let tilemapNode = SKTilemap.load(fromFile: filename) {
            if (tilemapNode.backgroundColor != nil) {
                self.backgroundColor = tilemapNode.backgroundColor!
            }
            return tilemapNode
        }
        return nil
    }
    
    override public func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
