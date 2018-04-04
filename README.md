Simple Webserver with Nginx and PHP based on Ubuntu Docker image.

Run as temporary container for testing:

	docker run -d --rm -p 8080:80 -v $(pwd):/www dersimn/webserver
