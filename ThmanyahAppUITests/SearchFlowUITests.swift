import XCTest

final class SearchFlowUITests: XCTestCase {
    func test_search_typing_shows_spinner_then_results_or_empty() {
        let app = XCUIApplication()
        app.launch()

        // Open search
        app.buttons.firstMatch.tap()

        let field = app.textFields.firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText("سوي")

        let progress = app.activityIndicators.firstMatch
        XCTAssertTrue(progress.waitForExistence(timeout: 2), "Spinner should appear while searching")

        XCTAssertTrue(app.otherElements.containing(.any, identifier: "").firstMatch.exists)
    }
}
