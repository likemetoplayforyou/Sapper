program Sapper;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UCellMatrix in 'Core\UCellMatrix.pas',
  UUtils in 'Core\UUtils.pas',
  UButtonMatrix in 'Core\UButtonMatrix.pas',
  FlipReverseRotateLibrary in 'Libs\FlipReverseRotateLibrary.pas',
  USCell in 'USCell.pas',
  USCellMatrix in 'USCellMatrix.pas',
  USCellType in 'USCellType.pas',
  USEnvironment in 'USEnvironment.pas',
  USVDM in 'USVDM.pas' {SVDM},
  UUniqueRandomizer in 'Core\UUniqueRandomizer.pas',
  UContainers in 'Core\UContainers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TSVDM, SVDM);
  Application.Run;
end.
