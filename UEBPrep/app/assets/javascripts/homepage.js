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
// GLOBALS

(function($)
{
    /*****************************************************************************
     *
     * Function:    window.onload()
     *
     * Description: Execute after DOM and content (images) have been loaded
     *
     *****************************************************************************/
    window.onload = function() { HOME.init(); };

    HOME =
    {
        // PROPERTIES

        /*****************************************************************************
         *
         * Method:      HOME.init()
         *
         * Description: Initalize homepage content
         *
         *****************************************************************************/
        init: function()
        {
            this.resizeContent().bindUI();
        },

        /*****************************************************************************
         *
         * Method:      HOME.resizeContent()
         *
         * Description: Resize content to fit window screen size appropriately
         *
         * Notes:       Font size modified accordingly, tweek as desired:
         *
         *              if (fontSize > maxScale) fontSize = maxScale;
         *              if (fontSize < minScale) fontSize = minScale;
         *              body.css('font-size', fontSize + '%');
         *
         *****************************************************************************/
        resizeContent: function()
        {
            // resize fonts
            var fontSize, body = $('body');
            fontSize = body.width() * 0.1, fontSize = (fontSize > 150) ? 150 : (fontSize < 20) ? 20 : fontSize, fontSize += "%";
            body.css('font-size', fontSize);

            return this;
        },

        /*****************************************************************************
         *
         * Method:      HOME.bindUI()
         *
         * Description: UI handlers for user actions
         *
         *****************************************************************************/
        bindUI: function()
        {
            var me = this;

            // other (click) functions...

            $(window).resize(function() { me.resizeContent(); });
        }
    };

}(jQuery));