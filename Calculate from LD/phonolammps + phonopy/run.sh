## Genarate Phonon_dispersion

dynaphopy  input_MoS2  -c_lammps   data.MoS2   --dim   4   4   1

phonolammps  in.lammps  -c  POSCAR_unitcell  --dim  1   1   1 

phonopy   band.conf  -p 
