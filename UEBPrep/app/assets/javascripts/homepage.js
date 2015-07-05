/*****************************************************************************
 *
 * Name:            main.js
 *
 * Author:          Raven Allan
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
 * 0.2  2015-07-03  Added Zurb's Foundation FW; stripped out unused methods
 *                  unsure if we'll need a source .js file for this (home) page,
 *                  yet, or even the app, but kept for now just in case...
 *
 * Copyright:       pdxCoders (c) 2015 https://github.com/galxy25/pdxCoders
 *****************************************************************************/
// GLOBALS

(function($)
{
    var HOME =
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
            this.bindUI();
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
            // var me = this;

            // other (click) functions...

            // $(window).resize(function() { me.resizeContent(); });
        }
    };

    /*****************************************************************************
     *
     * Function:    window.onload()
     *
     * Description: Execute after DOM and content (images) have been loaded
     *
     *****************************************************************************/
    window.onload = function() { HOME.init(); };

}(jQuery));