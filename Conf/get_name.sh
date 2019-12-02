#!/bin/bash

kern=`uname -r`

[ -z "$prot" ] && prot=`cat /proc/cmdline|grep -oP "strict"`
[ -z "$prot" ] && prot=`cat /proc/cmdline|grep -oP "intel_iommu=on"`
[ -z "$prot" ] && prot='unsafe'

[ $prot == "intel_iommu=on" ] && prot='defer'

#%+ magic to remove the suffix +
# -$prot"
echo "${kern%+}"
