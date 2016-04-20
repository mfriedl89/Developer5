
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
        
        
        /*let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.buttons["Create new user"].tap()
        
        let textFieldUsername = app.textFields["desiredUsername"]
        textFieldUsername.tap()
        textFieldUsername.typeText("anton")
        
        let textFieldfirstName = app.textFields["firstName"]
        textFieldfirstName.tap()
        textFieldfirstName.typeText("Anton")
        
        let textFieldsurName = app.textFields["surName"]
        textFieldsurName.tap()
        textFieldsurName.typeText("Müller")
        
        let textFieldPassword = app.textFields["password"]
        textFieldPassword.tap()
        textFieldPassword.typeText("P@sswort1234")
        
        let textFieldRepeatPassword = app.textFields["repeatPassword"]
        textFieldRepeatPassword.tap()
        textFieldRepeatPassword.typeText("P@sswort1234")
        
        app.buttons["Done"].tap()*/
        
        //Test has to go here, but currently the view isn't in his final position.
    }
    
}
