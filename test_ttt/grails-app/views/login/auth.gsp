

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="application.name" default="Tic-tac-toe"/></title>
    <meta name="layout" content="main"/>
    <g:javascript src='popup.js'/>
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
            <div class="leftPaneMenu" onclick="openPopup('Create Player', '${createLink(controller: 'player', action: 'create')}', '350', '300');">
                Create Player
            </div>

            <div class="leftPaneMenuLogin" >
                <div class='inner'>
                    <div class='fheader'><g:message code="springSecurity.login.header"/></div>


                    <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                        <p>
                            <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                            <input type='text' class='text_' name='j_username' id='username'/>
                        </p>

                        <p>
                            <label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                            <input type='password' class='text_' name='j_password' id='password'/>
                        </p>

                        <p id="remember_me_holder">
                            <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                            <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                        </p>

                        <p>
                            <input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
                        </p>
                    </form>
                </div>

            </div>


        </div>

        <div class="rightPane">
            <img src="${resource(dir: 'images', file: 'Tic_Tac_Toe.gif')}" alt="" width="95%" height="95%">
        </div>
    </div>

</div>
</body>
</html>



