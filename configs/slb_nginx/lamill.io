server {
	listen 80;
	server_name lamill.io;

	location /blog/ {
		proxy_pass http://172.17.0.4:8080/blog/;
	}

	location / {
		proxy_pass http://172.17.0.5;
	}

}
