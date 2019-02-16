#!/bin/bash
#git clone https://github.com/rsivphdev/pocicbcvtdc.git
rm -rf ./pocicbcvtdc
oc login -u cluster-admin
#oc policy add-role-to-group edit system:serviceaccounts:jik2hd-tools:jenkins -n jik2hd-dev
#oc policy add-role-to-group edit system:serviceaccounts:jik2hd-tools:jenkins -n jik2hd-test
#oc new-app -n jik2hd-tools -f jh-icbc-vtdc-template.yaml
oc project jik2hd-dev
oc delete all -l app=jhicbcvtdc
oc delete bc/jhicbcvtdc
oc delete is/jhicbcvtdc
oc delete is/wildfly
oc delete cm/jhicbcvtdc-config

oc project jik2hd-test
oc delete all -l app=jhicbcvtdc
oc delete bc/jhicbcvtdc
oc delete is/jhicbcvtdc
oc delete is/wildfly
oc delete cm/jhicbcvtdc-config

oc project jik2hd-tools
oc delete all -l app=jhicbcvtdc
oc delete bc/jh-icbc-vtdc-pipeline
oc delete job/jh-icbc-vtdc-installer-job
#oc delete template/jh-icbc-vtdc-template
