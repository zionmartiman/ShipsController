object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 533
  ClientWidth = 1165
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 273
    Height = 281
    Caption = 'GESTI'#211' DE VAIXELLS'
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 97
      Width = 44
      Height = 13
      Caption = 'Naviera: '
    end
    object Label2: TLabel
      Left = 40
      Top = 124
      Width = 24
      Height = 13
      Caption = 'Port:'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 72
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'Codi:'
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 72
      Top = 67
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Capacitat: '
      LabelPosition = lpLeft
      NumbersOnly = True
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 94
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'Seleccionar Naviera'
    end
    object ComboBox2: TComboBox
      Left = 72
      Top = 121
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'Seleccionar Port'
    end
    object Button1: TButton
      Left = 16
      Top = 148
      Width = 105
      Height = 25
      Caption = 'CREAR'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 144
      Top = 148
      Width = 105
      Height = 25
      Caption = 'DESTRUIR'
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 179
      Width = 105
      Height = 25
      Caption = 'ZARPAR'
      TabOrder = 6
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 144
      Top = 179
      Width = 105
      Height = 25
      Caption = 'ATRACAR'
      TabOrder = 7
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 16
      Top = 210
      Width = 105
      Height = 25
      Caption = 'CARREGAR'
      TabOrder = 8
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 144
      Top = 210
      Width = 105
      Height = 25
      Caption = 'DESCARREGAR'
      TabOrder = 9
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 16
      Top = 241
      Width = 105
      Height = 25
      Caption = 'MANTENIMENT'
      TabOrder = 10
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 144
      Top = 241
      Width = 105
      Height = 25
      Caption = 'FI MANTENIMENT'
      TabOrder = 11
      OnClick = Button8Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 291
    Width = 433
    Height = 233
    Caption = 'A PORT'
    TabOrder = 1
    object ListBox1: TListBox
      Left = 3
      Top = 16
      Width = 421
      Height = 217
      Color = clGradientInactiveCaption
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 447
    Top = 291
    Width = 506
    Height = 233
    Caption = 'NAVEGANT'
    TabOrder = 2
    object ListBox2: TListBox
      Left = 3
      Top = 16
      Width = 494
      Height = 217
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 287
    Top = 0
    Width = 170
    Height = 281
    Caption = 'DADES ACTUALS'
    TabOrder = 3
    object LabeledEdit3: TLabeledEdit
      Left = 113
      Top = 32
      Width = 24
      Height = 21
      EditLabel.Width = 84
      EditLabel.Height = 13
      EditLabel.Caption = 'TOTAL VAIXELLS:'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object LabeledEdit4: TLabeledEdit
      Left = 113
      Top = 76
      Width = 24
      Height = 21
      EditLabel.Width = 92
      EditLabel.Height = 13
      EditLabel.Caption = 'EN MANTENIMENT:'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object LabeledEdit5: TLabeledEdit
      Left = 113
      Top = 122
      Width = 24
      Height = 21
      EditLabel.Width = 57
      EditLabel.Height = 13
      EditLabel.Caption = 'NAVEGANT:'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object LabeledEdit6: TLabeledEdit
      Left = 113
      Top = 163
      Width = 24
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'CARREGATS:'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
    object LabeledEdit7: TLabeledEdit
      Left = 113
      Top = 204
      Width = 24
      Height = 21
      EditLabel.Width = 83
      EditLabel.Height = 13
      EditLabel.Caption = 'DESCARREGATS:'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 4
      Text = '0'
    end
    object ProgressBar1: TProgressBar
      Left = 17
      Top = 59
      Width = 128
      Height = 8
      Max = 50
      TabOrder = 5
    end
    object ProgressBar2: TProgressBar
      Left = 17
      Top = 103
      Width = 128
      Height = 8
      Max = 50
      TabOrder = 6
    end
    object ProgressBar3: TProgressBar
      Left = 17
      Top = 149
      Width = 128
      Height = 8
      Max = 50
      TabOrder = 7
    end
    object ProgressBar4: TProgressBar
      Left = 17
      Top = 190
      Width = 128
      Height = 8
      Max = 50
      TabOrder = 8
    end
    object ProgressBar5: TProgressBar
      Left = 17
      Top = 231
      Width = 128
      Height = 8
      Max = 50
      TabOrder = 9
    end
  end
  object GroupBox5: TGroupBox
    Left = 459
    Top = 4
    Width = 542
    Height = 277
    Caption = 'NAVEGANT'
    TabOrder = 4
    object Label3: TLabel
      Left = 10
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Naviera:'
    end
    object ListBox3: TListBox
      Left = 103
      Top = 18
      Width = 426
      Height = 248
      Color = clInfoBk
      ItemHeight = 13
      TabOrder = 0
    end
    object ComboBox3: TComboBox
      Left = 3
      Top = 67
      Width = 94
      Height = 21
      TabOrder = 1
      Text = 'Escull una opci'#243
    end
    object Button9: TButton
      Left = 16
      Top = 103
      Width = 75
      Height = 23
      Caption = 'Consultar'
      TabOrder = 2
      OnClick = Button9Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 959
    Top = 291
    Width = 198
    Height = 234
    Caption = 'GPS'
    TabOrder = 5
    object ListBox5: TListBox
      Left = 3
      Top = 16
      Width = 192
      Height = 215
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Webdings'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
    end
  end
end
