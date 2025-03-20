import SDL3


public struct SwtRegion {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
}

public struct SwtRect {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
}


public class SwtPaintEvent: SwtEventBase {
    var rect: SwtRect
    var region: SwtRegion

    override init () {
        rect = SwtRect(x: 0, y: 0, width: 10, height: 10)
        region = SwtRegion(x: 0, y: 0, width: 10, height: 10)
    }
}