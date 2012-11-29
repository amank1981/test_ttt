package com.damyant

class Player {
    String userName
    String name
    Integer age
    Integer gamesPlayed=0
    Integer gamesWon=0
    Integer gamesLoss=0
    Integer gamesD=0

    static constraints = {
        userName(unique: true)
        gamesPlayed(nullable: true)
        gamesWon(nullable: true)
        gamesLoss(nullable: true)
        gamesD(nullable: true)
    }
}
