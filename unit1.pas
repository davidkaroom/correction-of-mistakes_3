unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, my_module, Grids;

type

  { TKubik }

  TKubik = class(TForm)
    reb: TEdit;
    Button: TButton;
    Image: TImage;
    Result: TMemo;
    Podskazka2: TLabel;
    Podskazka: TLabel;
    MainMenu1: TMainMenu;
    Menu_file_saveas: TMenuItem;
    Menu_File_Save: TMenuItem;
    Menu_File_Open: TMenuItem;
    Menu_Exit: TMenuItem;
    Menu_Spravka: TMenuItem;
    Menu_File: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Table: TStringGrid;
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Menu_ExitClick(Sender: TObject);
    procedure Menu_File_OpenClick(Sender: TObject);
    procedure Menu_file_saveasClick(Sender: TObject);
    procedure Menu_File_SaveClick(Sender: TObject);
    procedure Menu_SpravkaClick(Sender: TObject);
  private

  public

  end;

var
  Kubik: TKubik;
  a,v,s:real;
  calculations: array [1..128] of Calculation; // хранит историю вычислений
  last_ind: integer;  // индекс последнего элеента записанного в массив calculations
implementation



{$R *.lfm}

{ TKubik }

procedure TKubik.Menu_File_OpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
      begin
        if OpenDialog1.FileName <> '' then
          begin
          loadparams(a, OpenDialog1.FileName);
          reb.Text  := floattostr( a );
          end;
      end;
end;

procedure TKubik.Menu_file_saveasClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    if SaveDialog1.FileName <> '' then
  Result.Lines.SaveToFile( SaveDialog1.FileName);
end;

procedure TKubik.Menu_File_SaveClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
     begin
       if SaveDialog1.FileName <> '' then
         begin
         saveparam(a, SaveDialog1.FileName);
         end;
     end;
end;

procedure TKubik.Menu_SpravkaClick(Sender: TObject);
begin
  ShowMessage('Программа вычисляет площадь и ребро куба по формулам V=a^3 and S=a*a*6 Автор: Бурдуковский Давид');
end;

procedure TKubik.FormCreate(Sender: TObject);
begin
  Result.Lines.Clear; //очищаем от лишней информации
  a:=random(100);
  reb.Text:=FloatToStr(a);
  last_ind := 0;
  with Table do begin
   cells[0,0]:='A';
   cells[1,0]:='S';
   cells[2,0]:='V';
  end;
end;

procedure TKubik.ButtonClick(Sender: TObject);
var last_calc: Calculation;
begin
 if TryStrToFloat(reb.Text, a) = false then
   begin
   ShowMessage('Неправильно введён параметр a');
   exit;
   end;
  a:=StrToFloat(reb.Text);
  v:=ob(a);
  s:=plosh(a);
  {работа с обычным выводом}
  Result.Lines.Add('Объём куба со стороной '+ FloatToStr(a) +' равен '+ FloatToStr (v));
  Result.Lines.Add('Площадь боковой поверхности куба стороной '+ FloatToStr(a) + ' равна '+ FloatToStr(s));
  {работа с таблицей}
      last_calc.a:=a;
      last_calc.s:=s;
      last_calc.v:=v;
      inc(last_ind);
      calculations[last_ind]:=last_calc;
      Table.RowCount:= last_ind + 1;
      with Table do begin
       Cells[0, last_ind] := floattostr(a);
       Cells[1, last_ind] := floattostr(s);
       Cells[2, last_ind] := floattostr(v);
      end;
end;

procedure TKubik.Menu_ExitClick(Sender: TObject);
begin
  close;
end;

end.

