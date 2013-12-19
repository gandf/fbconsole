object frmDBConnections: TfrmDBConnections
  Left = 252
  Top = 127
  HelpContext = 1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Database Connections'
  ClientHeight = 378
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnHelp = FormHelp
  PixelsPerInch = 96
  TextHeight = 13
  object lvConnections: TListView
    Left = 15
    Top = 22
    Width = 333
    Height = 312
    Columns = <
      item
        Caption = 'User Name'
        Width = 326
      end>
    ColumnClick = False
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnOK: TButton
    Left = 270
    Top = 345
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
end
