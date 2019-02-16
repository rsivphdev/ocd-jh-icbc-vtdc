#!/bin/bash
#git clone https://github.com/rsivphdev/pocicbcvtdc.git
git clone --single-branch --branch pipeline-enabled https://github.com/rsivphdev/pocicbcvtdc.git
sleep 3
oc login -u cluster-admin
oc new-app -n jik2hd-tools -f ../templates/jh-icbc-vtdc-template.yaml
oc create configmap jhicbcvtdc-config -n jik2hd-dev --from-file=pocicbcvtdc/modules/pssg/poc/icbc/main/module.xml --from-file=pocicbcvtdc/modules/pssg/poc/icbc/main/vphsc.properties
oc create configmap jhicbcvtdc-config -n jik2hd-test --from-file=pocicbcvtdc/modules/pssg/poc/icbc/main/module.xml --from-file=pocicbcvtdc/modules/pssg/poc/icbc/main/vphsc.properties
sleep 3
oc project jik2hd-dev
echo "Check for DEV Deployment Configuration (dc) \n"
oc get dc
sleep 3
oc set volume dc/jhicbcvtdc --overwrite --add --name=jhicbcvtdc-mnt --mount-path=/wildfly/provided_modules/pssg/poc/icbc/main --type=configmap --configmap-name=jhicbcvtdc-config
sleep 3
oc project jik2hd-test
echo "Check for TEST Deployment Configuration (dc) \n"
oc get dc
sleep 3
oc set volume dc/jhicbcvtdc --overwrite --add --name=jhicbcvtdc-mnt --mount-path=/wildfly/provided_modules/pssg/poc/icbc/main --type=configmap --configmap-name=jhicbcvtdc-config
rm -rf ./pocicbcvtdc
