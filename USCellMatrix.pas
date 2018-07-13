unit USCellMatrix;

interface

uses
  Controls,
  UCellMatrix, USCell, UTypes;

type
  TSCellMatrix = class(TCellMatrix)
  private
    FBombCount: integer;
    FFlagCount: integer;
    FAnyCellOpen: boolean;
    FOnSwitchFlag: TProcedure;

    procedure CellBeforeOpen(ACell: TSCell);
    procedure CellClick(ACell: TSCell);
    procedure CellFlagSwitch(ACell: TSCell);

    procedure ResetCells;
    procedure AssignBombs(ASafeCell: TSCell);
    procedure InitEmptyCells;
    procedure OpenAllCells;
    procedure InitCells(AFirstOpenCell: TSCell);
    procedure CheckWin;
    procedure CheckNearSafe(ACell: TSCell);
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; override;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); override;
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols, ABombCount: integer);
    procedure AfterConstruction; override;

    procedure Reset;

    property BombCount: integer read FBombCount;
    property FlagCount: integer read FFlagCount;
    property OnSwitchFlag: TProcedure read FOnSwitchFlag write FOnSwitchFlag;
  end;


implementation

uses
  Types, Dialogs,
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

      cell := Self.Cells[row, col] as TSCell;
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
  if ACell.HasFlag then
    Exit;

  if ACell.IsBomb then begin
    OpenAllCells;
    Container.Enabled := false;
  end
  else begin
    CheckNearSafe(ACell);

    CheckWin;
  end;
end;


procedure TSCellMatrix.CellFlagSwitch(ACell: TSCell);
begin
  if ACell.HasFlag then
    Inc(FFlagCount)
  else
    Dec(FFlagCount);

  if Assigned(FOnSwitchFlag) then
    FOnSwitchFlag;
end;


procedure TSCellMatrix.CheckNearSafe(ACell: TSCell);

  procedure tryOpenNear(ACell: TSCell; ARowDelta, AColDelta: integer);
  var
    nearRow: integer;
    nearCol: integer;
    nearCell: TSCell;
  begin
    nearRow := ACell.Row + ARowDelta;
    nearCol := ACell.Col + AColDelta;
    if ValidCell(nearRow, nearCol) then begin
      nearCell := Cells[nearRow, nearCol] as TSCell;
      if not nearCell.Opened then begin
        nearCell.Open;
        CheckNearSafe(nearCell);
      end;
    end;
  end;

begin
  if ACell.NearBombsCount = 0 then begin
    tryOpenNear(ACell, -1, -1);
    tryOpenNear(ACell, -1,  0);
    tryOpenNear(ACell, -1,  1);
    tryOpenNear(ACell,  0, -1);
    tryOpenNear(ACell,  0,  1);
    tryOpenNear(ACell,  1, -1);
    tryOpenNear(ACell,  1,  0);
    tryOpenNear(ACell,  1,  1);
  end;
end;


procedure TSCellMatrix.CheckWin;
var
  cell: TCell;
  closeCount: integer;
begin
  closeCount := 0;
  for cell in Self do begin
    if not (cell as TSCell).Opened then
      Inc(closeCount);

    if closeCount > FBombCount then
      Break;
  end;

  if closeCount = FBombCount then
    ShowMessage('Congratulations, you win!');
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
    cell.OnSwitchFlag := CellFlagSwitch;
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
    if ValidCell(nearRow, nearCol) then begin
      nearCell := Self.Cells[nearRow, nearCol] as TSCell;
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
      cell := Self.Cells[i, j] as TSCell;
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
      cell := Self.Cells[i, j] as TSCell;
      cell.Open(true);
    end;
  end;
end;


procedure TSCellMatrix.Reset;
begin
  FFlagCount := 0;
  FAnyCellOpen := false;
  ResetCells;
  if Assigned(FOnSwitchFlag) then
    FOnSwitchFlag;
  Container.Enabled := true;
end;


procedure TSCellMatrix.ResetCells;
var
  i, j: integer;
  cell: TSCell;
begin
  for i := 0 to RowCount - 1 do begin
    for j := 0 to ColCount - 1 do begin
      cell := Self.Cells[i, j] as TSCell;
      cell.Reset;
    end;
  end;
end;


end.
