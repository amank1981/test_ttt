<%@ page import="com.damyant.Player" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="${message(code: 'player.id.label', default: 'Id')}"/>

                <g:sortableColumn property="userName"
                                  title="${message(code: 'player.userName.label', default: 'User Name')}"/>

                <g:sortableColumn property="age" title="${message(code: 'player.age.label', default: 'Age')}"/>

                <g:sortableColumn property="name" title="${message(code: 'player.name.label', default: 'Name')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${playerInstanceList}" status="i" var="playerInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${playerInstance.id}">${fieldValue(bean: playerInstance, field: "id")}</g:link></td>

                    <td>${fieldValue(bean: playerInstance, field: "userName")}</td>

                    <td>${fieldValue(bean: playerInstance, field: "age")}</td>

                    <td>${fieldValue(bean: playerInstance, field: "name")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${playerInstanceTotal}"/>
    </div>
</div>
</body>
</html>
