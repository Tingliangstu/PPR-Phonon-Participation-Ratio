clear; close all; 
 tic;
 %% set up some parameters related to the dump file
 
 Total_atoms = 1400;                                                                 % number of atoms (have to  change the number of atoms in your system )
 
 len_header=9;  
 N=Total_atoms+len_header;                                                     % length of block
 
 total_time_step = 3001;                                                             % total number of dump point
 in_file = 'dump.gr';                                                                     %  dump file name
 save_file_name = 'v_all.mat';                                                       %  output  file
 dump_columns = 5;                                                                    %  The number of columns in the dump file

 %% deal with these velocity data
 
 v_all=zeros(Total_atoms, dump_columns-2, total_time_step);
 
 fileID=fopen(in_file);
 formatSpec='%n %n %n %n %n';
 for i = 1:total_time_step
     
      C = textscan(fileID, formatSpec, N, 'HeaderLines', len_header, 'Delimiter', '\t');
      
      for  j = 1 : dump_columns-2
          
            v_all(:,j,i)=C{1, j+2};                                                          % Just extract the velocity information for x, y, and z
           
      end
end

fclose(fileID);

save(save_file_name, 'v_all')                                                          % Maybe you need to output the velocity file for backup
toc;