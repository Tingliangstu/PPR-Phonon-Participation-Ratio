# Generate Phonon eigenvector using [Phonolammps](https://github.com/abelcarreras/phonolammps) + [Phonopy](https://phonopy.github.io/phonopy/), one need to calculate the phonon dispersion 

## Usage
#### 1. Learn to how to generate the force_constant using Empirical potential with [Phonolammps](https://github.com/abelcarreras/phonolammps). The following files should be include.

- [x] POSCAR (primitive structure file, and use to feed the [dynaphopy](https://abelcarreras.github.io/DynaPhoPy/usage.html) and the phonopy)

- [x] input_MoS2 (input file for [dynaphopy](https://abelcarreras.github.io/DynaPhoPy/usage.html))

  `dynaphopy  input_MoS2  -c_lammps   data.MoS2   --dim   4   4   1` ,

  means the data.MoS2 file will be generate with supercell (4   4   1)

- [x] data.MoS2 (lammps input file)

- [x] MoS.REBO.set5b (Empirical potential file)

- [x] in.lammps (read the data from lammps)

  use the following command to generate the force_constant:

  `phonolammps  in.lammps  -c  POSCAR_unitcell  --dim  1   1   1 `

#### 2. Use [Phonopy](https://phonopy.github.io/phonopy/) to calculate the phonon dispersion and get the eigenvector information. The following files should be include.

- [x] POSCAR (primitive structure file, and use to feed the phonopy)
- [x] band.conf
- [x] FORCE_CONSTANTS (generate by [Phonolammps](https://github.com/abelcarreras/phonolammps))

#### 3. run `run.sh`. The following files would be generate.

- [x] [band.yaml](https://phonopy.github.io/phonopy/output-files.html#band-yaml) (This file will be use to get the PPR)

- [x] Phonon dispersion, as shown in here.

  <div align=center><img width="600" height="300" src=https://github.com/Tingliangstu/PPR-Phonon-Participation-Ratio/blob/main/Calculate%20from%20LD/phonolammps%20%2B%20phonopy/MoS2_dispersion.eps>

