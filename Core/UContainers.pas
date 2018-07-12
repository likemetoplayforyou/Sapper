unit UContainers;

interface

uses
  Generics.Collections;

type
  TMatrix<T> = class(TEnumerable<T>)
  private
    type
      TEnumerator = class(TEnumerator<T>)
      private
        FMatrix: TMatrix<T>;
        FRow: integer;
        FCol: integer;
      protected
        function DoGetCurrent: T; override;
        function DoMoveNext: boolean; override;
      public
        constructor Create(AMatrix: TMatrix<T>);
      end;
  private
    FCells: array of array of T;
    FRowCount: integer;
    FColCount: integer;

    function GetCell(ARow, ACol: integer): T;
  protected
    function DoGetEnumerator: TEnumerator<T>; override;
  public
    constructor Create(ARows, ACols: integer);

    property RowCount: integer read FRowCount;
    property ColCount: integer read FColCount;
    property Cells[ARow, ACol: integer]: T read GetCell; default;
  end;


implementation

{ TMatrix<T> }

constructor TMatrix<T>.Create(ARows, ACols: integer);
var
  i: integer;
begin
  inherited Create;
  FColCount := ACols;
  FRowCount := ARows;

  SetLength(FCells, FRowCount);
  for i := 0 to FRowCount - 1 do
    SetLength(FCells[i], FColCount);
end;


function TMatrix<T>.DoGetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator.Create(Self);
end;


function TMatrix<T>.GetCell(ARow, ACol: integer): T;
begin
  Result := FCells[ARow, ACol];
end;


{ TMatrix<T>.TEnumerator }

constructor TMatrix<T>.TEnumerator.Create(AMatrix: TMatrix<T>);
begin
  inherited Create;
  FMatrix := AMatrix;
  FRow := -1;
  FCol := -1;
end;


function TMatrix<T>.TEnumerator.DoGetCurrent: T;
begin
  Result := FMatrix[FRow, FCol];
end;


function TMatrix<T>.TEnumerator.DoMoveNext: boolean;
begin
  if (FRow >= FMatrix.RowCount) and (FCol >= FMatrix.ColCount) then
    Exit(false);
  Inc(FCol);
  if FCol >= FMatrix.ColCount then begin
    Inc(FRow);
    FCol := 0;
  end;

  Result := (FRow < FMatrix.RowCount) and (FCol < FMatrix.ColCount);
end;


end.
