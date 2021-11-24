close all
clear all
clc
%% raidþiø pavyzdþiø nuskaitymas ir poþymiø skaièiavimas
%% read the image with hand-written characters
pavadinimas = 'train_data.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 8);
%% Atpaþintuvo kûrimas
%% Development of character recognizer
% poþymiai ið celiø masyvo perkeliami á matricà
% take the features from cell-type variable and save into a matrix-type variable
P = cell2mat(pozymiai_tinklo_mokymui);
% sukuriama teisingø atsakymø matrica: 11 raidþiø, 8 eilutës mokymui
% create the matrices of correct answers for each line (number of matrices = number of symbol lines)
T = [eye(11), eye(11), eye(11), eye(11), eye(11), eye(11), eye(11), eye(11)];
% sukuriamas SBF tinklas duotiems P ir T sàryðiams
% create an RBF network for classification with 13 neurons, and sigma = 1

tinklas = newrb(P,T,0,1,15); %mano ranka rašytus tekstus teisingai nuskaito, žmonos ranka rašytus tekstus nenuskaito.
%tinklas = newrb(P,T,0,1,6); %nei mano, nei žmonos rašytų tekstų nenuskaito.


%tinklas = newff(P,T,11); %daugiasluoksnis tinklas, prastai sekasi atpažinti tekstą
%tinklas = train(tinklas,P,T);

%% Tinklo patikra | Test of the network (recognizer)
% skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
% estimate output of the network for unknown symbols (row, that were not used during training)
P2 = P(:,12:22);
Y2 = sim(tinklas, P2);
% ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
% find which neural network output gives maximum value
[a2, b2] = max(Y2);
%% Rezultato atvaizdavimas
%% Visualize result
% apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
% calculate the total number of symbols in the row
raidziu_sk = size(P2,2);
% rezultatà saugosime kintamajame 'atsakymas'
% we will save the result in variable 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % the symbol here should be the same as written first symbol in your image
            atsakymas = [atsakymas, 'G'];
        case 2
            atsakymas = [atsakymas, 'T'];
        case 3
            atsakymas = [atsakymas, 'F'];
        case 4
            atsakymas = [atsakymas, 'M'];
        case 5
            atsakymas = [atsakymas, 'R'];
        case 6
            atsakymas = [atsakymas, 'S'];
        case 7
            atsakymas = [atsakymas, 'C'];
        case 8
            atsakymas = [atsakymas, 'P'];
        case 9
            atsakymas = [atsakymas, 'K'];
        case 10
            atsakymas = [atsakymas, 'A'];
        case 11
            atsakymas = [atsakymas, 'D'];
    end
end
% pateikime rezultatà komandiniame lange
% show the result in command window
disp(atsakymas)
% % figure(7), text(0.1,0.5,atsakymas,'FontSize',38)

%mano ranka rašyti žodžiai
disp('Testiniai tekstai (mano ranka rašyti)')
image_2_text(tinklas,'test_dakaras.png', 8)
image_2_text(tinklas,'test_marsas.png', 9)
image_2_text(tinklas,'test_paktas.png', 10)

%mano žmonos ranka rašyti žodžiai
disp('Žmonos rankraštis')
image_2_text(tinklas,'test_kapas_zmonos.png', 11)
image_2_text(tinklas,'test_skara_zmonos.png', 12)
image_2_text(tinklas,'test_takas_zmonos.png', 13)
image_2_text(tinklas,'test_gramas_zmonos.png', 14)
%žmonos ranka rašytų neatpažino raidžių - skiriasi rankraštis

%tas pats tekstas kaip žmonos, tik mano ranka rašyti
disp('Tas pats tekstas kaip žmonos, tik mano ranka rašytas')
image_2_text(tinklas,'test_kapas.png', 15)
image_2_text(tinklas,'test_skara.png', 16)
image_2_text(tinklas,'test_takas.png', 17)
image_2_text(tinklas,'test_gramas.png', 18)


function atsakymas = image_2_text(tinklas, failo_pavadinimas, index)       
    pozymiai_patikrai = pozymiai_raidems_atpazinti(failo_pavadinimas, 1);
    
    %% Raidþiø atpaþinimas
    % poþymiai ið celiø masyvo perkeliami á matricà
    P2 = cell2mat(pozymiai_patikrai);
    % skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
    Y2 = sim(tinklas, P2);
    % ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
    [a2, b2] = max(Y2);
    %% Rezultato atvaizdavimas
    % apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
    raidziu_sk = size(P2,2);
    % rezultatà saugosime kintamajame 'atsakymas'
    atsakymas = [];
    for k = 1:raidziu_sk
        switch b2(k)
            case 1
                atsakymas = [atsakymas, 'G'];
            case 2
                atsakymas = [atsakymas, 'T'];
            case 3
                atsakymas = [atsakymas, 'F'];
            case 4
                atsakymas = [atsakymas, 'M'];
            case 5
                atsakymas = [atsakymas, 'R'];
            case 6
                atsakymas = [atsakymas, 'S'];
            case 7
                atsakymas = [atsakymas, 'C'];
            case 8
                atsakymas = [atsakymas, 'P'];
            case 9
                atsakymas = [atsakymas, 'K'];
            case 10
                atsakymas = [atsakymas, 'A'];
            case 11
                atsakymas = [atsakymas, 'D'];
        end
    end
    % pateikime rezultatà komandiniame lange
    disp(atsakymas);
    
    figure(index), text(0.1,0.5,atsakymas,'FontSize',38), axis off
end

