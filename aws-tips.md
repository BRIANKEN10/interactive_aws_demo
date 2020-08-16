### AWS Server Instructions 

Followed https://www.charlesbordet.com/en/guide-shiny-aws/#7-extra-protect-your-app-with-a-password for the AWS instance type and the server connection (i.e. PUTTY) setup. Then switched to Marine Data Science (https://www.marinedatascience.co/blog/2019/04/28/run-shiny-server-on-your-own-digitalocean-droplet-part-2/index.html) to tackle working memory issues that made installing shiny impossible due to errors related to the package  **httpuv**, of note is the code suggested directly under the 9.2 chapter header. Then went with **Option 2** to install rmarkdown, shiny, and shiny js. 

Then to install the shiny server, I went Rstudio page: https://rstudio.com/products/shiny/download-server/ubuntu/ 
and followed the suggested linux commands. However:

* running wget https:... resulted in my permissions being denied. I then wrote sudo wget https... and this worked and I was able to install shiny server

Installing SF there are two issues that crop up: (1) issue with the package libudunits2-0 and (2) `gdal-config`. According to https://philmikejones.me/tutorials/2018-08-29-install-sf-ubuntu/ we install libundunits and gdal-config according to the steps in the website

* after rstudio and the sf issues are resolved 'tidyverse' installs successfully
* install tree via *sudo apt install tree* this helps map out the directory strucutre for the server
* 
