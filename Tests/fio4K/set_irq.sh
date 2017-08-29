#!/bin/bash

total_cpus=`nproc`

cpu=$1

config_nvme()
{
  #current_cpu=0
  for dev in /sys/bus/pci/drivers/nvme/[0-9]*
  do
    if [ ! -d $dev ]
    then
      continue
    fi
    for irq_info in $dev/msi_irqs/[0-9]*
    do
      ##### route all interrupts to specific cpu
      irq=$(basename "$irq_info")
      if [ ! -d /proc/irq/$irq ]
      then
        continue
      fi
      echo Setting IRQ $irq smp_affinity to $cpu
      echo $cpu > /proc/irq/$irq/smp_affinity_list
    done
  done
}


if [ $# != 1 ]; then
        echo `basename  $0` ": missing argument <cpu_number>"
        exit 1
fi

echo "Routing all interrupts to cpu $cpu"

config_nvme
