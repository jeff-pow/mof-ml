#bin/bash

base=$(pwd)

for gas in n2np n2p; do
        mkdir -p $gas
        cd $gas

        for temp in 77; do
                mkdir -p $temp
                cd $temp

                for pressure in 0.001 0.005 0.01 0.03 0.05 0.07 0.09 `seq 0.1 0.1 1.0`; do
                        mkdir -p $pressure
                        cd $pressure
                        cp ../../INPUT.pdb .

                        sed "s/xjobx/$gas"_"$temp"_"$pressure/g" $base/mpmc_submit.sh > mpmc_submit.sh
                        sed "s/xjobx/$gas"_"$temp"_"$pressure/g" ../../mpmc.inp > mpmc.inp
                        #sed -i "s/xtempx/$temp/g" mpmc.inp
                        sed -i "s/xpresx/$pressure/g" mpmc.inp

                        rm -f std*
                        rm -f core.*

                        bsub < mpmc_submit.sh
                        pwd

                        cd ../
                done
                cd ../
        done
        cd ../
done
