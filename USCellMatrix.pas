unit USCellMatrix;

interface

uses
  Controls,
  UCellMatrix;

type
  TSCellMatrix = class(TCellMatrix)
  private
    FBombCount: integer;

    procedure CellClick(Sender: TObject);
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; override;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); override;
    procedure AssignBombs;
    procedure InitEmptyCells;
    procedure InitCells;
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols, ABombCount: integer);
    procedure AfterConstruction; override;
  end;


implementation

uses
  USCell;

{ TSCellMatrix }

procedure TSCellMatrix.AfterConstruction;
begin
  inherited;
  InitCells;
end;


procedure TSCellMatrix.AssignBombs;
var
  remains: integer;
  row, col: integer;
  cell: TSCell;
begin
  Randomize;
  remains := FBombCount;
  while remains > 0 do begin
    row := Random(RowCount);
    col := Random(ColCount);

    cell := Self.Cell[row, col] as TSCell;
    if not cell.IsBomb then begin
      cell.IsBomb := true;
      Dec(remains);
    end;
  end;
end;


procedure TSCellMatrix.CellClick(Sender: TObject);
var
  cell: TSCell;
begin
  if Sender is TSCell then begin
    cell := TSCell(Sender);

  end;
end;


constructor TSCellMatrix.Create(
  AContainer: TWinControl; ACellWidth, ARows, ACols, ABombCount: integer);
begin
  inherited Create(AContainer, ACellWidth, ARows, ACols);
  FBombCount := ABombCount;
end;


function TSCellMatrix.GetCellClass(ARow, ACol: integer): TCellClass;
begin
  Result := TSCell;
end;


procedure TSCellMatrix.InitCell(ACell: TCell; ARow, ACol: integer);
var
  cell: TSCell;
begin
  inherited;
  if ACell is TSCell then begin
    cell := TSCell(ACell);
    //cell.OnClick := CellClick;
  end;
end;


procedure TSCellMatrix.InitCells;
begin
  AssignBombs;
end;


procedure TSCellMatrix.InitEmptyCells;
begin

end;


end.
