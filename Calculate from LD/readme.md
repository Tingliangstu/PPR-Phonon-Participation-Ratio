# Get PPR From different version codes using lattice dynamic (LD) method.

### In this method, one can use the following formula to calculate the PPR,  

$$
P_{\lambda}^{-1}=N\sum_{i}\left(\sum_{\alpha} e_{i\alpha,\lambda}^{*}e_{i\alpha,\lambda}\right)^{2}
$$

where *N* is the total number of atoms in primitive cell, and $e_{i\alpha,\lambda}$ is the αth eigenvector component of eigenmode λ for the ith atom. Each eigenmode λ is specified by the wave-vector **k** and branch index s. 

**For detailed theoretical formulas, see the derivation of the formulas in the [Ref](https://github.com/Tingliangstu/PPR-Phonon-Participation-Ratio/tree/main/Calculate%20from%20LD/Ref) folder.**

#### When PR ≈ 1.0, it means that most of the atoms are involved in the motion of the phonon and have collective excitation and propagation properties (delocalization modes). For example, PR < 0.2 characterizes the localization mode, i.e., only a few atoms have collective motion properties and the atoms vibrate in a haphazard manner, which is not the propagation mode of the phonon.

For specific case, see my collaborator's [github](https://github.com/hityingph/Tutorial-on-atomic-simulations/blob/main/Phonon%20Participation%20Ratios/Phonon%20Participation%20Ratios.ipynb) for graphene.

