package com.damyant

class PlayerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
     def springSecurityService

    def create = {
        def playerInstance = new User()
       // playerInstance.properties = params
        return [playerInstance: playerInstance]
    }

    def save = {
        def playerInstance
        Role role_player = Role.findByAuthority('ROLE_PLAYER')
        playerInstance = new User(username: params.username, password: params.password,name:params.name,age:params.age,  enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
        println"------------------------------"+playerInstance.errors
        if(params.password!=params.re_password) {
            flash.message = "${message(code: 'password.not.matched.message',default: 'Password & re-Password not matched')}"
            redirect(uri: '/')
        }else if (playerInstance.save()) {
            UserRole.create playerInstance, role_player
            println "saved"
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'player.label', default: 'Player'), playerInstance.username])}"
            redirect(uri: '/')
        }
        else {
            println"================"
            println playerInstance.errors
            flash.message = "${message(code: 'player.not.created.message', args: [message(code: 'player.label', default: 'Player'), playerInstance.id])}"
            redirect(uri: '/')
        }
    }

    def playerStatistic={
        def player=User.findByUsername(springSecurityService.currentUser.username)
        [player:player]
    }

}
