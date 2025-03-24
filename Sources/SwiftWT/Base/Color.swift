public struct SwtColor {
    var red:   UInt8
    var green: UInt8
    var blue:  UInt8
    var alpha: UInt8

    // MARK: Initializers

    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
        self.red   = r
        self.green = g
        self.blue  = b
        self.alpha = a
    }

    /// Copy constructor
    public init(_ color: SwtColor) {
        self.red = color.red
        self.green = color.green
        self.blue = color.blue
        self.alpha = color.alpha
    }

    // MARK: Properties

    /// Computed property to get premultiplied values
    public var premultiplied: (UInt8, UInt8, UInt8, UInt8) {
        let a = Float(alpha) / 255.0
        return (
            UInt8(Float(red) * a),
            UInt8(Float(green) * a),
            UInt8(Float(blue) * a),
            alpha
        )
    }

    // MARK: Methods

    public func toHex(withAlpha: Bool = false) -> String {
        if withAlpha {
            return String(format: "#%02X%02X%02X%02X", red, green, blue, alpha)
        } else {
            return String(format: "#%02X%02X%02X", red, green, blue)
        }
    }

    public func mixWith(_ otherColor: SwtColor, t: Float = 0.5) -> SwtColor {
        let at = 1.0 - max(0.0, min(t, 1.0))
        let bt = 1.0 - at
        let r = Float(self.red)   * at + Float(otherColor.red)   * bt
        let g = Float(self.green) * at + Float(otherColor.green) * bt
        let b = Float(self.blue)  * at + Float(otherColor.blue)  * bt
        let a = Float(self.alpha) * at + Float(otherColor.alpha) * bt

        return SwtColor(r: UInt8(r), g: UInt8(g), b: UInt8(b), a: UInt8(a))
    }

    public func relativeLuminance() -> Float {
        let r = Float(red) / 255.0
        let g = Float(blue) / 255.0
        let b = Float(green) / 255.0
        let v = 1.0 - (r * 0.21 + b * 0.72 + g * 0.07)
        return v
    }
}

// public extension SwtColor {
//     // Predefined colors in an extension
//     static var red:         SwtColor { SwtColor(r: 255, g:   0, b:   0) }
//     static var green:       SwtColor { SwtColor(r:   0, g: 255, b:   0) }
//     static var blue:        SwtColor { SwtColor(r:   0, g:   0, b: 255) }
//     static var white:       SwtColor { SwtColor(r: 255, g: 255, b: 255) }
//     static var black:       SwtColor { SwtColor(r:   0, g:   0, b:   0) }
//     static var gray:        SwtColor { SwtColor(r: 128, g: 128, b: 128) }
//     static var lightGray:   SwtColor { SwtColor(r: 211, g: 211, b: 211) }
//     static var darkGray:    SwtColor { SwtColor(r: 169, g: 169, b: 169) }
//     static var yellow:      SwtColor { SwtColor(r: 255, g: 255, b:   0) }
//     static var cyan:        SwtColor { SwtColor(r:   0, g: 255, b: 255) }
//     static var magenta:     SwtColor { SwtColor(r: 255, g:   0, b: 255) }
// }


