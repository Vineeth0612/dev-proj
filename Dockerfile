FROM nginx:latest

COPY index.html /usr/share/nginx/html/

COPY . .

EXPOSE 80

## CMD ["nginx" , "index.html"]


