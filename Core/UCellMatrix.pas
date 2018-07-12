unit UCellMatrix;

interface

uses
  Controls;

type
  TCellMatrix = class;


  TCell = class(TObject)
  private
    FMatrix: TCellMatrix;
    FRow: integer;
    FCol: integer;
  public
    constructor Create(AMatrix: TCellMatrix; ARow, ACol: integer); virtual;

    property Row: integer read FRow;
    property Col: integer read FCol;
    property Matrix: TCellMatrix read FMatrix;
  end;


  TCellClass = class of TCell;


  TCellMatrix = class(TObject)
  private
    FCells: array of array of TCell;
    FContainer: TWinControl;
    FCellWidth: integer;
    FRowCount: integer;
    FColCount: integer;

    function CreateCell(ARow, ACol: integer): TCell;
    function GetCell(ARow, ACol: integer): TCell;

    procedure Log(const AMsg: string; const AArgs: array of const);
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; virtual;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); virtual;
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols: integer);
    procedure AfterConstruction; override;

    function Width: integer;
    property Container: TWinControl read FContainer;
    property CellWidth: integer read FCellWidth;
    property RowCount: integer read FRowCount;
    property ColCount: integer read FColCount;
    property Cell[ARow, ACol: integer]: TCell read GetCell;
  end;


implementation

{ TCellMatrix }

procedure TCellMatrix.AfterConstruction;
var
  i, j: integer;
  cell: TCell;
begin
  inherited;
  for i := 0 to FRowCount - 1 do begin
    for j := 0 to FColCount - 1 do begin
      cell := CreateCell(i, j);
      FCells[i, j] := cell;
      if cell <> nil then
        InitCell(cell, i, j);
    end;
  end;
end;


constructor TCellMatrix.Create(
  AContainer: TWinControl; ACellWidth, ARows, ACols: integer);
var
  i: integer;
begin
  inherited Create;
  FContainer := AContainer;
  FCellWidth := ACellWidth;
  FColCount := ACols;
  FRowCount := ARows;

  SetLength(FCells, FRowCount);
  for i := 0 to FRowCount - 1 do
    SetLength(FCells[i], FColCount);
end;


function TCellMatrix.CreateCell(ARow, ACol: integer): TCell;
begin
  Result := GetCellClass(ARow, ACol).Create(Self, ARow, ACol);
//  if cellClass = nil then
//    Exit;
//
//  Result := cellClass.Create(FContainer);
//  try
//    InitCell(Result, ARow, ACol);
//  except
//    Result.Free;
//    raise;
//  end;
end;


function TCellMatrix.GetCell(ARow, ACol: integer): TCell;
begin
  Result := FCells[ARow, ACol];
end;


function TCellMatrix.GetCellClass(ARow, ACol: integer): TCellClass;
begin
  Result := TCell;
end;


procedure TCellMatrix.InitCell(ACell: TCell; ARow, ACol: integer);
begin
//  ACell.Parent := FContainer;
//  ACell.Width := FCellWidth;
//  ACell.Height := FCellWidth;
//  ACell.Left := ACol * FCellWidth;
//  ACell.Top := ARow * FCellWidth;
end;


procedure TCellMatrix.Log(const AMsg: string; const AArgs: array of const);
begin

end;


function TCellMatrix.Width: integer;
begin
  Result := FColCount * FCellWidth;
end;


{ TCell }

constructor TCell.Create(AMatrix: TCellMatrix; ARow, ACol: integer);
begin
  inherited Create;
  FMatrix := AMatrix;
  FRow := ARow;
  FCol := ACol;
end;


end.
