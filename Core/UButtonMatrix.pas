unit UButtonMatrix;

interface

uses
  Controls,
  UCellMatrix;


type
  TButtonMatrix = class(TCellMatrix)
  protected
    function GetCellClass(ARow, ACol: integer): TCellClass; override;
  end;


implementation

uses
  Buttons;

{ TButtonMatrix }

function TButtonMatrix.GetCellClass(ARow, ACol: integer): TCellClass;
begin
  Result := TCell;//TBitBtn;
end;


end.
