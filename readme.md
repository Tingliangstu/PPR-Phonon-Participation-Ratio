# PPR-Phonon-Participation-Ratio
####**Calculation of phonon participation rates -- used to characterize atomic vibrational information including the degree of localization and delocalization.**

### This project contains two calculation methods. As follows:

#### 1. [Calculate PPR from PDOS (classical MD)](https://github.com/Tingliangstu/PPR-Phonon-Participation-Ratio/tree/main/Calculate%20from%20PDOS)

Based on the atomic phonon density of states (PDOS) [[Dickey 1969]](https://doi.org/10.1103/PhysRev.188.1407), the PPR is calculated to approximately measure the phonon localization with the following form [[Bell 1970]](https://doi.org/10.1039/DF9705000055):,
$$
PPR(\omega) = \frac{1}{N} \frac{(\sum_{i}PDOS_{i}^{2}(\omega))^{2}}{\sum_{i}PDOS_{i}^{4}(\omega)},
$$
where *$PDOS_{i}$* is the atomic *PDOS*, and *N* is the total number of atoms involved in the calculation.

#### 2. [Calculate PPR from lattice dynamic (LD)](https://github.com/Tingliangstu/PPR-Phonon-Participation-Ratio/tree/main/Calculate%20from%20LD)

In this method, one can use the following formula to calculate the PPR,  
$$
P_{\lambda}^{-1}=N \sum_{i}\left(\sum_{\alpha} e_{i \alpha, \lambda}^{*} e_{i \alpha, \lambda}\right)^{2}
$$

where *N* is the total number of atoms in primitive cell. and $e_{i \alpha, \lambda}$ is the αth eigenvector component of eigenmode λ for the ith atom. Each eigenmode λ is specified by the wave-vector **k** and branch index s. 

