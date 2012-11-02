// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .




$(document).ready(function () {

    $("#submit").click(function(event)
        {
            var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
            var name_format = new RegExp(/^[a-zA-Z'-]+$/i);
            var name=$("#user_name").val();
            var email=$("#user_email").val();
            var password=$("#user_password").val();
            var   password_confirmation=$("#user_password_confirmation").val();

            if(name=='' || email== '' || password== '' || password_confirmation == '')
            {
                alert("Fill all the details")
                event.preventDefault();

            }
            else if(!(name_format.test(name)))
            {
                alert("Enter name in correct format")
                event.preventDefault();
            }
            else if(!(pattern.test(email)))
            {
                alert("Enter email in correct format")
                event.preventDefault();
            }
            else if(password.length < 6 || password.length > 15)
            {
                alert("Enter password between 6 to 15 characters")
                event.preventDefault();
            }
            else if(password!=password_confirmation)
            {
                alert("Password should match with password confirmation")
                event.preventDefault();
            }
            else
            {

            }

        }
    );

    $("#sign-in").click(function(event)
    {
        var session_password=$("#session_password").val();
        var session_email=$("#session_email").val();
        if( session_email== '' || session_password== '' )
        {
            alert("Fill all the details")
            event.preventDefault();

        }

    });

    $("#post-form").click(function(event)
    {
        var post=$("#post_content").val();

        if( post == '' )
        {
            alert("Post can't be blank")
            event.preventDefault();

        }
        else if(post.length > 140)
        {
            alert("Post should not be more than 140 characters")
            event.preventDefault();
        }
        else
        {

        }

    });

    $("#comment-form").click(function(event)
    {
        var comment=$("#comment_body").val();

        if(comment == '' )
        {
            alert("Comment can't be blank")
            event.preventDefault();

        }
        else if(comment.length > 140)
        {
            alert("Comment should not be more than 140 characters")
            event.preventDefault();


        }
        else
        {

        }

    });


});
