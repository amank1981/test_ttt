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

</head>
<body>
<div align="center">

    <div class="header">
        <g:message code="application.name" default="Tic-tac-toe"/>
    </div>

    <div class="tttMain">
        <div class="playerDetails" style="height: 40px;" >
            <div style="font-size: 25px; float: left;margin-left: 50px ">Name: ${player.name} </div>
            <div style="font-size: 25px; float: left;margin-left: 50px;">Age: ${player.age} </div>
        </div>
            <div class="playerDetails">

                    <div class="pdLeft">Match Played:</div>
                    <div class="pdRight">${player.gamesPlayed}</div>

                    <div class="pdLeft">Match Won:</div>
                    <div class="pdRight">${player.gamesWon}</div>

                    <div class="pdLeft">Match Lost:</div>
                    <div class="pdRight">${player.gamesLoss}</div>

                    <div class="pdLeft">Match Drawn:</div>
                    <div class="pdRight">${player.gamesD}</div>

            </div>


            <g:link uri="/">
                <div class="newGame">
                    Play New Game
                </div>
            </g:link>




    </div>

</div>

</body>
</html>