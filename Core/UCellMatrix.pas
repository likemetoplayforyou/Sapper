unit UCellMatrix;

interface

uses
  Controls,
  UContainers;

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


  TCellMatrix = class(TMatrix<TCell>)
  private
    FContainer: TWinControl;
    FCellWidth: integer;

    procedure Log(const AMsg: string; const AArgs: array of const);
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; virtual;
    function CreateCell(ARow, ACol: integer): TCell; override;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); virtual;
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols: integer);

    function Width: integer;
    property Container: TWinControl read FContainer;
    property CellWidth: integer read FCellWidth;
  end;


implementation

{ TCellMatrix }

constructor TCellMatrix.Create(
  AContainer: TWinControl; ACellWidth, ARows, ACols: integer);
begin
  inherited Create(ARows, ACols);
  FContainer := AContainer;
  FCellWidth := ACellWidth;
end;


function TCellMatrix.CreateCell(ARow, ACol: integer): TCell;
begin
  Result := GetCellClass(ARow, ACol).Create(Self, ARow, ACol);
  InitCell(Result, ARow, ACol);
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
  Result := ColCount * FCellWidth;
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
