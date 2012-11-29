<%--
  Created by IntelliJ IDEA.
  User: aman
  Date: 11/20/12
  Time: 3:32 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <script type="text/javascript">
        var player='Player1';
        var playerSine='X';
        function updateCell(fData){
            document.getElementById('selectedCellNo').value=fData;
            document.newMoves.submit();

        }

        function updateMoves(){
            var gameId='${params.gameId}',pReload=true;
            var cUser='${cUsername}',ajaxCall=true;


            if('${cUsername}'!='${game.playerMove.username}'&& pReload){
                if(ajaxCall){
                    ajaxCall=false;
                    jQuery.ajax({
                        url: "${grailsApplication.config.grails.serverURL}/play/gameCurrentPlayer",
                        data:({gameId:gameId}),
                        success: function(result) {
                            if(result==cUser){
                                window.location.href=window.location.href;
                                pReload=false;
                                ajaxCall=true;
                            }
                        }
                    });

                }
                setTimeout(updateMoves, 5000);
            } else if(${!game.gameRequest}){
                document.newMoves.submit();
                setTimeout(updateMoves, 10000);
            }

        }


        window.onload = function () {
            if(${game.playerMove.username!=cUsername}){
                jQuery.each(document.getElementsByClassName('tttCell'),function(){
                    this.onclick='null';
                });
            }
            if(!${game.gameRequest}){
                jQuery.each(document.getElementsByClassName('tttCell'),function(){
                    this.onclick='null';
                });
            }
            updateMoves()

        };

        function shoeDiv(data){
            document.getElementById(data).style.display='block';
        }
    </script>
</head>
<body>
<div>
    <g:link uri="/">
        <div class="header">
            <g:message code="application.name" default="Tic-tac-toe"/>
        </div> </g:link>
    <div class="tttMain">
        <div align="left" class="greetings"> Hi ${cUsername} (
        <g:if test="${cUsername==game.userCreated.username}">X</g:if>
        <g:else>0</g:else>
        )</div>

        <div class="tttMainView">
            <g:each in="${0..8}" var="no">
                %{--<g:link action="updatePlayerMove" params="[cell:no,cUser:cUsername,gameId:game.id]">--}%
                <div class="tttCell" id="cell${no}" onclick="updateCell(${no})">
                    <g:if test="${game.userCreatedMoves}" >
                            <g:if test="${no==game.userCreatedMoves.mov1}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> X</div>
                            </g:if>
                            <g:if test="${no==game.userCreatedMoves.mov2}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> X</div>
                            </g:if>
                            <g:if test="${no==game.userCreatedMoves.mov3}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> X</div>
                            </g:if>
                            <g:if test="${no==game.userCreatedMoves.mov4}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> X</div>
                            </g:if>
                            <g:if test="${no==game.userCreatedMoves.mov5}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> X</div>
                            </g:if>
                    </g:if>
                    <g:if test="${game.secondPlayerMoves}">
                            <g:if test="${no==game.secondPlayerMoves.mov1}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> 0</div>
                            </g:if>
                            <g:if test="${no==game.secondPlayerMoves.mov2}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> 0</div>
                            </g:if>
                            <g:if test="${no==game.secondPlayerMoves.mov3}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> 0</div>
                            </g:if>
                            <g:if test="${no==game.secondPlayerMoves.mov4}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> 0</div>
                            </g:if>
                            <g:if test="${no==game.secondPlayerMoves.mov5}">
                                <div style="font-size: 90px;margin: 5px;font-weight: bold;"> 0</div>
                            </g:if>
                    </g:if>
                </div>
                %{--</g:link>--}%
            </g:each>
        </div>
        <g:if test="${game.gameStatus!=null}">
            <g:if test="${game.gameStatus=='R'}">
                <div class="playersMove" id="playersMove">
                    ${game.gameWinner.username}  Won the Game!!
                </div>
            </g:if>
            <g:else>
                <div class="playersMove" id="playersMove">
                   *** Game Is Draw ***
                </div>
            </g:else>


        </g:if>
        <g:elseif test="${!game.gameRequest}">
            <div class="playersMove" id="playersMove">
                Your request Yet not accepted
            </div>
        </g:elseif>
        <g:else>
        <div class="playersMove" id="playersMove">
            ${game.playerMove.username}  move
        </div>
        </g:else>
        <g:if test="${game.gameStatus!=null}">
        <div style="text-decoration:blink;" id="matchEnd">
            <g:link uri="/" style="color: red;font-size: 15px;background-color: #2ffdff;">Play new game:${game.gameStatus}</g:link>
        </div>
        </g:if>
    </div>
   <div>
       <g:form action="updatePlayerMove" name="newMoves">
           <input type="hidden" name="cUser" value="${cUsername}">
           <input type="hidden" name="gameId" value="${game.id}">
           <input type="hidden" name="cellNo" value="" id="selectedCellNo">
       </g:form>
   </div>
</div>
 <script type="text/javascript">




 </script>
</body>
</html>