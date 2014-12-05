unit Vaixells;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, UtNau, Uterror;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    GroupBox2: TGroupBox;
    LabeledEdit3: TLabeledEdit;
    ProgressBar1: TProgressBar;
    LabeledEdit4: TLabeledEdit;
    ProgressBar2: TProgressBar;
    LabeledEdit5: TLabeledEdit;
    ProgressBar3: TProgressBar;
    LabeledEdit6: TLabeledEdit;
    ProgressBar4: TProgressBar;
    LabeledEdit7: TLabeledEdit;
    ProgressBar5: TProgressBar;
    GroupBox3: TGroupBox;
    ListBox1: TListBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ComboBox3: TComboBox;
    Label3: TLabel;
    Button9: TButton;
    GroupBox6: TGroupBox;
    ListBox5: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
    procedure mostrarerror(codi:integer);
    procedure inicialitzarLlistats;
    procedure vaixell_averiat(id:integer);
    procedure vaixell_arreglat(id:integer);
    procedure actualitzar_temps(pos:integer; estat:char);
    procedure vaixell_enfonsat (pos:integer);
  public
  nau:Tnau;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actualitzar_temps(pos: integer; estat: char);
begin
  self.ListBox5.items[pos]:=estat;
  if (nau.consultar_estat(pos) = 2) and (nau.consultar_desgast(pos)<100) then
  begin
    listbox2.Items[pos] :=inttostr(pos) + '-> ' + 'Codi:' + nau.consultar_codi(pos) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(pos)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(pos) + '|' + 'Port:' + nau.consultar_port(pos) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(pos)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(pos));
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pos:integer;
begin

    if ((self.LabeledEdit1.Text <> '') and (self.LabeledEdit2.Text <> '') and (self.ComboBox1.itemindex <> -1) and (self.ComboBox2.ItemIndex <> -1)) then
    begin
      pos := nau.crear_vaixell(self.LabeledEdit1.Text,self.ComboBox1.Items[self.ComboBox1.ItemIndex],self.ComboBox2.Items[self.ComboBox2.ItemIndex],strtoint(self.LabeledEdit2.Text));
      if pos >= 0 then
      begin
        listbox1.Items[pos] :=inttostr(pos) + '-> ' + 'Codi:' + nau.consultar_codi(pos) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(pos)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(pos) + '|' + 'Port:' + nau.consultar_port(pos) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(pos)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(pos));
        self.LabeledEdit3.Text := inttostr(strtoint(self.LabeledEdit3.Text) + 1);
        self.ProgressBar1.Position := self.ProgressBar1.Position + 1;
        self.LabeledEdit7.Text := inttostr(strtoint(self.LabeledEdit7.Text) + 1);
        self.ProgressBar5.Position := self.ProgressBar5.Position + 1;
      end
      else
      begin
        mostrarerror(nau.err.codierror);
      end;
    end
    else
    begin
         mostrarerror(-1);
    end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if messagedlg('segur que vols eliminar el vaixell?',mtconfirmation,[mbok,mbCancel],1) = 1 then
begin
  if nau.destruir_vaixell(listbox1.ItemIndex) then
  begin
     listbox1.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ';
     self.LabeledEdit3.Text := inttostr(strtoint(self.LabeledEdit3.Text) -1);
     self.ProgressBar1.Position := self.ProgressBar1.Position - 1;
  end
  else
  begin
    mostrarerror(nau.err.codierror);
  end;
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if listbox1.ItemIndex <> -1 then
 begin
  if nau.navegar_vaixell(listbox1.ItemIndex) then
  begin
    listbox1.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ';
    listbox2.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox1.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox1.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox1.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox1.ItemIndex) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox1.ItemIndex)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(listbox1.ItemIndex));
    self.LabeledEdit5.Text := inttostr(strtoint(self.LabeledEdit5.text)+1);
    self.ProgressBar3.Position := self.ProgressBar3.Position + 1;
  end
  else
  begin
    mostrarerror(nau.err.codierror);
  end;
 end
 else
 begin
   mostrarerror(-3);
 end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if nau.atracar_vaixell(listbox2.ItemIndex) then
  begin
    listbox2.Items[listbox1.ItemIndex] := inttostr(listbox2.ItemIndex) + '-> ';
    listbox1.Items[listbox2.ItemIndex] := inttostr(listbox2.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox2.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox2.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox2.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox2.ItemIndex) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox2.ItemIndex)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(listbox2.ItemIndex));
    listbox5.Items[listbox2.ItemIndex] :='';
    self.LabeledEdit5.Text := inttostr(strtoint(self.LabeledEdit5.text)-1);
    self.ProgressBar3.Position := self.ProgressBar3.Position - 1;
  end
  else
  begin
    mostrarerror(nau.err.codierror);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  carrega:integer;
begin
  carrega := strtoint(inputbox('carregar','introdueix la carrega desitjada','0'));
 if listbox1.ItemIndex<>-1 then
 begin
  if carrega >= 0 then
  begin
    if nau.carregar_vaixell(listbox1.ItemIndex,carrega) then
    begin
      listbox1.Items[listbox1.ItemIndex] :=inttostr(listbox1.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox1.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox1.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox1.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox1.ItemIndex) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox1.ItemIndex)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(listbox1.ItemIndex));
      if nau.consultar_carrega(listbox1.ItemIndex) >= nau.consultar_capacitat(listbox1.ItemIndex) * 0.9 then
      begin
        self.LabeledEdit6.Text := inttostr(strtoint(self.LabeledEdit6.Text) + 1);
        self.ProgressBar4.Position := self.ProgressBar4.Position + 1;
        self.LabeledEdit7.Text := inttostr(strtoint(self.LabeledEdit7.Text) - 1);
        self.ProgressBar5.Position := self.ProgressBar5.Position - 1;
      end;
    end
    else
    begin
      mostrarerror(nau.err.codierror);
    end;
  end
  else
  begin
    mostrarerror(-2);
  end;
 end
 else
 begin
   mostrarerror(-3);
 end;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if nau.descarregar_vaixell(self.ListBox1.ItemIndex) then
  begin
     listbox1.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox1.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox1.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox1.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox1.ItemIndex) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox1.ItemIndex)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(listbox1.ItemIndex));
     self.LabeledEdit6.Text := inttostr(strtoint(self.LabeledEdit6.Text) - 1);
     self.ProgressBar4.Position := self.ProgressBar4.Position - 1;
     self.LabeledEdit7.Text := inttostr(strtoint(self.LabeledEdit7.Text) + 1);
     self.ProgressBar5.Position := self.ProgressBar5.Position + 1;
  end
  else
  begin
    mostrarerror(nau.err.codierror);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  if nau.Posar_Manteniment(listbox1.ItemIndex) then
  begin
    listbox1.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox1.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox1.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox1.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox1.ItemIndex) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox1.ItemIndex)) + '|' + ' -> MANTENIMENT';
    self.LabeledEdit4.Text := inttostr(strtoint(self.LabeledEdit4.text)+1);
    self.ProgressBar2.Position := self.ProgressBar2.Position - 1;
  end
  else
  begin
    mostrarerror(nau.err.codierror);
  end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
    if nau.Fi_manteniment(listbox1.ItemIndex) then
    begin
      listbox1.Items[listbox1.ItemIndex] := inttostr(listbox1.ItemIndex) + '-> ' + 'Codi:' + nau.consultar_codi(listbox1.ItemIndex) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(listbox1.ItemIndex)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(listbox1.ItemIndex) + '|' + 'Port:' + nau.consultar_port(listbox1.ItemIndex)+ '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(listbox1.ItemIndex)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(listbox1.ItemIndex));
      self.LabeledEdit4.Text := inttostr(strtoint(self.LabeledEdit4.text)-1);
      self.ProgressBar2.Position := self.ProgressBar2.Position - 1;
    end
    else
    begin
      mostrarerror(nau.err.codierror);
    end;
  end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  try
    listbox3.Clear;
    nau.buscar_naviera(combobox3.Items[combobox3.ItemIndex], listbox3.Items);
  except

  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  nau.destruir_nau;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
nau := tnau.crear_nau;
nau.onEspatllat := self.vaixell_averiat;
nau.onArreglat := self.vaixell_arreglat;
nau.onEnfonsat := self.vaixell_enfonsat;
inicialitzarLlistats;
combobox1.Items.LoadFromFile('dadesnavieres.txt');
combobox3.Items.LoadFromFile('dadesnavieres.txt');
combobox2.Items.LoadFromFile('dadesports.txt');
nau.onMeteo:= actualitzar_temps;
end;

procedure TForm1.inicialitzarLlistats;
var
  i:integer;
begin
    for I := 0 to UtNau.NUM_VAIXELLS-1 do
    begin
      listbox1.Items.Add(inttostr(i) + '-> ');
      listbox2.Items.Add(inttostr(i) + '-> ');
      listbox5.Items.Add('');
    end;

end;

procedure TForm1.mostrarerror(codi: integer);
var
  err:Terror;
begin
   err := terror.Create;
   err.codiError := codi;
   err.mostrarError;
   err.Destroy;
end;

procedure TForm1.vaixell_arreglat(id: integer);
begin
   listbox2.Items[id] := inttostr(id) + '-> ' + 'Codi:' + nau.consultar_codi(id) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(id)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(id) + '|' + 'Port:' + nau.consultar_port(id)+ '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(id)) + '|' + 'Desgast:' + floattostr(nau.consultar_desgast(id));
end;

procedure TForm1.vaixell_averiat(id: integer);
begin
  listbox2.Items[id] := inttostr(id) + '-> ' + 'Codi:' + nau.consultar_codi(id) + '|' + 'Capacitat:' + inttostr(nau.consultar_capacitat(id)) + '|' + 'Naviera:' + '|' + nau.consultar_naviera(id) + '|' + 'Port:' + nau.consultar_port(id) + '|' + 'Càrrega:' + inttostr(nau.consultar_carrega(id)) + '|' + ' -> AVERIAT';
end;

procedure TForm1.vaixell_enfonsat(pos: integer);
begin
    listbox2.Items[pos] :=inttostr(pos) + '-> ';
    listbox1.Items[pos] :=inttostr(pos) + '-> --ENFONSAT--';
    listbox5.Items[pos] :='';
end;

end.
