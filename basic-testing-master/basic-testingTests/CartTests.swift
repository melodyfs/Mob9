//
//  ShopTests.swift
//  basic-testingTests
//
//  Created by Eliel Gordon on 5/23/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import XCTest
@testable import basic_testing

class CartTests: XCTestCase {
    var cart: Cart!
    var items = [LineItem]()
    
    override func setUp() {
        super.setUp()
        cart = Cart(items: items, taxPercent: 0.1, discountPercent: 0, couponCode: .gold(discount: 0.2))
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // TODO: Test creating empty shopping cart
    func testCreateEmptyShoppingCartHasNoItems() {
        cart = Cart(items: items, taxPercent: 0.0, discountPercent: 0, couponCode: .gold(discount: 0.2))
        XCTAssert(cart.numberOfItems() == 0)
    }
    
    // TODO: Test Creating line items have the correct total from price and quantity
    func testLineItemTotal() {
        
        let item1 = LineItem(id: 1, quantity: 1, price: 2, name: "Milk")
        let item2 = LineItem(id: 2, quantity: 1, price: 3, name: "Milk")
        cart.add(item: item1)
        cart.add(item: item2)
        
        XCTAssert(cart.total() == 2 + 3)
        XCTAssert(cart.numberOfItems() == 2)

    }
    
    // TODO:
    // Test Adding items to cart works
    // Test that the number of items in cart equal the number of line items inserted
    func testCartAddingItemsToCart() {
        let item1 = LineItem(id: 1, quantity: 1, price: 2, name: "Milk")
        let item2 = LineItem(id: 2, quantity: 1, price: 3, name: "Milk")
        cart.add(item: item1)
        cart.add(item: item2)
        XCTAssert(cart.numberOfItems() == 2)
    }
    
    // TODO: Create line items and tests that total is equal to the number of lineitems multiplied by their respective quantities
    func testCartTotalWithItems() {
        let item1 = LineItem(id: 1, quantity: 1, price: 2, name: "Milk")
        let item2 = LineItem(id: 2, quantity: 2, price: 3, name: "Milk")
        cart.add(item: item1)
        cart.add(item: item2)
        cart.addCoupon(code: .none)
        print(cart.total())
        XCTAssert(cart.total() == 2 * 1 + 3 * 2)
    }
    
    // TODO: Test cart total will be equal to line items * quantity + tax - coupon code
    func testCartTotalWithCouponAndTax() {
        let item1 = LineItem(id: 1, quantity: 1, price: 2, name: "Milk")
        let item2 = LineItem(id: 2, quantity: 2, price: 3, name: "Milk")
        cart.add(item: item1)
        cart.add(item: item2)
        cart.addCoupon(code: .gold(discount: 0.2))
        var total = Double(2 * 1 + 3 * 2)
        XCTAssert(cart.total() == total + total * 0 - total * 0.2)
    }
    
    // TODO: Test cart total will be equal to line items * quantity + tax
    func testCartTotalWithJustTax() {
        let item1 = LineItem(id: 1, quantity: 1, price: 2, name: "Milk")
        let item2 = LineItem(id: 2, quantity: 2, price: 3, name: "Milk")
        cart.add(item: item1)
        cart.add(item: item2)
        cart.addCoupon(code: .none)
        var total = Double(2 * 1 + 3 * 2)
        print(cart.total())
        XCTAssert(cart.total() == total + total * 0.1)
    }
}
