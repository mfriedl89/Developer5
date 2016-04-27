
import XCTest

class MetadataUITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        sleep(1);
        let answerButton = app.buttons["Login"]
        answerButton.tap()
        
        let textFieldUsername = app.textFields["username"]
        let textFieldPassword = app.secureTextFields["password"]
        
        sleep(1);
        
        XCTAssert(app.staticTexts["Username:"].exists)
        XCTAssert(app.staticTexts["Password:"].exists)
        
        textFieldUsername.tap()
        XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
        textFieldUsername.typeText("3")
        XCTAssertEqual(textFieldUsername.value as? String, "3")
        
        textFieldPassword.tap()
        XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
        textFieldPassword.typeText("3")
        
        app.buttons["Login"].tap()
        
  
        app.navigationBars["Conari"].buttons["Tutorial erstellen"].tap()
        app.textFields["title"].tap()
        app.textFields["title"].typeText("test")
        XCTAssertEqual(app.textFields["title"].value as? String, "test")
        
        let incrementButton = app.steppers.buttons["Increment"]
        incrementButton.tap()
        incrementButton.tap()
        
        app.textFields["category"].tap()
        
        app.pickerWheels["Arts and Entertainment"].tap()
        app.textFields["duration"].tap()
        app.pickerWheels["00:00"].tap()
        app.buttons["Weiter"].tap()
        
        let element = app.otherElements["texteditor"].childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let element2 = element.childrenMatchingType(.Other).element
        element2.childrenMatchingType(.TextField).element
        element2.childrenMatchingType(.TextField).element
        returnButton.tap()
        element2.childrenMatchingType(.TextField).element
        app.toolbars.containingType(.Button, identifier:"Ordered List").childrenMatchingType(.Button).elementBoundByIndex(6).tap()
        app.sheets.collectionViews.buttons["Photo Library"].tap()
        app.tables.buttons["Moments"].tap()
        app.collectionViews["PhotosGridView"].cells["Photo, Landscape, March 13, 2011, 1:17 AM"].tap()
        sleep(1)
        app.buttons["Save"].tap()
        //app.navigationBars["Test"].buttons["Save"].tap()
        
        
        
        



        
        //Test has to go here, but currently the view isn't in his final position.
    }
    
}
