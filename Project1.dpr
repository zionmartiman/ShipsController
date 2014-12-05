program Project1;

uses
  Vcl.Forms,
  Vaixells in 'Vaixells.pas' {Form1},
  Uterror in 'Uterror.pas',
  Utmeteo in 'Utmeteo.pas',
  UtNau in 'UtNau.pas',
  UtVaixell in 'UtVaixell.pas',
  UtGPS in 'UtGPS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
