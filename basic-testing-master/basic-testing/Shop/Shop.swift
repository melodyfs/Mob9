//
//  Shop.swift
//  basic-testing
//
//  Created by Eliel Gordon on 5/23/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation

protocol ShopType {
    associatedtype Merchandise
    var products: [Merchandise] {get set}
    var cart: Cart {get set}
    
    func checkout()
}

enum CouponCode {
    case basic(discount: Double)
    case silver(discount: Double)
    case gold(discount: Double)
    case none
    
    func returnDiscount() -> Double {
        switch self {
        case .basic(let discount), .silver(let discount), .gold(let discount):
            return discount
        default:
            return 0.0
        }
    }
}

protocol Cartable {
    associatedtype Item
    var items: [Item] {get set}
    var taxPercent: Double {get set}
    var discountPercent: Double {get set}
    var couponCode: CouponCode {get set}
    
    func checkout()
    // Total line items without tax and coupon
    func subTotal() -> Double
    // Total line items with tax minus discount
    mutating func total() -> Double
    mutating func add(item: Item...)
    func numberOfItems() -> Int
    mutating func addCoupon(code: CouponCode) -> Double
}

struct LineItem {
    var id: Int
    var quantity: Int
    var price: Double
    var name: String
}


// TODO: Fill in. Product a shop can sell
// id, name, price
struct Product {
    var id: Int
    var name: String
    var price: Int
}

// TODO: Fill in implementation
struct Cart: Cartable {
    var items: [LineItem]
    var taxPercent: Double
//    var totalPrice: Double
    
    var discountPercent: Double
    
    var couponCode: CouponCode
    
    func checkout() {
        
    }
    
    func subTotal() -> Double {
        var total = 0.0
        
        for item in items {
            total += item.price * Double(item.quantity)
        }
        
        return total
    }
    
    mutating func total() -> Double {
        
        return subTotal() + subTotal() * taxPercent - addCoupon(code: couponCode)
    }
    
    mutating func add(item: LineItem...) {
        items.append(contentsOf: item)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    mutating func addCoupon(code: CouponCode) -> Double {
        couponCode = code
        return subTotal() * code.returnDiscount()
    }
}
struct Shop {}

