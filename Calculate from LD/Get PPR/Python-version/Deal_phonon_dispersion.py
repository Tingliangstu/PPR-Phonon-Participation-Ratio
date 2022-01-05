#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
@author: LiangTing
Email: lianting.zj@gmail.com
2020/03/04 21:42:48
"""
from __future__ import division, print_function
import numpy as np

__all__ = ["phonon"]

class phonon(object):

    def __init__(self, deal_file):

        self._deal_file = deal_file

        # phonon information

        self.qpoints_number = None  # get number of qpoints used  to  calculate
        self.poscar_atoms_number = None  # get number of atoms in POSCAR

        # Properties are for use within the class only

        self._phonon = None  # get phonon dictionary
        self._group_velocity = []
        self._frequencies = []
        self._eigenvectors = []
        self._qpoints = []
        self._distances = []

        # self._labels = []  # Labels specified are depicted in band structure plot at the points of band segments.

        # get participation
        self._participation = []

        import os
        if not os.path.isfile(self._deal_file):
            # Check that the .yaml file exists
            raise ValueError("\nSorry, the file " + self._deal_file + " does not exist or not in this folder.")
        else:
            print('\n' + self._deal_file + ' exists, Processing file is starting, please wait !!!\n')

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return False

    def deal_yaml_file(self):
        import yaml
        with open(self._deal_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)  # Load the yaml file and convert it to a dictionary
            self.qpoints_number = data['nqpoint']  # get number of qpoints used to calculate
            self.poscar_atoms_number = data['natom']  # get number of atoms in poscar
            self.phonon = data.get('phonon')  # get phonon dictionary

    @property
    def get_frequencies(self):
        # Get phonon frequencies
        for phonon in self.phonon:
            self._qpoints.append(phonon['q-position'])
            self._distances.append(phonon['distance'])  # can be used to draw the phonon dispersion

            # frequencies
            for f in phonon['band']:
                self._frequencies.append(f['frequency'])

        return np.array(self._frequencies)

    @property
    def get_eigenvectors(self):
        # Get phonon eigenvectors
        for phonon in self.phonon:
            for ev in phonon['band']:
                self._eigenvectors.append(ev['eigenvector'])

        return np.array(self._eigenvectors)

    @property
    def get_participation(self):

        # Get phonon participation
        for phonon in self.phonon:
            for ev in phonon['band']:
                e_add = 0
                count = 0
                for atom in ev['eigenvector']:
                    x = complex(atom[0][0], atom[0][1])  # Build  plural
                    y = complex(atom[1][0], atom[1][1])
                    z = complex(atom[2][0], atom[2][1])
                    x2 = x * x.conjugate()  # Take the conjugate
                    y2 = y * y.conjugate()
                    z2 = z * z.conjugate()
                    e = (x2 + y2 + z2) ** 2  # The in-plane and out-of-plane phonon modes (e = x, y and z) are considered here
                    e_add += e.real          # Only the real part is taken because the imaginary part is 0 (Corresponds to the number of atoms in poscar)
                    count += 1               # Count the number of atoms in the system (equal to the number of atoms in POSCAR)

                if count != self.poscar_atoms_number:
                    raise ValueError('\nDeal_phonon_dispersion should not reach here!!!')

                else:
                    p = int(self.poscar_atoms_number) * e_add
                    self._participation.append(1 / p)

        print('\n Participation ratio is generated OK ^_^')

        return np.array(self._participation)

    @property
    def get_group_velocity(self):
        # Get group_velocity
        for phonon in self.phonon:
            if 'group_velocity' in phonon['band'][0]:
                for v in phonon['band']:
                    Gv = v['group_velocity']
                    group_velocity = np.sqrt((((Gv[0]) * 100) ** 2 + ((Gv[1]) * 100) ** 2 + ((Gv[2]) * 100) ** 2))
                    self._group_velocity.append(group_velocity)
            else:
                self._group_velocity = None

        # Is exists the group_velocity?
        if self._group_velocity is None:

            raise ValueError('\nGroup_velocity does not exist')

        else:

            return np.array(self._group_velocity)

    @staticmethod
    def plot_phonon_figures(frequency, participation_ratio):
        import matplotlib.pyplot as plt
        # figure for participation_ratio
        plt.rcParams['figure.figsize'] = (9.0, 6.0)  # Set output image size
        plt.figure(1)
        plt.plot(frequency, participation_ratio, 'or', label='participation_ratio')
        plt.ylim(0, 1)
        plt.xlim(0, 16)                              # For MoS2
        plt.xticks(fontsize=15)
        plt.yticks(fontsize=15)
        plt.xlabel('Frequency (THz)', fontsize=15)
        plt.ylabel('Participation_ratio', fontsize=15)
        plt.legend(fontsize=15, loc='best')
        plt.show()  # show the plot on the screen

    def plot_dispersion(self):
        pass

    def writeToFile(self, file_name='phonon_inf.csv'):
        #import csv
        pass

if __name__ == "__main__":
    deal_file = 'band.yaml'
    ph = phonon(deal_file)
    ph.deal_yaml_file()
    ph.plot_phonon_figures(ph.get_frequencies, ph.get_participation)
    print('PPR Calculate All Done\n')
