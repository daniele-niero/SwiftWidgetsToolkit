/*
 `@unchecked Sendable` is used here because `SDLResource` manages a raw pointer (`OpaquePointer`) which is inherently unsafe.
 However, the class ensures thread safety by only allowing access to the pointer through controlled methods and by ensuring the pointer is properly destroyed in the `deinit` method.
*/
internal final class SDLResource: @unchecked Sendable {
    private var resourcePointer: OpaquePointer?
    private let destroyClosure: (OpaquePointer) -> Void

    /// Accessor to get the underlying pointer.
    var rawPointer: OpaquePointer? {
        return resourcePointer
    }
    
    /// Initializes the resource wrapper with a C pointer and its corresponding destroy function.
    init(pointer: OpaquePointer, destroy: @escaping (OpaquePointer) -> Void) {
        self.resourcePointer = pointer
        self.destroyClosure = destroy
    }
    
    /// Manually destroy the resource if needed.
    func destroy() {
        if let ptr = resourcePointer {
            destroyClosure(ptr)
            resourcePointer = nil
        }
    }
    
    deinit {
        destroy()
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