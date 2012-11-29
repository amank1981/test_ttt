<%--
  Created by IntelliJ IDEA.
  User: aman
  Date: 11/20/12
  Time: 2:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="main"/>

  </head>
  <body>
  <g:form controller="play" action="gameBetweenTwoPlayer" onsubmit="return validateaform(this);">

      <div style="float: left;">
           Select player: <g:select name="otherPlayer" from="${players}" optionKey="username" optionValue="username" noSelection="['':'select one']"/>
       </div>
         <br><br>
          <div>
              <input type="submit" value="Play">
          </div>
      </g:form>
  </body>
</html>