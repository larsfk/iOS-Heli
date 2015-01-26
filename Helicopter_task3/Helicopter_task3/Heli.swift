// ---------------------------------------
// Sprite definitions for 'heliSheet'
// Generated with TexturePacker 3.6.0
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class Heli {

    // sprite names
    let HELI_1 = "heli_1"
    let HELI_2 = "heli_2"
    let HELI_3 = "heli_3"
    let HELI_4 = "heli_4"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "heliSheet")


    // individual texture objects
    func heli_1() -> SKTexture { return textureAtlas.textureNamed(HELI_1) }
    func heli_2() -> SKTexture { return textureAtlas.textureNamed(HELI_2) }
    func heli_3() -> SKTexture { return textureAtlas.textureNamed(HELI_3) }
    func heli_4() -> SKTexture { return textureAtlas.textureNamed(HELI_4) }


    // texture arrays for animations
    func heli_fly() -> [SKTexture] {
        return [
            heli_1(),
            heli_2(),
            heli_3(),
            heli_4()
        ]
    }


}
