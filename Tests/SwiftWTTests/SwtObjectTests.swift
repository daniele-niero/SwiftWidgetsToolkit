import Testing
@testable import SwiftWT

// MARK: - Test Suite

@MainActor
@Suite("SwtObject Parent-Child Relationships")
struct SwtObjectTests {
    
    // MARK: - Initialization Tests
    
    /// Tests that initialization with a parent correctly adds the child.
    @Test("Initializer with parent adds child to parent")
    func initWithParentAddsChild() async {
        let parent =  SwtObject()
        let child =  SwtObject(parent: parent)
        
         #expect(parent.children.contains { $0 === child }) // Verify child is added
         #expect(child.parent === parent) // Verify parent is set
    }
    
    /// Tests initialization without a parent.
    @Test("Initializer without parent leaves parent nil")
    func initWithoutParent() {
        let object = SwtObject()
        #expect(object.parent == nil)
    }
    
    // MARK: - Parent Property Tests
    
    /// Tests that setting `parent` updates relationships correctly.
    @Test("Setting parent updates hierarchy")
    func settingParentUpdatesHierarchy() async throws {
        let oldParent = SwtObject()
        let newParent = SwtObject()
        let child = SwtObject(parent: oldParent)
        
        // Change parent
        child.parent = newParent
        
        // Verify old parent no longer has child
        #expect(!oldParent.children.contains { $0 === child })
        // Verify new parent now has child
        #expect(newParent.children.contains { $0 === child })
        // Verify child's parent is updated
        #expect(child.parent === newParent)
    }
    
    /// Tests that setting `parent` to `nil` removes the child.
    @Test("Setting parent to nil removes child")
    func settingParentToNilRemovesChild() {
        let parent = SwtObject()
        let child = SwtObject(parent: parent)
        child.parent = nil
        
        #expect(parent.children.isEmpty) // Parent has no children
        #expect(child.parent == nil) // Child has no parent
    }
    
    // MARK: - Child Management Tests
    
    /// Tests that duplicate children are not added.
    @Test("Adding duplicate child is ignored")
    func duplicateChildIsIgnored() {
        let parent = SwtObject()
        let child = SwtObject()
        
        child.parent = parent
        child.parent = parent // Attempt duplicate
        
        #expect(parent.children.count == 1) // Only one instance
    }
    
    /// Tests that `removeChild` cleans up both sides of the relationship.
    @Test("removeChild cleans up parent/child links")
    func removeChildCleansUpLinks() {
        let parent = SwtObject()
        let child = SwtObject()
        child.parent = parent
        
        parent.removeChild(child)
        
        #expect(parent.children.isEmpty)
        #expect(child.parent == nil)
    }
}
