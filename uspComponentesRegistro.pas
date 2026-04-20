unit uspComponentesRegistro;

interface

uses
  Classes, uspQuery;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('spComponentes', [TspQuery]);
end;

end.
