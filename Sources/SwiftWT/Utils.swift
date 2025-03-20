import Foundation

/** A custom print function that prints to either standard output or standard error.

 - Parameters:
   - items: The items to print.
   - separator: A string to print between each item. The default is a single space (" ").
   - terminator: A string to print at the end. The default is a newline ("\n").
   - asError: A Boolean value that determines whether to print to standard error. The default is `false`.
*/
func print(_ items: Any..., separator: String = " ", terminator: String = "\n", asError: Bool = false) {
    let output = items.map { "\($0)" }.joined(separator: separator)
    if asError {
        if let data = (output + terminator).data(using: .utf8) {
            FileHandle.standardError.write(data)
        }
    } else {
        Swift.print(output, terminator: terminator)
    }
}

/**
 A wrapper class that holds a weak reference to an object of type `T`.

 This class is useful for storing weak references in collections, such as arrays or dictionaries, to avoid strong reference cycles and ensure that objects can be deallocated when they are no longer needed.

 - Note: The generic type `T` must conform to `AnyObject`.

 - Parameters:
   - value: The object to hold a weak reference to.
 */
class WeakRef<T: AnyObject> {
    /// The weakly referenced object.
    weak var value: T?

    /**
     Initializes a new `WeakRef` instance with the given object.

     - Parameters:
       - value: The object to hold a weak reference to.
     */
    init(_ value: T?) {
        self.value = value
    }
}


// @propertyWrapper
// struct WeakArray<T: AnyObject> {
//     private var elements: [WeakRef<T>] = []

//     var wrappedValue: [WeakRef<T>] {
//         mutating get {
//             elements.removeAll { $0.value == nil }
//             return elements
//         }
//         set {
//             elements = newValue.map { WeakRef(value: $0) }
//         }
//     }
// }