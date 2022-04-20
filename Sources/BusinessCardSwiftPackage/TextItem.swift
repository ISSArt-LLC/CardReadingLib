import Foundation

class TextItem: Identifiable {
    var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}



@available(macOS 10.15, *)
public class RecognizedContent: ObservableObject {
    @Published var items = TextItem()
}
