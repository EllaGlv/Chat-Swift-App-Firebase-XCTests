//
//  ChatTests.swift
//  ChatTests
//
//  Created by Alla Golovinova on 07.10.2021.
//

import XCTest
@testable import Chat

class ChatTests: XCTestCase {
    var dataSource: ChatViewController!
    let tableView = UITableView()
    
    override func setUpWithError() throws {
        
        dataSource = ChatViewController()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        for number in 0..<3 {
            let message = Message(sender: "123", body: "\(number)", userName: "Jane")
            dataSource.messages.append(message)
        }
    }
    
    
    //Testing Chat TableView
    
    func testDataSourceHasMessages() {
        XCTAssertEqual(dataSource.messages.count, 3,
                       "DataSource should have correct number of messages")
    }
    
    func testNumberOfRows() {
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 3,
                       "Number of rows in table should match number of messages")
    }
    
    func testCellForRow() {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MessageCell
        XCTAssertEqual(cell.label.text, "0",
                       "The first cell should display 0")
    }
    
    func testSenderNameAfterSendingMessage() {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MessageCell
        XCTAssertEqual(cell.rightNameLabel.text, "J",
                       "The first cell should display first letter of username in Avatar")
    }
    
    func testCheckPlaceAndColorOfMessage() {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MessageCell
        XCTAssertEqual(cell.MessageBubble.backgroundColor, UIColor(named: K.BrandColors.lightGray),
                       "The color of background od another user should be lightGray")
        XCTAssertEqual(cell.leftViewWithImage.isHidden, false,
                       "The view should be on the left side")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
