//! include /ui/juic/js/core/component.js
//! include /ui/{prj}/js/{prj}{ActionName}Model.js
//! include /ui/{prj}/js/{prj}{ActionName}Page.js
function {PRJ}{ActionName}Controller (containerID) {
    this._init();
    this.renderTo(containerID);
}

extend({PRJ}{ActionName}Controller, EventTarget, {
       handleEvent: function(evt) {
           switch(evt.type) {
               case 'failedOperation':
                   alert(evt.errMsg);
                   break;
               case 'create{ActionName}':
                   this._dao.create{ActionName}();
                   break;
               case 'create{ActionName}Done':
                   this._dao.retrieve{ActionName}();
                   break;
               case 'retrieve{ActionName}':
                   this._dao.retrieve{ActionName}(evt.localeId);
                   break;
               case 'retrieve{ActionName}Done':
                   this._populateModel(evt.data);
                   break;
               case 'update{ActionName}':
                   this._dao.update{ActionName}();
                   break;
               case 'update{ActionName}Done':
                   this._populateModel();
                   break;
               case 'delete{ActionName}':
                   this._dao.delete{ActionName}(evt.id);
                   break;
               case 'delete{ActionName}Done':
                   this._dao.retrieve{ActionName}();
                   break;
               default:
                   break;
           }
       },
       _init: function() {
           this._initDAO();
           this._initModel();
           this._initView();
           this._initEventListeners();
       },
       _initModel: function() {
           this._model = new {PRJ}{ActionName}Model();
           this._populateModel({PRJ}_{ACTION_NAME}_GLOBAL_CONFIG);
       },
       _populateModel: function(data) {
           //populate meodel here and dispatch correposnding event to notify view
           //this._model.setName({PRJ}_{ACTION_NAME}_GLOBAL_CONFIG.property1);
           this._model.dispatch('{actionName}ModelUpdated');
       },
       _initView: function() {
           this._view = new {PRJ}{ActionName}Page(this._model);
       },
       _initDAO: function() {
            //var endPoint = AjaxService.getMBeanInstance("{prj}{ActionName}Controller");
            var endPoint = new {PRJ}{ActionName}HandlerMockup();
            this._dao = new {PRJ}{ActionName}DAO(endPoint);
       },
       _initEventListeners: function() {
           this._dao.addEventListener('create{ActionName}Done',this);
           this._dao.addEventListener('retrieve{ActionName}Done',this);
           this._dao.addEventListener('update{ActionName}Done',this);
           this._dao.addEventListener('delete{ActionName}Done',this);
           this._model.addEventListener('create{ActionName}',this);
           this._model.addEventListener('retrieve{ActionName}',this);
           this._model.addEventListener('update{ActionName}',this);
           this._model.addEventListener('delete{ActionName}',this);
       },
       renderTo: function(containerID) {
           var h = [];
           this._view.renderHtml(h);
           $(containerID).innerHTML = h.join('');
       }
});

function {PRJ}{ActionName}DAO (endPoint) {
    this._endPoint = endPoint;
}

extend({PRJ}{ActionName}DAO, EventTarget, {
        _initCBObject: function(callBackEvent,exceptionEvent) {
            var daoHandler = this;
            return {
                callback: function(data) {
                    daoHandler.dispatch(callBackEvent,{data:data});
                },
                exceptionHandler: function(msg,expObj) {
                    daoHandler.dispatch(exceptionEvent||"failedOperation",{errMsg:expObj.message});
                }
            };
        },
        create{ActionName}: function(data) {
            this._endPoint.create{ActionName}(dump(data),this._initCBObject("create{ActionName}Done"));
        },
        retrieve{ActionName}: function(data) {
            this._endPoint.retrieve{ActionName}(dump(data),this._initCBObject("retrieve{ActionName}Done"));
        },
        update{ActionName}: function(data) {
            this._endPoint.update{ActionName}(dump(data),this._initCBObject("retrieve{ActionName}Done"));
        },
        delete{ActionName}: function(data) {
            this._endPoint.delete{ActionName}(dump(data),this._initCBObject('delete{ActionName}Done'));
        }
    });

function {PRJ}{ActionName}HandlerMockup () {
}

extend({PRJ}{ActionName}HandlerMockup, EventTarget, {
        _execute: function(data,cb) {
            setTimeout(function(){
                cb.callback(data);
            },3000);
        },
        create{ActionName}: function(data,cb) {
            this._execute("",cb);
        },
        retrieve{ActionName}: function(data,cb) {
            this._execute({PRJ}_{ACTION_NAME}_GLOBAL_CONFIG,cb);
        },
        update{ActionName}: function(data,cb) {
            this._execute("",cb);
        },
        delete{ActionName}: function(data,cb) {
            this._execute("",cb);
        }
    });

var {PRJ}_{ACTION_NAME}_GLOBAL_CONFIG = {};
{PRJ}_{ACTION_NAME}_GLOBAL_CONFIG.property1="value1";
{PRJ}_{ACTION_NAME}_GLOBAL_CONFIG.property2="value2";
