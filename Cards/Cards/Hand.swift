//
//  Hand.swift
//  Cards
//
//  Created by Daniel Nunez on 19-03-21.
//

import Foundation

public struct Hand {

    var AS = 14

    init() {}


    func validHand(hand: [Int]) -> Bool {
        var tempHand = hand
        var isValid = false

        if tempHand.count > 7 {

            return false
        } else if tempHand.first == AS {
            tempHand[0] = 1
        }

        let consecutives = tempHand.map { $0 - 1 }.dropFirst() == tempHand.dropLast()

        isValid = consecutives

        return isValid
    }
}
