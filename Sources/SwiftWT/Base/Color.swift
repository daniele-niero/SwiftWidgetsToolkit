public struct SwtColor {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var alpha: UInt8

    // MARK: Initializers

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8 = 255) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    // Convenience init with floating-point (0.0 - 1.0) values
    init(r: Float, g: Float, b: Float, a: Float = 1.0) {
        self.red = UInt8(max(0, min(255, r * 255)))
        self.green = UInt8(max(0, min(255, g * 255)))
        self.blue = UInt8(max(0, min(255, b * 255)))
        self.alpha = UInt8(max(0, min(255, a * 255)))
    }

    // copy construnctror
    init(_ color: SwtColor) {
        self.red = color.red
        self.green = color.green
        self.blue = color.blue
        self.alpha = color.alpha
    }

    // Computed property to get premultiplied values
    var premultiplied: (UInt8, UInt8, UInt8, UInt8) {
        let a = Float(alpha) / 255.0
        return (
            UInt8(Float(red) * a),
            UInt8(Float(green) * a),
            UInt8(Float(blue) * a),
            alpha
        )
    }
}

public extension SwtColor {
    // Predefined colors in an extension
    static var red: SwtColor { SwtColor(r: 255, g: 0, b: 0) }
    static var green: SwtColor { SwtColor(r: 0, g: 255, b: 0) }
    static var blue: SwtColor { SwtColor(r: 0, g: 0, b: 255) }
    static var white: SwtColor { SwtColor(r: 255, g: 255, b: 255) }
    static var black: SwtColor { SwtColor(r: 0, g: 0, b: 0) }
    static var gray: SwtColor { SwtColor(r: 128, g: 128, b: 128) }
    static var lightGray: SwtColor { SwtColor(r: 211, g: 211, b: 211) }
    static var darkGray: SwtColor { SwtColor(r: 169, g: 169, b: 169) }
    static var yellow: SwtColor { SwtColor(r: 255, g: 255, b: 0) }
    static var cyan: SwtColor { SwtColor(r: 0, g: 255, b: 255) }
    static var magenta: SwtColor { SwtColor(r: 255, g: 0, b: 255) }
}


