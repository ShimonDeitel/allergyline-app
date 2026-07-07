import Foundation

struct AllergylineEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var hadReaction: Bool
    var severity: String
    var notes: String

    init(id: UUID = UUID(), createdAt: Date = Date(), hadReaction: Bool = false, severity: String = "", notes: String = "") {
        self.id = id
        self.createdAt = createdAt
        self.hadReaction = hadReaction
        self.severity = severity
        self.notes = notes
    }
}
