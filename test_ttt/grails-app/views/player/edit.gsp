<%@ page import="com.damyant.Player" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${playerInstance}">
        <div class="errors">
            <g:renderErrors bean="${playerInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${playerInstance?.id}"/>
        <g:hiddenField name="version" value="${playerInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="userName"><g:message code="player.userName.label" default="User Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'userName', 'errors')}">
                        <g:textField name="userName" value="${playerInstance?.userName}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="age"><g:message code="player.age.label" default="Age"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'age', 'errors')}">
                        <g:textField name="age" value="${fieldValue(bean: playerInstance, field: 'age')}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name"><g:message code="player.name.label" default="Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'name', 'errors')}">
                        <g:textField name="name" value="${playerInstance?.name}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update"
                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
