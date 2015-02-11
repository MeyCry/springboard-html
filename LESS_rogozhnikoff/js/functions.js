var app = {
    init: function(){
        this.layout();
        this.custom.content();
        this.custom.forms();
        this.browser();

        // отлавливаем полную загрузку
        $(window).on("load", function () {
            app.afterLoad();
        });

        // отлавливаем ресайз окна с задержкой
        var resizeTimer = 50;
        $(window).resize(function () {
            if (resizeTimer) clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function() {
                app.layout()
            }, 50);
        });
    },

    layout: function(){
        // сетки и прочая каламуть
    },

    browser: function(){ // всякие мутки для обеспечения кроссбраузерности

        // обычно нужен только ie
        if($.browser.msie){
            var ie = true;
            if($.browser.version == '6.0') var ie6 = true;
            else if ($.browser.version >= '7.0') var ie7 = true;
            else if ($.browser.version >= '8.0') var ie8 = true;
        }

        // обычно ласт-чайлды нужны только на списках
        if(ie) $('li:last-child').addClass('last-child');
    },
    custom: {
        content: function(){
            var textContainer = $('article');

            // красим таблицу
            textContainer.find('tr:odd').not('thead tr').addClass('odd');
            textContainer.find('tr:even').not('thead tr').addClass('even');
        },
        forms: function(){
            $('input[placeholder], textarea[placeholder]').placeholder();
        }
    },
    afterLoad: function(){
        // сюда можно какие-то фоновые загрузки
    }
};

(function ($) { // овверайдим, если кто-то другой хочет наш Баксик
    $(function() { // dom сформирован
        app.init(); // запускаем
        console.log('...он сказал Поехали! - и взмахнул рукой.');
    });
})(jQuery);