package com.damyant

class TttPlayService {

    static transactional = true

    def serviceMethod() {

    }

    def checkGamesStatus(player1,player2,session){
        def result=[:]
        def player1Status=checkStatus(player1)
        def player2Status=checkStatus(player2)
        if(player1Status){
            updatePlayerWonData('Player1',session)
           if(session.Player2.userame!='comp'){
              updatePlayerlossData('Player2',session)
            }

            result.put('status','won')
            result.put('player','player1')
            result.put('result',player1Status)
        }else if(player2Status){
            if(session.Player2.username!='comp'){
              updatePlayerWonData('Player2',session)
                result.put('player','player2')
            }else{result.put('player','Computer')}

            updatePlayerlossData('Player1',session)
            result.put('status','won')

            result.put('result',player2Status)
        } else if(player1.size()==5 || player2.size()==5){
            result.put('status','draw')
            updatePlayerDrawData(session)
        }

        //result.put('status','won')
       // result.put('player','player1')
        return result
    }

    def checkTwoPlayerGameStatus(gameId){
        def game=GameTtt.get(gameId)
       def player1Moves=[],player2Moves=[]
        for(def i=1;i<=5;i++){
           if(game.userCreatedMoves['mov'+i]){player1Moves.add(game.userCreatedMoves['mov'+i])}
           if(game.secondPlayerMoves['mov'+i]){player2Moves.add(game.secondPlayerMoves['mov'+i])}
        }
        println"---------------------"
        println player1Moves
        println player2Moves
        println"---------------------"
        if(checkStatus(player1Moves)){
            game.gameWinner=game.userCreated
            game.gameStatus='R'
        }else if(checkStatus(player2Moves)){
            game.gameWinner=game.secondPlayer
            game.gameStatus='R'
        }else if(game.userCreatedMoves.mov5 && game.secondPlayerMoves.mov5){
            game.gameStatus='D'
        }
        game.save(flush: true)
    }

    def checkStatus(dataArray){
       def result=0,status=null
       def winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        winningCombinations.each{wc->
            result=0
          wc.each{c->
              dataArray.each{d->
                if(Integer.parseInt(d.toString())==c){
                    result++
                    if(result==3){
                        status =wc
                    }
                }
              }
          }
        }
        return status
    }

    def updatePlayerWonData(player,session){
        def playerInstance=User.findByUsername(session[player].username)
        playerInstance.gamesPlayed=playerInstance.gamesPlayed+1
        playerInstance.gamesWon=playerInstance.gamesWon+1
        playerInstance.save(Flushable:true)
        println "----w----"+playerInstance.errors

    }

    def updatePlayerlossData(player,session){
        def playerInstance=User.findByUsername(session[player].username)
        playerInstance.gamesPlayed=playerInstance.gamesPlayed+1
        playerInstance.gamesLoss=playerInstance.gamesLoss+1
        playerInstance.save(Flushable:true)
        println "---l-----"+playerInstance.errors

    }

    def updatePlayerDrawData(session){
        def player1Instance=User.findByUsername(session['Player1'].username)
        if(session.Player2.username!='comp'){
           def player2Instance=User.findByUsername(session['Player2'].username)
             player2Instance.gamesPlayed=player2Instance.gamesPlayed+1
             player2Instance.gamesD=player2Instance.gamesD+1
             player2Instance.save(Flushable:true)
             println "-d2--l-----"+player2Instance.errors
        }

        player1Instance.gamesPlayed=player1Instance.gamesPlayed+1
        player1Instance.gamesD=player1Instance.gamesD+1

        player1Instance.save(Flushable:true)

        println "--d2-l-----"+player1Instance.errors


    }

    def getComputerMove(session){
       def move1=session.Player1SelectedCell
       def move2=session.Player2SelectedCell

       def moves=[], leftMoves=[] ,nextMove=null
         move1.each{m1->
                moves.add(m1)
            }
            move2.each{m2->
                moves.add(m2)
            }
        println"----------moves-------"+moves
        for(def i=0;i<9;i++){
            def add=true
            moves.each{m->
                if(i==Integer.parseInt(m)){
                  add=false
                }
            }
            if(add)leftMoves.add(i)
        }
        println"~~~~~~~~~~~~~:" +leftMoves
        Random randomGenerator = new Random()
        if(leftMoves.size()>0)
        nextMove=leftMoves[randomGenerator.nextInt(leftMoves.size())]
        println "@@@@@@@@@@@@@@@@@@@@@@"+nextMove
        return nextMove

    }

    
    def createNewGame(player1,player2){
        println"--------create new games-------"
        def gameCreator=User.findByUsername(player1)

       def gameList
         gameList=GameTtt.findAllByUserCreated(gameCreator)

        gameList.each{g->
            g.delete(flush: true)
        }
        def newGame=new GameTtt()

        newGame.userCreated=gameCreator
        newGame.secondPlayer=User.findByUsername(player2)
        newGame.userCreatedMoves=newGamesMoveInstance()
        newGame.secondPlayerMoves=newGamesMoveInstance()
        newGame.playerMove=gameCreator
        newGame.save(flush: true)
        println "----------------------"+newGame.errors
        return newGame
    }

    def acceptGameRequest(gameId){
        def game=GameTtt.get(gameId)
        game.gameRequest=true
        game.save(flush: true)
        println"-------------------"+game.errors
        return game
    }
    
    def newGamesMoveInstance(){
        def gm= new GameMoves()
        gm.save()
        return gm
    }
    def gameReqList(player){
        println"-------------------------"+player
        def reqList =null
        reqList=GameTtt.findAllBySecondPlayerAndGameRequest(User.findByUsername(player),false)
        return reqList

    }
    def gameRunning(player){
        println"-------------------------"+player
        def user=User.findByUsername(player)
        def gRunning=GameTtt.createCriteria().list {
            eq('userCreated',user)
            or{
               eq('secondPlayer',user)
            }
            and{
                eq('gameRequest',true)
            }
        }
        return gRunning

    }


    def newMove(gameId,cellNo,user){
        println"@@@@@@@@@@:"+gameId+":"+cellNo+":"+user
        cellNo=Integer.parseInt(cellNo)
       def game=GameTtt.get(gameId)
        println"==========="+game
        if(game.userCreated.username==user){
               if(game.userCreatedMoves.mov1==null){game.userCreatedMoves.mov1=cellNo}
          else if(game.userCreatedMoves.mov2==null){game.userCreatedMoves.mov2=cellNo}
          else if(game.userCreatedMoves.mov3==null){game.userCreatedMoves.mov3=cellNo}
          else if(game.userCreatedMoves.mov4==null){game.userCreatedMoves.mov4=cellNo}
          else {game.userCreatedMoves.mov5=cellNo}
            game.playerMove=game.secondPlayer
        }
        if(game.secondPlayer.username==user){
               if(game.secondPlayerMoves.mov1==null){game.secondPlayerMoves.mov1=cellNo}
          else if(game.secondPlayerMoves.mov2==null){game.secondPlayerMoves.mov2=cellNo}
          else if(game.secondPlayerMoves.mov3==null){game.secondPlayerMoves.mov3=cellNo}
          else if(game.secondPlayerMoves.mov4==null){game.secondPlayerMoves.mov4=cellNo}
          else {game.secondPlayerMoves.mov5=cellNo}
            game.playerMove=game.userCreated
        }
        
        game.save(flush: true)
        
    }
}
