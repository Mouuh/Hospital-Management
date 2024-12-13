program GestionHopital;

uses SysUtils;

type
  Malade = record
    Nom: string;
    Prenom: string;
  end;

  Service = record
    Designation: string;
    Responsable: string;
    NombreLit: integer;
    Malades: array of Malade;
  end;

  Hopital = record
    Adresse: string;
    Services: array of Service;
  end;

var
  Services: array of Service;
  H: Hopital;

procedure AjouterHopital;
begin
  writeln('Ajouter un Hôpital');
  writeln('Veuillez saisir l''adresse de l''hôpital:');
  write('Adresse: ');
  readln(H.Adresse);
end;

procedure AjouterService;
var
  i, j: integer;
  S: Service;
begin
  writeln('Ajouter un Service');
  for i := 1 to 5 do
  begin
    writeln('Service N', i);
    write('Désignation: ');
    readln(S.Designation);
    write('Responsable: ');
    readln(S.Responsable);
    write('Nombre de lits: ');
    readln(S.NombreLit);
    SetLength(S.Malades, S.NombreLit);

    writeln('La liste des malades:');
    for j := 0 to S.NombreLit - 1 do
    begin
      write('  ', j + 1, ') Nom: ');
      readln(S.Malades[j].Nom);
      write('     Prénom: ');
      readln(S.Malades[j].Prenom);
    end;

    writeln('Le service a été ajouté avec succès!');
    SetLength(Services, Length(Services) + 1);
    Services[High(Services)] := S;
  end;
end;

procedure AfficherService;
var
  i, j: integer;
begin
  writeln('Information Hôpital:');
  writeln('Adresse: ', H.Adresse);
  writeln('Services:');

  for i := 0 to High(Services) do
  begin
    writeln('Service N', i + 1);
    writeln('Désignation: ', Services[i].Designation);
    writeln('Responsable: ', Services[i].Responsable);
    writeln('Nombre de lits: ', Services[i].NombreLit);
    writeln('La liste des malades:');

    for j := 0 to High(Services[i].Malades) do
    begin
      writeln('  ', j + 1, ') Nom: ', Services[i].Malades[j].Nom, ', Prénom: ', Services[i].Malades[j].Prenom);
    end;

    writeln;
  end;
end;

procedure RechercherMalade;
var
  Nom, Prenom: string;
  i, j: integer;
  MaladeTrouve: boolean;
begin
  writeln('Recherche d''un malade');
  write('Nom du malade: ');
  readln(Nom);
  write('Prénom du malade: ');
  readln(Prenom);

  MaladeTrouve := False;
  for i := 0 to High(Services) do
  begin
    for j := 0 to High(Services[i].Malades) do
    begin
      if (Services[i].Malades[j].Nom = Nom) and (Services[i].Malades[j].Prenom = Prenom) then
      begin
        writeln('Le malade ', Nom, ' ', Prenom, ' est au lit numéro ', j + 1);
        writeln('Responsable: ', Services[i].Responsable);
        writeln('Désignation du service: ', Services[i].Designation);
        writeln('Dans l''hôpital de ', H.Adresse);
        MaladeTrouve := True;
        Break;
      end;
    end;
    if MaladeTrouve then
      Break;
  end;

  if not MaladeTrouve then
    writeln('Le malade ', Nom, ' ', Prenom, ' n''a pas été trouvé dans les services de l''hôpital.');
end;

procedure AfficherLitsDisponibles;
var
  i, j, LitsOccupes, LitsDisponibles: integer;
begin
  writeln('Information Hôpital:');
  writeln('Adresse: ', H.Adresse);
  writeln('Services:');

  for i := 0 to High(Services) do
  begin
    writeln('Service N', i + 1);
    writeln('Désignation: ', Services[i].Designation);
    writeln('Responsable: ', Services[i].Responsable);
    writeln('Nombre de lits: ', Services[i].NombreLit);

    LitsOccupes := 0;
    LitsDisponibles := 0;

    for j := 0 to Services[i].NombreLit - 1 do
    begin
      if (Services[i].Malades[j].Nom = '') and (Services[i].Malades[j].Prenom = '') then
        Inc(LitsDisponibles)
      else
        Inc(LitsOccupes);
    end;

    writeln('Lits occupés: ', LitsOccupes);
    writeln('Lits disponibles: ', LitsDisponibles);
    writeln;
  end;
end;

var
  Option: string;
begin
  repeat
    writeln('Menu principal');
    writeln('1. Ajouter Hôpital');
    writeln('2. Ajouter un Service');
    writeln('3. Afficher les Services');
    writeln('4. Rechercher un Malade');
    writeln('5. Afficher les Lits Disponibles');
    writeln('6. Quitter');
    write('Choisissez une option (1-6): ');
    readln(Option);

    case Option of
      '1': AjouterHopital;
      '2': AjouterService;
      '3': AfficherService;
      '4': RechercherMalade;
      '5': AfficherLitsDisponibles;
      '6': writeln('Programme terminé.');
    else
      writeln('Option invalide. Veuillez choisir une option valide.');
    end;

    writeln;
  until Option = '6';
end.
