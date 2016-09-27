//
//  SKTilesetData.swift
//  SKTiled
//
//  Created by Michael Fessenden on 3/21/16.
//  Copyright © 2016 Michael Fessenden. All rights reserved.

import SpriteKit


/**
 A simple data structure representing an animated tile frame.
 
 - parameter gid:       `Int` unique tile id.
 - parameter duration:  `TimeInterval` frame duration.
  - parameter texture:  `SKTexture?` optional tile texture.
 */
internal struct AnimationFrame {
    public var gid: Int = 0
    public var duration: NSTimeInterval = 0
    public var texture: SKTexture? = nil
}


/**
The `SKTilesetData` represents a single tileset tile data, with texture, id and properties:
 
- tile texture
- tile animation
- tile orientation
 */
public class SKTilesetData: SKTiledObject  {
    
    weak public var tileset: SKTileset!               // is assigned on add
    public var uuid: String = NSUUID().UUIDString     // unique id
    public var id: Int = 0                            // tile id
    public var texture: SKTexture!                    // initial tile texture
    public var source: String! = nil                  // source image name (part of a collections tileset)
    public var probability: CGFloat = 1.0             // used in Tiled application, might not be useful here.
    public var properties: [String: String] = [:]
    
    // animation frames
    internal var frames: [AnimationFrame] = []        // animation frames
    public var isAnimated: Bool { return frames.count > 0 }
    
    // flipped flags
    public var flipHoriz: Bool = false                // tile is flipped horizontally
    public var flipVert:  Bool = false                // tile is flipped vertically
    public var flipDiag:  Bool = false                // tile is flipped diagonally
    
    public var localID: Int {                         // return the local id for this tile
        guard let tileset = tileset else { return id }
        return tileset.getLocalID(forGlobalID: id)
    }
    
    // MARK: - Init
    public init(){}
    
    /**
     Initialize the data with a tileset, id.
     
     - parameter tileId:  `Int` unique tile id.
     - parameter tileSet: `SKTileset` tileset reference.
     - returns: `SKTilesetData` tile data.
     */
    public init(tileId: Int, withTileset tileSet: SKTileset) {
        self.id = tileId
        self.tileset = tileSet
    }
    
    /**
     Initialize the data with a tileset, id & texture.
     
     - parameter tileId:  `Int` unique tile id.
     - parameter texture: `SKTexture` tile texture.
     - parameter tileSet: `SKTileset` tileset reference.
     - returns: `SKTilesetData` tile data.
     */
    public init(tileId: Int, texture: SKTexture, tileSet: SKTileset) {
        self.id = tileId
        self.texture = texture
        self.texture.filteringMode = .Nearest
        self.tileset = tileSet
    }
    
    /**
     Add tile animation to the data.
     
     - parameter gid:         `Int` id for frame.
     - parameter duration:    `NSTimeInterval` frame interval.
     - parameter tileTexture: `SKTexture?` frame texture.
     */
    public func addFrame(gid: Int, interval: NSTimeInterval, tileTexture: SKTexture? = nil) {
        frames.append(AnimationFrame(gid: gid, duration: interval, texture: tileTexture))
    }
    
    /**
     Remove a tile animation frame.
     
     - parameter gid: `Int` id for frame.
     - returns: `AnimationFrame?` animation frame (if it exists).
     */
    func removeFrame(gid: Int) -> AnimationFrame? {
        if let index = frames.indexOf( { $0.gid == gid } ) {
            return frames.removeAtIndex(index)
        }
        return nil
    }
}


public func ==(lhs: SKTilesetData, rhs: SKTilesetData) -> Bool{
    return (lhs.hashValue == rhs.hashValue)
}


extension SKTilesetData: Hashable {
    public var hashValue: Int { return id.hashValue }
}


extension AnimationFrame: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { return "\(gid): \(duration)" }
    public var debugDescription: String { return description }
}


extension SKTilesetData: CustomStringConvertible, CustomDebugStringConvertible {
    
    /// Tile data description.
    public var description: String {
        guard let tileset = tileset else { return "Tile ID: \(id) (no tileset)" }
        let tileSizeString = "\(Int(tileset.tileSize.width))x\(Int(tileset.tileSize.height))"
        var dataString = properties.count > 0 ? "Tile ID: \(id) @ \(tileSizeString), " : "Tile ID: \(id) @ \(tileSizeString)"
        for (index, pair) in properties.enumerate() {
            let pstring = (index < properties.count - 1) ? "\"\(pair.0)\": \(pair.1)," : "\"\(pair.0)\": \(pair.1)"
            dataString += pstring
        }
        return dataString
    }
    
    public var debugDescription: String { return description }
}
