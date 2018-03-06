/**
 * Created by DimDesktop on 4/7/2016.
 */
$(document).ready(
    $("#forgotpassbtn").click(function () {

        bootbox.dialog({
            title: "Change Password",
            message: '<div class="row">  ' +
            '   <div class="col-md-12"> ' +
            '       <form class="form-horizontal"> ' +
            '           <div class="form-group"> ' +
            '               <label class="col-md-2 control-label" for="name">Username</label> ' +
            '               <div class="col-md-4"> ' +
            '                   <input id="email" name="email" type="text" placeholder="Type your email" class="form-control input-md"> ' +
                //'                   <span class="help-block">Username</span>' +
            '                </div> ' +
            '           </div> ' +
                //'           <div class="form-group"> ' +
                //'               <label class="col-md-2 control-label" for="name">Current Password</label> ' +
                //'               <div class="col-md-4"> ' +
                //'                   <input id="oldpassid" name="oldpassword" type="password" placeholder="Type current password" class="form-control input-md"> ' +
                //    //'                   <span class="help-block">Current password</span>' +
                //'                </div> ' +
                //'           </div> ' +
            '       </form>' +
            '   </div>' +
            '</div>',
            buttons: {
                success: {
                    label: "Save",
                    className: "btn-success",
                    callback: function () {
                        alert('prompt');
                        //TODO
                    }
                },
                main: {
                    label: "Cancel",
                    className: "btn-default",
                    callback: function () {
                    }
                }
            }
        })
    })
);

