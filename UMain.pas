unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  USCellMatrix;

type
  TfrmMain = class(TForm)
    pnStats: TPanel;
    pnMap: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCellMatrix: TSCellMatrix;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}



procedure TfrmMain.FormCreate(Sender: TObject);
const
  CELL_WIDTH = 20;
  MAP_ROW_COUNT = 10;
  MAP_COL_COUNT = 10;
  BOMB_COUNT = 30;
begin
  inherited;
  FCellMatrix :=
    TSCellMatrix.Create(
      pnMap, CELL_WIDTH, MAP_ROW_COUNT, MAP_COL_COUNT, BOMB_COUNT);

  ClientHeight := pnStats.Height + MAP_ROW_COUNT * CELL_WIDTH;
  ClientWidth := MAP_ROW_COUNT * CELL_WIDTH;
end;


procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FCellMatrix.Free;
  inherited;
end;

end.
