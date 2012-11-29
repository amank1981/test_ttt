package com.damyant

class GameMoves {
     Integer mov1
     Integer mov2
     Integer mov3
     Integer mov4
     Integer mov5
    static belongsTo = [GameTtt]
    static constraints = {
        mov1 nullable: true
        mov2 nullable: true
        mov3 nullable: true
        mov4 nullable: true
        mov5 nullable: true
    }
}
