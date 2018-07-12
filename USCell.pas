unit USCell;

interface

uses
  Buttons, ExtCtrls,
  UCellMatrix;

type
  TSCell = class(TCell)
  private
    FIsBomb: boolean;
    FOpened: boolean;

    FPanel: TPanel;
    FButton: TBitBtn;
    FImage: TPaintBox;
  public
    constructor Create(AMatrix: TCellMatrix; ARow, ACol: integer); override;

    procedure Open;

    property IsBomb: boolean read FIsBomb write FIsBomb;
    property Opened: boolean read FOpened;
  end;


implementation

uses
  Controls;

{ TSCell }

constructor TSCell.Create(AMatrix: TCellMatrix; ARow, ACol: integer);
begin
  inherited;
  FPanel := TPanel.Create(AMatrix.Container);
  FPanel.BevelOuter := bvNone;
  FPanel.Parent := AMatrix.Container;
  FPanel.Width := AMatrix.CellWidth;
  FPanel.Height := AMatrix.CellWidth;
  FPanel.Left := ACol * AMatrix.CellWidth;
  FPanel.Top := ARow * AMatrix.CellWidth;

  FButton := TBitBtn.Create(AMatrix.Container);
  FButton.Parent := FPanel;
  FButton.Align := alClient;
  FButton.Visible := true;

  FImage := TPaintBox.Create(AMatrix.Container);
  FImage.Parent := FPanel;
  FImage.Align := alClient;
  FImage.Visible := false;
end;


procedure TSCell.Open;
begin
  FButton.Visible := false;
  FImage.Visible := true;
  FOpened := true;
end;


end.
