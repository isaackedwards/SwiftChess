//
//  PlayerTests.swift
//  SwiftChess
//
//  Created by Steve Barnegren on 11/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftChess

class PlayerTests: XCTestCase {
    
     // MARK: - Setup / Tear Down
    var game: Game!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let firstPlayer = Human(color: .white)
        let secondPlayer = Human(color: .black)
        game = Game(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Occupy square tests
    
    func testOccupliesSquareAtLocationReturnsTrueWhenOccupiedByPlayerPiece() {
        
        let location = BoardLocation(index: 0) // <-- should be occupied by white
        XCTAssert(game.whitePlayer.occupiesSquareAt(location: location),
                  "Expected square to be occupied by player color")
    }
    
    func testOccupliesSquareAtLocationReturnsFalseWhenSquareEmpty() {

        let location = BoardLocation(x: 0, y: 2) // <-- should be empty
        XCTAssert(game.whitePlayer.occupiesSquareAt(location: location) == false,
                  "Expected square to not be occupied by player color")
    }
    
    func testOccupliesSquareAtLocationReturnsFalseWhenOccupiedByOppositeColor() {
        
        let location = BoardLocation(x: 0, y: 7) // <-- should be occupied by black
        XCTAssert(game.whitePlayer.occupiesSquareAt(location: location) == false,
                  "Expected square to not be occupied by player color")
    }

    // Piece move tests
    
    func testPlayerCannotMovePieceToSameLocation() {
        let location = BoardLocation(index: 0)
        XCTAssert(game.whitePlayer.canMovePiece(fromLocation: location, toLocation: location) == false)
    }
    
    // MARK: - Move Errors
    
    func gameForTestingCallbacks(board: Board, color: Color) -> Game {
        
        let whitePlayer = Human(color: .white)
        let blackPlayer = Human(color: .black)
        
        let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer, board: board, colorToMove: color)
        
        return game
    }
    
    func testMoveInToCheckErrorIsThrownByMovingQueen() {
        
        let board = ASCIIBoard(pieces: "- - - - * - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "G - - - Q - - r" +
                                       "- - - - - - - -" )

        let queenLocation = board.locationOfCharacter("Q")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: queenLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }
    
    func testMoveInToCheckErrorIsThrownByMovingPawn() {
        
        let board = ASCIIBoard(pieces: "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - * - - -" +
                                       "G - - - P - - r" +
                                       "- - - - - - - -" )
        
        let pieceLocation = board.locationOfCharacter("P")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: pieceLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }
    
    func testMoveInToCheckErrorIsThrownByMovingKnight() {
        
        let board = ASCIIBoard(pieces: "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - * - - - -" +
                                       "- - - - - - - -" +
                                       "G - - - K - - r" +
                                       "- - - - - - - -" )
        
        let pieceLocation = board.locationOfCharacter("K")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: pieceLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }
    
    func testMoveInToCheckErrorIsThrownByMovingBishop() {
        
        let board = ASCIIBoard(pieces: "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - * - - - - -" +
                                       "- - - - - - - -" +
                                       "G - - - B - - r" +
                                       "- - - - - - - -" )
        
        let pieceLocation = board.locationOfCharacter("B")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: pieceLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }
    
    func testMoveInToCheckErrorIsThrownByMovingRook() {
        
        let board = ASCIIBoard(pieces: "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - * - - -" +
                                       "- - - - - - - -" +
                                       "G - - - R - - r" +
                                       "- - - - - - - -" )
        
        let pieceLocation = board.locationOfCharacter("R")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: pieceLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }
    
    func testMoveInToCheckErrorIsThrownByMovingKing() {
        
        let board = ASCIIBoard(pieces: "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "* - - - - - - r" +
                                       "G - - - - - - -" )
        
        let pieceLocation = board.locationOfCharacter("G")
        let targetLocation = board.locationOfCharacter("*")
        
        let game = gameForTestingCallbacks(board: board.board, color: .white)
        
        guard let player = game.currentPlayer as? Human else {
            fatalError()
        }
        
        // Assert that the correct error is thrown
        XCTAssertTrue(player.canMovePieceWithError(fromLocation: pieceLocation,
                                                   toLocation: targetLocation).error == .cannotMoveInToCheck)
    }   
    
}
