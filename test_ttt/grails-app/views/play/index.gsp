

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="application.name" default="Tic-tac-toe"/></title>
    <meta name="layout" content="main"/>
    <g:javascript src='popup.js'/>
    <script type="text/javascript">

        function validateaform(thisForm){
            if(thisForm.otherPlayer.value==''){
                alert("please select 1 player!");
                return false;
            }
            return true;
        }
        window.onload = function () {
            setTimeout(reloadPlayIndexPage,5000);
        };

    function reloadPlayIndexPage(){
        if(!popupStatus){window.location.href=window.location.href;}

        setTimeout(reloadPlayIndexPage,5000);
    }
    </script>
</head>

<body>
<div style="width:1000px;height: 700px;margin: 50px;">
    <div class="header">
        <g:message code="application.name" default="Tic-tac-toe"/>
    </div>

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="innerBody">
        <div class="leftPane">
            <div class="leftPaneMenu">
                Hi  ${player.username} !!
            </div>
            <g:link controller="logout">
            <div class="leftPaneMenu">
                Log Out
            </div>
            </g:link>
            %{--<g:link action="gameInAction" params="['player1':player.username]" >
                <div class="leftPaneMenu">
                    Play with Computer
                </div>
            </g:link>--}%
            <div class="leftPaneMenu" onclick="openPopup('Multi Player', '${createLink(controller:'play', action: 'multiPlayerGames' )}', '300', '150');">
                Play with other Player
            </div>
            <g:link controller="player" action="playerStatistic">
            <div class="leftPaneMenu">
                View Statistics
            </div>
            </g:link>
        </div>

        <div class="rightPane">
            <img src="${resource(dir: 'images',file: 'Tic_Tac_Toe.gif')}" alt="" width="95%" height="95%">
        </div>
    </div>
    <g:if test="${gameRequest}">
    <g:each in="${gameRequest}" var="req">
      <g:link controller="play" action="gameBetweenTwoPlayer" params="[gameId:req.id]">
    <div class="gameRequest">  Accept ${req.userCreated?.username} play request
    </div>  </g:link>
    </g:each>
        <g:each in="${gameRunning}" var="gr">
      <g:link controller="play" action="gameBetweenTwoPlayer" params="[runningGameId:gr.id]">
    <div class="gameRequest">  User: ${gr.userCreated?.username} game is running
    </div>  </g:link>
    </g:each>
    </g:if>
</div>
</body>
</html>