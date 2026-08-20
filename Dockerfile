FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

COPY . .

EXPOSE 80

## CMD ["nginx" , "index.html"]


