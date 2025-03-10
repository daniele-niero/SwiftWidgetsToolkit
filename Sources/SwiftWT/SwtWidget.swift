

public class SwtWidget: SwtObject {
    public override init(parent: SwtObject? = nil) {
        super.init(parent: parent) 

        if parent == nil {
            // we need a window to host the widget
            let _ = SwtCoreWindow("Nice Test!")
        }
    }
}
