---
layout: post
title: Waiting for Cloudinary uploads to finish with Rails UJS
categories:
 – blog
published: true
meta:
  description: How to nicely disable a form to let uploads finish before submitting to the server.
  index: true
---

Rails has a really neat [UJS](http://guides.rubyonrails.org/working_with_javascript_in_rails.html#unobtrusive-javascript) feature that'll disable a forms submit buttons after the user has clicked it. It's a very handy to solve the age old problem of "User is clicking submit multiple times". Similarly Cloudinary has a [fantastic API](https://cloudinary.com/documentation/jquery_image_and_video_upload) that allows users to upload images directly to them, without the data having to make a stop your your server.

However, out of the box, UJS won't wait for uploads to finish uploading to 3rd party servers. Luckily a bit of JavaScript magic solves this! I've setup a [repo on GitHub](https://github.com/MikeRogers0/CloudinaryHerokuDemo/) which demos this script along with a Cloudinary + CarrierWave configuration example.

## The form

This is a pretty bog standard Rails form. I'm using the [Cloudinary Ruby Gem](https://github.com/cloudinary/cloudinary_gem) which provides the cloudinary upload helpers.

    <%-- app/view/user/_form.html.erb -->
    <% form_for :user, html: { class: 'cloudinaryable-form' } do %>
      <!--
      The `cl_image_upload` method does all the authorisation magic and always has
      the class `cloudinary-fileupload`.
      -->
      <%= f.cl_image_upload(:image, allowed_formats: %w(jpg jpeg gif png)) %>

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
      // If the field isn't on the page, cloudinary_fileupload is not configured or
      // Rails UJS is missing, don't add the listeners. 
      if( $('.cloudinary-fileupload').length === 0 
        || $.fn.cloudinary_fileupload === undefined 
        || Rails === undefined
      ) {
        return;
      }

      // Initialize the Cloudinary fields.
      $('.cloudinary-fileupload').cloudinary_fileupload();

      // Add a listener that'll add a `data-upload-state` attribute when a user is uploading
      // a file, then clears it when the upload is completed.
      $('.cloudinary-fileupload')
        .on('fileuploadsend', function(e, data){
          $(this).attr('data-upload-state', 'uploading');
        })
        .on('cloudinaryalways', function(data){
          $(this).attr('data-upload-state', null);

          // If the form is disabled but has been submitted, resubmit it.
          if( $(this).parents('form').find(Rails.formEnableSelector).length >= 1 ){
            $(this).parents('form').submit();
          }
        });

      // Add a listener to the form that'll delay the submission until the upload is complete.
      $(".cloudinary-fileupload").parents('form')
        .on('submit', function(e){
          // If we're not uploading, let the form submit as normal.
          if( $(this).find('.cloudinary-fileupload[data-upload-state="uploading"]').length == 0 ){
            return;
          }

          // Stop the form submitting (UJS will disable the submit button though!)
          e.preventDefault();
        });
    });

## Other Notes

This is a very simplified example, the Cloudinary library helper has a bunch of [other events](https://cloudinary.com/documentation/jquery_image_and_video_upload#upload_events) that'll allow for users to get visual feedback as to how their upload is progressing (and add a preview while it's uploading).

A similar approach could also be applied when uploading files to other services (like AWS S3).
