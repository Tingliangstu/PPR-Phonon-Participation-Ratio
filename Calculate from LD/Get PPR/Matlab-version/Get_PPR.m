%% Start 
clear; close all; font_size=15;
 tic;
%% Read data from .yaml file

 yaml_file = 'band.yaml'; 
 YamlStruct = ReadYaml(yaml_file);

%% Deal with these data
 Total_qpoint = YamlStruct.nqpoint;
 Band_number = size (YamlStruct.phonon{1, 1}.band, 2);      % Also equal to the number of phonon branches
 Frequency = zeros(Total_qpoint, Band_number);
 Group_velocity = cell(Total_qpoint, Band_number);
 Eigenvector = cell(Total_qpoint, Band_number);                
 Total_Group_velocity = zeros(Total_qpoint, Band_number);  %Preallocated memory

 for  i = 1:Total_qpoint
    
        for  j = 1:Band_number
       
                    Frequency(i, j)= YamlStruct.phonon{1, i}.band{1, j}.frequency;
                    Group_velocity{i, j}= YamlStruct.phonon{1, i}.band{1, j}.group_velocity;
                    Eigenvector{i, j}=YamlStruct.phonon{1, i}.band{1, j}.eigenvector;
                     %%Total 
                     Total_Group_velocity(i, j) = sqrt(((cell2mat(Group_velocity{i,j}(1,1))*100)^2 + (cell2mat(Group_velocity{i,j}(1,2))*100)^2  +...
                     (cell2mat(Group_velocity{i,j}(1,3))*100)^2));  
                     %%% with unit of (m/s)  (A*THZ = 100 m/s)
        end   
    
 end
%%   Plot  Total_Group_velocity  and  Collate the format of these data

 T_Frequency = reshape(Frequency, Total_qpoint * Band_number, 1);
 T_Total_Group_velocity = reshape(Total_Group_velocity, Total_qpoint * Band_number, 1);

 figure(1);
 scatter(T_Frequency, T_Total_Group_velocity/1000, 36, 'm', 'filled');
 xlim([0,15]);
 set(gca, 'fontsize', font_size);
 xlabel('Frequency (THz)');
 ylabel('|v| (km/s)');
 legend('Total group velocity (MoS_2)');

%%  Deal with participation ratio

 %Get some parameters from the yaml file

 atoms_number = size(Eigenvector{1, 1}, 2);                   % The number of atoms in the poscar
 %Total_atom_system = cell2mat(YamlStruct.supercell_matrix(1,1)) + cell2mat(YamlStruct.supercell_matrix(2,2));  %% Only for 2D material 
 Result_atom = zeros(1, atoms_number);                   
 Participation_ratio = zeros(Total_qpoint, Band_number);
 
  for  i = 1:Total_qpoint
    
          for  j = 1:Band_number
			  
                for  k = 1:atoms_number     
					
                       [Result_atom(1, k)]=find_e(cell2mat(Eigenvector{i, j}{1, k}));
					   
                end
                
                Participation_ratio(i, j) = 1./(atoms_number * sum(Result_atom));
                
		  end
  end

 %% Plot  Participation_ratio
 T_Participation_ratio = reshape(Participation_ratio, Total_qpoint * Band_number, 1);
 
 figure(2);
 plot(T_Frequency, T_Participation_ratio, ' ko', 'linewidth', 2);
 
 xlim([0 15]);          
 ylim([0 1]);                                                                        % X, Y scale for MoS2 only;
 set(gca, 'fontsize', font_size);
 xlabel('Frequency (THz)');
 ylabel('Participation ratio');
 legend('MoS_2', 'Location', 'best');
 
 toc;







