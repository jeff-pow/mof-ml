#/bin/bash

base=$(pwd)
cifs_dir=./paper-cifs

for file in ${cifs_dir}/*.cif; do
    echo $mol_name
    echo "here"
    echo $file
    # Make sure to chown files so `basename` can be used
    filename=$(basename "$file")
    mol_name="${filename%.*}"
    echo $mol_name
    # Run EQeq to get the charges on the full system and convert to a pdb
    $base/eqeq.sh $file
    # mv ./eqeq_output/*.pdb ./${cifs_dir}/${mol_name}.pdb
    pdb=${cifs_dir}/${mol_name}.pdb
    echo $pdb
    mv ${file}_EQeq_ewald_1.20_-2.00.pdb $pdb
    cat ${file}_EQeq_ewald_1.20_-2.00.json | sed 's/^\[\(.*\)\]$/\1/' | tr ',' '\n' > ${cifs_dir}/${mol_name}_charges.txt

    # If file is not clean, run pdb_wizard to remove isolated molecules
    # This may be possible in mercury too. In the GUI the commands are 
    # Edit -> Edit Structure -> Remove Molecules
    if [[ "$file" != *_clean* ]]; then
        echo -e "1\n5\n0\n3\n3\n${cifs_dir}/${mol_name}.pdb\n0\n0\n" | python3 $HOME/bin/pdb_wizard.py $pdb
    fi

    # echo -e "1\n5\n0\n3\n2\n1\n" | python3 $HOME/bin/pdb_wizard.py $file # Append charges to the file
    # Convert standard pdb format to mpmc pdb >:(
    # echo -e "3\n2\n1\n${cifs_dir}/${mol_name}_charges.txt\n1\n1\n${cifs_dir}/${mol_name}_mpmc.pdb\n0\n0" 
    # exit 1
    echo -e "3\n2\n1\n${cifs_dir}/${mol_name}_charges.txt\n1\n1\n${cifs_dir}/${mol_name}_mpmc.pdb\n0\n0" | python3 $HOME/bin/pdb_wizard.py $pdb # Append charges to the file

        
done
