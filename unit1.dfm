object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 592
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    810
    592)
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 153
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 804
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 67
      Height = 15
      Caption = 'Sz'#225'mlasz'#225'm:'
    end
    object szamszam: TLabel
      Left = 81
      Top = 16
      Width = 102
      Height = 15
      Caption = '00000000000000000'
    end
    object deviza: TLabel
      Left = 281
      Top = 16
      Width = 23
      Height = 15
      Caption = 'HUF'
    end
    object tulaj: TLabel
      Left = 8
      Top = 37
      Width = 6
      Height = 15
      Caption = '1'
    end
    object cim: TLabel
      Left = 8
      Top = 58
      Width = 30
      Height = 15
      Caption = '11111'
    end
    object egyenkezd: TLabel
      Left = 99
      Top = 90
      Width = 24
      Height = 15
      Caption = '1111'
    end
    object egyenveg: TLabel
      Left = 99
      Top = 111
      Width = 24
      Height = 15
      Caption = '1111'
    end
    object Nyitóegyenleg: TLabel
      Left = 8
      Top = 90
      Width = 77
      Height = 15
      Caption = 'Nyit'#243'egyenleg'
    end
    object Label2: TLabel
      Left = 8
      Top = 111
      Width = 72
      Height = 15
      Caption = 'Z'#225'r'#243'egyenleg'
    end
    object Label3: TLabel
      Left = 304
      Top = 90
      Width = 68
      Height = 15
      Caption = 'Nyit'#243' D'#225'tum'
    end
    object Label4: TLabel
      Left = 304
      Top = 111
      Width = 63
      Height = 15
      Caption = 'Z'#225'r'#243' D'#225'tum'
    end
    object kezddatum: TLabel
      Left = 392
      Top = 90
      Width = 48
      Height = 15
      Caption = '01012033'
    end
    object vegdatum: TLabel
      Left = 392
      Top = 111
      Width = 48
      Height = 15
      Caption = '01012023'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 153
    Width = 810
    Height = 439
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 4
    ExplicitWidth = 804
    ExplicitHeight = 430
  end
  object Button1: TButton
    Left = 362
    Top = 8
    Width = 129
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Otvorit STM'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 356
  end
  object Button2: TButton
    Left = 497
    Top = 8
    Width = 146
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Ulozit PDF'
    TabOrder = 1
    OnClick = Button2Click
    ExplicitLeft = 491
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 153
    Width = 810
    Height = 439
    Align = alClient
    ColCount = 22
    DefaultColWidth = 100
    FixedCols = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goFixedRowDefAlign]
    TabOrder = 2
    ExplicitWidth = 804
    ExplicitHeight = 430
  end
  object Button3: TButton
    Left = 649
    Top = 8
    Width = 146
    Height = 57
    Anchors = [akTop, akRight]
    Caption = 'Koniec'
    TabOrder = 5
    OnClick = Button3Click
    ExplicitLeft = 643
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    Left = 256
    Top = 296
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    DefaultExt = '*.stm'
    Filter = '*.stm'
    Left = 96
    Top = 304
  end
  object PReport1: TPReport
    FileName = 'default.pdf'
    CreationDate = 45309.959348344910000000
    UseOutlines = False
    ViewerPreference = []
    Left = 296
    Top = 208
  end
end
