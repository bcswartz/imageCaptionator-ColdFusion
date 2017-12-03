# Image Captionator

This repo contains the code for a ColdFusion 8 and jQuery-powered application written back in early 2008.  The 
application was built as an experiment to see what one could do with the image manipulation tags and functions added
to ColdFusion 8.

The application allowed the user to choose one image out of a small gallery of images and, using jQuery and jQuery UI, 
overlay text or blocks of color over the image. When the user saved their work, metadata describing each 
overlay was saved to a database record along with a reference to the image file itself.  So rather than creating a new
image file, the application would save the data needed to replicate the user's image using ColdFusion code.

To see the application in action, you can watch the following YouTube video:  https://youtu.be/JcLnO6zB3MM

The code in this codebase is old and wasn't written with the best practices for writing ColdFusion or JavaScript code
in mind (not by 2008 standards and certainly not by modern standards).  And the UI is functional but hardly pretty.  But the JavaScript/jQuery code still worked on
Chrome as of December 2017, and the ColdFusion code should work on a current ColdFusion instance with some refactoring 
(note: the code is written with tags as cfscript support was incomplete at the time).

The most valuable pieces of the code are the jQuery/JavaScript that powers the overlay creation tools and the ColdFusion
code that manages the image metadata and image rendering.

The database tables for the application were MySQL tables and were as follows:

### Table: captionImages
Column | Data type | Notes
-------|:---------:|-------
captionId | integer | PK auto-increment
imageFile | varchar(1000) |

### Table: captionData
Column | Data type | Notes
-------|:---------:|-------
captionDataId | integer | PK auto-increment
imageId | integer | FK to captionImages
type | varchar(15) |
text | varchar(1000) |
font | varchar(50) |
fsize | integer |
style | varchar(50) |
strikethrough | varchar(3) |
underline | varchar(3) |
color | varchar(10) |
lft | integer |
itop | integer |
background | varchar(10) |
width | integer |
height | integer |
depth | integer |
dateCreated | datetime |

### Table: captionTries
Column | Data type | Notes
-------|:---------:|-------
tryId  | integer | PK auto-increment
ipAddress | varchar(25) |
tryDate | datetime | 



