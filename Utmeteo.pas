unit Utmeteo;

interface

uses Uterror, Vcl.extctrls, System.SysUtils;

type
  TMeteo = class
  private
    Ftemps: Ttimer;
    Fvalor: integer;
    Festat: char;
    procedure Setestat(const Value: char);
    procedure Settemps(const Value: Ttimer);
    procedure Setvalor(const Value: integer);
    procedure comprovar_meteo(Sender:Tobject);
  public
    onMeteo: procedure (estat:char; valor:integer) of object;
    constructor crear;
    property estat:char read Festat write Setestat;
    property valor: integer read Fvalor write Setvalor;
    property temps: Ttimer read Ftemps write Settemps;
    procedure quin_estat(primera_vegada:integer);
end;

implementation

{ TMeteo }

procedure TMeteo.comprovar_meteo(Sender: Tobject);
begin
    self.quin_estat(0);
end;

constructor TMeteo.crear;
begin
  quin_estat(1); //0 si no es la primera vegada i 1 si ho es.
  self.valor:=random(20);
  self.temps:=Ttimer.create(temps);
  self.temps.Interval:=1000;
  self.temps.Enabled:=True;
  self.temps.OnTimer:=self.comprovar_meteo;
end;

procedure TMeteo.quin_estat(primera_vegada: integer);
begin
  if primera_vegada = 1 then
  begin
     self.valor:=random(20);
  end
  else
  begin
    self.valor:=self.valor + random(5)-2;
    if self.valor < 0 then
    begin
      self.valor:=0;
    end
    else
    if self.valor > 20 then
    begin
      self.valor:=20;
    end;
  end;
  case self.valor of
  0..5:
    begin
        if primera_vegada = 1 then
        begin
            self.estat:=chr(213);
        end
        else
        begin
          self.estat:=chr(213);
          self.onMeteo(self.estat, self.valor);
        end;
    end;
  6..10:
    begin
        if primera_vegada = 1 then
        begin
            self.estat:=chr(217);
        end
        else
        begin
          self.estat:=chr(217);
          self.onMeteo(self.estat, self.valor);
        end;
    end;
  11..15:
    begin
        if primera_vegada = 1 then
        begin
            self.estat:=chr(218);
        end
        else
        begin
          self.estat:=chr(218);
          self.onMeteo(self.estat, self.valor);
        end;
    end;
  16..20:
    begin
        if primera_vegada = 1 then
        begin
            self.estat:=chr(221);
        end
        else
        begin
          self.estat:=chr(221);
          self.onMeteo(self.estat, self.valor);
        end;
    end;
  end;
end;

procedure TMeteo.Setestat(const Value: char);
begin
  Festat := Value;
end;

procedure TMeteo.Settemps(const Value: Ttimer);
begin
  Ftemps := Value;
end;

procedure TMeteo.Setvalor(const Value: integer);
begin
  Fvalor := Value;
end;

end.
