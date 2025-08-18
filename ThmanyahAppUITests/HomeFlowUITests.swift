import XCTest

final class HomeFlowUITests: XCTestCase {
    func test_toolbar_and_title_exist() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.navigationBars.staticTexts["مساء الخير"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["magnifyingglass"].exists || app.images["magnifyingglass"].exists)
    }

    func test_toggle_search_view() throws {
        let app = XCUIApplication()
        app.launch()
        let searchButton = app.buttons.firstMatch
                searchButton.tap() 
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
        // Close search
        searchButton.tap()
        XCTAssertTrue(textField.exists)
    }
}
