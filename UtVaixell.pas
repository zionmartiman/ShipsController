unit UtVaixell;

interface
uses Uterror, Utmeteo, Utgps, Vcl.Dialogs, System.SysUtils, vcl.extctrls;
const
  A_PORT = 1;
  NAVEGANT = 2;
  AVERIAT = 3;
  MANTENIMENT = 4;

    type
      TVaixell = class
      private
            Fcarregat: integer;
            Fport_actual: string;
            Fcapacitat: integer;
            Festat: integer;
            Fnaviera: string;
            Fcodi: string;
            Fen_manteniment: boolean;
            Fdesgast: extended;
            Fid: integer;
            Fmeteo: Tmeteo;
            procedure Setcapacitat(const Value: integer);
            procedure Setcodi(const Value: string);
            procedure Seten_manteniment(const Value: boolean);
            procedure Setestat(const Value: integer);
            procedure Setnaviera(const Value: string);
            procedure Setport_actual(const Value: string);
            procedure Setcarregat(const Value: integer);
            procedure Setdesgast(const Value: extended);
            procedure Setid(const Value: integer);
            procedure Setmeteo(const Value: Tmeteo);
            property codi:string read Fcodi write Setcodi;
            property capacitat:integer read Fcapacitat write Setcapacitat;
            property naviera:string read Fnaviera write Setnaviera;
            property port_actual:string read Fport_actual write Setport_actual;
            property carregat:integer read Fcarregat write Setcarregat;
            property en_manteniment:boolean read Fen_manteniment write Seten_manteniment;
            property estat:integer read Festat write Setestat;
            property desgast:extended read Fdesgast write Setdesgast;
            property id:integer read Fid write Setid;
            property meteo:Tmeteo read Fmeteo write Setmeteo;
            procedure comprovar_averia(sender:tobject);
      public
            err:terror;
            t:ttimer;
            onEspatllat: procedure (id:integer) of object; //tipus event
            onArreglat: procedure (id:integer) of object;
            onMeteo: procedure (id:integer; temps:char) of object;
            constructor crear(id:integer;codi,naviera,port:string;capacitat:integer);
            destructor destruir;
            function consultar_codi:string;
            function consultar_capacitat:integer;
            function consultar_naviera:string;
            function consultar_port_actual:string;
            function consultar_carregat:integer;
            function consultar_en_manteniment:boolean;
            function consultar_estat:integer;
            function navegar():boolean;
            function consultar_desgast:extended;
            function carregar(quantitat:integer):boolean;
            procedure posar_manteniment;
            procedure treure_manteniment;
            procedure descarregar;
            procedure atracar;
            procedure pasar_temps(estat:char; valor:integer);
            procedure incrementar_desgast (qtt:extended);
            procedure canviar_estat(estat:integer);
      end;
implementation

{ TVaixell }

procedure TVaixell.atracar;
begin
  self.estat := 1;
  self.t.Enabled := false;
end;

procedure TVaixell.canviar_estat(estat: integer);
begin
  self.estat:=estat;
end;

function TVaixell.carregar(quantitat:integer): boolean;
var
  res:boolean;
begin
    res := false;
    quantitat := quantitat + self.carregat;
   if (quantitat <= self.capacitat) then
   begin
      self.carregat := quantitat;
      res := true;
   end
   else
   begin
     //quantitat més gran a la capacitat
     self.err.codierror := -204;
   end;
   result := res;
end;

procedure TVaixell.comprovar_averia;
begin
  if self.estat = 2 then
  begin
     if random(100) <= self.desgast then
     begin
        self.estat := 3;
        onEspatllat(self.id);
     end;
  end
  else
  begin
     if random (100) <= 100 - self.desgast  then
     begin
       self.estat := 2;
       onArreglat(self.id);
     end;

  end;
end;

function TVaixell.consultar_capacitat: integer;
begin
  result := self.capacitat;
end;

function TVaixell.consultar_carregat: integer;
begin
  result := self.carregat;
end;

function TVaixell.consultar_codi: string;
begin
  result := self.codi;
end;

function TVaixell.consultar_desgast: extended;
begin
  result := self.desgast;
end;

function TVaixell.consultar_en_manteniment: boolean;
begin
   result := self.en_manteniment;
end;

function TVaixell.consultar_estat: integer;
begin
   result := self.estat;
end;

function TVaixell.consultar_naviera: string;
begin
  result := self.naviera;
end;

function TVaixell.consultar_port_actual: string;
begin
  result := self.port_actual;
end;

constructor TVaixell.crear(id:integer;codi, naviera, port: string; capacitat: integer);
begin
  self.id := id;
  self.codi := codi;
  self.naviera := naviera;
  self.port_actual:=port;
  self.capacitat := capacitat;
  self.carregat := 0;
  self.Festat := A_PORT;
  self.Fen_manteniment := false;
  self.desgast := 0;
  err := terror.Create;
  t := ttimer.Create(t);
  t.Interval := 1000;
  t.Enabled := false;
  t.OnTimer := self.comprovar_averia;

  self.meteo:=Tmeteo.crear;
  self.meteo.onMeteo := self.pasar_temps;
end;

procedure TVaixell.descarregar;
begin
  self.carregat := 0;
end;

destructor TVaixell.destruir;
begin
self.meteo.temps.Enabled:=false;
self.err.Destroy;
self.t.Destroy;
self.meteo.Destroy;

end;

procedure TVaixell.incrementar_desgast(qtt: extended);
begin
    self.desgast:=self.desgast+qtt;
end;

function TVaixell.navegar(): boolean;
var
  res:boolean;
  port:string;
  desgast:extended;
begin
   res := true;
   desgast := 10;
  if self.Fen_manteniment = false then
  begin
      if self.estat = 1 then
      begin
            port := inputbox ('Port Destí','Introdueix un Port destí','port');
            if port <> self.port_actual then
            begin
              self.port_actual := port;
              self.estat := 2;
              if self.carregat >= self.capacitat * 0.9 then
              begin
                desgast := desgast + (self.desgast * 0.1);
              end;
              self.desgast := desgast;
              self.t.Enabled := true;
              // creació del timer per saber si s'averia
            end
            else
            begin
              err.codierror := -202;
              res := false;
            end;
      end
      else
      begin
        err.codierror := -203;
        res := false;
      end;
  end
  else
  begin
    err.codierror := -201;
    res := false;
  end;
  result := res;
end;

procedure TVaixell.pasar_temps(estat: char; valor: integer);
begin
  self.onMeteo(self.id, estat);
end;

procedure TVaixell.posar_manteniment;
begin
    self.estat := 4;
    self.desgast := 0;
    self.en_manteniment := true;
end;

procedure TVaixell.Setcapacitat(const Value: integer);
begin
  Fcapacitat := Value;
end;


procedure TVaixell.Setcarregat(const Value: integer);
begin
  Fcarregat := Value;
end;

procedure TVaixell.Setcodi(const Value: string);
begin
  Fcodi := Value;
end;

procedure TVaixell.Setdesgast(const Value: extended);
begin
  Fdesgast := Value;
end;

procedure TVaixell.Seten_manteniment(const Value: boolean);
begin
  Fen_manteniment := Value;
end;

procedure TVaixell.Setestat(const Value: integer);
begin
  Festat := Value;
end;

procedure TVaixell.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TVaixell.Setmeteo(const Value: Tmeteo);
begin
  Fmeteo := Value;
end;

procedure TVaixell.Setnaviera(const Value: string);
begin
  Fnaviera := Value;
end;

procedure TVaixell.Setport_actual(const Value: string);
begin
  Fport_actual := Value;
end;

procedure TVaixell.treure_manteniment;
begin
  self.estat := 1;
  self.en_manteniment := false;
end;

end.
