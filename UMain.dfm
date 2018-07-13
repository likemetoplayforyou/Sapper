object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Sapper'
  ClientHeight = 271
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnStats: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnRestart: TButton
      Left = 86
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Restart'
      TabOrder = 0
      OnClick = btnRestartClick
    end
    object pnBombRemains: TPanel
      Left = 200
      Top = 1
      Width = 49
      Height = 39
      Align = alRight
      TabOrder = 1
      object lblBombRemains: TLabel
        Left = 13
        Top = 7
        Width = 22
        Height = 23
        Caption = '10'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
  end
  object pnMap: TPanel
    Left = 0
    Top = 41
    Width = 250
    Height = 230
    Align = alClient
    TabOrder = 1
  end
end
