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
     	    new Ajax.Updater('cell'+fData, './updateCell?cell='+fData+'&player='+player, {
			method : "post",
			onComplete : updateCellCss(fData),
			evalScripts : true
		});
          }
      function updateCellCss(data){
          var element=document.getElementById('cell'+data) ;
          element.className='cellSelcted';
          element.onclick='null';
          if(player=='Player1'){
              player='Player2';
          }else{player='Player1';}
          jQuery('#playersMove').html(player+'  move');
          checkGameStatus();
          if(${player2==null} && (player=='Player2')){
             // alert('computer move');
              jQuery.ajax({
              url: "${grailsApplication.config.grails.serverURL}/play/computerMove",
              data:({test:'test'}),
              success: function(result) {
                    updateCell(result)
              }
              });
          }
      }
      function checkGameStatus(){
          jQuery.ajax({
              url: "${grailsApplication.config.grails.serverURL}/play/checkGameStatus",
              data:({test:'test'}),
              success: function(result) {
                  //alert(result.status);
                  if(result.status=='won'){
                      jQuery.each(result.result, function() {
						   document.getElementById('cell'+this).className='winnerCell';
                          shoeDiv('matchEnd');
                           //jQuery('#matchEnd').style.display=block;
                           jQuery('#playersMove').html(result.player+'  Won this match!');
                          jQuery.each(document.getElementsByClassName('tttCell'),function(){
                              this.onclick='null';
                          });
					});
                  } else if(result.status=='draw'){
                     jQuery('#playersMove').html('  Match is Draw');
                      shoeDiv('matchEnd');
                          jQuery.each(document.getElementsByClassName('tttCell'),function(){
                              this.onclick='null';
                          });
                  }
              }
          });

      }
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
               %{--<div class="tttMainLeft">


                   <g:link action="newGame">
                       <div class="newGame">
                           Play New Game
                       </div>
                   </g:link>

               </div>--}%
                    <div class="tttMainView">
                        <g:each in="${0..8}" var="no">
                            <div class="tttCell" id="cell${no}" onclick="updateCell(${no})">

                            </div>
                        </g:each>
                    </div>
                   <div class="playersMove" id="playersMove">
                       Player1  move
                   </div>
                   <div style="text-decoration:blink;display: none;" id="matchEnd">
                       <g:link uri="/" style="color: red;font-size: 15px;background-color: #2ffdff;">Play new game</g:link>
                   </div>
           </div>

       </div>

  </body>
</html>