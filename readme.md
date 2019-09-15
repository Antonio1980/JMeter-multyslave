*Installation*


1. Build base image (from JMeter/Dockerfile):

$ docker build .

2. Copy base image id and put it for every slave and master (in Dockerfiles):

- FROM [image id]

3. Build slaves first (do it for every slave - JMeter/slave1/Dockerfile):

$ docker build ./slave1

Put image id's of slaves into docker-compose.yml as image: [image id]

4. Build master (from JMeter/master/Dockerfile):

$ docker build ./master

Put image id of master into docker-compose.yml as image: [image id]

5. Build docker-compose.yml

$ docker-compose up


As success installation you should see output like:

Creating network "jmeter_vins" with driver "bridge"
Creating jmeter_slave1_1 ... done
Creating jmeter_slave3_1 ... done
Creating master          ... done
Creating jmeter_slave2_1 ... done
Attaching to master, jmeter_slave2_1, jmeter_slave3_1, jmeter_slave1_1
slave2_1  | Jul 10, 2019 3:38:13 PM java.util.prefs.FileSystemPreferences$1 run
slave2_1  | INFO: Created user preferences directory.
slave2_1  | Using local port: 50000
slave1_1  | Jul 10, 2019 3:38:14 PM java.util.prefs.FileSystemPreferences$1 run
slave1_1  | INFO: Created user preferences directory.
slave3_1  | Jul 10, 2019 3:38:14 PM java.util.prefs.FileSystemPreferences$1 run
slave3_1  | INFO: Created user preferences directory.
slave3_1  | Using local port: 50000
slave1_1  | Using local port: 50000
slave2_1  | Created remote object: UnicastServerRef2 [liveRef: [endpoint:[172.28.0.5:50000](local),objID:[78a0163b:16bdc88fe9b:-7fff, -5682709527428558056]]]
slave3_1  | Created remote object: UnicastServerRef2 [liveRef: [endpoint:[172.28.0.2:50000](local),objID:[677eebad:16bdc890021:-7fff, 3722208447558129444]]]
slave1_1  | Created remote object: UnicastServerRef2 [liveRef: [endpoint:[172.28.0.3:50000](local),objID:[-36fa3b5c:16bdc89004d:-7fff, -5281370229377918438]]]


Check docker processes:

$ docker ps -a

You should see:

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
96516e90dde2        64afe86ca4fd        "/bin/sh -c '$JMETER…"   21 seconds ago      Up 18 seconds       1099/tcp, 50000/tcp   jmeter_slave2_1
7197d8b190b7        ab5d32f1dd11        "/bin/bash"              21 seconds ago      Up 18 seconds       60000/tcp             master
32696c2df0cf        64afe86ca4fd        "/bin/sh -c '$JMETER…"   21 seconds ago      Up 17 seconds       1099/tcp, 50000/tcp   jmeter_slave1_1
e0daf981f899        64afe86ca4fd        "/bin/sh -c '$JMETER…"   21 seconds ago      Up 18 seconds       1099/tcp, 50000/tcp   jmeter_slave3_1

Test execution
---------------

1. Execute bash in master container:

$ docker exec -it [master image name] bash

As result you inside master container and bash terminal opened.

2. Run test plan:

$ bin/jmeter -n -t jmx/BalanceServiceNew.jmx -R 172.28.0.5,172.28.0.3,172.28.0.2 -l result/result.csv -Djmeter.save.saveservice.output_format=csv

3. Check test results:

$ cat result/result.csv

4. Generate report:

$ bin/jmeter -g resukt/result.csv -o output -f

