unit USCellMatrix;

interface

uses
  Controls,
  UCellMatrix, USCell;

type
  TSCellMatrix = class(TCellMatrix)
  private
    FBombCount: integer;
    FAnyCellOpen: boolean;

    procedure CellBeforeOpen(ACell: TSCell);
    procedure CellClick(ACell: TSCell);
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; override;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); override;

    procedure ResetCells;
    procedure AssignBombs(ASafeCell: TSCell);
    procedure InitEmptyCells;
    procedure OpenAllCells;
    procedure InitCells(AFirstOpenCell: TSCell);
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols, ABombCount: integer);
    procedure AfterConstruction; override;

    procedure Reset;
  end;


implementation

uses
  Types,
  UUniqueRandomizer;

{ TSCellMatrix }

procedure TSCellMatrix.AfterConstruction;
begin
  inherited;
end;


procedure TSCellMatrix.AssignBombs(ASafeCell: TSCell);
var
  randomizer: TUniqueRandomizer;
  remains: integer;
  coord: TIntegerDynArray;
  row, col: integer;
  cell: TSCell;
begin
  randomizer := TUniqueRandomizer.Create([RowCount, ColCount]);
  try
    remains := FBombCount;
    while remains > 0 do begin
      coord := randomizer.Generate;
      row := coord[0];
      col := coord[1];

      cell := Self.Cell[row, col] as TSCell;
      if (cell <> ASafeCell) and not cell.IsBomb then begin
        cell.IsBomb := true;
        Dec(remains);
      end;
    end;
  finally
    randomizer.Free;
  end;
end;


procedure TSCellMatrix.CellBeforeOpen(ACell: TSCell);
begin
  if not FAnyCellOpen then begin
    InitCells(ACell);
    FAnyCellOpen := true;
  end;
end;


procedure TSCellMatrix.CellClick(ACell: TSCell);
begin
  if ACell.IsBomb then
    OpenAllCells;
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
    cell.OnClick := CellClick;
    cell.OnBeforeOpen := CellBeforeOpen;
  end;
end;


procedure TSCellMatrix.InitCells(AFirstOpenCell: TSCell);
begin
  AssignBombs(AFirstOpenCell);
  InitEmptyCells;
end;


procedure TSCellMatrix.InitEmptyCells;

  procedure tryIncNearBombCount(ACell: TSCell; ARowDelta, AColDelta: integer);
  var
    nearRow: integer;
    nearCol: integer;
    nearCell: TSCell;
  begin
    nearRow := ACell.Row + ARowDelta;
    nearCol := ACell.Col + AColDelta;
    if
      (0 <= nearRow) and (nearRow < RowCount) and
      (0 <= nearCol) and (nearCol < ColCount)
    then begin
      nearCell := Self.Cell[nearRow, nearCol] as TSCell;
      if nearCell.IsBomb then
        ACell.NearBombsCount := ACell.NearBombsCount + 1;
    end;
  end;

var
  i, j: integer;
  cell: TSCell;
begin
  for i := 0 to RowCount - 1 do begin
    for j := 0 to ColCount - 1 do begin
      cell := Self.Cell[i, j] as TSCell;
      if not cell.IsBomb then begin
        tryIncNearBombCount(cell, -1, -1);
        tryIncNearBombCount(cell, -1,  0);
        tryIncNearBombCount(cell, -1,  1);
        tryIncNearBombCount(cell,  0, -1);
        tryIncNearBombCount(cell,  0,  1);
        tryIncNearBombCount(cell,  1, -1);
        tryIncNearBombCount(cell,  1,  0);
        tryIncNearBombCount(cell,  1,  1);
      end;
    end;
  end;
end;


procedure TSCellMatrix.OpenAllCells;
var
  i, j: integer;
  cell: TSCell;
begin
  for i := 0 to RowCount - 1 do begin
    for j := 0 to ColCount - 1 do begin
      cell := Self.Cell[i, j] as TSCell;
      cell.Open(true);
    end;
  end;
end;


procedure TSCellMatrix.Reset;
begin
  FAnyCellOpen := false;
  ResetCells;
end;


procedure TSCellMatrix.ResetCells;
var
  i, j: integer;
  cell: TSCell;
begin
  for i := 0 to RowCount - 1 do begin
    for j := 0 to ColCount - 1 do begin
      cell := Self.Cell[i, j] as TSCell;
      cell.Reset;
    end;
  end;
end;


end.
