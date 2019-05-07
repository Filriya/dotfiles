#!/bin/bash
cd $(dirname $0)

scriptDir=`pwd -P`
echo $scriptDir

$scriptDir/bin/setup/link.sh
$scriptDir/bin/setup/install.sh
