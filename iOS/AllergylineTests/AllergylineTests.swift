import XCTest
@testable import Allergyline

@MainActor
final class AllergylineTests: XCTestCase {
    func test_freshStore_hasSeedData() {
        let store = Store()
        XCTAssertFalse(store.entries.isEmpty)
    }

    func test_freshStore_doesNotHitFreeLimit() {
        let store = Store()
        XCTAssertFalse(store.isAtFreeLimit, "Seed data alone must never trip the paywall")
    }

    func test_add_incrementsCount() {
        let store = Store()
        let before = store.entries.count
        _ = store.add(AllergylineEntry())
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func test_add_respectsFreeLimit() {
        let store = Store()
        while store.entries.count < Store.freeEntryLimit {
            _ = store.add(AllergylineEntry())
        }
        let result = store.add(AllergylineEntry())
        XCTAssertFalse(result)
        XCTAssertTrue(store.isAtFreeLimit)
    }

    func test_delete_removesEntry() {
        let store = Store()
        let entry = AllergylineEntry()
        _ = store.add(entry)
        store.delete(entry)
        XCTAssertFalse(store.entries.contains(entry))
    }

    func test_update_modifiesExistingEntry() {
        let store = Store()
        var entry = AllergylineEntry()
        _ = store.add(entry)
        entry.createdAt = Date.distantPast
        store.update(entry)
        XCTAssertEqual(store.entries.first(where: { $0.id == entry.id })?.createdAt, Date.distantPast)
    }

    func test_deleteAtOffsets_removesCorrectEntry() {
        let store = Store()
        let countBefore = store.entries.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.entries.count, countBefore - 1)
    }

    func test_seedData_isNotEmpty() {
        XCTAssertGreaterThan(Store.seedData().count, 0)
    }
}
