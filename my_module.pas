unit my_module;
{это модуль логики программы}
// здесь описываются все процедуры, которые работают с данными пользователя:
// получение (вычисление) новых данных, сохранение и загрузка в файл
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
// Запись описывающая исходные данные и результат расчётов.
 Calculation = record
   a: Real;
   s,v: Real;
 end;

function plosh(a:real): real;  //вычисляет площадь поверхности куба
function ob(a:real): real; //вычисляет объем куба
procedure saveparam(a:real; filename: string); //сохраняет параметры ввода в текстовый файл построчно
procedure loadparams(var a: real; filename: string); //загружает параметры ввода из текстового файла построчно


implementation
 function plosh(a:real): real;
  begin
  result := a*a*6;
  end;
 function ob(a:real): real ;
  begin
  result := a*a*a;
  end;
procedure saveparam(a:real; filename: string);
 var f:text;
 begin
   assign(f, filename);
       rewrite(f);
       writeln(f, a);
       close(f);
 end;
 procedure loadparams(var a: real; filename: string);
   var
    f: text;
  begin
      assign(f, filename);
      reset(f);
      readln(f, a);
      close(f);
  end;

end.

