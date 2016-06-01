
import XCTest

class MetadataUITests: XCTestCase {
  
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
    
    sleep(1);
    
    let app = XCUIApplication()
    let answerButton = app.buttons["Login"]
    answerButton.tap()
    
    sleep(1);
    
    XCTAssert(app.staticTexts["Username:"].exists)
    XCTAssert(app.staticTexts["Password:"].exists)
    
    let textFieldUsername = app.textFields["username"]
    let textFieldPassword = app.secureTextFields["password"]
    
    textFieldUsername.tap()
    XCTAssertTrue(textFieldUsername.exists, "Text field username doesn't exist")
    textFieldUsername.typeText("anton")
    XCTAssertEqual(textFieldUsername.value as? String, "anton")
    
    textFieldPassword.tap()
    XCTAssertTrue(textFieldPassword.exists, "Text field password doesn't exist")
    textFieldPassword.typeText("Test1234@")
    
    app.buttons["Login"].tap()
    
    sleep(1);

    app.buttons["Create Text Tutorial"].tap()
    
    sleep(1);
    
    app.textFields["title"].tap()
    app.textFields["title"].typeText("test")
    XCTAssertEqual(app.textFields["title"].value as? String, "test")
    app.buttons["Done"].tap()
    
    sleep(1);
    
    let incrementButton = app.steppers.buttons["Increment"]
    incrementButton.tap()
    incrementButton.tap()
    
    app.textFields["category"].tap()
    app.pickerWheels["Arts and Entertainment"].adjustToPickerWheelValue("Conari")
    app.textFields["duration"].tap()
    app.pickerWheels["00:00"].adjustToPickerWheelValue("00:10")
    
    app.navigationBars["Text Tutorial"].buttons["Next"].tap()

    
    sleep(1);
    
    let element = app.otherElements["texteditor"].childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
    element.tap()
    
    sleep(1);
    
    let returnButton = app.buttons["Return"]
    returnButton.tap()
    sleep(1);
    
    let element2 = element.childrenMatchingType(.Other).element
    element2.childrenMatchingType(.TextField).element
    element2.childrenMatchingType(.TextField).element
    returnButton.tap()
    sleep(1);
    element2.childrenMatchingType(.TextField).element
    app.toolbars.containingType(.Button, identifier:"Ordered List").childrenMatchingType(.Button).elementBoundByIndex(6).tap()
    sleep(1);
    app.sheets.collectionViews.buttons["Photo Library"].tap()
    app.tables.buttons["Moments"].tap()
    app.collectionViews["PhotosGridView"].cells["Photo, Landscape, March 13, 2011, 1:17 AM"].tap()
    sleep(1)
    app.navigationBars["test"].buttons["Save"].tap()
    //app.navigationBars["Test"].buttons["Save"].tap()
    
  }
  
}
