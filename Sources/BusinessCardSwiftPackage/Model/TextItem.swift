import Foundation

public class TextItem: Identifiable {
    public  var id: String
    public var text: String = ""
    
    public init() {
        id = UUID().uuidString
    }
}



@available(macOS 10.15, *)
public class RecognizedContent: ObservableObject {
    @Published var items = TextItem()
}
