<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="body">

    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${playerInstance}">
        <div class="errors">
            <g:renderErrors bean="${playerInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="username"><g:message code="player.username.label" default="User Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'username', 'errors')}">
                        <g:textField name="username" value="${playerInstance?.username}"/>
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
                        <label for="name"><g:message code="player.password.label" default="Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: playerInstance, field: 'password', 'errors')}">
                        <input type="password" name="password" value="${playerInstance?.password}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name"><g:message code="player.repassword.label" default="Re-Password"/></label>
                    </td>
                    <td valign="top" class="value">
                        <input type="password" name="re_password" />
                    </td>
                </tr>


                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
