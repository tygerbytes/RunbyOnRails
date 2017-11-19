/**
 * Script for the main page. Needs some TLC.
 */

(function () {
    "use strict";

    $(document).ready(function() {
        loadSettingsFromCookie();
    });

    $('[name="commit"]').on("click", function () {
        saveSettingsToCookie();
    });

    function CookieElements() {
        return [['five_k_time', null]];
    }

    function loadSettingsFromCookie() {
        const ID = 0;
        const DEFAULT_VALUE = 1;
        var cookies = CookieElements();
        for (var x = 0; x < cookies.length; x++) {
            var cookie_element = cookies[x];
            var document_element = document.getElementById(cookie_element[ID]);
            if (document_element === null) {
                continue;
            }
            var cookie_value = getCookie(cookie_element[ID]);
            if (cookie_value === null) {
                document_element.value = cookie_element[DEFAULT_VALUE];
            }
            else {
                document_element.value = cookie_value;
            }
        }
    }

    function saveSettingsToCookie() {
        var cookies = CookieElements();
        for (var x = 0; x < cookies.length; x++) {
            var element_id = (cookies[x])[0];
            setCookie(element_id, document.getElementById(element_id).value);
        }
    }

    function setCookie(name, value, days_to_expire) {
        if(days_to_expire === undefined) {
            days_to_expire = 365;
        }
        var d = new Date();
        d.setTime(d.getTime() + (days_to_expire*24*60*60*1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = 'runby_pace_' + name + "=" + value + "; " + expires;
    }

    function getCookie(name) {
        name = 'runby_pace_'+ name + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) === 0) {
                return c.substring(name.length, c.length);
            }
        }
        return null;
    }
})();
