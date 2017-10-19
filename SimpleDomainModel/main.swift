//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//
//  @author: Yeun-Yuan(Jessie) Kuo
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol CustomStringConvertible {
    var description : String {
        get
    }
}

protocol Mathematics {
    func add(_: Money) -> Money
    func subtract(_:Money) -> Money
}

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
    }
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    public enum newCurrency : String {
        case USD = "USD"
        case GBP = "GBP"
        case EUR = "EUR"
        case CAN = "CAN"
    }
    
    var description: String {
        return ("\(currency)\(Double(amount))")
    }
    
    public func convert(_ to: String) -> Money {
        var updatedAmount = 0.0
        var updatedCurrency = ""
        switch self.currency {
        case "USD":
            switch to {
            case "GBP":
                updatedAmount = Double(amount) * 0.5
                updatedCurrency = "GBP"
            case "EUR":
                updatedAmount = Double(amount) * 1.5
                updatedCurrency = "EUR"
            case "CAN":
                updatedAmount = Double(amount) * 1.25
                updatedCurrency = "CAN"
            default:
                break
            }
        case "GBP":
            switch to {
            case "USD":
                updatedAmount = Double(amount) * 2
                updatedCurrency = "USD"
            case "EUR":
                updatedAmount = Double(amount) * 3
                updatedCurrency = "EUR"
            case "CAN":
                updatedAmount = Double(amount) * 2.5
                updatedCurrency = "CAN"
            default:
                break
            }
        case "EUR":
            switch to {
            case "USD":
                updatedAmount = Double(amount) * (2.0/3.0)
                updatedCurrency = "USD"
            case "GBP":
                updatedAmount = Double(amount) * (1.0/3.0)
                updatedCurrency = "GBP"
            case "CAN":
                updatedAmount = Double(amount) * (5.0/6.0)
                updatedCurrency = "CAN"
            default:
                break
            }
        case "CAN":
            switch to {
            case "USD":
                updatedAmount = Double(amount) * (4.0/5.0)
                updatedCurrency = "USD"
            case "GBP":
                updatedAmount = Double(amount) * (2.0/5.0)
                updatedCurrency = "GBP"
            case "EUR":
                updatedAmount = Double(amount) * (6.0/5.0)
                updatedCurrency = "EUR"
            default:
                break
            }
        default:
            break
        }
        return Money(amount: Int(updatedAmount), currency: updatedCurrency)
    }
    
    public func add(_ to: Money) -> Money {
        var temp = amount
        if (to.currency != currency) {
            temp = convert(to.currency).amount
        }
        return Money(amount: temp + to.amount, currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        var temp = amount
        if (from.currency != currency) {
            temp = convert(from.currency).amount
        }
        return Money(amount: from.amount - temp, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    var description: String {
        return("Job:\(title), Income:\(calculateIncome(1000))")
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let money):
            return Int(Double(hours) * money)
        case .Salary(let money):
            return money
        }
    }
    
    open func raise(_ amt : Double) {
        switch type {
        case .Hourly(let money):
            type = JobType.Hourly(amt + money)
        case .Salary(let money):
            type = JobType.Salary(Int(amt) + money)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    var description: String {
        var job = ""
        var spouse = ""
        if (self._job != nil) {
            job = "\(self._job)"
        } else {
            job = "Job less"
        }
        if (self._spouse != nil) {
            spouse = "\(self._spouse)"
        } else {
            spouse = "Single"
        }
        return ("[\(firstName) \(lastName), job: \(job), spouse: \(spouse)]")
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if (age >= 16) {
                _job = value
            } else {
                _job = nil
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if (age >= 18) {
                _spouse = value
            } else {
                _spouse = nil
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible {
   
    fileprivate var members : [Person] = []
    
    var description: String {
        var familyMembers = "Family Members: \n"
        for person in 0...members.count {
            familyMembers += "\(members[person].description)"
        }
        return familyMembers
    }
    
    
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            members.append(spouse1)
            spouse2.spouse = spouse1
            members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        var children = false
        for person in members {
            if (person.age >= 21) {
                children = true
            }
        }
        if (children) {
            members.append(child)
        }
        return children
    }
    
    open func householdIncome() -> Int {
        var totalIncome = 0
        for person in members {
            if (person.job != nil) {
                totalIncome += (person.job?.calculateIncome(2000))!
            }
        }
        return totalIncome
    }
}





