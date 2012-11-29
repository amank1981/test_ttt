package com.damyant


class User {

    transient springSecurityService
    transient mailService

    String email
    String username
    String password
    String name
    Integer age
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    Integer gamesPlayed=0
    Integer gamesWon=0
    Integer gamesLoss=0
    Integer gamesD=0
    boolean userLogIn=false

    static constraints = {
        username blank: false, unique: true
        password blank: false
        age nullable: true
        email nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
}
