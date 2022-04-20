import Foundation

public class TextItem: Identifiable {
    public  var id: String
    var text: String = ""
    
    init() {
        id = UUID().uuidString
    }
}



@available(macOS 10.15, *)
public class RecognizedContent: ObservableObject {
    @Published var items = TextItem()
}
