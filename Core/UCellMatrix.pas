unit UCellMatrix;

interface

uses
  Controls,
  UContainers;

type
  //TCellMatrix<T> = class;


  TCell = class(TObject)
  private
    //FMatrix: TCellMatrix<TCell>;
    FRow: integer;
    FCol: integer;
  public
    constructor Create(
      {AMatrix: TCellMatrix<TCell>; }ARow, ACol: integer); virtual;

    property Row: integer read FRow;
    property Col: integer read FCol;
    //property Matrix: TCellMatrix<TCell> read FMatrix;
  end;


  TCellClass = class of TCell;


  TCellMatrix<T: TCell, constructor> = class(TMatrix<T>)
  private
    FContainer: TWinControl;
    FCellWidth: integer;

    procedure Log(const AMsg: string; const AArgs: array of const);
  protected
    function CreateCell(ARow, ACol: integer): T; override;
    procedure InitCell(ACell: TCell; ARow, ACol: integer); virtual;
  public
    constructor Create(
      AContainer: TWinControl; ACellWidth, ARows, ACols: integer);

    function Width: integer;
    property Container: TWinControl read FContainer;
    property CellWidth: integer read FCellWidth;
  end;


implementation

{ TCellMatrix<T> }

constructor TCellMatrix<T>.Create(
  AContainer: TWinControl; ACellWidth, ARows, ACols: integer);
begin
  inherited Create(ARows, ACols);
  FContainer := AContainer;
  FCellWidth := ACellWidth;
end;


function TCellMatrix<T>.CreateCell(ARow, ACol: integer): T;
begin
  Result := T.Create({Self, }ARow, ACol);
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


procedure TCellMatrix<T>.InitCell(ACell: TCell; ARow, ACol: integer);
begin
//  ACell.Parent := FContainer;
//  ACell.Width := FCellWidth;
//  ACell.Height := FCellWidth;
//  ACell.Left := ACol * FCellWidth;
//  ACell.Top := ARow * FCellWidth;
end;


procedure TCellMatrix<T>.Log(const AMsg: string; const AArgs: array of const);
begin

end;


function TCellMatrix<T>.Width: integer;
begin
  Result := ColCount * FCellWidth;
end;


{ TCell }

constructor TCell.Create(AMatrix: TCellMatrix<TCell>; ARow, ACol: integer);
begin
  inherited Create;
  FMatrix := AMatrix;
  FRow := ARow;
  FCol := ACol;
end;


end.
