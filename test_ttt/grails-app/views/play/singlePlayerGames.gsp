<%--
  Created by IntelliJ IDEA.
  User: aman
  Date: 11/20/12
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.damyant.Player" contentType="text/html;charset=UTF-8" %>
<html>
  <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="main"/>
  </head>
  <body>
  <div>
      <g:form controller="play" action="gameInAction">

      <div style="float: left;">
           Select player: <g:select name="player1" from="${players}" optionKey="userName" optionValue="userName"/>
       </div>
          <div>
              <input type="submit" value="Play">
          </div>
      </g:form>
  </div>

  </body>
</html>