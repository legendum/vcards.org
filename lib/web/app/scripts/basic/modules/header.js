/**
 * @fileoverview Manage the page header
 * @author Kevin Hutchinson
 */

/*global App*/

/*
 * Description of module.
 */
App.addModule('header', function(context) {

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
          console.log('init header module');
        },

        destroy: function() {
          console.log('destroy header module');
        }
    };

});
