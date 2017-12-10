---
layout: post
title: Waiting for uploads to complete with Rails UJS
categories:
 – blog
published: true
meta:
  description: How to nicely disable the form and let everything complete.
  index: true
---

Rails UJS `disable-with` feature is one of the mostly subtly brilliant tricks which can solve the classic issue of "User is clicking submit multiple times".

However it falls over a little when directly uploading file to services like S3 & Cloudinary as UJS isn't aware of 3rd party uploads.

Here is my fix:

    Code Sample

What this will do is disable the form as normal, then wait for the direct uploads to finish. Then resubmit the form as normal.
