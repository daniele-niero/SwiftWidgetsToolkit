import SDL3

/// A Swift struct representing key events.
public struct SwtKeyEvent: CustomStringConvertible, CustomDebugStringConvertible {
    private let event: SDL_KeyboardEvent

    init(event: SDL_KeyboardEvent) {
        self.event = event
    }
    
    var key: SwtKeyCode {
        if let wrapped = SwtKeyCode(event.key) {
            return wrapped
        } else {
            return SwtKeyCode.unknown
        }
    }

    var modifier: SwtKeyModifier {
        if let wrapped = SwtKeyModifier(event.mod) {
            return wrapped
        } else {
            return SwtKeyModifier.none
        }
    }

    var pressed:  Bool { return event.down }
    var released: Bool { return !event.down }
    var repeated: Bool { return event.repeat }
    
    // Custom description for standard print statements
    public var description: String {
        return "SwtKeyEvent(key: \(key), modifier: \(modifier)), repeat: \(repeated), pressed: \(pressed), released: \(released)"
    }

    // Custom debug description for debug print statements
    public var debugDescription: String {
        return "SwtKeyEvent(sdl_event: \(event))"
    }
}


/// A Swift enum representing SDL virtual key codes.
public enum SwtKeyCode: UInt32 {
    case unknown                = 0x00000000 // ¯\_(ツ)_/¯
    case `return`               = 0x0000000d // \r
    case escape                 = 0x0000001b // \x1B
    case backspace              = 0x00000008 // \b
    case tab                    = 0x00000009 // \t
    case space                  = 0x00000020 //  
    case exclaim                = 0x00000021 // !
    case quote                  = 0x00000022 // "
    case hash                   = 0x00000023 // #
    case dollar                 = 0x00000024 // $
    case percent                = 0x00000025 // %
    case ampersand              = 0x00000026 // &
    case apostrophe             = 0x00000027 // \
    case leftparen              = 0x00000028 // (
    case rightparen             = 0x00000029 // )
    case asterisk               = 0x0000002a // *
    case plus                   = 0x0000002b // +
    case comma                  = 0x0000002c // ,
    case minus                  = 0x0000002d // -
    case period                 = 0x0000002e // .
    case slash                  = 0x0000002f // /
    case _0                     = 0x00000030 // 0
    case _1                     = 0x00000031 // 1
    case _2                     = 0x00000032 // 2
    case _3                     = 0x00000033 // 3
    case _4                     = 0x00000034 // 4
    case _5                     = 0x00000035 // 5
    case _6                     = 0x00000036 // 6
    case _7                     = 0x00000037 // 7
    case _8                     = 0x00000038 // 8
    case _9                     = 0x00000039 // 9
    case colon                  = 0x0000003a // :
    case semicolon              = 0x0000003b // ;
    case less                   = 0x0000003c // <
    case equals                 = 0x0000003d // =
    case greater                = 0x0000003e // >
    case question               = 0x0000003f // ?
    case at                     = 0x00000040 // @
    case leftBracket            = 0x0000005b // [
    case backslash              = 0x0000005c // \\
    case rightBracket           = 0x0000005d // ]
    case caret                  = 0x0000005e // ^
    case underscore             = 0x0000005f // _
    case grave                  = 0x00000060 // `
    case a                      = 0x00000061 // a
    case b                      = 0x00000062 // b
    case c                      = 0x00000063 // c
    case d                      = 0x00000064 // d
    case e                      = 0x00000065 // e
    case f                      = 0x00000066 // f
    case g                      = 0x00000067 // g
    case h                      = 0x00000068 // h
    case i                      = 0x00000069 // i
    case j                      = 0x0000006a // j
    case k                      = 0x0000006b // k
    case l                      = 0x0000006c // l
    case m                      = 0x0000006d // m
    case n                      = 0x0000006e // n
    case o                      = 0x0000006f // o
    case p                      = 0x00000070 // p
    case q                      = 0x00000071 // q
    case r                      = 0x00000072 // r
    case s                      = 0x00000073 // s
    case t                      = 0x00000074 // t
    case u                      = 0x00000075 // u
    case v                      = 0x00000076 // v
    case w                      = 0x00000077 // w
    case x                      = 0x00000078 // x
    case y                      = 0x00000079 // y
    case z                      = 0x0000007a // z
    case leftBrace              = 0x0000007b // {
    case pipe                   = 0x0000007c // |
    case rightBrace             = 0x0000007d // }
    case tilde                  = 0x0000007e // ~
    case delete                 = 0x0000007f 
    case plusminus              = 0x000000b1 
    case capslock               = 0x40000039 
    case f1                     = 0x4000003a 
    case f2                     = 0x4000003b 
    case f3                     = 0x4000003c 
    case f4                     = 0x4000003d 
    case f5                     = 0x4000003e 
    case f6                     = 0x4000003f 
    case f7                     = 0x40000040 
    case f8                     = 0x40000041 
    case f9                     = 0x40000042 
    case f10                    = 0x40000043 
    case f11                    = 0x40000044 
    case f12                    = 0x40000045 
    case printScreen            = 0x40000046 
    case scrollLock             = 0x40000047 
    case pause                  = 0x40000048 
    case insert                 = 0x40000049 
    case home                   = 0x4000004a 
    case pageup                 = 0x4000004b 
    case end                    = 0x4000004d 
    case pagedown               = 0x4000004e 
    case right                  = 0x4000004f 
    case left                   = 0x40000050 
    case down                   = 0x40000051 
    case up                     = 0x40000052 
    case numlockClear           = 0x40000053 
    case kpDivide               = 0x40000054 
    case kpMultiply             = 0x40000055 
    case kpMinus                = 0x40000056 
    case kpPlus                 = 0x40000057 
    case kpEnter                = 0x40000058 
    case kp1                    = 0x40000059 
    case kp2                    = 0x4000005a 
    case kp3                    = 0x4000005b 
    case kp4                    = 0x4000005c 
    case kp5                    = 0x4000005d 
    case kp6                    = 0x4000005e 
    case kp7                    = 0x4000005f 
    case kp8                    = 0x40000060 
    case kp9                    = 0x40000061 
    case kp0                    = 0x40000062 
    case kpPeriod               = 0x40000063 
    case application            = 0x40000065 
    case power                  = 0x40000066 
    case kpEquals               = 0x40000067 
    case f13                    = 0x40000068 
    case f14                    = 0x40000069 
    case f15                    = 0x4000006a 
    case f16                    = 0x4000006b 
    case f17                    = 0x4000006c 
    case f18                    = 0x4000006d 
    case f19                    = 0x4000006e 
    case f20                    = 0x4000006f 
    case f21                    = 0x40000070 
    case f22                    = 0x40000071 
    case f23                    = 0x40000072 
    case f24                    = 0x40000073 
    case execute                = 0x40000074 
    case help                   = 0x40000075 
    case menu                   = 0x40000076 
    case select                 = 0x40000077 
    case stop                   = 0x40000078 
    case again                  = 0x40000079 
    case undo                   = 0x4000007a 
    case cut                    = 0x4000007b 
    case copy                   = 0x4000007c 
    case paste                  = 0x4000007d 
    case find                   = 0x4000007e 
    case mute                   = 0x4000007f 
    case volumeUp               = 0x40000080 
    case volumeDown             = 0x40000081 
    case kpComma                = 0x40000085 
    case kpEqualsAs400          = 0x40000086 
    case altErase               = 0x40000099 
    case sysReq                 = 0x4000009a 
    case cancel                 = 0x4000009b 
    case clear                  = 0x4000009c 
    case prior                  = 0x4000009d 
    case return2                = 0x4000009e 
    case separator              = 0x4000009f 
    case out                    = 0x400000a0 
    case oper                   = 0x400000a1 
    case clearagain             = 0x400000a2 
    case crsel                  = 0x400000a3 
    case exsel                  = 0x400000a4 
    case kp00                   = 0x400000b0 
    case kp000                  = 0x400000b1 
    case thousandsseparator     = 0x400000b2 
    case decimalseparator       = 0x400000b3 
    case currencyunit           = 0x400000b4 
    case currencysubunit        = 0x400000b5 
    case kpLeftparen            = 0x400000b6 
    case kpRightparen           = 0x400000b7 
    case kpLeftbrace            = 0x400000b8 
    case kpRightbrace           = 0x400000b9 
    case kpTab                  = 0x400000ba 
    case kpBackspace            = 0x400000bb 
    case kpA                    = 0x400000bc 
    case kpB                    = 0x400000bd 
    case kpC                    = 0x400000be 
    case kpD                    = 0x400000bf 
    case kpE                    = 0x400000c0 
    case kpF                    = 0x400000c1 
    case kpXor                  = 0x400000c2 
    case kpPower                = 0x400000c3 
    case kpPercent              = 0x400000c4 
    case kpLess                 = 0x400000c5 
    case kpGreater              = 0x400000c6 
    case kpAmpersand            = 0x400000c7 
    case kpDblampersand         = 0x400000c8 
    case kpVerticalbar          = 0x400000c9 
    case kpDblverticalbar       = 0x400000ca 
    case kpColon                = 0x400000cb 
    case kpHash                 = 0x400000cc 
    case kpSpace                = 0x400000cd 
    case kpAt                   = 0x400000ce 
    case kpExclam               = 0x400000cf 
    case kpMemStore             = 0x400000d0 
    case kpMemRecall            = 0x400000d1 
    case kpMemClear             = 0x400000d2 
    case kpMemAdd               = 0x400000d3 
    case kpMemSubtract          = 0x400000d4 
    case kpMemMultiply          = 0x400000d5 
    case kpMemDivide            = 0x400000d6 
    case kpPlusMinus            = 0x400000d7 
    case kpClear                = 0x400000d8 
    case kpClearEntry           = 0x400000d9 
    case kpBinary               = 0x400000da 
    case kpOctal                = 0x400000db 
    case kpDecimal              = 0x400000dc 
    case kpHexadecimal          = 0x400000dd 
    case leftCtrl               = 0x400000e0 
    case leftShift              = 0x400000e1 
    case leftAlt                = 0x400000e2 
    case leftGui                = 0x400000e3 
    case rightCtrl              = 0x400000e4 
    case rightShift             = 0x400000e5 
    case rightAlt               = 0x400000e6 
    case rightGui               = 0x400000e7 
    case mode                   = 0x40000101 
    case sleep                  = 0x40000102 
    case wake                   = 0x40000103 
    case channelIncrement       = 0x40000104 
    case channelDecrement       = 0x40000105 
    case mediaPlay              = 0x40000106 
    case mediaPause             = 0x40000107 
    case mediaRecord            = 0x40000108 
    case mediaFastForward       = 0x40000109 
    case mediaRewind            = 0x4000010a 
    case mediaNextTrack         = 0x4000010b 
    case mediaPreviousTrack     = 0x4000010c 
    case mediaStop              = 0x4000010d 
    case mediaEject             = 0x4000010e 
    case mediaPlayPause         = 0x4000010f 
    case mediaSelect            = 0x40000110 
    case acNew                  = 0x40000111 
    case acOpen                 = 0x40000112 
    case acClose                = 0x40000113 
    case acExit                 = 0x40000114 
    case acSave                 = 0x40000115 
    case acPrint                = 0x40000116 
    case acProperties           = 0x40000117 
    case acSearch               = 0x40000118 
    case acHome                 = 0x40000119 
    case acBack                 = 0x4000011a 
    case acForward              = 0x4000011b 
    case acStop                 = 0x4000011c 
    case acRefresh              = 0x4000011d 
    case acBookmarks            = 0x4000011e 
    case softLeft               = 0x4000011f 
    case softRight              = 0x40000120 
    case call                   = 0x40000121 
    case endCall                = 0x40000122 
    case leftTab                = 0x20000001 
    case level5Shift            = 0x20000002 
    case multiKeyCompose        = 0x20000003 
    case leftMeta               = 0x20000004 
    case rightMeta              = 0x20000005 
    case leftHyper              = 0x20000006 
    case rightHyper             = 0x20000007 

    public init?(_ rawValue: UInt32) {
        self.init(rawValue: rawValue)
    }
}

public enum SwtKeyModifier: UInt16 {
    case none       = 0x0000
    case lShift     = 0x0001
    case rShift     = 0x0002
    case lCtrl      = 0x0040
    case rCtrl      = 0x0080
    case lAlt       = 0x0100
    case rAlt       = 0x0200
    case lGui       = 0x0400
    case rGui       = 0x0800
    case numLock    = 0x1000
    case capsLock   = 0x2000
    case mode       = 0x4000
    case scroll     = 0x8000
    case ctrl       = 0x00C0 // lCtrl | rCtrl
    case shift      = 0x0003 // lShift | rShift
    case alt        = 0x0300 // lAlt | rAlt
    case gui        = 0x0C00 // lGui | rGui

    public init?(_ rawValue: UInt16) {
        self.init(rawValue: rawValue)
    }
}
