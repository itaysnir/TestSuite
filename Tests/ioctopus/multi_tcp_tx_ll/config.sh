if [ -z "$if1" ]; then
	echo "if1 not configured $if1"
	exit 22
fi



sudo set_irq_affinity_bynode.sh  0 $if1
ssh $loader1 sudo set_irq_affinity_bynode.sh  0 $dif1
