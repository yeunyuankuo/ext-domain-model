//
//  UnitTest.swift
//  SimpleDomainModel
//
//  Created by Jessie Kuo on 18/10/2017.
//  Copyright © 2017 Ted Neward. All rights reserved.
//

import XCTest
import SimpleDomainModel

class UnitTest: XCTestCase {
    
    func descriptionTest() {
        let test1 = Money(amount: 5, currency:"USD")
        let test2 = Money(amount: 10, currency:"GBP")
        let test3 = Money(amount: 15, currency:"EUR")
        let test4 = Money(amount: 20, currency:"CAN")
        XCTAssert(test1.description == "USD5.0")
        XCTAssert(test2.description == "GBP10.0")
        XCTAssert(test3.description == "EUR15.0")
        XCTAssert(test4.description == "CAN20.0")
    }
    
    func jobPersonTest() {
        let job = Job(title: "developer", type: Job.JobType.Hourly(25))
        XCTAssert(job.description == "Job:developer, Income:25000")
        
        let jessie = Person(firstName: "Jessie", lastName: "Kuo", age: 22)
        jessie.job = Job(title: "developer", type: Job.JobType.Hourly(25))
        jessie.spouse = Person(firstName: "Angelina", lastName: "Jolin", age: 35)
        XCTAssert(jessie.job != nil)
        XCTAssert(jessie.spouse != nil)
        XCTAssert(jessie.description == "[Jessie Kuo, job: developer, spouse: Angelina Jolin]")
    }
    
    func extentionTest() {
        let test1 = Money(amount: 100, currency: "USD")
        let test2 = Money(amount: 1000, currency: "GBP")
        let ext1 = 100.USD
        let ext2 = 1000.GBP
        XCTAssert(test1.amount == ext1.amount && test1.currency == ext1.currency)
        XCTAssert(test2.amount == ext2.amount && test2.currency == ext2.currency)
    }
    
    func testMath() {
        let money1 = Money(amount: 100, currency: "USD")
        let money2 = Money(amount: 50, currency: "USD")
        let money3 = Money(amount: 10, currency: "USD")
        XCTAssert(money1.add(money2).amount == 150 && money2.add(money3).amount == 60)
        XCTAssert(money1.currency == money2.currency && money2.currency == money3.currency && money1.currency == money3.currency)
        
        let moneySub1 = Money(amount: 100, currency: "USD")
        let moneySub2 = Money(amount: 50, currency: "USD")
        let moneySub3 = Money(amount: 10, currency: "USD")
        XCTAssert(moneySub1.subtract(moneySub2).amount == -50 && moneySub2.subtract(moneySub3).amount == -40)
        XCTAssert(moneySub1.currency == moneySub2.currency && moneySub2.currency == moneySub3.currency && moneySub1.currency == moneySub3.currency)
    }
}


