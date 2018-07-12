object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
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
