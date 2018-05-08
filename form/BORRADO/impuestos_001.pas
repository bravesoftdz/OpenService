unit impuestos_001;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls, DbCtrls,
    utilidades_usuarios, utilidades_general, db, utilidades_forms_Filtrar, Buttons, ExtCtrls, Grids,
    variants, DBGrids, sqldb, utilidades_contabilidad, utilidades_bd, utilidades_rgtro,
    utilidades_impuestos;

type

    { Tform_impuestos_001 }

    Tform_impuestos_001 = class(TForm)
        BitBtn_Ver_Situacion_Registro_Composiciones: TBitBtn;
        ButtonPanel1: TButtonPanel;
        DBCheckBox_IVA_con_Recargo_SN: TDBCheckBox;
        DBEdit_Cuenta_Contable: TDBEdit;
        DBEdit_Tanto_Por_Ciento: TDBEdit;
        DBEdit_Descripcion: TDBEdit;
        DBEdit_eMail1: TDBEdit;
        DBGrid_Impuestos_Composiciones: TDBGrid;
        DBNavigator_Impuestos_Composiciones: TDBNavigator;
        GroupBox11: TGroupBox;
        GroupBox_Impuestos_Composicion: TGroupBox;
        Label17: TLabel;
        Label24: TLabel;
        Label25: TLabel;
        Label62: TLabel;
        RadioGroup_Bajas: TRadioGroup;

        procedure Borrar_Impuesto_a_Composiciones;
        function  Comprobar_No_Tocar( param_Reproducir_Mensajes, param_Ejecutar_No_Tocar : Boolean ) : Boolean;
        procedure Cauto_Composicion_Y_Guardo_en_Historico_sus_Cambios( param_id_impuestos, param_id_impuestos_al_que_pertenece, param_descripcion : ShortString );
        function  Existe_Impuesto_Composicion_Ya( param_id_impuestos, param_id_impuestos_al_que_pertenece : ShortString ) : Trecord_Existe;
        function  Elegir_Impuesto(param_familia : ShortString) : TRecord_Rgtro_Comun;
        procedure Asignar_Impuesto_a_Composiciones;
        function  Asignar_Impuesto_a_Composiciones_2( param_id_impuestos, param_id_impuestos_al_que_pertenece : ShortString ) : Boolean;
        procedure BitBtn_Ver_Situacion_Registro_ComposicionesClick(Sender: TObject);
        procedure DBGrid_Impuestos_ComposicionesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure DBNavigator_Impuestos_ComposicionesBeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure RadioGroup_BajasClick(Sender: TObject);
        procedure Refrescar_Registros;
        procedure Presentar_Datos;
        procedure no_Tocar;
        procedure CancelButtonClick(Sender: TObject);
        procedure Comprobar_Toda_Fecha_Hora( param_msg : TStrings );
        procedure Actualizar_Campos_Fecha_Hora_Si_Completado( param_msg : TStrings );
        procedure FormActivate(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
        procedure OKButtonClick(Sender: TObject);
        procedure para_Empezar;
    private
        { private declarations }
        private_Salir_OK : Boolean;
    public
        { public declarations }
        public_Solo_Ver      : Boolean;
        public_Menu_Worked   : Integer;
        public_Pulso_Aceptar : Boolean;
        public_Record_Rgtro  : TRecord_Rgtro_Comun;
    end;

var
    form_impuestos_001: Tform_impuestos_001;

implementation

{$R *.lfm}

uses menu, impuestos_000, impuestos_002;

{ Tform_impuestos_001 }

procedure Tform_impuestos_001.FormCreate(Sender: TObject);
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

    private_Salir_OK := false;

  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    public_Solo_Ver     := false;
end;

procedure Tform_impuestos_001.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    with form_impuestos_000.SQLQuery_Impuestos do
    begin
        public_Record_Rgtro := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                           '',
                                                           '',

                                                           FieldByName('descripcion').AsString,
                                                           FieldByName('Tanto_Por_Ciento').AsString,
                                                           FieldByName('Sumado_A_Ftra_SN').AsString );
    end;

    Presentar_Datos;

  { ****************************************************************************
    SOLO PARA ESTE FORM
    **************************************************************************** }
end;

procedure Tform_impuestos_001.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
    ButtonPanel1.SetFocus; // Con esto consigo que salga del campo que este y pueda actualizarlo

    var_msg := TStringList.Create;

    if public_Pulso_Aceptar = true then
    begin
        with form_impuestos_000.SQLQuery_Impuestos do
        begin
            if Trim(FieldByName('Tanto_Por_Ciento').AsString) = '' then
            begin
                if form_impuestos_000.SQLQuery_Impuestos_Composiciones.RecordCount = 0 then
                begin
                    var_msg.Add( '* El % del impuesto.');
                    UTI_GEN_Aviso(false, var_msg, 'SE AVISA POR FALTA.-', True, False);
                end;
            end;

            var_msg.Clear;

            Comprobar_Toda_Fecha_Hora(var_msg);

            if Trim(FieldByName('descripcion').AsString) = '' then
            begin
                var_msg.Add( '* La descripción.');
            end;

            if Trim(FieldByName('Sumado_A_Ftra_SN').AsString) = '' then
            begin
                var_msg.Add( '* Si se suma al total de factura o no.');
            end;

            form_Menu.Traer_Configuracion_APP;

            UTI_CONTA_esta_Cta_Ctble_BIEN( form_menu.public_User_Configuracion.Impuestos_Obligar_Cuenta_Contable_SN, //.... aqui tambien permitir el control de exigirlo o no
                                           var_msg,
                                           form_impuestos_000.SQLQuery_Impuestos,
                                           '',
                                           'impuestos',
                                           'Cuenta_Contable',
                                           'LA CUENTA CONTABLE' );
        end;
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
            if form_Menu.public_Salir_OK = False then CloseAction := CloseAction.caNone;
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
                    // var_msg.Free;
                    CloseAction := CloseAction.caNone;
                end
            else
                begin
                    // var_msg.Free;
                    CloseAction := caFree;
                end;

        end;

    var_msg.Free;
end;

procedure Tform_impuestos_001.Comprobar_Toda_Fecha_Hora( param_msg : TStrings );
var var_msg : TStrings;
begin
    Actualizar_Campos_Fecha_Hora_Si_Completado(param_msg);

  { ************************************************************************************************
    ** COMPROBAR CUALES SON OBLIGADOS O DE SÓLO AVISO                                             **
    ************************************************************************************************ }
  { ** Cuando un campo de fecha o hora es de introducción obligatoria                             **
    ************************************************************************************************
    if DateEdit_Fecha_Nacimiento.Text  = '  /  /    ' then
    begin
         param_msg.Add( '* La fecha de nacimiento de quien facturamos' );
    end;

    ************************************************************************************************
    ** Cuando un campo de fecha o hora es de solo aviso, pero no introducción obligatoria         **
    ************************************************************************************************
    if DateEdit_Fecha_Nacimiento.Text  = '  /  /    ' then
    begin
         var_msg := TStringList.Create;
         var_msg.Add('** NO SE HA INTRODUCIDO LA FECHA DE NACIMIENTO DE QUIEN FACTURAMOS ** ');
         UTI_GEN_Aviso(true, var_msg, 'AVISAMOS DE ... ', True, False);
         var_msg.Free;
    end; }
end;

procedure Tform_impuestos_001.Actualizar_Campos_Fecha_Hora_Si_Completado( param_msg : TStrings );
begin
    // No lo vamos a usar en este modulo
end;

procedure Tform_impuestos_001.OKButtonClick(Sender: TObject);
begin
    private_Salir_OK     := true;
    public_Pulso_Aceptar := true;
end;

procedure Tform_impuestos_001.CancelButtonClick(Sender: TObject);
begin
    private_Salir_OK     := true;
    public_Pulso_Aceptar := false;
end;

procedure Tform_impuestos_001.no_Tocar;
begin
    DBEdit_Descripcion.Enabled := False;
end;

procedure Tform_impuestos_001.Presentar_Datos;
var var_Hora : tTime;
    var_Dia  : tDate;
begin
    with form_impuestos_000.SQLQuery_Impuestos do
    begin
    end;
end;

procedure Tform_impuestos_001.Refrescar_Registros;
begin
    form_impuestos_000.Refrescar_Registros_Composiciones;
end;

procedure Tform_impuestos_001.RadioGroup_BajasClick(Sender: TObject);
begin
    //UTI_TB_Ver_Bajas_SN('um', Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);
    Refrescar_Registros;
end;

procedure Tform_impuestos_001.BitBtn_Ver_Situacion_Registro_ComposicionesClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if form_impuestos_000.SQLQuery_Impuestos_Composiciones.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'impuestos_composiciones',
                                           form_impuestos_000.SQLQuery_Impuestos_Composiciones,
                                           form_impuestos_000.DataSource_Impuestos_Composiciones,
                                           DBGrid_Impuestos_Composiciones );
        end;
    end;
end;

procedure Tform_impuestos_001.DBNavigator_Impuestos_ComposicionesBeforeAction(Sender: TObject;
    Button: TDBNavButtonType);
begin
    case Button of
        nbInsert : begin
            Asignar_Impuesto_a_Composiciones;
            Abort;
        end;

        nbDelete : begin
            Borrar_Impuesto_a_Composiciones;
            Abort;
        end;

        nbRefresh : begin
            form_impuestos_000.Refrescar_Registros_Composiciones;
            Abort;
        end;
    end;
end;

function Tform_impuestos_001.Elegir_Impuesto(param_familia : ShortString) : TRecord_Rgtro_Comun;
var var_msg : TStrings;
begin
    Result.id_1 := '';

    if UTI_GEN_Form_Abierto_Ya('form_impuestos_002') = false then
    begin
        Application.CreateForm(Tform_impuestos_002, form_impuestos_002);

        form_impuestos_002.public_id_impuesto_que_no_tiene_que_aparecer := param_familia;

        form_impuestos_002.public_Solo_Ver    := true;
        form_impuestos_002.public_Elegimos    := true;
        form_impuestos_002.public_Menu_Worked := public_Menu_Worked;

        form_impuestos_002.para_Empezar;

        form_impuestos_002.ShowModal;

        if form_impuestos_002.public_Rgtro_Seleccionado = true then
        begin
            with form_impuestos_002.SQLQuery_Impuestos_para_composicion do
            begin
                Result := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                      '',
                                                      '',

                                                      FieldByName('descripcion').AsString,
                                                      FieldByName('Tanto_Por_Ciento').AsString,
                                                      FieldByName('Sumado_A_Ftra_SN').AsString );
            end;
        end;

        form_impuestos_002.Free;
    end else begin
        var_msg := TStringList.Create;
        var_msg.Add(rs_Modulo_Abierto);
        UTI_GEN_Aviso(true, var_msg, 'AVISAMOS DE ... ', True, False);
        var_msg.Free;
        Exit;
    end;
end;

function Tform_impuestos_001.Existe_Impuesto_Composicion_Ya( param_id_impuestos,
                                                             param_id_impuestos_al_que_pertenece : ShortString ) : Trecord_Existe;
var var_SQL            : TStrings;
    var_SQLTransaction : TSQLTransaction;
    var_SQLConnector   : TSQLConnector;
    var_SQLQuery       : TSQLQuery;
begin
    try
      { ****************************************************************************
        Creamos la Transaccion y la conexión con el motor BD, y la abrimos
        **************************************************************************** }
        var_SQLTransaction := TSQLTransaction.Create(nil);
        var_SQLConnector   := TSQLConnector.Create(nil);

        if UTI_CN_Abrir( var_SQLTransaction,
                         var_SQLConnector ) = False then UTI_GEN_Salir;

      { ****************************************************************************
        Creamos la SQL Según el motor de BD
        **************************************************************************** }
        var_SQL := TStringList.Create;

        var_SQL.Add('SELECT i.*' );
        var_SQL.Add(  'FROM impuestos_composiciones AS i' );

        var_SQL.Add(' WHERE i.id_impuestos_al_que_pertenece = ' +  Trim(param_id_impuestos_al_que_pertenece) );
        var_SQL.Add(  ' AND i.id_impuestos = ' +  Trim(param_id_impuestos) );

        var_SQL.Add(' ORDER BY i.id_impuestos_al_que_pertenece ASC, id_impuestos ASC' );

      { ****************************************************************************
        Abrimos la tabla
        **************************************************************************** }
        var_SQLQuery      := TSQLQuery.Create(nil);
        var_SQLQuery.Name := 'SQLQuery_Existe_Impuesto_Composicion_Ya';

        if UTI_TB_Abrir( '', '', '',
                         var_SQLConnector,
                         var_SQLTransaction,
                         var_SQLQuery,
                         -1, // asi me trae todos los registros de golpe
                         var_SQL.Text ) = False then UTI_GEN_Salir;

      { ****************************************************************************
        TRABAJAMOS CON LOS REGISTROS DEVUELTOS
        ****************************************************************************
        Si el módulo no se creó, no se permite entrar en él ... Result := False
        **************************************************************************** }
        Result.Fallo_en_Conexion_BD := false;
        Result.Existe               := false;
        Result.deBaja               := 'N';

        if var_SQLQuery.RecordCount > 0 then
        begin
            Result.Existe := true;
            if not var_SQLQuery.FieldByName('Del_WHEN').IsNull then Result.deBaja := 'S';
        end;

      { ****************************************************************************
        Cerramos la tabla
        **************************************************************************** }
        if UTI_TB_Cerrar( var_SQLConnector,
                          var_SQLTransaction,
                          var_SQLQuery ) = false then UTI_GEN_Salir;

        var_SQLQuery.Free;

        var_SQL.Free;

        var_SQLTransaction.Free;
        var_SQLConnector.Free;
    except
         on error : Exception do
         begin
             UTI_GEN_Error_Log( 'Error al comprobar si el impuesto existe ya como composición del' +
                                ' impuesto cabecera. La tabla ha sido ' + var_SQLQuery.Name +
                                ' desde el módulo ' + Screen.ActiveForm.Name,
                                error );
             try
                 var_SQL.Free;
                 var_SQLTransaction.Free;
                 var_SQLConnector.Free;
                 var_SQLQuery.Free;
             except
             end;

             Result.Fallo_en_Conexion_BD := true;
         end;
    end;
end;

procedure Tform_impuestos_001.Cauto_Composicion_Y_Guardo_en_Historico_sus_Cambios( param_id_impuestos,
                                                                                   param_id_impuestos_al_que_pertenece,
                                                                                   param_descripcion : ShortString );
var var_SQL : TStrings;
begin
    // ********************************************************************* //
    // ** Esto lo hago porque puede ser que los criterios de filtrado me  ** //
    // ** eviten filtrar el registro recien creado                        ** //
    // ********************************************************************* //
    var_SQL := TStringList.Create;

    var_SQL.Add('SELECT i.*' );
    var_SQL.Add(  'FROM impuestos_composiciones AS i' );

    var_SQL.Add(' WHERE i.id_impuestos_al_que_pertenece = ' +  Trim(param_id_impuestos_al_que_pertenece) );
    var_SQL.Add(  ' AND i.id_impuestos = ' +  Trim(param_id_impuestos) );

    var_SQL.Add(' ORDER BY i.id_impuestos_al_que_pertenece ASC, id_impuestos ASC' );

{
    var_SQL.Add( 'SELECT i.*' );
    var_SQL.Add(   'FROM impuestos_composiciones AS i' );
    var_SQL.Add(  'WHERE i.id_impuestos = ' + Trim(param_id_impuestos)  );
    var_SQL.Add(    'AND i.id = ' +  Trim(param_Id) );
    var_SQL.Add(  'ORDER BY i.id_impuestos ASC' );
}

    if UTI_RGTRO_Buscar_Rgtro_y_Grabar_Cambios_en_Historico( 'SQLQuery_Impuestos_Composiciones',
                                                             var_SQL ) = false then
    begin
        var_SQL.Clear;

        var_SQL.Add( 'No se pudo grabar el histórico de los cambios' +
                     ' realizados al añadir al impuesto ' +
                     Trim(form_impuestos_000.SQLQuery_Impuestos.FieldByName('descripcion').AsString) +
                     ' como composición suya el impuesto ' + Trim(param_descripcion) );

        UTI_GEN_Aviso(true, var_SQL, 'ERROR ... ', True, False);
    end;

    var_SQL.Free;
end;

procedure Tform_impuestos_001.DBGrid_Impuestos_ComposicionesDrawColumnCell(Sender: TObject;
    const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var var_Color_Normal : TColor;
begin
    with Sender as TDBGrid do
    begin
        if form_impuestos_000.SQLQuery_Impuestos_Composiciones.RecordCount = 0 then Exit;

        var_Color_Normal := Canvas.Brush.Color;

        // ***************************************************************************************** //
        // ** Primero comprobamos si es un registro dado de baja o no                             ** //
        // ***************************************************************************************** //
        if not form_impuestos_000.SQLQuery_Impuestos_Composiciones.FieldByName('Del_WHEN').IsNull then
        begin
            // ************************************************************************************* //
            // ** Registro DADO de BAJA                                                           ** //
            // ************************************************************************************* //
            Canvas.Font.Color := clSilver;
        end else begin
            // ************************************************************************************* //
            // ** Registro DADO de ALTA, NO BAJA                                                  ** //
            // ************************************************************************************* //
            // ** Así que las pinto, pero sólo si no son las columnas que van a ser dibujadas     ** //
            // ************************************************************************************* //
            if State <> [gdSelected] then
            begin
                if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
                begin
                    Canvas.font.Color := clBlack;
                end;
            end;
        end;

        // ***************************************************************************************** //
        // ** Ahora paso a dibujar una celda normal con los colores elegidos o una dibujada       ** //
        // ***************************************************************************************** //
        if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
        begin
            // ************************************************************************************* //
            // ** No es una de las columnas a dibujar por lo que la pinto con los colores elegidos** //
            // ************************************************************************************* //
            DefaultDrawColumnCell(Rect, DataCol, Column, State)
        end else begin
            // ************************************************************************************* //
            // ** Es una de las columnas a dibujar                                                ** //
            // ************************************************************************************* //
            if Column.FieldName = 'COLUMNA_CON_IMAGEN'  then
            begin
                if form_impuestos_000.SQLQuery_Impuestos_Composiciones.FieldByName('OT_Tanto_Por_Ciento').AsString = '' then
                begin
                    Canvas.StretchDraw(Rect, form_impuestos_000.Image_Confirmado.Picture.Graphic);
                end;
            end;
        end;

        Canvas.Font.Color := var_Color_Normal;
    end;
end;

procedure Tform_impuestos_001.Asignar_Impuesto_a_Composiciones;
var var_Registro      : TRecord_Rgtro_Comun;
    var_msg           : TStrings;
    var_record_Existe : Trecord_Existe;
begin
    var_msg := TStringList.Create;

    if Trim(DBEdit_Tanto_Por_Ciento.Text) <> '' then
    begin
        var_msg.Add('No se puede añadir una composición si ya el impuesto tiene %');
        UTI_GEN_Aviso(true, var_msg, 'Error.-', True, False);

        var_msg.Free;
        Exit;
    end;

    with form_impuestos_000.SQLQuery_Impuestos_Composiciones do
    begin
        if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
        begin
            var_Registro := Elegir_Impuesto(form_impuestos_000.SQLQuery_Impuestos.FieldByName('id').AsString);

            if var_Registro.id_1 <> '' then
            begin
                if Trim(var_Registro.descripcion_2) = '' then
                begin
                    var_msg.Add('No se puede añadir un impuesto que ya es un impuesto compuesto');
                    UTI_GEN_Aviso(true, var_msg, 'Error.-', True, False);

                    var_msg.Free;
                    Exit;
                end;

                var_record_Existe := Existe_Impuesto_Composicion_Ya( var_Registro.id_1,
                                                                     form_impuestos_000.SQLQuery_Impuestos.FieldByName('id').asString );

                if var_record_Existe.Fallo_en_Conexion_BD = true then
                begin
                end else begin
                    if var_record_Existe.Existe = false then
                    begin
                        if Asignar_Impuesto_a_Composiciones_2( var_Registro.id_1,
                                                               form_impuestos_000.SQLQuery_Impuestos.FieldByName('id').AsString ) = true then
                        begin
                            // ********************************************************************* //
                            // ** Si se consiguió asignar la subfamilia a la familia, lo que hace-** //
                            // ** mos es refrescar la tabla de subfamilias, buscar el registro re-** //
                            // ** cién creado y guardar los cambios realizados sobre el registro  ** //
                            // ** en el historico de cambios                                      ** //
                            // ********************************************************************* //
                            form_impuestos_000.Refrescar_Registros_Composiciones;


                            with form_impuestos_000.SQLQuery_Impuestos_Composiciones do
                            begin
                                 Locate( 'id_impuestos_al_que_pertenece;id_impuestos',
                                         VarArrayOf( [ form_impuestos_000.SQLQuery_Impuestos.FieldByName('id').Value,
                                                       StrToInt64(var_Registro.id_1) ] ),
                                         [] );
                            end;

                            with form_impuestos_000.SQLQuery_Impuestos do
                            begin
                                Cauto_Composicion_Y_Guardo_en_Historico_sus_Cambios( var_Registro.id_1,
                                                                                     form_impuestos_000.SQLQuery_Impuestos.FieldByName('id').asString,
                                                                                     var_Registro.descripcion_1 );
                            end;
                        end;
                    end else begin
                        var_msg.Clear;

                        var_msg.Add( 'Composición repetida.');

                        if UpperCase(var_record_Existe.deBaja) = 'S' then
                        begin
                            var_msg.Add(rs_Rgtro_Borrado);
                        end;

                        UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                    end;
                end;
            end;

        end;

        var_msg.Free;
    end;
end;

procedure Tform_impuestos_001.FormActivate(Sender: TObject);
begin
    If form_impuestos_000.public_Elegimos = true then
    begin
        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    Comprobar_No_Tocar(true, true);
end;

function Tform_impuestos_001.Comprobar_No_Tocar( param_Reproducir_Mensajes,
                                                 param_Ejecutar_No_Tocar : Boolean ) : Boolean;
begin
    Result := false;

    // ********************************************************************************************* //
    // ** Si se llamó para solo verlo, pues no se puede tocar                                     ** //
    // ********************************************************************************************* //
    if public_Solo_Ver = true then
    begin
        Result := true;
        if param_Ejecutar_No_Tocar = true then no_Tocar;
    end;
end;

function Tform_impuestos_001.Asignar_Impuesto_a_Composiciones_2( param_id_impuestos,
                                                                 param_id_impuestos_al_que_pertenece : ShortString ) : Boolean;
var var_SQL            : TStrings;
    var_SQLTransaction : TSQLTransaction;
    var_SQLConnector   : TSQLConnector;
    var_SQLQuery       : TSQLQuery;
    var_Fecha          : ShortString;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    Result := true;
    Try
      { ****************************************************************************
        Creamos la Transaccion y la conexión con el motor BD, y la abrimos
        **************************************************************************** }
        var_SQLTransaction := TSQLTransaction.Create(nil);
        var_SQLConnector   := TSQLConnector.Create(nil);

        if UTI_CN_Abrir( var_SQLTransaction,
                         var_SQLConnector ) = False then UTI_GEN_Salir;

      { ****************************************************************************
        Creamos la SQL Según el motor de BD
        **************************************************************************** }
        var_SQL := TStringList.Create;

        var_Fecha := UTI_GEN_Format_Fecha_Hora(UTI_CN_Fecha_Hora, true);

        var_SQL.Add( 'INSERT INTO impuestos_composiciones' );
        var_SQL.Add(      '( id_impuestos_al_que_pertenece,' );
        var_SQL.Add(        'id_impuestos,' );

        var_SQL.Add(        'Insert_WHEN,' );
        var_SQL.Add(        'Insert_Id_User )' );
        var_SQL.Add( 'VALUES' );
        var_SQL.Add(      '( '  + Trim(param_id_impuestos_al_que_pertenece) + ',' );
        var_SQL.Add(              Trim(param_id_impuestos) + ',' );

        var_SQL.Add(              UTI_GEN_Comillas(UTI_GEN_Format_Fecha_Hora(UTI_CN_Fecha_Hora, true)) + ',' );
        var_SQL.Add(              IntToStr(Form_Menu.public_User) + ' )' );

      { ****************************************************************************
        Abrimos la tabla
        **************************************************************************** }
        var_SQLQuery          := TSQLQuery.Create(nil);

        var_SQLQuery.Database := var_SQLConnector;
        var_SQLQuery.SQL.Text := var_SQL.Text;

        var_SQLQuery.Name     := 'SQLQuery_Asignar_Impuesto_a_Composiciones_2';


        var_SQLQuery.ExecSQL;
        var_SQLTransaction.Commit;


      { ****************************************************************************
        Destruimos la tabla y conexiones
        **************************************************************************** }
        var_SQLQuery.Free;
        var_SQL.Free;

      { ****************************************************************************
        Cerramos La transacción y la conexión con la BD
        **************************************************************************** }
        if UTI_CN_Cerrar( var_SQLTransaction,
                          var_SQLConnector ) = False then UTI_GEN_Salir;

        var_SQLTransaction.Free;
        var_SQLConnector.Free;
    Except
         on error : Exception do
         begin
             UTI_GEN_Error_Log( 'Error al CREAR la composición ' + Trim(param_id_impuestos) +
                                ' para el impuesto ' + Trim(param_id_impuestos_al_que_pertenece) +
                                '. La tabla ha sido ' + var_SQLQuery.Name + ' desde el módulo ' +
                                Screen.ActiveForm.Name,
                                error );
             try
                 var_SQL.Free;
                 var_SQLTransaction.Free;
                 var_SQLConnector.Free;
                 var_SQLQuery.Free;
             except
             end;

             Result := false
         end;
    end;
end;

procedure Tform_impuestos_001.Borrar_Impuesto_a_Composiciones;
var var_msg           : TStrings;
    var_Fue_Utilizado : ShortInt;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    { Esto es lo que habia antes

      Quitar_Impuesto_de_Composiciones;
      Abort; }

    if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
    begin
        with form_impuestos_000.SQLQuery_Impuestos do
        begin
            var_Fue_Utilizado := UTI_IMPTOS_Fue_Utilizado( FieldByName('id').AsString );
            if var_Fue_Utilizado = 0 then
            begin
                UTI_RGTRO_Borrar( 'impuestos_composiciones',
                                  form_impuestos_000.SQLQuery_Impuestos_Composiciones,
                                  public_Solo_Ver,
                                  public_Menu_Worked );
            end else begin
                var_msg := TStringList.Create;
                var_msg.Add('No se puede borrar');
                var_msg.Add(' ');

                if var_Fue_Utilizado = 1 then
                begin
                    var_msg.Add('Este impuesto fue usado ya, no podemos borrarle ninguna línea de su composición.');
                end else begin
                    var_msg.Add('No se pudo comprobar si está usado el impuesto.');
                end;

                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                var_msg.Free;
            end;
        end;
    end;
end;

end.


