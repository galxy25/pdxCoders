/*****************************************************************************
 *
 * Name:            main.js
 *
 * Description:     Source Script for the pdxCoders eLearning Platform Project
 *
 *                  All behaviors and hooks related to matching controllers
 *                  go here; logic automatically available via application.js
 * Log:
 *
 * 0.0  2015-05-25  Initial Revision
 *
 * 0.1  2015-06-01  Implemented User creation & authentication functionality
 *
 * Copyright:       pdxCoders (c) 2015 0.0 @ http:// ... .com
 *****************************************************************************/
var
    mainObj   = {},
    windowObj = { winH:$(window).height(), winW:$(window).width() }
    ;


/*****************************************************************************
 *
 * Function:    $(document).ready()
 *
 * Description: Execute after all content has been loaded
 *
 *****************************************************************************/
$(function()
{
    console.log("DOM loaded; likely add shit here later..");
});


/*****************************************************************************
 *
 * Function:    window.onload()
 *
 * Description: Execute after all content has been loaded
 *
 *****************************************************************************/
window.onload = function()
{
    $(window).resize(function()
    {
        windowObj.updateHW().resizeContent(); // add timer later to prevent constant firing
    });
    $(window).resize();     // fire resize on main app init
    $('#homepage-homeBtn, #homepage-mainTbl').fadeIn(400);

    mainObj.appStart();     // run main application manager
};


/*****************************************************************************
 *
 * Function:    mainObj.appStart()
 *
 * Description: Main Application Manager
 *
 *****************************************************************************/
mainObj.appStart = function()
{
    $('#homepage-joinBtnTwitter')
    .mouseenter(function() { $(this).html("join with twitter"); })
    .mouseleave(function() { $(this).html('<img id="homepage-iTwitter" src="assets/homepage/iTwitter.png" style="height:90%;width:auto;" alt="image">'); })
    .click(function()
    {
        alert("nice try, but this isn't implemented yet...");
    });

    $('#homepage-joinBtnFacebook')
    .mouseenter(function() { $(this).html("join with facebook"); })
    .mouseleave(function() { $(this).html('<img id="homepage-iFacebook" src="assets/homepage/iFacebook.png" style="height:100%;width:auto;" alt="image">'); })
    .click(function()
    {
        alert("nice try, but this isn't implemented yet...");
    });
}


/*****************************************************************************
 *
 * Function:    windowObj.resizeContent()
 *
 * Description: Resize content to fit window screen size appropriately
 *
 * Notes:       Font size is modified accordingly:
 *
 *              if (fontSize > maxScale) fontSize = maxScale;
 *              if (fontSize < minScale) fontSize = minScale;
 *              body.css('font-size', fontSize + '%');
 *
 *****************************************************************************/
windowObj.resizeContent = function()
{
    var fontSize, hw = "height:", body = $('body');
    hw += this.winH * 0.08, hw += "px;width:auto;";
    $('#homepage-iHeader, #homepage-iHomeBtn').attr('style', hw);
    $('#homepage-mainContent').height(this.winH * 0.58).width(this.winW * 0.35);

    var mainContentH = $('#homepage-mainContent').height();
    $('#homepage-joinBtnFacebook, #homepage-joinBtnTwitter, .homepage-input').height(mainContentH * 0.045).width(mainContentH * 0.4);

    fontSize = body.width() * 0.06, fontSize = (fontSize > 95) ? 95 : (fontSize < 30) ? 30 : fontSize, fontSize += "%";
    body.css('font-size', fontSize);
    return this;
}


/*****************************************************************************
 *
 * Function:    windowObj.updateHW()
 *
 * Description: Updates windowObj Namespace vars of window's height/width
 *
 *****************************************************************************/
windowObj.updateHW = function()
{
    this.winH = $(window).height(), this.winW = $(window).width();
    return this;
}

