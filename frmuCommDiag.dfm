object frmCommDiag: TfrmCommDiag
  Left = 217
  Top = 237
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'Communication Diagnostics'
  ClientHeight = 453
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pgcDiagnostics: TPageControl
    Left = 0
    Top = 0
    Width = 341
    Height = 416
    ActivePage = tabDBConnection
    Align = alClient
    TabOrder = 0
    object tabDBConnection: TTabSheet
      Caption = 'DB Connection'
      object lblDBResults: TLabel
        Left = 6
        Top = 240
        Width = 38
        Height = 13
        Caption = '&Results:'
        FocusControl = memDBResults
      end
      object memDBResults: TMemo
        Left = 6
        Top = 258
        Width = 324
        Height = 127
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 2
        WordWrap = False
      end
      object gbDatabaseInfo: TGroupBox
        Left = 6
        Top = 114
        Width = 324
        Height = 115
        Caption = ' Database Information'
        TabOrder = 1
        object lblDatabase: TLabel
          Left = 12
          Top = 24
          Width = 49
          Height = 13
          Caption = '&Database:'
          FocusControl = edtDatabase
        end
        object lblUsername: TLabel
          Left = 12
          Top = 54
          Width = 56
          Height = 13
          Caption = '&User Name:'
          FocusControl = edtUsername
        end
        object lblPassword: TLabel
          Left = 12
          Top = 84
          Width = 49
          Height = 13
          Caption = '&Password:'
          FocusControl = edtPassword
        end
        object btnSelDB: TButton
          Left = 271
          Top = 24
          Width = 21
          Height = 21
          Hint = 'Select database'
          Caption = '...'
          TabOrder = 1
          OnClick = btnSelDBClick
        end
        object edtUsername: TEdit
          Left = 91
          Top = 54
          Width = 199
          Height = 21
          MaxLength = 128
          TabOrder = 2
        end
        object edtPassword: TEdit
          Left = 91
          Top = 84
          Width = 199
          Height = 21
          MaxLength = 32
          PasswordChar = '*'
          TabOrder = 3
        end
        object edtDatabase: TEdit
          Left = 91
          Top = 24
          Width = 181
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = edtDatabaseChange
        end
      end
      object gbDBServerInfo: TGroupBox
        Left = 6
        Top = 6
        Width = 322
        Height = 103
        Caption = ' Server Information'
        TabOrder = 0
        object lblServerName: TLabel
          Left = 12
          Top = 48
          Width = 65
          Height = 13
          Caption = '&Server Name:'
          FocusControl = cbDBServer
        end
        object lblProtocol: TLabel
          Left = 174
          Top = 48
          Width = 85
          Height = 13
          Caption = '&Network Protocol:'
          FocusControl = cbProtocol
        end
        object cbProtocol: TComboBox
          Left = 174
          Top = 66
          Width = 103
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
          Items.Strings = (
            'TCP/IP'
            'NetBEUI'
            'SPX')
        end
        object rbLocalServer: TRadioButton
          Left = 36
          Top = 24
          Width = 107
          Height = 17
          Caption = '&Local Server'
          TabOrder = 0
          OnClick = rbLocalServerClick
        end
        object rbRemoteServer: TRadioButton
          Left = 166
          Top = 24
          Width = 116
          Height = 17
          Caption = 'R&emote Server'
          TabOrder = 1
          OnClick = rbRemoteServerClick
        end
        object cbDBServer: TComboBox
          Left = 13
          Top = 66
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          OnClick = cbDBServerClick
        end
      end
    end
    object tabTCPIP: TTabSheet
      Caption = 'TCP/IP'
      object lblWinSockResults: TLabel
        Left = 6
        Top = 90
        Width = 61
        Height = 13
        AutoSize = False
        Caption = '&Results:'
        FocusControl = memTCPIPResults
      end
      object memTCPIPResults: TMemo
        Left = 6
        Top = 108
        Width = 322
        Height = 277
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
      object gbTCPIPServerInfo: TGroupBox
        Left = 6
        Top = 6
        Width = 317
        Height = 73
        Caption = ' Server Information'
        TabOrder = 0
        object lblWinsockServer: TLabel
          Left = 12
          Top = 18
          Width = 43
          Height = 13
          AutoSize = False
          Caption = '&Host:'
          FocusControl = cbTCPIPServer
        end
        object lblService: TLabel
          Left = 220
          Top = 18
          Width = 67
          Height = 13
          AutoSize = False
          Caption = '&Service:'
          FocusControl = cbService
        end
        object cbService: TComboBox
          Left = 220
          Top = 36
          Width = 79
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            '21'
            'ftp'
            '3050'
            'gds_db'
            'ping')
        end
        object cbTCPIPServer: TComboBox
          Left = 12
          Top = 37
          Width = 175
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
      end
    end
    object tabNetBEUI: TTabSheet
      Caption = 'NetBEUI'
      object lblNetBeuiResults: TLabel
        Left = 6
        Top = 78
        Width = 55
        Height = 13
        AutoSize = False
        Caption = '&Results:'
        FocusControl = memNetBeuiResults
      end
      object memNetBeuiResults: TMemo
        Left = 6
        Top = 96
        Width = 322
        Height = 289
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
      object gbNetBEUIServerInfo: TGroupBox
        Left = 6
        Top = 6
        Width = 317
        Height = 61
        Caption = ' Server Information'
        TabOrder = 0
        object lblNetBEUIServer: TLabel
          Left = 12
          Top = 24
          Width = 65
          Height = 13
          Caption = '&Server Name:'
          FocusControl = cbNetBEUIServer
        end
        object cbNetBEUIServer: TComboBox
          Left = 121
          Top = 24
          Width = 185
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
      end
    end
    object tabSPX: TTabSheet
      Caption = 'SPX'
      object lblSPXResults: TLabel
        Left = 6
        Top = 78
        Width = 49
        Height = 13
        AutoSize = False
        Caption = '&Results:'
        FocusControl = memSPXResults
      end
      object gbNovellServerInfo: TGroupBox
        Left = 6
        Top = 6
        Width = 317
        Height = 61
        Caption = ' Server Information'
        TabOrder = 0
        object lblSPXServer: TLabel
          Left = 12
          Top = 24
          Width = 65
          Height = 13
          Caption = '&Server Name:'
          FocusControl = cbSPXServer
        end
        object cbSPXServer: TComboBox
          Left = 121
          Top = 24
          Width = 185
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
      end
      object memSPXResults: TMemo
        Left = 6
        Top = 96
        Width = 322
        Height = 289
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
    end
  end
  object pnlButtonBar: TPanel
    Left = 0
    Top = 416
    Width = 341
    Height = 37
    Align = alBottom
    TabOrder = 1
    object btnTest: TButton
      Left = 183
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Test'
      Default = True
      TabOrder = 0
      OnClick = btnTestClick
    end
    object btnCancel: TButton
      Left = 261
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
