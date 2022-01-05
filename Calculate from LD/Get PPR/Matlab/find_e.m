function [Result_atom]=find_e(everyatom_eigenvector)

atom1x = complex(everyatom_eigenvector(1,1), everyatom_eigenvector(1,2));              % Constructing complex numbers
atom1y = complex(everyatom_eigenvector(2,1), everyatom_eigenvector(2,2));
atom1z = complex(everyatom_eigenvector(3,1), everyatom_eigenvector(3,2));
atom1x2 = atom1x * conj(atom1x);                                                  % Solving for conjugate 
atom1y2 = atom1y * conj(atom1y);
atom1z2 = atom1z * conj(atom1z);

Result_atom = (atom1x2+atom1y2+atom1z2)^2 ;                           % Square