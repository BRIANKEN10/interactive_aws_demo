### AWS Server Instructions 

Followed https://www.charlesbordet.com/en/guide-shiny-aws/#7-extra-protect-your-app-with-a-password for the AWS instance type and the server connection (i.e. PUTTY) setup. Then switched to Marine Data Science (https://www.marinedatascience.co/blog/2019/04/28/run-shiny-server-on-your-own-digitalocean-droplet-part-2/index.html) to tackle working memory issues that made installing shiny impossible due to errors related to the package  **httpuv**, of note is the code suggested directly under the 9.2 chapter header. Then went with **Option 2** to install rmarkdown, shiny, and shiny js. 

Then to install the shiny server, I went Rstudio page: https://rstudio.com/products/shiny/download-server/ubuntu/ 
and followed the suggested linux commands. However:

* running wget https:... resulted in my permissions being denied. I then wrote sudo wget https... and this worked and I was able to install shiny server