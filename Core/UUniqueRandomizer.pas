unit UUniqueRandomizer;

interface

uses
  Types, Generics.Collections;

type
  TUniqueRandomizer = class(TObject)
  private
    FRanges: array of integer;
    FValues: TList<integer>;

    function CalcRandom: integer;
  public
    constructor Create(ARanges: array of integer);
    destructor Destroy; override;

    function Generate: TIntegerDynArray;
  end;


implementation

{ TUniqueRandomizer }

function TUniqueRandomizer.CalcRandom: integer;
var
  idx: integer;
begin
  idx := Random(FValues.Count);
  Result := FValues[idx];
  FValues.Delete(idx);
end;


constructor TUniqueRandomizer.Create(ARanges: array of integer);
var
  i: integer;
  len: integer;
begin
  inherited Create;
  FValues := TList<integer>.Create;

  len := 1;
  SetLength(FRanges, Length(ARanges));
  for i := 0 to High(ARanges) do begin
    FRanges[i] := ARanges[i];
    len := len * FRanges[i];
  end;

  for i := 0 to len - 1 do
    FValues.Add(i);

  Randomize;
end;


destructor TUniqueRandomizer.Destroy;
begin
  FValues.Free;
  inherited;
end;


function TUniqueRandomizer.Generate: TIntegerDynArray;
var
  num: integer;
  i: integer;
begin
  num := CalcRandom;

  SetLength(Result, Length(FRanges));
  for i := High(FRanges) downto 0 do begin
    Result[i] := num mod FRanges[i];
    num := num div FRanges[i];
  end;
end;


end.
