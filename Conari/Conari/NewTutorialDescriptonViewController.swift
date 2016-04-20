//
//  NewTutorialDescriptonViewController.swift
//  Conari
//
//  Created by Stefan Mitterrutzner on 20/04/16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import UIKit
import RichEditorView


class NewTutorialDescriptonViewController: UIViewController {

    var current:TutorialMetaData = TutorialMetaData(Title: "",category: "",duration: "",difficulty: 0);
    
    var editor:RichEditorView?
    var keyman:KeyboardManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = current.Title
        
        editor = RichEditorView(frame: self.view.bounds)
        editor!.setHTML("<h1>My Awesome Editor</h1>Now I am editing in <em>style.</em><img src=\"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==\"alt=\"Base64 encoded image\" width=\"150\" height=\"150\"/>" )
        editor?.delegate = self
        self.view.addSubview(editor!)
        
        keyman = KeyboardManager(view: self.view)
        keyman?.toolbar.delegate = self
        keyman?.toolbar.editor = editor

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        keyman?.beginMonitoring()
    }
    
    override func viewWillDisappear(animated: Bool) {
        keyman?.stopMonitoring()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    


}

extension NewTutorialDescriptonViewController: RichEditorDelegate {
    
    func richEditor(editor: RichEditorView, heightDidChange height: Int) { }
    
    func richEditor(editor: RichEditorView, contentDidChange content: String) {

    }
    
    func richEditorTookFocus(editor: RichEditorView) { }
    
    func richEditorLostFocus(editor: RichEditorView) { }
    
    func richEditorDidLoad(editor: RichEditorView) { }
    
    func richEditor(editor: RichEditorView, shouldInteractWithURL url: NSURL) -> Bool { return true }
    
    func richEditor(editor: RichEditorView, handleCustomAction content: String) { }
    
}

extension NewTutorialDescriptonViewController: RichEditorToolbarDelegate {
    
    private func randomColor() -> UIColor {
        let colors = [
            UIColor.redColor(),
            UIColor.orangeColor(),
            UIColor.yellowColor(),
            UIColor.greenColor(),
            UIColor.blueColor(),
            UIColor.purpleColor()
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }
    
    func richEditorToolbarChangeTextColor(toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }
    
    func richEditorToolbarChangeBackgroundColor(toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }
    
    func richEditorToolbarInsertImage(toolbar: RichEditorToolbar) {
        toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
    }
    
    func richEditorToolbarInsertLink(toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        if let hasSelection = toolbar.editor?.rangeSelectionExists() where hasSelection {
            toolbar.editor?.insertLink("http://github.com/cjwirth/RichEditorView", title: "Github Link")
        }
    }
}


