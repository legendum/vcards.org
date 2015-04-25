/**
 * @fileoverview Manage the page
 * @author Kevin Hutchinson
 */

/*global App*/

/*
 * Description of module.
 */
App.addModule('page', function(context) {

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
          console.log('init page module');
        },

        destroy: function() {
          console.log('destroy page module');
        }
    };

});
