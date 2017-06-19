<!DOCTYPE html>
<html>
    {include file="head.tpl"/}   
    <body>

      <div class="site-content">

        {include file="site_header.tpl"/}         
        <h2>Messages</h2>
        
        <p>
          Enter your message below:
        </p>
        
        <form action="{$host/}/messages" method="post">
            <input type="text" name="message" value="" required="true"/>
            <input type="submit" />
        </form>

        <div>
          <p>
            Here are some other messages, too:
          </p>
          {foreach from="$messages" item="item"}
              <a href="{$host/}/messages/{$item.id/}">{$item.message/}</a><br/>
          {/foreach}
        </div>

      </div>
    </body>
    <!-- optional enhancement -->
   {include file="optional_enhancement_js.tpl"/}   
</html>