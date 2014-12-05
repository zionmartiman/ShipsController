unit UtGPS;

interface

uses Uterror, Vcl.extctrls, System.SysUtils;

type
  TGPS = class
  private
    Fdistancia: integer;
    Fposicio: integer;
    Ftemps: Ttimer;
    procedure Setdistancia(const Value: integer);
    procedure Setposicio(const Value: integer);
    procedure Settemps(const Value: Ttimer);
    property posicio:integer read Fposicio write Setposicio;
    property distancia:integer read Fdistancia write Setdistancia;
    property temps:Ttimer read Ftemps write Settemps;
    function calculaDistancia(origen, desti: string): integer;
  public
    constructor crear;
    destructor destruir;
    procedure iniciar;
    procedure parar;
end;

implementation

{ TGPS }

function TGPS.calculaDistancia(origen, desti: string): integer;
var
  total:string;
  i,suma:integer;
begin
  suma := 0;
  total := origen + desti;
  for I := 0 to length(total) -1 do
  begin
    suma := suma + ord(total[i]);
  end;
  result := 10 + (suma MOD 20);
end;

constructor TGPS.crear;
begin
  self.temps:=Ttimer.create(temps);
  self.temps.Interval:=1000;
  self.temps.Enabled:=True;
end;

destructor TGPS.destruir;
begin

end;

procedure TGPS.iniciar;
begin

end;

procedure TGPS.parar;
begin

end;

procedure TGPS.Setdistancia(const Value: integer);
begin
  Fdistancia := Value;
end;

procedure TGPS.Setposicio(const Value: integer);
begin
  Fposicio := Value;
end;

procedure TGPS.Settemps(const Value: Ttimer);
begin
  Ftemps := Value;
end;

end.
