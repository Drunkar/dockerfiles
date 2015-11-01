# tornado-anaconda-with-template
Dockerfile for tornado web server with anaconda python.
Work with tornado template: https://github.com/Drunkar/tornado_template .

```
git clone https://github.com/Drunkar/tornado_template.git

docker run --name my_app -d -p 80:8787 -v ANY_PATH/tornado_template:/app drunkar/tornado-anaconda-with-template
```
