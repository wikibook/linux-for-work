#!/bin/sh -x

mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DgroupId=com.example -DartifactId=hello-webapp -Dversion=1.0-SNAPSHOT
