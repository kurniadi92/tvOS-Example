class AppData {
    static private let images = [
        "1AQ4nd4S8KQ",
        "ApOnzwFVitQ",
        "AwTu6RFgWj8",
        "Br0F5xMArxI",
        "bZZzwY-g2QE",
        "C95qOcY61RE",
        "etu79NENlDE",
        "FC_FlEf32Cw",
        "kReaeCvbj5I",
        "LiKYBjz6spc",
        "T3L72nHQ6aQ",
        "TTz8HGV9J9I",
        "u7S0O4rP4uA",
        "xcugN-enErw",
        "Z__lpNQPaSM"
    ]
    
    static let allWords = ["Lead", "Follow", "Go", "Into", "Back", "Run", "Searching", "For", "to", "Direction", "Of", "From", "Fly", "In", "Deep", "Inside", "Every", ""] + firstName + lastName
    
    static private let firstName = [
        "Love", "Hate", "Despair", "Happy", "Sad", "Mad", "Emotion", "Sick", "Anxious", "Depression", "Grateful", "Free"
    ]
    
    static private let middleName = [
        "Lead to", "Follow", "Go Into", "Back to", "Run to", "Searching For", "From", "Direction of", "Fly to", "In Deep of", "Inside every", "Behind Every"
    ]
    
    static private let lastName = [
        "Rome", "Heart", "Mind", "City", "Paradise", "Hell", "Tokyo", "Sea", "Mountain", "Football", "South", "Island"
    ]
    
    private static var _temp = [Content]()
    
    static func all() -> [Content] {
        guard _temp.isEmpty else {
            return _temp
        }
        var contents = [Content]()
        
        (0..<30).forEach { _ in
            let title = "\(firstName[Int.random(in: 0..<12)]) \(middleName[Int.random(in: 0..<12)]) \(lastName[Int.random(in: 0..<12)])"
            let content = Content(title: title, imageName: images[Int.random(in: 0..<15)], isMovie: Bool.random())
            contents.append(content)
        }
        
        _temp = contents
        
        return contents
    }
}
