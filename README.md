# spring-boot-startup-script
Spring Boot Application usually is build into one uber jar (big jar) with versioning, example: great-app-1.9.jar, great-app-2.0.jar, ... 

To start or stop the big versioning uber jar is quite annoying.

This script is automatically find newest version of uber jar and run.

## Stop / Start
### Example deployed directory:
```
great-app-1.9.jar.bk (we usually make a backup jar file to easy rollback)
great-app-2.0.jar
bootstrap.sh
```

### Command:
```
./bootstrap.sh start
./bootstrap.sh stop
./bootstrap.sh restart
```



