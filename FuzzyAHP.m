function [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
fuzzyRelasi={};
[jumlahData, jumlahKriteria] = size(relasiAntarKriteria);

% mengisi nilai di - segitugas bawah di matruk relasiAntarKriteria
disp("relasi antar kriteria : ");
for i=1:jumlahData 
    for j=i+1:jumlahData 
        relasiAntarKriteria(j,i) = 1 / relasiAntarKriteria(i,j);
  
    end
end
 relasiAntarKriteria;

%melakukan pergitungan pada mtrik relasi antar kriteria
disp("Fuzzy Relasi = ");
for i=1:jumlahData
    for j=1:jumlahKriteria
        kriteria = relasiAntarKriteria(i,j); 
        if kriteria >= 1 
            fuzzyRelasi{i,j} = TFN{kriteria ,1 }; 
            disp(fuzzyRelasi{i,j});
           
        else
            fuzzyRelasi{i,j} = TFN{round(kriteria^-1) ,2 }; 
           disp(fuzzyRelasi{i,j});
        
        end
    end
end
    
% hitung jumlah masing msing TFN pada matriks fuzzyRelasi
disp("jumlah relasi perbaris :");
for i=1:jumlahData
    barisRelasi = [fuzzyRelasi{i,:}]; 
    jumlahRelasiPerBaris{1,i} = sum(reshape(barisRelasi,3,[])'); 
    disp(jumlahRelasiPerBaris{1,i});
end
disp("jumlah relasi perkolom : ");
RelasiPerData = [jumlahRelasiPerBaris{1,:}];
jumlahRelasiPerKolom = sum(reshape(RelasiPerData,3,[])');
disp(jumlahRelasiPerKolom);

disp("jumlah relasi pada masing masing kolom : ");
for i=1:jumlahData
    RelasiPerData = [jumlahRelasiPerBaris{1,i}];
    for j=1:3 
        nilaiRelasiPerKolom = jumlahRelasiPerKolom(1,j);
        jumlahPerKolom(1,j) = (RelasiPerData(1,j))*(1/nilaiRelasiPerKolom);
       
    end
    jumlahRelasiPerBaris{1,i} = jumlahPerKolom;
     disp(jumlahRelasiPerBaris{1,i});
end

derajatKemungkinan = zeros(jumlahData*(jumlahData-1),3); 

idxBaris = 1;

for i=1:jumlahData 
    for j=1:jumlahData 
        if i~=j
            derajatKemungkinan(idxBaris,[1 2]) = [i j]; 
            M1 = jumlahRelasiPerBaris{1,i};
            M2 = jumlahRelasiPerBaris{1,j};
            
            if M1(1,2) >= M2(1,2) 
                derajatKemungkinan(idxBaris,3) = 1; 
            elseif M2(1,1) >= M1(1,3) 
                derajatKemungkinan(idxBaris,3) = 0; 
            else
                derajatKemungkinan(idxBaris,3) = (M2(1,1)-M1(1,3))/((M1(1,2)-M1(1,3))-(M2(1,2)-M2(1,1)));
            end
            
            idxBaris = idxBaris + 1;
        end
    end
end

disp("Derajat Kemungkinan : ");
disp(derajatKemungkinan);

for i=1:jumlahData, 
    bobotAntarKriteria(1,i) = min(derajatKemungkinan([find(derajatKemungkinan(:,1) == i)], [3]));
end
disp("Bobot Antar Kriteria : ");
disp(bobotAntarKriteria);


bobotAntarKriteria = bobotAntarKriteria/sum(bobotAntarKriteria);
disp("Normalisasi nilai bobot : ");
disp(bobotAntarKriteria);
end
