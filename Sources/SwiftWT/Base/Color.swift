import Foundation

public struct SwtColor {
    public var red:   UInt8
    public var green: UInt8
    public var blue:  UInt8
    public var alpha: UInt8

    // MARK: Initializers

    public init() {
        self.red   = 0
        self.green = 0
        self.blue  = 0
        self.alpha = 255
    }

    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8 = 255) {
        self.red   = min(r, 255)
        self.green = min(g, 255)
        self.blue  = min(b, 255)
        self.alpha = min(a, 255)
    }

    /// Copy constructor
    public init(_ color: SwtColor) {
        self.red = color.red
        self.green = color.green
        self.blue = color.blue
        self.alpha = color.alpha
    }

    /// Initializes a `SwtColor` from a hex string (e.g., "#RRGGBB" or "#RRGGBBAA").
    public init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        // Remove "#" if present
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        // Ensure valid length (6 or 8 characters)
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else {
            return nil
        }

        var hexValue: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&hexValue) else {
            return nil
        }

        // Extract color components
        let r, g, b, a: UInt8
        if hexSanitized.count == 6 {
            r = UInt8((hexValue >> 16) & 0xFF)
            g = UInt8((hexValue >> 8) & 0xFF)
            b = UInt8(hexValue & 0xFF)
            a = 255 // Default alpha to 255 (fully opaque)
        } else {
            r = UInt8((hexValue >> 24) & 0xFF)
            g = UInt8((hexValue >> 16) & 0xFF)
            b = UInt8((hexValue >> 8) & 0xFF)
            a = UInt8(hexValue & 0xFF)
        }

        self.init(r: r, g: g, b: b, a: a)
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
        let r = Float(red)   / 255.0
        let g = Float(green) / 255.0
        let b = Float(blue)  / 255.0
        return r * 0.2126 + b * 0.7152 + g * 0.0722
    }

    public func contrastRatio(with: SwtColor) -> Float {
        let thisL  = self.relativeLuminance()
        let otherL = with.relativeLuminance()
        let L1 = max(thisL, otherL)
        let L2 = min(thisL, otherL)
        return (L1 + 0.05) / (L2 + 0.05)
    }
}

public struct SwtGlobalColor {
    // Predefined colors in an extension
    static var red:         SwtColor { SwtColor(r: 255, g:   0, b:   0) }
    static var green:       SwtColor { SwtColor(r:   0, g: 255, b:   0) }
    static var blue:        SwtColor { SwtColor(r:   0, g:   0, b: 255) }
    static var white:       SwtColor { SwtColor(r: 255, g: 255, b: 255) }
    static var black:       SwtColor { SwtColor(r:   0, g:   0, b:   0) }
    static var gray:        SwtColor { SwtColor(r: 128, g: 128, b: 128) }
    static var lightGray:   SwtColor { SwtColor(r: 211, g: 211, b: 211) }
    static var darkGray:    SwtColor { SwtColor(r: 169, g: 169, b: 169) }
    static var yellow:      SwtColor { SwtColor(r: 255, g: 255, b:   0) }
    static var cyan:        SwtColor { SwtColor(r:   0, g: 255, b: 255) }
    static var magenta:     SwtColor { SwtColor(r: 255, g:   0, b: 255) }

    public static func color(named name: String) -> SwtColor? {
        let mirror = Mirror(reflecting: SwtGlobalColor.self)
        for case let (label?, value) in mirror.children {
            if label.lowercased() == name.lowercased(), let color = value as? SwtColor {
                return color
            }
        }
        return SwtColor()  // black by default
    }
}


