## fix_dates shell script

Moving and copying files to some places too many times can cause the files' dates to be set to the date when they were copied. This is especially annoying if the files are copied to a phone afterwards, because the gallery app will then show them in a random order if it does not support sorting by specific attributes or by name.

So here's a little Powershell script that fixes the dates of images (png and jpg) and videos (mp4), by setting it to their original creation dates.

The script replaces the "Last write time" (Date modified) attribute of each file placed in the folder where it is executed with the "Date taken" attribute for images and the "Date encoded" (Media created) attribute for videos.