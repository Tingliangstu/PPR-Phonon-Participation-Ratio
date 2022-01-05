# Get PPR From matlab codes using single-atom PDOS.

In this method, one can use the following formula to calculate the PPR,
$$
PPR(\omega) = \frac{1}{N} \frac{(\sum_{i}PDOS_{i}^{2}(\omega))^{2}}{\sum_{i}PDOS_{i}^{4}(\omega)},
$$
where *$PDOS_{i}$* is the atomic *PDOS*, and *N* is the total number of atoms involved in the calculation. (From top Dr. [penghua](https://github.com/hityingph/Tutorial-on-atomic-simulations/blob/main/Phonon%20Participation%20Ratios/Phonon%20Participation%20Ratios.ipynb))

**The code is adapted from matlab for calculating the total PDOS written by Dr. [Zheyong Fan](https://github.com/brucefan1983), and I will refine the tutorial using it once I have time.**

#### If you use the code, the following citations are highly recommended.

1. Liang T, Zhou M, Zhang P, et al., [Int. J. Heat Mass Transf. 151, 119395 (2020)](https://www.sciencedirect.com/science/article/pii/S0017931019350446)
2. Zhou M, Liang T, Wu B, et al., [Journal of Applied Physics, 2020, 128(23): 234304](https://aip.scitation.org/doi/full/10.1063/5.0025402)
3. Xu K, Liang T, Zhang Z, et al., [Nanoscale, 2022](https://pubs.rsc.org/en/content/articlehtml/2022/nr/d1nr05113j)

