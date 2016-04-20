
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
        app.buttons["New Tutorial"].tap()
        
        let title = app.textFields["title"]
        title.tap()
        title.typeText("Test123")
        
        let category = app.textFields["category"]
        category.tap()
        
        app.pickerWheels.element.adjustToPickerWheelValue("Youth")
        
        
        //let stepper = app.steppers["stepper"]
        //stepper.increment
        
        //app.steppers.element.incrementArrows.element.tap();
        
        //app.steppers.element.incrementArrows.element.tap()
        
        let duration = app.textFields["duration"]
        duration.tap()
        app.pickerWheels.element.adjustToPickerWheelValue("00:10")
        
        app.buttons["Weiter"].tap()
        
        let texteditor = app.otherElements["texteditor"]
        texteditor.tap()
        texteditor.typeText("test")
        
        

        app.buttons["Save"].tap()
        
        
        
        
        //Test has to go here, but currently the view isn't in his final position.
    }
    
}
