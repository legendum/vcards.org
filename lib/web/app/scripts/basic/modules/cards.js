/**
 * @fileoverview Manage cards on the page
 * @author Kevin Hutchinson
 */

/*global App*/

/*
 * Description of module.
 */
App.addModule('cards', function(context) {

    'use strict';

    //-----------------------------------------------------------
    // Private
    //-----------------------------------------------------------

    /**
     * Description of function.
     * @param {type} name Description
     * @returns {type} Description
     * @private
     */
    function privateFunction(name) {

    }

    //-----------------------------------------------------------
    // Public
    //-----------------------------------------------------------

    return {
        init: function() {
          console.log('init cards module');
        },

        destroy: function() {
          console.log('destroy cards module');
        }
    };

});
