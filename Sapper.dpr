program Sapper;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UCellMatrix in 'Core\UCellMatrix.pas',
  UUtils in 'Core\UUtils.pas',
  UButtonMatrix in 'Core\UButtonMatrix.pas',
  FlipReverseRotateLibrary in 'Libs\FlipReverseRotateLibrary.pas',
  USCell in 'USCell.pas',
  USCellMatrix in 'USCellMatrix.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
