//
//  SKTiledObject.swift
//  SKTiled
//
//  Created by Michael Fessenden on 5/16/16.
//  Copyright © 2016 Michael Fessenden. All rights reserved.
//

import SpriteKit


/**
 Protocol describing a generic Tiled object with a properties dictionary.
 
 Objects conforming to this protocol support custom properties that can be parsed via the `SKTilemapParser` parser.
 */
public protocol SKTiledObject: Hashable {
    var uuid: String { get set }                    // unique id (layer & object names may not be unique).
    var properties: [String: String] { get set }    // properties shared by most objects.
    func parseProperties()                          // parse the properties
    //func parseProperties(withBlock: ()->())         // parse properties with closure.
}


public extension SKTiledObject {
    
    public var hashValue: Int { return uuid.hashValue }
    
    // MARK: - Properties Parsing
    /**
     Returns true if the node has the given property.
     
     - parameter key: `String` key to query.
     
     - returns: `Bool` properties has a value for the key.
     */
    public func hasKey(key: String) -> Bool {
        if let _ = properties[key] { return true }
        return false
    }
    
    /**
     Returns a string for the given key.
     
     - parameter key: `String` properties key.
     
     - returns: `String` value for properties key.
     */
    public func stringForKey(key: String) -> String? {
        return properties[key]
    }
    
    /**
     Returns a string array for the given key.
     
     - parameter key:         `String` properties key.
     - parameter separatedBy: `String` separator.
     
     - returns: `[String]` value for properties key.
     */
    public func stringArrayForKey(key: String, separatedBy: String=",") -> [String] {
        if let value = properties[key] {
            return value.componentsSeparatedByString(separatedBy)
        }
        return [String]()
    }
    
    /**
     Returns a integer value for the given key.
     
     - parameter key: `String` properties key.
     
     - returns: `Int?` value for properties key.
     */
    public func intForKey(key: String) -> Int? {
        guard (hasKey(key) == true) else { return nil }
        return Int(properties[key]!)
    }
    
    /**
     Returns a integer array for the given key.
     
     - parameter key:         `String` properties key.
     - parameter separatedBy: `String` separator.
     
     - returns: `[Int]` array of integers for properties key.
     */
    public func integerArrayForKey(key: String, separatedBy: String=",") -> [Int] {
        if let value = properties[key] {
            return  value.componentsSeparatedByString(separatedBy).flatMap { Int($0) }
        }
        return [Int]()
    }
    
    /**
     Returns a float value for the given key.
     
     - parameter key: `String` properties key.
     
     - returns: `Double?` value for properties key.
     */
    public func doubleForKey(key: String) -> Double? {
        guard (hasKey(key) == true) else { return nil }
        return Double(properties[key]!)
    }
    
    /**
     Returns a double array for the given key.
     
     - parameter key:         `String` properties key.
     - parameter separatedBy: `String` separator.
     
     - returns: `[Double]` array of doubles for properties key.
     */
    public func doubleArrayForKey(key: String, separatedBy: String=",") -> [Double] {
        if let value = properties[key] {
            return  value.componentsSeparatedByString(separatedBy).flatMap { Double($0) }
        }
        return [Double]()
    }
    
    /**
     Returns a boolean value for the given key.
     
     - parameter key: `String` properties key.
     
     - returns: `Bool` value for properties key.
     */
    public func boolForKey(key: String) -> Bool {
        guard let value = properties[key]?.lowercaseString else { return false }
        return ["true", "false", "yes", "no"].contains(value) ? (["true", "yes"].contains(value)) ? true : false : false
    }
    
    /// Returns a string representation of the node's properties.
    public var propertiesString: String {
        var pstring = ""
        for value in properties.enumerate() {
            let indexIsLast = value.0 < (properties.count - 1)
            pstring += (indexIsLast==true) ? "\"\(value.1.0)\": \(value.1.1), " : "\"\(value.1.0)\": \(value.1.1)"
        }
        return pstring
    }
    
    // MARK: - Key/Value Parsing
    /**
     Parses a key/value string (separated byt '=') and returns a tuple.
     
     - parameter string: `String` key/value string.
     
     - returns: `(String:Any)?` value for properties key.
     */
    public func keyValuePair(string: String) -> (key: String, value: Any)? {
        var result: (key: String, value: Any)? = nil
        let values = string.componentsSeparatedByString("=")
        if values.count == 2 {
            result = (key: values[0], value: values[1])
    }
        return result
    }
}

