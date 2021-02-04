#!/usr/bin/bash

# ---- Scala.js dependencies

SCALA_BINARY_VERSION="2.13"
SCALA_FULL_VERSION="2.13.3"

SCALA_JS_VERSION="1.3.0"
SCALA_JS_DOM_VERSION="1.1.0"

SCALA_JS_LIBRARY_CLASSPATH=$(cs fetch -p org.scala-js:scalajs-library_$SCALA_BINARY_VERSION:$SCALA_JS_VERSION)
SCALA_JS_DOM_CLASSPATH=$(cs fetch -p org.scala-js:scalajs-dom_sjs1_$SCALA_BINARY_VERSION:$SCALA_JS_DOM_VERSION)

SCALA_JS_COMPILER_PLUGIN_CLASSPATH=$(cs fetch -p org.scala-js:scalajs-compiler_$SCALA_FULL_VERSION:$SCALA_JS_VERSION:intransitive)

# ------------- Mdoc properties

MDOC_OPTS_FOLDER=$(mktemp -d)

echo "js-classpath=$SCALA_JS_LIBRARY_CLASSPATH:$SCALA_JS_DOM_CLASSPATH" >> $MDOC_OPTS_FOLDER/mdoc.properties
echo "js-scalac-options=-Xplugin:$SCALA_JS_COMPILER_PLUGIN_CLASSPATH" >> $MDOC_OPTS_FOLDER/mdoc.properties

echo $MDOC_OPTS_FOLDER

# ------------- Mdoc classpath 

MDOC_VERSION="2.2.16"

MDOC_CLASSPATH=$(cs fetch -p org.scalameta::mdoc-js:$MDOC_VERSION)


# ------------- REPRODUCTION

RESULTS=$(mktemp -d)

java -classpath $MDOC_CLASSPATH:$MDOC_OPTS_FOLDER mdoc.Main --in docs --out $RESULTS
