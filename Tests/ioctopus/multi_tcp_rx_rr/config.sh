if [ -z "$if1" ]; then
	echo "if1 not configured $if1"
	exit 22
fi

sudo set_irq_affinity_bynode.sh  1 $if1
ssh $loader1 sudo set_irq_affinity_bynode.sh  1 $dif1
