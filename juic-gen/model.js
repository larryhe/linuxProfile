//! include /ui/juic/js/core/component.js
function {PRJ}{ActionName}Model () {
}

extend({PRJ}{ActionName}Model, EventTarget, {
        TO_BE_REPLACED: function(data) {
            this._TO_BE_REPLACED = data;
        },
        TO_BE_REPLACED: function() {
            return this._TO_BE_REPLACED;
        }
    });
