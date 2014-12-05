unit UtNau;

interface
   uses UtVaixell, Uterror, Vcl.Dialogs, System.SysUtils, System.Classes;
   const
      NUM_VAIXELLS = 50;
  type
    Tnau = class
      private
          v_vaixells: array [0..NUM_VAIXELLS -1] of TVaixell;
          function primera_pos_lliure:integer;
          procedure vaixell_averiat(id:integer);
          procedure vaixell_arreglat(id:integer);

      public
          err:Terror;
          onEspatllat:procedure (id:integer) of object;
          onArreglat:procedure (id:integer) of object;
          onMeteo: procedure (pos:integer; temps:char) of object;
          onEnfonsat: procedure (pos:integer) of object;
          constructor crear_nau;
          destructor destruir_nau;
          function destruir_vaixells (i:integer):boolean;
          function crear_vaixell(codi,naviera,port:string;capacitat:integer):integer;
          function consultar_capacitat(vaixell:integer):integer;
          function consultar_desgast(vaixell:integer):extended;
          function consultar_codi(vaixell:integer):string;
          function buscarCodiRepetit(codi:string):boolean;
          function consultar_carrega(vaixell:integer):integer;
          function destruir_vaixell(vaixell:integer):boolean;
          function navegar_vaixell(vaixell:integer):boolean;
          function carregar_vaixell(vaixell:integer;quantitat:integer):boolean;
          function Posar_Manteniment(vaixell:integer):boolean;
          function Fi_manteniment(vaixell:integer):boolean;
          function descarregar_vaixell(vaixell:integer):boolean;
          function atracar_vaixell(vaixell:integer):boolean;
          function consultar_naviera(vaixell:integer):string;
          function consultar_port(vaixell:integer):string;
          function consultar_estat(vaixell:integer):integer;
          procedure buscar_naviera(naviera: string; llistat:TStrings);
          procedure canviar_temps (id:integer; estat: char);
    end;
implementation

{ Tnau }

function Tnau.atracar_vaixell(vaixell: integer): boolean;
var
  res:boolean;
begin
  res := false;
  if self.v_vaixells[vaixell] <> nil then
  begin
    if self.v_vaixells[vaixell].consultar_estat = 2 then
    begin
      self.v_vaixells[vaixell].atracar;
      res := true;
    end
    else
    begin
       err.codierror := -111;
    end;

  end
  else
  begin
    err.codierror := -103;
  end;
  result := res;
end;

function Tnau.buscarCodiRepetit(codi: string): boolean;
var
  i:integer;
  res:boolean;
begin
   i := 0;
   res := false;
   while ((i < NUM_VAIXELLS) and (res = false))do
   begin
     if self.v_vaixells[i] <> nil then
     begin
       if self.v_vaixells[i].consultar_codi = codi then
       begin
         res := true;
       end;
     end;
   i := i + 1;
   end;
   result := res;
end;

procedure Tnau.buscar_naviera(naviera: string; llistat:TStrings);
var
  i:integer;
  estat:string;
begin
    for i := 0 to NUM_VAIXELLS do
    begin
      if self.v_vaixells[i]<>nil then
      begin
        if self.v_vaixells[i].consultar_naviera=naviera then
        begin
          if v_vaixells[i].consultar_estat=2 then
          begin
            estat:='MAR';
          end
          else
          begin
            if v_vaixells[i].consultar_estat=4 then
            begin
              estat:='En Manteniment';
            end
            else
            begin
              estat:='NO esta en manteniment';
            end;
          end;

          llistat.Add(v_vaixells[i].consultar_codi+'|Capacitat: '+inttostr(v_vaixells[i].consultar_capacitat)+'|Port Actual: '+v_vaixells[i].consultar_port_actual+
          '|'+estat+'|Carrega: '+inttostr(v_vaixells[i].consultar_carregat)+'|Desgast: '+floattostr(v_vaixells[i].consultar_desgast));

        end;
      end;
    end;
end;

procedure Tnau.canviar_temps(id:integer; estat: char);
begin
  if (self.v_vaixells[id].consultar_estat = 2) OR (self.v_vaixells[id].consultar_estat = 3) then
  begin
    if estat=chr(221) then
    begin
      self.v_vaixells[id].incrementar_desgast(2);
    end;
    if estat=chr(218) then
    begin
      self.v_vaixells[id].incrementar_desgast(1);
    end;
    self.onMeteo(id, estat);
  end;
  if self.v_vaixells[id].consultar_desgast>100 then
  begin
    self.v_vaixells[id].canviar_estat(1);
    onEnfonsat(id);
    self.destruir_vaixells(id);
  end;

end;

function Tnau.carregar_vaixell(vaixell: integer;quantitat:integer): boolean;
var
  res : boolean;
begin
res := false;
  if self.v_vaixells[vaixell] <> nil then
  begin
    if self.v_vaixells[vaixell].consultar_estat = 1 then
    begin
        if self.v_vaixells[vaixell].carregar(quantitat) then
        begin
           res := true;
        end
        else
        begin
           //error en utvaixell
           self.err.codierror := self.v_vaixells[vaixell].err.codierror;
        end;
    end
    else
    begin
      self.err.codierror := -105;
    end;
  end
  else
  begin
    //vaixell = nil
    self.err.codierror := -103;
  end;
  result := res;
end;

function Tnau.consultar_capacitat(vaixell: integer): integer;
var
  res:integer;
begin
  res := self.v_vaixells[vaixell].consultar_capacitat;
  result := res;
end;

function Tnau.consultar_carrega(vaixell:integer): integer;
begin
  result := self.v_vaixells[vaixell].consultar_carregat;
end;

function Tnau.consultar_codi(vaixell: integer): string;
begin
  result := self.v_vaixells[vaixell].consultar_codi;
end;

function Tnau.consultar_desgast(vaixell: integer): extended;
begin
  result := self.v_vaixells[vaixell].consultar_desgast;
end;

function Tnau.consultar_estat(vaixell: integer): integer;
begin
  result := self.v_vaixells[vaixell].consultar_estat;
end;

function Tnau.consultar_naviera(vaixell: integer): string;
begin
  result := self.v_vaixells[vaixell].consultar_naviera;
end;

function Tnau.consultar_port(vaixell: integer): string;
begin
  result := self.v_vaixells[vaixell].consultar_port_actual;
end;

constructor Tnau.crear_nau;
var i:integer;
begin
    for I := 0 to NUM_VAIXELLS - 1 do
    begin
      self.v_vaixells[i] := nil;
      //self.v_vaixells[i].onMeteo:=self.canviar_temps;
    end;
    self.err := Terror.Create;

end;

function Tnau.crear_vaixell(codi, naviera, port: string;
  capacitat: integer): integer;
  var
    pos:integer;
begin
    pos := self.primera_pos_lliure;
    if pos >= 0 then
    begin
      if buscarCodiRepetit(codi) = false then
      begin
        self.v_vaixells[pos] := TVaixell.crear(pos,codi,naviera,port,capacitat);
        self.v_vaixells[pos].onEspatllat := self.vaixell_averiat;
        self.v_vaixells[pos].onArreglat := self.vaixell_arreglat;
        self.v_vaixells[pos].onMeteo:=self.canviar_temps;
      end
      else
      begin
        err.codierror := -102;
        pos := -1;
      end;
    end
    else
    begin
      self.err.codierror := -101;
    end;

    result := pos;
end;

function Tnau.descarregar_vaixell(vaixell: integer): boolean;
var
  res:boolean;
begin
  res := false;
  if self.v_vaixells[vaixell] <> nil then
  begin
      if self.v_vaixells[vaixell].consultar_estat = 1 then
      begin
          if self.v_vaixells[vaixell].consultar_carregat >= self.v_vaixells[vaixell].consultar_capacitat * 0.9 then
          begin
            self.v_vaixells[vaixell].descarregar;
            res := true;
          end
          else
          begin
            err.codierror := -109;
          end;

      end
      else
      begin
        err.codierror := -108;
      end;

  end
  else
  begin
    err.codierror := -103;
  end;
  result := res;
end;

destructor Tnau.destruir_nau;
var
  i:integer;
begin
      for i := 0 to NUM_VAIXELLS -1 do
      begin
        self.destruir_vaixells(i);
      end;
      self.err.Destroy;
end;

function Tnau.destruir_vaixell(vaixell: integer): boolean;
var
  res:boolean;
begin
  res:=true;
  if self.v_vaixells[vaixell] <> nil then
  begin
    if self.v_vaixells[vaixell].consultar_estat = 4 then
     begin
        self.v_vaixells[vaixell].Destroy;
        self.v_vaixells[vaixell] := nil;
     end
     else
     begin
       err.codierror := -104;
       res := false;
     end;
  end
  else
  begin
    // vaixell escollit nil
    err.codierror := -103;
    res := false;
  end;
  result := res;
end;

function Tnau.destruir_vaixells(i: integer): boolean;
var
  res:boolean;
begin
res:= TRUE;
     if self.v_vaixells[i] <> nil then
     begin
       self.v_vaixells[i].destruir;
       self.v_vaixells[i] := nil;
     end
     else
     begin
       res:=FALSE;
       self.err.codiError := -103;
     end;
     result := res;
end;

function Tnau.Fi_manteniment(vaixell: integer): boolean;
var
  res:boolean;
begin
res := false;
  if self.v_vaixells[vaixell] <> nil then
  begin
    if self.v_vaixells[vaixell].consultar_estat = 4 then
    begin
       self.v_vaixells[vaixell].treure_manteniment;
       res := true;
    end
    else
    begin
      //vaixell no esta a port
      self.err.codierror := -107;
    end;
  end
  else
  begin
    err.codierror := -103;
  end;
  result := res;

end;

function Tnau.navegar_vaixell(vaixell: integer): boolean;
var
  res:boolean;
begin
  if self.v_vaixells[vaixell] <> nil then
  begin
        res := self.v_vaixells[vaixell].navegar;
        self.err.codierror := self.v_vaixells[vaixell].err.codierror;
  end
  else
  begin
    self.err.codierror := -103;
    res := false;
  end;
  result := res;
end;

function Tnau.Posar_Manteniment(vaixell: integer): boolean;
var
  res:boolean;
  desgast:integer;
begin
res := false;
  if self.v_vaixells[vaixell] <> nil then
  begin
    if self.v_vaixells[vaixell].consultar_estat = 1 then
    begin
      if self.v_vaixells[vaixell].consultar_carregat < self.v_vaixells[vaixell].consultar_capacitat * 0.9 then
      begin
          self.v_vaixells[vaixell].posar_manteniment;
          res := true;
      end
      else
      begin
          self.err.codierror := -110;
      end;
    end
    else
    begin
      //vaixell no esta a port
      self.err.codierror := -106;
    end;
  end
  else
  begin
    err.codierror := -103;
  end;
  result := res ;
end;

function Tnau.primera_pos_lliure: integer;
var
  i:integer;
begin
  i:=0;
  while ((self.v_vaixells[i] <> nil) and (i < NUM_VAIXELLS)) do
  begin
       i := i + 1;
  end;

  if i = NUM_VAIXELLS then
  begin
    i := -1;
  end;

  result := i;

end;

procedure Tnau.vaixell_arreglat(id: integer);
begin
self.onArreglat(id);
end;

procedure Tnau.vaixell_averiat(id: integer);
begin
  self.onEspatllat(id);
end;

end.





















