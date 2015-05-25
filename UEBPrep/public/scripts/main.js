/*****************************************************************************
*
* Name:             main.js
*
* Description:      Source Script for the pdxCoders eLearning Platform Project
*
* Log:
*
* 0.0  2015-05-25   Initial Revision
*
* Copyright:        pdxCoders (c) 2015 0.0 @ http:// ... .com
*****************************************************************************/
var
mainObj = {},
windowObj = { winH:$(window).height(), winW:$(window).width() }
;


/*****************************************************************************
*
* Function:     window.onload
*
* Description:  Execute after all content has been loaded
*
*****************************************************************************/
window.onload = function()
{

    // Load main content...


    // Resize main content to fit screen appropriately
	$(window).resize(function()
	{
        windowObj.updateHW();
        resizeFont();

        var iconHW = "height:";
        iconHW += windowObj.winH * 0.12, iconHW += "px;width:auto;";
        $("#iNav").attr("style", iconHW);
	});
    $(window).resize();

    function resizeFont()
    {
        /* Resize Font Size
        var body = $('body'), maxScale = 95, minScale = 30, fontSize = body.width() * 0.065;
        if (fontSize > maxScale) fontSize = maxScale;
        if (fontSize < minScale) fontSize = minScale;
        body.css('font-size', fontSize + '%'); */
        var fontSize, body = $("body");
        fontSize = body.width() * 0.075, fontSize = (fontSize > 95) ? 95 : (fontSize < 30) ? 30 : fontSize, fontSize += "%";
        body.css("font-size", fontSize);
    }
};


/*****************************************************************************
*
* Function:     windowObj.updateHW()
*
* Description:  Updates windowObj Namespace vars of window's height/width
*
*****************************************************************************/
windowObj.updateHW = function()
{
    this.winH = $(window).height(), this.winW = $(window).width();
    return this;
}

