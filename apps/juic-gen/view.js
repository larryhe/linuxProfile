//! include /ui/juic/js/components/common.js
//! include /ui/juic/js/components/JUICCommon.js
//! include /ui/juic/js/components/sfLoading.js
//! include /ui/{prj}/css/{prj}_style.css
function {PRJ}{ActionName}Page (model) {
    this.register();
    this._init(model);
}

extend({PRJ}{ActionName}Page, Component, {
        renderHtml: function(h) {
            //render your DOM tree here
        },
        _init: function(model) {
            this._model = model;
            this._initComponents();
            this._initEventListeners();
            this._postInit();
        },
        _initComponents: function() {
            this._loadingBox = new SFLoading();
            //init sub components that will build up the whole big component.
        },
        _initEventListeners: function() {
            //this is default event that the component should handle to re-render UI while getting notification that model was updated.
            this._model.addEventListener('{actionName}ModelUpdated',this);
            //It usually depends how many sub components you have created in initComponents method
            this._TO_BE_REPLACED.addEventListener("TO_BE_REPLACED",this);
        },
        _postInit: function() {
            //populate sub components like set default value etc here
        },
        handleEvent: function(evt) {
            switch(evt.type) {
                case 'TO_BE_REPLACED':
                    //call some methods to handle this event accordingly
                    break;
                case '{actionName}ModelUpdated':
                    //call some methods to handle this event accordingly
                    break;
                default:
                    break;
            }
        }
    });

{PRJ}{ActionName}Page.TO_BE_REPLACED = function(arg) {
    //implement your static factory method here according your needs.
}
