#!/bin/bash

javac -classpath jfugue/jfugue-4.0.3.jar Score.java
java -classpath jfugue/jfugue-4.0.3.jar:. Score
