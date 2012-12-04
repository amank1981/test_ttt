package com.damyant

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN','ROLE_PLAYER'])
class PlayController {
    /**
     * Dependency injection for the tttPlayService.
     */
    def tttPlayService

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    def sessionRegistry
    

    def index = {
        def userInstance=User.findByUsername(springSecurityService.currentUser.username)
        def gameRequest=tttPlayService.gameReqList(userInstance.username)
        def gameRunning=tttPlayService.gameRunning(userInstance.username)
        [player:userInstance,gameRequest:gameRequest,gameRunning:gameRunning]
    }

    def newGame={
        redirect(uri: '/')
    }

    def singlePlayerGames={
        def playerList=Player.list()
        [players:playerList]
    }

    def multiPlayerGames={
        def player1=User.findByUsername(springSecurityService.currentUser.username)
        def players=[]
        sessionRegistry.getAllPrincipals().each{p->
            if(p.username!=player1.username){
                players.add(p)
            }
        }
        [players:players]
    }

    def gameInAction={
        def player1=null,player2=null
        player1=User.findByUsername(springSecurityService.currentUser.username)
        session.Player1=player1
        session.Player1SelectedCell=[]

        if(params.otherPlayer){
         player2=User.findByUsername(params.otherPlayer)
         session.Player2=player2
         session.Player2SelectedCell=[]
        } else{
          def comp=  new User()
            comp.username='comp'
            comp.name='computer'
         session.Player2=comp
         session.Player2SelectedCell=[]
        }
        [player1:player1,player2:player2]
    }


    def gameBetweenTwoPlayer={
       def cUsername=springSecurityService.currentUser.username
        
        def game
        if (params.runningGameId){
            game = GameTtt.get(params.runningGameId)
        }
        else if (params.gameId ){
            game = GameTtt.get(params.gameId)
            if (cUsername==game.secondPlayer.username){
                tttPlayService.acceptGameRequest(params.gameId)
            }
            //game=GameTtt.get(params.gameId)
        }
        else{
            game=tttPlayService.createNewGame(cUsername,params.otherPlayer)
        }

        //def gameRequest=tttPlayService.gameReqList(game.secondPlayer.username)
        [cUsername:cUsername,game:game]
    }

    def updatePlayerMove={
        println"---------Update player move:"+params
        if (params.cellNo){
            tttPlayService.newMove(params.gameId,params.cellNo,params.cUser)
            tttPlayService.checkTwoPlayerGameStatus(params.gameId)
        }


        redirect(action: 'gameBetweenTwoPlayer', params:[gameId:params.gameId] )
    }

    def gameCurrentPlayer={
        println"-------------"+params
        def playerMove=GameTtt.get(params.gameId).playerMove.username
        render playerMove
    }

    def updateCell={
        println"----------"+params
        def player1SelectedCell=session.Player1SelectedCell
        def player2SelectedCell=session.Player2SelectedCell
        def sign
        if(params.player=='Player1'){
            sign='X'
           player1SelectedCell.add(params.cell)
        }else{
            sign='O'
            player2SelectedCell.add(params.cell)
        }

        [pSign:sign]
    }


    def checkGameStatus = {
        println "----:" + params
        def player1SelectedCell = session.Player1SelectedCell
        def player2SelectedCell = session.Player2SelectedCell
        def result=tttPlayService.checkGamesStatus(player1SelectedCell,player2SelectedCell,session)
        println"==:"+result
        println "---------1--------player1SelectedCell:-" + player1SelectedCell
        println "--------1---------player2SelectedCell:-" + player2SelectedCell
        render result as JSON
    }

    def computerMove={
        def nextMove=tttPlayService.getComputerMove(session)
        render nextMove.toString()
    }


}
