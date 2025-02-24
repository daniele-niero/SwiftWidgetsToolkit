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