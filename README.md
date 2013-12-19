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

	sudo docker run -d -p 80 -p 3306 tutum/lamp

It will print the new container ID (like `d35bf1374e88`). Get the allocated external port for Apache:

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
	EXPOSE 80 3306
	CMD ['/run.sh']

replacing `https://github.com/username/customapp.git` with your application's GIT repository.
After that, build the new `Dockerfile`:

	sudo docker build -t username/my-lamp-app .

And test it:

	CONTAINER_ID=$(sudo docker run -d -p 80 username/my-lamp-app)
	sudo docker port $CONTAINER_ID 80

It will print the allocated port (like 4751). Test your deployment:

	curl http://localhost:4751/

That's it!


Connecting to the bundled MySQL server from within the container
----------------------------------------------------------------

The bundled MySQL server has a `root` user with no password for local connections.
Simply connect from your PHP code with this user:

	<?php
	$mysql = new mysqli("localhost", "root");
	echo "MySQL Server info: ".$mysql->host_info;
	?>


Connecting to the bundled MySQL server from outside the container
-----------------------------------------------------------------

The first time that you run your container, a new user `admin` with all privileges 
will be created in MySQL with a random password. To get the password, check the logs
of the container by running:

	sudo docker logs $CONTAINER_ID

You will see an output like the following:

	========================================================================
	You can now connect to this MySQL Server using:

	    mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>

	Please remember to change the above password as soon as possible!
	MySQL user 'root' has no password but only allows local connections
	========================================================================

In this case, `47nnf4FweaKu` is the password allocated to the `admin` user. To get
the allocated port to MySQL, execute:

	sudo docker port $CONTAINER_ID 3306

It will print the allocated port (like 4751). You can then connect to MySQL:

	 mysql -uadmin -p47nnf4FweaKu -h127.0.0.1 -P4751

Remember that the `root` user does not allow connections from outside the container - 
you should use this `admin` user instead!
