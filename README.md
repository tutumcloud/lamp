tutum-docker-lamp
=================

Out-of-the-box LAMP image (PHP+MySQL)


Usage
-----

To create the image `tutum/lamp`, execute the following command on the tutum-docker-lamp folder:

	docker build -t tutum/lamp .

You can now push your new image to the registry:

	sudo docker push tutum/lamp


Running your LAMP docker image
------------------------------

Start your image:

	sudo docker run -d tutum/lamp

It will print the new container ID (like `d35bf1374e88`). Get the allocated external port:

	sudo docker port d35bf1374e88 80

It will print the allocated port (like 4751). Test your deployment:

	curl http://localhost:4751/

Hello world!


Loading your custom PHP application
-----------------------------------

In order to replace the "Hello World" application that comes bundled with this docker image,
create a new `Dockerfile` in an empty folder with the following contents:

	FROM tutum/lamp:latest
	RUN rm -fr /app
	RUN git clone https://github.com/username/customapp.git /app
	EXPOSE 80
	CMD ['/run.sh']

replacing `https://github.com/username/customapp.git` with your application's GIT repository.
After that, build the new `Dockerfile`:

	docker build -t username/my-lamp-app .

And test it:

	ID=$(sudo docker run -d username/my-lamp-app)
	sudo docker port $ID 80

It will print the allocated port (like 4751). Test your deployment:

	curl http://localhost:4751/

That's it!
