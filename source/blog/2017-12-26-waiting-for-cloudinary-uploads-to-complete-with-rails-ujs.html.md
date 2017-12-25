---
layout: post
title: Waiting for Cloudinary uploads to finish with Rails UJS
categories:
 – blog
published: true
meta:
  description: How to nicely disable the form and let everything finish uploading before submitting to the server.
  index: true
---

Rails has a really neat UJS feature that'll disable a forms submit buttons after the user has clicked it. It's very handle to solve the age old problem of "User is clicking submit multiple times". Cloudinary is a [fantastic API](https://cloudinary.com/documentation/jquery_image_and_video_upload) that allows users to upload images directly to them, without the data having to make a stop your your server.

Out of the box, UJS won't wait for uploads to finish uploading to 3rd party servers. Luckily a bit of JavaScript magic solves this!

## The form

This is a pretty bog standard Rails form. I'm using the [Cloudinary Ruby Gem](https://github.com/cloudinary/cloudinary_gem) to get the cloudinary upload helpers. I also added a `cloudinaryable-form` class to it, so our JavaScript can target it more precisely.

    <%-- app/view/user/_form.html.erb -->
    <% form_for :user, html: { class: 'cloudinaryable-form' } do %>
      <!--
      The `cl_image_upload` method does all the authorisation magic and always has
      the class `cloudinary-fileupload`.
      -->
      <%= f.cl_image_upload(:image) %>

      <!--
      Rails 5 will add the attribute `data-disable-with` to submit buttons, which is shown
      when the form is submitting.
      <input type="submit" name="commit" value="Create User" data-disable-with="Updating User">
      -->
      <%= f.submit %>
    <% end %>

## The JavaScript

What the JavaScript will do is disable the form after the user clicks submit, but only send it to the server once the uploads are all complete.

    // app/assets/javascripts/components/cloudinary.js
    // I use turbolinks, but this can be replaced with `.on('ready')` if required.
    $(document).on('turbolinks:load', function() {
      // If the field isn't on the page or cloudinary_fileupload is not configured
      // Just move on.
      if( $("input.cloudinary-fileupload[type=file]").length < 1 || $.fn.cloudinary_fileupload === undefined) {
        return;
      }

      // Initialize the cloudinary fields.
      $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload({});

      // Add a listener that'll add a `data-upload-state` attribute when a user is uploading
      // a file, then clears it when the upload is completed.
      $("input.cloudinary-fileupload[type=file]")
        .on('fileuploadprocessalways', function(e, data){
          $(this).attr('data-upload-state', 'running');
        })
        .on('cloudinaryalways', function(data){
          $(this).attr('data-upload-state', '');

          // If the form is disabled but submitting, resubmit it.
          if( $(this).parents('form').data('submitting') ){
            $(this).parents('form').submit();
          }
        });

      $('.cloudinaryable-form').on('submit', function(e){
        // If we're not uploading, let the form submit as normal.
        if( $(this).find('[data-upload-state="running"]').length == 0 ){
          return;
        }

        // Otherwise hold the form in the submitting state
        $(this).data('submitting', true)

        // Disable form, showing the disabled-with copy.
        $.rails.disableFormElements( $(this) );

        // Stop the form submitting.
        e.preventDefault();
      });
    });


## Other Notes

This is a very simple example, the Cloudinary library helper has a bunch of [other events](https://cloudinary.com/documentation/jquery_image_and_video_upload#upload_events) that'll allow for users to get visual feedback as to how their upload is progressing.

A similar approach could also be applied when uploading files to other services (like AWS S3).
