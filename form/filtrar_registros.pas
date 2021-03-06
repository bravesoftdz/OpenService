unit filtrar_registros;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, db, ExtCtrls, StdCtrls, maskedit, ButtonPanel,
    EditBtn, ComCtrls, utilidades_rgtro, utilidades_general, utilidades_bd, utilidades_forms_Filtrar;

type

    { TForm_Filtrar_Registros }

    TForm_Filtrar_Registros = class(TForm)

      BitBtn_Add: TBitBtn;
      BitBtn_Add_OrderBy: TBitBtn;
      BitBtn_Buscar: TBitBtn;
      BitBtn_Ignorar: TBitBtn;
      BitBtn_Ignorar_OrderBy: TBitBtn;
      ButtonPanel1: TButtonPanel;
      CheckBox_Contenido: TCheckBox;
      CheckBox_NOT: TCheckBox;
      CheckBox_NULL: TCheckBox;
      ComboBox_Campo: TComboBox;
      ComboBox_Filtros: TComboBox;
      DateEdit_Fecha_Contenido: TDateEdit;
      Edit_Contenido: TEdit;
      GroupBox1: TGroupBox;
      GroupBox2: TGroupBox;
      GroupBox3: TGroupBox;
      GroupBox_And_Or: TGroupBox;
      GroupBox_ASC_DESC: TGroupBox;
      GroupBox_Contenido: TGroupBox;
      GroupBox_Not_Null: TGroupBox;
      GroupBox_Operador: TGroupBox;
      Label_Contenido: TLabel;
      Label_Fecha: TLabel;
      Label_Fecha1: TLabel;
      Label_Fecha2: TLabel;
      Label_Hora: TLabel;
      MaskEdit_Hora_Contenido: TMaskEdit;
      Memo_Filtros: TMemo;
      Memo_OrderBy: TMemo;
      Panel1: TPanel;
      RadioGroup_Bajas: TRadioGroup;
      Radio_AND: TRadioButton;
      Radio_ASC: TRadioButton;
      Radio_Contenga_Texto: TRadioButton;
      Radio_Distinto_De: TRadioButton;
      Radio_Igual_A: TRadioButton;
      Radio_Mayor_Igual_Que: TRadioButton;
      Radio_Mayor_Que: TRadioButton;
      Radio_Menor_Igual_Que: TRadioButton;
      Radio_Menor_Que: TRadioButton;
      Radio_OR: TRadioButton;
      Radio_OR1: TRadioButton;

      procedure BitBtn_Add_OrderByClick(Sender: TObject);
      procedure BitBtn_BuscarClick(Sender: TObject);
      procedure BitBtn_Ignorar_OrderByClick(Sender: TObject);

      procedure Anular_Uso;
      procedure CheckBox_NULLChange(Sender: TObject);
      procedure ComboBox_FiltrosChange(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure RadioGroup_BajasClick(Sender: TObject);
      procedure Rellenar_Campos;
      procedure Rellenar_Filtros( param_Order_By : array of TOrder_By );
      procedure Cambio_de_Campo;
      procedure BitBtn_IgnorarClick(Sender: TObject);
      procedure BitBtn_AddClick(Sender: TObject);
      procedure ComboBox_CampoChange(Sender: TObject);
      procedure Comprobar_Si_Memo_Vacio;
      procedure AnadirStrings_Filtros( param_SQL : TStrings );
      procedure AnadirStrings_OrderBy( param_SQL : TStrings );
      procedure CancelButtonClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
      procedure FormCreate(Sender: TObject);
      procedure Memo_FiltrosChange(Sender: TObject);
      procedure OKButtonClick(Sender: TObject);

    private
      { private declarations }
      private_Salir_OK : Boolean;

      procedure Activar_Operadores( param_SN : Boolean );

    public
      { public declarations }
      public_Campos        : TFieldDefs;
      public_nombre_tabla  : String;
      public_Pulso_Aceptar : Boolean;

    end;

var
    Form_Filtrar_Registros: TForm_Filtrar_Registros;

implementation

{$R *.lfm}

uses menu;

{ TForm_Filtrar_Registros }

procedure TForm_Filtrar_Registros.Memo_FiltrosChange(Sender: TObject);
begin
  Comprobar_Si_Memo_Vacio;
end;

procedure TForm_Filtrar_Registros.Comprobar_Si_Memo_Vacio;
begin
    if Trim(Memo_Filtros.Lines.Text) = '' then
         GroupBox_And_Or.Enabled := False
    else GroupBox_And_Or.Enabled := True;
end;

procedure TForm_Filtrar_Registros.BitBtn_IgnorarClick(Sender: TObject);
begin
    Memo_Filtros.Lines.Clear;
    UTI_TB_Ver_Bajas_SN(public_nombre_tabla, Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);
    Memo_Filtros.Lines.Text := UTI_TB_Quitar_AndOr_Principio(Memo_Filtros.Lines.Text);
end;

procedure TForm_Filtrar_Registros.ComboBox_CampoChange(Sender: TObject);
begin
    Cambio_de_Campo;
end;

procedure TForm_Filtrar_Registros.FormDestroy(Sender: TObject);
begin
    public_Campos.Free;
end;

procedure TForm_Filtrar_Registros.CheckBox_NULLChange(Sender: TObject);
begin
    if CheckBox_NULL.Checked = false then
         Cambio_de_Campo
    else Anular_Uso;
end;

procedure TForm_Filtrar_Registros.Activar_Operadores( param_SN : Boolean );
begin
  Radio_Igual_A.Enabled         := param_SN;
  Radio_Menor_Que.Enabled       := param_SN;
  Radio_Mayor_Que.Enabled       := param_SN;
  Radio_Distinto_De.Enabled     := param_SN;
  Radio_Menor_Igual_Que.Enabled := param_SN;
  Radio_Mayor_Igual_Que.Enabled := param_SN;
end;

procedure TForm_Filtrar_Registros.Anular_Uso;
begin
  Activar_Operadores( false );

  Radio_Contenga_Texto.Enabled     := false;
  Label_Fecha.Enabled              := false;
  DateEdit_Fecha_Contenido.Enabled := false;
  CheckBox_Contenido.Enabled       := false;
  Label_Contenido.Enabled          := false;
  Edit_Contenido.Enabled           := false;
  Label_Hora.Enabled               := false;
  MaskEdit_Hora_Contenido.Enabled  := false;
end;

procedure TForm_Filtrar_Registros.BitBtn_AddClick(Sender: TObject);
var var_SQL_OLD : TStrings;
    var_Frase   : String;
    var_msg     : TStrings;
    var_Dia     : ShortString;
    var_Hora    : ShortString;
begin
    var_SQL_OLD := TStringList.Create;
    var_msg     := TStringList.Create;

    var_SQL_OLD.Assign(Memo_Filtros.Lines);

  { ****************************************************************************
    NO CAMBIAR EL ORDEN DE PREGUNTAR PORQUE COMANDO TRABAJARA CON EL CAMPO
    ****************************************************************************
    SI CheckBox_NULL esta ACTIVADO(Checked = true), no hará nada ni con
    GroupBox_Operador, ni con GroupBox_Contenido.
    ****************************************************************************
    Si CheckBox_NULL NO esta ACTIVADO(Checked = false), trabajaremos con el
    contenido deGroupBox_Operador, ni con GroupBox_Contenido.
    **************************************************************************** }
    if CheckBox_NULL.Checked = true then
        begin
            var_Frase := Trim(ComboBox_Campo.Text) + ' IS NULL ';
        end
    else
        begin
          { ********************************************************************
            CheckBox_NULL NO esta ACTIVADO(Checked = false), trabajaremos con el
            contenido deGroupBox_Operador, ni con GroupBox_Contenido.
            ********************************************************************
            Primero controlaremos que se pulsara el campo ComboBox_Campo.Text,
            porque su manera de tratarlo es diferente a los otros operadores
            ******************************************************************** }
            if Radio_Contenga_Texto.Checked = true then
                begin
                    var_Frase := Trim(ComboBox_Campo.Text) +
                                 ' LIKE ' +
                                 UTI_GEN_Comillas( '%' +
                                            Edit_Contenido.Text +
                                            '%' );
                end
            else
                begin
                  { ************************************************************
                    Ahora vamos a trabajar con GroupBox_Operador
                    ************************************************************ }
                    if Radio_Igual_A.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' = ';
                    end;

                    if Radio_Menor_Que.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' < ';
                    end;

                    if Radio_Mayor_Que.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' > ';
                    end;

                    if Radio_Distinto_De.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' <> ';
                    end;

                    if Radio_Menor_Igual_Que.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' <= ';
                    end;

                    if Radio_Mayor_Igual_Que.Checked = true then
                    begin
                        var_Frase := Trim(ComboBox_Campo.Text) + ' >= ';
                    end;

                  { ************************************************************
                    Ahora trabajaremos con GroupBox_Contenido
                    ************************************************************
                    Primero veremos si están activos los componentes necesarios
                    para campos fecha o tiempo
                    ************************************************************ }
                    if (DateEdit_Fecha_Contenido.Enabled = True) and
                       (MaskEdit_Hora_Contenido.Enabled = True)  then
                        begin
                          { ****************************************************
                            Están activos los dos componentes, el de fecha y el
                            de tiempo
                            **************************************************** }
                            var_Dia := Trim(DateEdit_Fecha_Contenido.Text);

                            if MaskEdit_Hora_Contenido.Text <> '  :  :  ' then
                                 var_Hora := Trim(MaskEdit_Hora_Contenido.Text)
                            else var_Hora := '00:00:00';

                            var_Frase := Trim(var_Frase) + ' ' +
                                         UTI_GEN_Comillas(  UTI_GEN_Format_Fecha_Hora( StrToDateTime(Trim(var_Dia) + ' ' +
                                                                                                     Trim(var_Hora)), true )  );
                          { var_Frase := Trim(var_Frase) + ' ' +
                                         UTI_GEN_Comillas( Trim(var_Dia) + ' ' +
                                         Trim(var_Hora) ); }
                        end
                    else
                        begin
                          { ****************************************************
                            O está activo para introducir una fecha o para una
                            hora
                            **************************************************** }
                            if DateEdit_Fecha_Contenido.Enabled = True then
                            begin
                                var_Frase := Trim(var_Frase) + ' ' +
                                             UTI_GEN_Comillas(Trim(UTI_GEN_Format_Fecha_Hora(StrToDateTime(DateEdit_Fecha_Contenido.Text), true)));

                              { var_Frase := Trim(var_Frase) + ' ' +
                                             UTI_GEN_Comillas(Trim(DateEdit_Fecha_Contenido.Text)); }
                            end;

                            if MaskEdit_Hora_Contenido.Enabled = True then
                            begin
                                if MaskEdit_Hora_Contenido.Text <> '  :  :  ' then
                                    begin
                                        var_Frase := Trim(var_Frase) + ' ' +
                                                     UTI_GEN_Comillas(Trim(MaskEdit_Hora_Contenido.Text));
                                    end
                                else var_Frase := Trim(var_Frase) + ' ' +
                                                  UTI_GEN_Comillas('00:00:00');
                            end;
                        end;

                  { ************************************************************
                    Ahora comprobaremos si está activo para introducir texto
                    ************************************************************ }
                    if Edit_Contenido.Enabled = True then
                    begin
                        if Trim(Edit_Contenido.Text) <> '' then
                            begin
                                if UTI_RGTRO_Campo_es_Texto( public_Campos.Items[ComboBox_Campo.ItemIndex].DataType,
                                                             '' ) = true then
                                     var_Frase := Trim(var_Frase) + ' ' + UTI_GEN_Comillas(Trim(Edit_Contenido.Text))
                                else var_Frase := Trim(var_Frase) + ' ' + Trim(Edit_Contenido.Text);
                            end
                        else var_msg.Add('* El contenido');
                    end;

                  { ************************************************************
                    Ahora comprobaremos si está activo para campos true/false
                    ************************************************************ }
                    if CheckBox_Contenido.Enabled = True then
                    begin
                        if CheckBox_Contenido.Checked = True then
                             var_Frase := Trim(var_Frase)
                        else var_Frase := ' NOT ' + Trim(var_Frase);
                    end;
                end;
        end;

  { ****************************************************************************
    CONTROLAR ANTES DEL AND/OR EL NOT, PERO AL FINAL
    **************************************************************************** }
    if Trim(var_msg.Text) = '' then
        begin
            if CheckBox_NOT.Checked = true then
            begin
                if CheckBox_Contenido.Checked = True then
                begin
                    var_Frase := ' NOT ' + Trim(var_Frase);
                end;
            end;

          { ****************************************************************************
            CONTROLAR ESTO AL FINAL, PERO AL FINAL DE TODO
            **************************************************************************** }
            if GroupBox_And_Or.Enabled = true then
            begin
                if Radio_AND.Checked = true then
                     var_Frase := ' AND ' + Trim(var_Frase)
                else var_Frase := ' OR ' + Trim(var_Frase);
            end;

            var_SQL_OLD.Text := Trim(var_SQL_OLD.Text) + var_Frase;

            Memo_Filtros.Lines.Clear;
            Memo_Filtros.Lines.AddStrings(var_SQL_OLD);
        end
    else UTI_GEN_Aviso(true, var_msg, rs_Falta, True, False);

    var_msg.Free;
    var_SQL_OLD.Free;
end;

procedure TForm_Filtrar_Registros.BitBtn_BuscarClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
  var_Registro := UTI_Abrir_Form( '', '', true, true, ComboBox_Campo.Text );

  if var_Registro.id_1 <> '' then
    Edit_Contenido.Text := var_Registro.id_1;
end;

procedure TForm_Filtrar_Registros.RadioGroup_BajasClick(Sender: TObject);
begin
    UTI_TB_Ver_Bajas_SN(public_nombre_tabla, Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);
    Memo_Filtros.Lines.Text := UTI_TB_Quitar_AndOr_Principio(Memo_Filtros.Lines.Text);
end;

procedure TForm_Filtrar_Registros.FormCreate(Sender: TObject);
begin
    { ****************************************************************************
      Obligado en cada formulario para no olvidarlo
      **************************************************************************** }
      with Self do
      begin
          Color       := $00C2C29E;
          Position    := poScreenCenter;
          BorderIcons := [];
          BorderStyle := bsSingle;
      end;

      private_Salir_OK     := false;
      public_Pulso_Aceptar := false;
    { **************************************************************************** }

      Memo_Filtros.Lines.Clear;
      Memo_OrderBy.Lines.Clear;

      DateEdit_Fecha_Contenido.Date := Now;

      public_Campos := TFieldDefs.Create(Nil);
end;

procedure TForm_Filtrar_Registros.Rellenar_Campos;
var var_Contador : ShortInt;
    var_Campo    : String;
begin
  { ****************************************************************************
    Rellenamos el combobox de los campos de la tabla devueltos por la sql
    **************************************************************************** }
    ComboBox_Campo.Items.Clear;

    for var_Contador := 0 to (public_Campos.Count - 1) do
    begin
        If Pos( UpperCase('OT_'), UpperCase(public_Campos.Items[var_Contador].Name) ) = 0 then
        begin
            var_Campo := public_Campos.Items[var_Contador].Name;
            if Trim(public_nombre_tabla) <> '' then
            begin
                var_Campo := Trim(public_nombre_tabla) + '.' + var_Campo;
            end;
            ComboBox_Campo.Items.Add(var_Campo);
        end;
    end;

    ComboBox_Campo.ItemIndex := 0;
    Cambio_de_Campo;
end;

procedure TForm_Filtrar_Registros.AnadirStrings_Filtros( param_SQL : TStrings );
begin
    with Memo_Filtros do
    begin
        Clear;
        if Trim(param_SQL.Text) <> '' then
        begin
            Lines.AddStrings(param_SQL);
        end;
    end;

    Comprobar_Si_Memo_Vacio;
end;

procedure TForm_Filtrar_Registros.AnadirStrings_OrderBy( param_SQL : TStrings );
begin
    with Memo_OrderBy do
    begin
        Clear;
        if Trim(param_SQL.Text) <> '' then
        begin
            Lines.AddStrings(param_SQL);
        end;
    end;
end;

procedure TForm_Filtrar_Registros.BitBtn_Ignorar_OrderByClick(Sender: TObject);
begin
    Memo_OrderBy.Lines.Clear;
end;

procedure TForm_Filtrar_Registros.CancelButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := false;
end;

procedure TForm_Filtrar_Registros.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;

    if public_Pulso_Aceptar = true then
    begin
        {   COMPROBAMOS SI FALTA ALGO

            if Memo_Filtros.Lines.Count = 0 then
            begin
                var_msg.Add( 'No hay ningún filtro');
                UTI_GEN_Aviso(true, var_msg, '¿Está seguro?', True, False);
                var_msg.Clear;
            end;
        }
    end;

    if private_Salir_OK = False then
        begin
          { ********************************************************************
            Intento BitBtn_SALIR de la aplicación de un modo no permitido.
            ********************************************************************
            Pero si desde el menu principal está a true la variable
            public_Salir_Ok, significa que hay que salir si o si pues se pulsó
            cancelar al preguntar otra vez por la contraseña
            ******************************************************************** }
            if form_Menu.public_Salir_OK = False then CloseAction := caNone;
        end
    else
        begin
          { ********************************************************************
            Fue correcto el modo como quiere salir de la aplicación
            ********************************************************************
            Comprobaremos si no se generó algún error por falta de completar
            algun campo y si se salió con el botón Ok o Cancel
            ******************************************************************** }
            if (Trim(var_msg.Text) <> '') and (public_Pulso_Aceptar = true) then
                begin
                    UTI_GEN_Aviso(true, var_msg, rs_Falta, True, False);
                    CloseAction := caNone;
                end
            else  CloseAction := caFree;
        end;

    var_msg.Free;
end;

procedure TForm_Filtrar_Registros.OKButtonClick(Sender: TObject);
begin
    private_Salir_OK     := true;
    public_Pulso_Aceptar := true;
end;

procedure TForm_Filtrar_Registros.BitBtn_Add_OrderByClick(Sender: TObject);
begin
    if Trim(Memo_OrderBy.Lines.Text) <> '' then
    begin
         Memo_OrderBy.Lines.Text := Trim(Memo_OrderBy.Lines.Text) + ', ';
    end;

    Memo_OrderBy.Lines.Text := Memo_OrderBy.Lines.Text + ComboBox_Campo.Text;

    if Radio_ASC.Checked = true then
         Memo_OrderBy.Lines.Text := Memo_OrderBy.Lines.Text + ' ASC'
    else Memo_OrderBy.Lines.Text := Memo_OrderBy.Lines.Text + ' DESC';
end;

procedure TForm_Filtrar_Registros.Rellenar_Filtros( param_Order_By : array of TOrder_By );
var var_Contador : ShortInt;
begin
  { ****************************************************************************
    Rellenamos el combobox de los campos de la tabla devueltos por la sql
    **************************************************************************** }
    ComboBox_Filtros.Items.Clear;

    ComboBox_Filtros.Items.Add( 'Por campo elegido (ASC / DESC)' );

    UTI_TB_Rellenar_ComboBox_Orden( false,
                                    ComboBox_Filtros,
                                    param_Order_By,
                                    0 );
end;

procedure TForm_Filtrar_Registros.ComboBox_FiltrosChange(Sender: TObject);
begin
    if ComboBox_Filtros.ItemIndex = 0 then
         Memo_OrderBy.Enabled := true
    else Memo_OrderBy.Enabled := false;
end;

procedure TForm_Filtrar_Registros.Cambio_de_Campo;
var var_posicion : Integer;
begin
    Anular_Uso;

    // if UpperCase(Copy( Trim(ComboBox_Campo.Text), 0, 3 )) = UpperCase('ID_') then
    If Pos(UpperCase('ID_'), UpperCase(ComboBox_Campo.Text)) <> 0 then
         BitBtn_Buscar.Visible := true
    else BitBtn_Buscar.Visible := false;

    var_posicion := ComboBox_Campo.ItemIndex;

    if UTI_RGTRO_Campo_es_DiaHora( public_Campos.Items[var_posicion].DataType,
                                   '' ) = true then
    begin
      Activar_Operadores(true);

      Label_Fecha.Enabled              := true;
      DateEdit_Fecha_Contenido.Enabled := true;

      Label_Hora.Enabled               := true;
      MaskEdit_Hora_Contenido.Enabled  := true;
    end;

    if UTI_RGTRO_Campo_es_Dia( public_Campos.Items[var_posicion].DataType,
                               '' ) = true then
    begin
      Activar_Operadores(true);

      Label_Fecha.Enabled              := true;
      DateEdit_Fecha_Contenido.Enabled := true;
    end;

    if UTI_RGTRO_Campo_es_Hora( public_Campos.Items[var_posicion].DataType,
                                '' ) = true then
    begin
      Activar_Operadores(true);

      Label_Hora.Enabled              := true;
      MaskEdit_Hora_Contenido.Enabled := true;
    end;

    if UTI_RGTRO_Campo_es_Numero( public_Campos.Items[var_posicion].DataType,
                                  '' ) = true then
    begin
      Activar_Operadores(true);

      Label_Contenido.Enabled := true;
      Edit_Contenido.Enabled  := true;
    end;

    if UTI_RGTRO_Campo_es_Texto( public_Campos.Items[var_posicion].DataType,
                                 '' ) = true then
    begin
      Activar_Operadores(true);

      Radio_Contenga_Texto.Enabled := true;

      Label_Contenido.Enabled      := true;
      Edit_Contenido.Enabled       := true;
    end;

    if (public_Campos.Items[var_posicion].DataType = ftBoolean) then
    begin
      CheckBox_Contenido.Enabled := true;
    end;

    if (public_Campos.Items[var_posicion].DataType = ftUnknown)       then ShowMessage('ftUnknown ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftBytes)         then ShowMessage('ftBytes ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftVarBytes)      then ShowMessage('ftVarBytes ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftBlob)          then ShowMessage('ftBlob ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftGraphic)       then ShowMessage('ftGraphic ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftParadoxOle)    then ShowMessage('ftParadoxOle ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftDBaseOle)      then ShowMessage('ftDBaseOle ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftTypedBinary)   then ShowMessage('ftTypedBinary ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftCursor)        then ShowMessage('ftCursor ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftADT)           then ShowMessage('ftADT ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftArray)         then ShowMessage('ftArray ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftReference)     then ShowMessage('ftReference ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftDataSet)       then ShowMessage('ftDataSet ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftOraBlob)       then ShowMessage('ftOraBlob ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftOraClob)       then ShowMessage('ftOraClob ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftVariant)       then ShowMessage('ftVariant ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftInterface)     then ShowMessage('ftInterface ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftIDispatch)     then ShowMessage('ftIDispatch ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftGuid)          then ShowMessage('ftGuid ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftTimeStamp)     then ShowMessage('ftTimeStamp ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftFMTBcd)        then ShowMessage('ftFMTBcd ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftFixedWideChar) then ShowMessage('ftFixedWideChar ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
    if (public_Campos.Items[var_posicion].DataType = ftWideMemo)      then ShowMessage('ftWideMemo ... no se si tendras que arreglarlo tambien en UTI_RGTRO_Buscar_id');
end;

end.

