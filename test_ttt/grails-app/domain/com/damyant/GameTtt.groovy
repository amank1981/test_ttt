package com.damyant

class GameTtt {

    User userCreated
    User secondPlayer
    GameMoves userCreatedMoves
    GameMoves secondPlayerMoves
    boolean gameRequest=false
    User playerMove
    String gameStatus
    User gameWinner

    static constraints = {
        userCreatedMoves nullable:  true
        secondPlayerMoves nullable: true
        playerMove nullable: true
        gameStatus nullable: true
        gameWinner nullable: true
    }

}
