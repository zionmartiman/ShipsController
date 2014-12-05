unit Uterror;

interface
  uses
    vcl.dialogs;
  type
    Terror = class
      private
    Fcodierror: integer;
    procedure Setcodierror(const Value: integer);

      public
        property codierror:integer read Fcodierror write Setcodierror;
        function quinerror:string;
        procedure mostrarerror;

    end;
implementation

{ Terror }

procedure Terror.mostrarerror;
begin
    messagedlg (quinerror,mterror,[mbok],1);
end;

function Terror.quinerror: string;
var
  res : string;
begin
     case self.codierror of
        //errors interf�cie (-1-100)
            -1: res := 'Dades de creaci� incomplertes';
            -2: res := 'La quantitat ha de ser superior o igual a 0';
            -3: res := 'Cap vaixell seleccionat';
        //errors nau (-101-200)
            -101: res := 'No es poden crear m�s vaixells';
            -102: res := 'El vaixell que es vol crear ja existeix';
            -103: res := 'El vaixell escollit es incorrecte o no existeix';
            -104: res := 'Per eliminar un vaixell ha d''estar En manteniment';
            -105: res := 'per a carregar un vaixell aquest ha d''estar a port i no pot estar en manteniment';
            -106: res := 'El vaixell no es troba a port o ja est� en manteniment';
            -107: res := 'El vaixell no es troba actualment en manteniment';
            -108: res := 'Per a descarregar un vaixell ha d''estar a port i no pot estar en manteniment';
            -109: res := 'Un vaixell mom�s es considera carragat quan porta un 90% o m�s de la seva capacitat';
            -110: res := 'Per a poder posar en manteniment aquest no pot estar carregat';
            -111: res := 'El vaixell no es troba a port o est� averiat';
        //errors vaixell (-201-300)
            -201: res := 'Un vaixell en reparaci� no pot navegar';
            -202: res := 'El port dest� ha de ser diferent al actual';
            -203: res := 'Per a poder navegar, el vaixell ha destar actualment a port';
            -204: res := 'No es pot introduir aquesta c�rrega degut a que supera a la capacitat m�xima';

     end;
  result := res;
end;

procedure Terror.Setcodierror(const Value: integer);
begin
  Fcodierror := Value;
end;

end.
