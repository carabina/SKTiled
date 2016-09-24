#Custom Properties

One of the most powerful features of *SKTiled* is the ability to exploit Tiled's custom properties for most objects. 
All objects that conform to the `TiledObject` protocol have methods for parsing Tiled object properties. Tiled property values are all encoded as strings. **SKTiled** will attempt to parse the intended type, but be sure to check the type of property you are querying.

If you are using the v0.17 of Tiled or newer, *SKTiled* supports the new **color** and **file** property types (values are stored as strings internally anyway, which *SKTiled* already supports). The custom color/file types listed above will also be parsed if they are created as string types in Tiled.


    SKTilemap:
      name                (String)    - map name.
      hidden              (Bool)      - hide the map.
      worldScale          (Float)     - world starting scale.
      debug               (Bool)      - debug mode.                                       (debug)      
      gridColor           (Color)     - hex string used for visualizing the tile grid.    (debug)
      gridOpacity         (Float)     - grid overlay opactity.                            (debug)    
      frameColor          (Color)     - hex string used for visualizing the bounding box. (debug)
      highlightColor      (Color)     - hex string used for highlighting tiles.           (debug)
      zPosition           (Float)     - initial zPosition.
      allowMovement       (Bool)      - scene camera movement enabled.
      allowZoom           (Bool)      - scene camera zoom enabled.
      showObjects         (Bool)      - globally show/hide objects in all object groups.
      tileOverlap         (Float)     - tile overlap amount.
      maxZoom             (Float)     - maximum camera zoom.
      minZoom             (Float)     - minimum camera zoom.
      ignoreBackground    (Bool)      - ignore Tiled scene background color.
      antialiasLines      (Bool)      - antialias lines.

    TiledLayerObject:
      hidden              (Bool)      - hide the layer.
      color               (String)    - hex string to override color.
      zPosition           (Float)     - used to manually override layer zPosition.
      gridColor           (Color)     - hex string used for visualizing the tile grid.

    SKObjectGroup:
      lineWidth           (Float)     - object line width.
      showNames           (Bool)      - display object names.
      showObjects         (Bool)      - globally show/hide objects.
      isDynamic           (Bool)      - automatically create objects as dynamic bodies

    SKImageLayer:
      frame               (File)      - image layer animation frame.
      duration            (Float)     - frame duration.

    SKTilesetData:
      collisionSize       (Float)     - used to add collision to the tile.
      collisionShape      (Int)       - 0 = rectangle, 1 = circle.
      nodeClass           (String)    - tile node class**

    SKTileObject:
      hidden              (Bool)      - hide the object.
      color               (String)    - hex string to override object color.
<<<<<<< HEAD
      lineWidth           (Float)     - object line width.   
=======
      lineWidth           (Float)     - object line width.
      nodeClass           (String)    - object node class**

    ** not yet implemented


>>>>>>> iOS10
 Next: [GameplayKit](gameplaykit.html) - [Index](Tutorial.html)


###SKTilemap Colors
    
    // setting one of these in the tiled file will apply it to ALL layers
    gridColor: grid visualization color
    frameColor: bounding box color
    highlightColor: layer highlight color
    
    
###TiledLayerObject Colors

    color:  object group color
    gridColor: grid visualization color
    frameColor: bounding box color
    highlightColor: layer highlight color
