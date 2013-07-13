#!/bin/bash
cd $SF_HOME
ant upgrade -Dargs="-w jboss -c larry -dontask"
ant upgrade -Dargs="-w jboss -c larry -createseq"
ant upgrade -Dargs="-w jboss -c larry -createindices"
