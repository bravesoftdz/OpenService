unit users_001;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls, ButtonPanel, StdCtrls,
    sqldb, utilidades_general, Buttons, DBGrids, Grids, ExtCtrls, utilidades_usuarios, variants,
    utilidades_datos_tablas, utilidades_forms_Filtrar, utilidades_rgtro, utilidades_bd;

type

    { TForm_users_001 }

    TForm_users_001 = class(TForm)
      BitBtn_Filtrar: TBitBtn;
      BitBtn_Ver_Situacion_Permisos: TBitBtn;
      BitBtn_Ver_Situacion_Registro1: TBitBtn;
        BitBtn_Ver_Situacion_Registro_Passwords: TBitBtn;
        ButtonPanel1: TButtonPanel;
        DBCheckBox1: TDBCheckBox;
        DBComboBox1: TDBComboBox;
        DBEdit_eMail1: TDBEdit;
        DBEdit_Nick: TDBEdit;
        DBGrid_Menus: TDBGrid;
        DBGrid_Menus_Permisos: TDBGrid;
        DBGrid_Passwords: TDBGrid;
        DBNavigator_Menus: TDBNavigator;
        DBNavigator_Menus_Permisos: TDBNavigator;
        DBNavigator_Passwords: TDBNavigator;
        GroupBox11: TGroupBox;
        GroupBox_Modulos: TGroupBox;
        GroupBox_Passwords: TGroupBox;
        GroupBox_Permisos: TGroupBox;
        Label1: TLabel;
        Label12: TLabel;
        Label13: TLabel;
        Label2: TLabel;
        Label62: TLabel;
        Memo_Filtros: TMemo;
        Memo_OrderBy: TMemo;
        RadioGroup_Bajas: TRadioGroup;

        procedure Borrar_Registro_Menus_Permisos;
        procedure Borrar_Registro_Menus;
        procedure Borrar_Registro_Passwords;
        function  Comprobar_No_Tocar( param_Reproducir_Mensajes, param_Ejecutar_No_Tocar : Boolean ) : Boolean;
        procedure Editar_Registro_Passwords;
        procedure Editar_Registro_Menus;
        procedure Editar_Registro_Menus_Permisos;
        procedure FormCreate(Sender: TObject);
        procedure Preparar_Memo(param_Borramos_Filtro : Boolean);
        procedure BitBtn_FiltrarClick(Sender: TObject);
        procedure Insertar_Registro_Menus_Permisos;
        procedure BitBtn_Ver_Situacion_PermisosClick(Sender: TObject);
        procedure BitBtn_Ver_Situacion_Registro1Click(Sender: TObject);
        procedure DBGrid_Menus_PermisosDblClick(Sender: TObject);
        procedure DBGrid_Menus_PermisosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure DBGrid_MenusDblClick(Sender: TObject);
        procedure DBGrid_MenusDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure DBGrid_MenusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBGrid_Menus_PermisosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBNavigator_MenusBeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure DBNavigator_Menus_PermisosBeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure Presentar_Datos;
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure Refrescar_Registros;
        procedure Insertar_Registro_Passwords;
        procedure Insertar_Registro_Menus;
        procedure no_Tocar;

        procedure BitBtn_Ver_Situacion_Registro_PasswordsClick(Sender: TObject);
        procedure DBGrid_PasswordsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBNavigator_PasswordsBeforeAction(Sender: TObject; Button: TDBNavButtonType);

        procedure CancelButtonClick(Sender: TObject);
        procedure DBGrid_PasswordsDblClick(Sender: TObject);
        procedure DBGrid_PasswordsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure FormActivate(Sender: TObject);
        procedure para_Empezar;
        procedure OKButtonClick(Sender: TObject);
        procedure RadioGroup_BajasClick(Sender: TObject);
    private
        { private declarations }
        private_Salir_OK     : Boolean;
    public
        { public declarations }
        public_Solo_Ver      : Boolean;
        public_Menu_Worked   : Integer;
        public_Pulso_Aceptar : Boolean;
        public_Record_Rgtro  : TRecord_Rgtro_Comun;
    end;

var
    Form_users_001: TForm_users_001;

implementation

{$R *.lfm}

uses menu, users_000, users_002, users_003, users_004;

{ TForm_users_001 }

procedure TForm_users_001.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
    ButtonPanel1.SetFocus; // Con esto consigo que salga del campo que este y pueda actualizarlo

    var_msg := TStringList.Create;

    if public_Pulso_Aceptar = true then
    begin
        with Form_users_000.SQLQuery_Users do
        begin
            if Trim(DBEdit_Nick.Text) <> '' then
                 DBEdit_Nick.Text := AnsiUpperCase(Trim(DBEdit_Nick.Text))
            else var_msg.Add( '* El Nick.');

            if Trim(FieldByName('Tipo').AsString) = '' then var_msg.Add( '* El TIPO DE USUARIO.');
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
            if form_Menu.public_Salir_OK = False then CloseAction := caFree ;
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
                    UTI_GEN_Aviso(true, var_msg, 'FALTA POR COMPLETAR.-', True, False);
                    CloseAction := TCloseAction.caNone;
                end
            else
                begin
                    // var_msg.Free;
                    CloseAction := caFree;
                end;

        end;

    var_msg.Free;
end;

procedure TForm_users_001.OKButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := true;
end;

procedure TForm_users_001.CancelButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := false;
end;

procedure TForm_users_001.DBGrid_PasswordsDblClick(Sender: TObject);
begin
    Editar_Registro_Passwords;
end;

procedure TForm_users_001.DBGrid_PasswordsDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
var var_Color_Normal : TColor;
begin
    with Sender as TDBGrid do
    begin
        if Form_users_000.SQLQuery_Users_Passwords.RecordCount = 0 then Exit;

        var_Color_Normal := Canvas.Brush.Color;

      { ************************************************************************
        Primero comprobamos si es un registro dado de baja o no
        ************************************************************************ }
        if not Form_users_000.SQLQuery_Users_Passwords.FieldByName('Del_WHEN').IsNull then
            begin
              { ****************************************************************
                Registro DADO de BAJA
                **************************************************************** }
                Canvas.Font.Color := clSilver;
            end
        else
            begin
              { ****************************************************************
                Registro DADO de ALTA, NO BAJA
                ****************************************************************
                Así que las pinto, pero sólo si no son las columnas que van a
                ser dibujadas
                **************************************************************** }
                if State <> [gdSelected] then
                begin
                    if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
                    begin
                        Canvas.font.Color := clBlack;
                    end;
                end;
            end;

      { ************************************************************************
        Ahora paso a dibujar una celda normal con los colores elegidos o una
        dibujada
        ************************************************************************ }
        if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
            begin
              { ****************************************************************
                No es una de las columnas a dibujar por lo que la pinto con los
                colores elegidos
                **************************************************************** }
                DefaultDrawColumnCell(Rect, DataCol, Column, State)
            end
        else
            begin
              { ****************************************************************
                Es una de las columnas a dibujar
                **************************************************************** }
                // COLUMNA CONFIRMADA
                if Column.FieldName = 'COLUMNA_CON_IMAGEN'  then
                begin
                    {
                    if Trim(Form_users_000.SQLQuery_Users_Passwords.FieldByName('id_medio').asString) = '1' then
                    begin
                        Canvas.StretchDraw(param_Rect, Image_Confirmado.Picture.Graphic);
                    end;
                    }
                end;
            end;

        Canvas.Font.Color := var_Color_Normal;
    end;
end;

procedure TForm_users_001.DBGrid_PasswordsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then Editar_Registro_Passwords;
end;

procedure TForm_users_001.BitBtn_Ver_Situacion_Registro_PasswordsClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if form_users_000.SQLQuery_Users_Passwords.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'users_passwords', form_users_000.SQLQuery_Users_Passwords, form_users_000.DataSource_Users_Passwords, DBGrid_Passwords);
        end;
    end;
end;

procedure TForm_users_001.DBNavigator_PasswordsBeforeAction(Sender: TObject; Button: TDBNavButtonType);
begin
    case Button of
        nbInsert : begin
            Insertar_Registro_Passwords;
            Abort;
        end;

        nbEdit : begin
            Editar_Registro_Passwords;
            Abort;
        end;

        nbDelete : begin
            Borrar_Registro_Passwords;
            Abort;
        end;

        nbRefresh : begin
            form_users_000.Refrescar_Registros_Passwords;
            Abort;
        end;
    end;
end;

procedure TForm_users_001.no_Tocar;
begin
    DBEdit_Nick.Enabled := False;
end;

procedure TForm_users_001.DBGrid_MenusDblClick(Sender: TObject);
begin
    Editar_Registro_Menus;
end;

procedure TForm_users_001.BitBtn_Ver_Situacion_Registro1Click(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if form_users_000.SQLQuery_Users_Menus.RecordCount > 0 then UTI_RGTRO_Ver_Estado_Registro( 'users_menus', form_users_000.SQLQuery_Users_Menus, form_users_000.DataSource_Users_Menus, DBGrid_Menus );
    end;
end;

procedure TForm_users_001.DBGrid_Menus_PermisosDblClick(Sender: TObject);
begin
    Editar_Registro_Menus_Permisos;
end;

procedure TForm_users_001.DBGrid_MenusDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
var var_Color_Normal : TColor;
begin
    with Sender as TDBGrid do
    begin
        if Form_users_000.SQLQuery_Users_Menus.RecordCount = 0 then Exit;

        var_Color_Normal := Canvas.Brush.Color;

      { ************************************************************************
        Primero comprobamos si es un registro dado de baja o no
        ************************************************************************ }
        if not Form_users_000.SQLQuery_Users_Menus.FieldByName('Del_WHEN').IsNull then
            begin
              { ****************************************************************
                Registro DADO de BAJA
                **************************************************************** }
                Canvas.Font.Color := clSilver;
            end
        else
            begin
              { ****************************************************************
                Registro DADO de ALTA, NO BAJA
                ****************************************************************
                Así que las pinto, pero sólo si no son las columnas que van a
                ser dibujadas
                **************************************************************** }
                if State <> [gdSelected] then
                begin
                    if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
                    begin
                        Canvas.font.Color := clBlack;
                    end;
                end;
            end;

      { ************************************************************************
        Ahora paso a dibujar una celda normal con los colores elegidos o una
        dibujada
        ************************************************************************ }
        if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
            begin
              { ****************************************************************
                No es una de las columnas a dibujar por lo que la pinto con los
                colores elegidos
                **************************************************************** }
                DefaultDrawColumnCell(Rect, DataCol, Column, State)
            end
        else
            begin
              { ****************************************************************
                Es una de las columnas a dibujar
                **************************************************************** }
                // COLUMNA CONFIRMADA
                if Column.FieldName = 'COLUMNA_CON_IMAGEN'  then
                begin
                    {
                    if Trim(Form_users_000.SQLQuery_Users_Menus.FieldByName('id_medio').asString) = '1' then
                    begin
                        Canvas.StretchDraw(param_Rect, Image_Confirmado.Picture.Graphic);
                    end;
                    }
                end;
            end;

        Canvas.Font.Color := var_Color_Normal;
    end;
end;

procedure TForm_users_001.DBGrid_MenusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then Editar_Registro_Menus;
end;

procedure TForm_users_001.DBGrid_Menus_PermisosKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = 13 then Editar_Registro_Menus_Permisos;
end;

procedure TForm_users_001.DBNavigator_MenusBeforeAction(Sender: TObject; Button: TDBNavButtonType);
begin
    case Button of
        nbInsert : begin
            Insertar_Registro_Menus;
            Abort;
        end;

        nbEdit : begin
            Editar_Registro_Menus;
            Abort;
        end;

        nbDelete : begin
            Borrar_Registro_Menus;
            Abort;
        end;

        nbRefresh : begin
            form_users_000.Refrescar_Registros_Menus;
            Abort;
        end;
    end;
end;

procedure TForm_users_001.Presentar_Datos;
begin
    Memo_OrderBy.Lines.Text := 'um.Id_Users ASC, um.Id_Menus ASC';

    Preparar_Memo(true);
end;

procedure TForm_users_001.Preparar_Memo(param_Borramos_Filtro : Boolean);
var
  var_SQL_ADD : TStrings;
begin
  var_SQL_ADD := TStringList.Create;
  var_SQL_ADD.Clear;
  var_SQL_ADD.Add( 'um.Id_Users = ' + form_users_000.SQLQuery_Users.FieldByName('id').AsString );
  UTI_TB_SQL_ADD( param_Borramos_Filtro,
                  Memo_Filtros.Lines,
                  var_SQL_ADD );

  UTI_TB_Ver_Bajas_SN('um', Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);

  Memo_Filtros.Lines.Text := UTI_TB_Quitar_AndOr_Principio(Memo_Filtros.Lines.Text);

  var_SQL_ADD.Free;
end;

procedure TForm_users_001.DBGrid_Menus_PermisosDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
var var_Color_Normal : TColor;
begin
    with Sender as TDBGrid do
    begin
        if Form_users_000.SQLQuery_Users_Menus_Permisos.RecordCount = 0 then Exit;

        var_Color_Normal := Canvas.Brush.Color;

      { ************************************************************************
        Primero comprobamos si es un registro dado de baja o no
        ************************************************************************ }
        if not Form_users_000.SQLQuery_Users_Menus_Permisos.FieldByName('Del_WHEN').IsNull then
            begin
              { ****************************************************************
                Registro DADO de BAJA
                **************************************************************** }
                Canvas.Font.Color := clSilver;
            end
        else
            begin
              { ****************************************************************
                Registro DADO de ALTA, NO BAJA
                ****************************************************************
                Así que las pinto, pero sólo si no son las columnas que van a
                ser dibujadas
                **************************************************************** }
                if State <> [gdSelected] then
                begin
                    if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
                    begin
                        Canvas.font.Color := clBlack;
                    end;
                end;
            end;

      { ************************************************************************
        Ahora paso a dibujar una celda normal con los colores elegidos o una
        dibujada
        ************************************************************************ }
        if (Column.FieldName <> 'COLUMNA_CON_IMAGEN') then
            begin
              { ****************************************************************
                No es una de las columnas a dibujar por lo que la pinto con los
                colores elegidos
                **************************************************************** }
                DefaultDrawColumnCell(Rect, DataCol, Column, State)
            end
        else
            begin
              { ****************************************************************
                Es una de las columnas a dibujar
                **************************************************************** }
                // COLUMNA CONFIRMADA
                if Column.FieldName = 'COLUMNA_CON_IMAGEN'  then
                begin
                    {
                    if Trim(Form_users_000.SQLQuery_Users_Menus.FieldByName('id_medio').asString) = '1' then
                    begin
                        Canvas.StretchDraw(param_Rect, Image_Confirmado.Picture.Graphic);
                    end;
                    }
                end;
            end;

        Canvas.Font.Color := var_Color_Normal;
    end;
end;

procedure TForm_users_001.BitBtn_Ver_Situacion_PermisosClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if form_users_000.SQLQuery_Users_Menus_Permisos.RecordCount > 0 then
        begin
             UTI_RGTRO_Ver_Estado_Registro( 'users_menus_permissions', form_users_000.SQLQuery_Users_Menus_Permisos, form_users_000.DataSource_Users_Menus_Permisos, DBGrid_Menus_Permisos );
        end;
    end;
end;

procedure TForm_users_001.BitBtn_FiltrarClick(Sender: TObject);
begin
    RadioGroup_Bajas.ItemIndex := Form_users_000.Filtrar_users_menus( RadioGroup_Bajas.ItemIndex,
                                                                      true,
                                                                      Memo_Filtros.Lines,
                                                                      Memo_OrderBy.Lines );
end;

procedure TForm_users_001.Refrescar_Registros;
begin
    form_users_000.Refrescar_Registros_Passwords;
    form_users_000.Refrescar_Registros_Menus;
    // Refrescar_Registros_Menus_Permisos; NO HACE FALTA PORQUE LO HACE EL AFTER SCROLL DE LA TABLA DE MENUS
end;

procedure TForm_users_001.DBNavigator_Menus_PermisosBeforeAction(Sender: TObject;
    Button: TDBNavButtonType);
begin
    case Button of
        nbInsert : begin
            Insertar_Registro_Menus_Permisos;
            Abort;
        end;

        nbEdit : begin
            Editar_Registro_Menus_Permisos;
            Abort;
        end;

        nbDelete : begin
            Borrar_Registro_Menus_Permisos;
            Abort;
        end;

        nbRefresh : begin
            form_users_000.Refrescar_Registros_Menus_Permisos;
            Abort;
        end;
    end;
end;

procedure TForm_users_001.RadioGroup_BajasClick(Sender: TObject);
begin
    //UTI_TB_Ver_Bajas_SN('um', Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);
    Refrescar_Registros;
end;

procedure TForm_users_001.FormCreate(Sender: TObject);
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
    { **************************************************************************** }

    { ****************************************************************************
      Solo para formularios que traten con datos
      **************************************************************************** }
      public_Solo_Ver                      := false;
end;

procedure TForm_users_001.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    with form_users_000.SQLQuery_Users do
    begin
        public_Record_Rgtro := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                           '',
                                                           '',
                                                           FieldByName('Descripcion_Nick').AsString,
                                                           '',
                                                           '' );
    end;

    Presentar_Datos;
end;

procedure TForm_users_001.FormActivate(Sender: TObject);
begin
    If Form_users_000.public_Elegimos = true then
    begin
        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    Comprobar_No_Tocar(true, true);
end;

function TForm_users_001.Comprobar_No_Tocar( param_Reproducir_Mensajes,
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

procedure Tform_users_001.Editar_Registro_Passwords;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_Form                  : TForm_users_002;
  var_record_Existe         : Trecord_Existe;
  var_id                    : ShortString;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Passwords do
    begin
        var_msg := TStringList.Create;

        if (RecordCount > 0) and
           (Active = true)   then
            begin
                var_id := FieldByName('id').AsString;

                if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
                begin
                    if UTI_RGTRO_isLock( 'users_passwords',
                                         FieldByName('id').AsString,
                                         true ) = true then
                        begin
                            Exit;
                        end
                    else
                        begin
                            if UTI_RGTRO_Lock( 'users_passwords',
                                               FieldByName('id').AsString ) = true then
                                 Edit
                            else Exit;
                        end;

                    var_Form := TForm_users_002.Create(nil);

                    var_Form.public_Menu_Worked := public_Menu_Worked;

                    if public_Solo_Ver = true then
                    begin
                        var_Form.public_Solo_Ver := true;
                    end;

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                        begin
                            SetLength(var_Campos_para_Existe_ya, 1);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Password').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'Password';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_passwords',                   // param_nombre_tabla
                                                                      'ORDER BY users_passwords.Password', // param_order_by
                                                                      FieldByName('Id_Users').AsString,    // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );         // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    var_Form.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( form_users_000.SQLQuery_Users_Passwords ) = true then
                                               begin
                                                    FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                                    FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                                    UTI_RGTRO_Grabar_Antes( 'users_passwords',
                                                                            form_users_000.SQLQuery_Users_Passwords );
                                               end
                                            else Cancel;
                                            var_Form.Free;
                                        end
                                    else
                                        begin
                                            var_Form.Free;
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add( 'Contraseña repetida, pertenece al usuario ' +
                                                         Trim(var_record_Existe.OT_Descripcion_Nick) + '.');

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add('Y está dada de baja.');
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            var_Form.Free;
                            Cancel;
                        end;

                    UTI_RGTRO_UnLock( 'users_passwords',
                                      var_id );
                end;
            end
        else
            begin
                var_msg.Add(rs_no_Hay_Rgtros);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end;
    end;

    var_msg.Free;
end;

procedure Tform_users_001.Editar_Registro_Menus;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_record_Existe         : Trecord_Existe;
  var_id                    : ShortString;

begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Menus do
    begin
        var_msg := TStringList.Create;

        if (RecordCount > 0) and
           (Active = true)   then
            begin
                var_id := FieldByName('id').AsString;

                if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
                begin
                    if UTI_RGTRO_isLock( 'users_menus',
                                         FieldByName('id').AsString,
                                         true ) = true then
                    begin
                        Exit;
                    end else begin
                        if UTI_RGTRO_Lock( 'users_menus',
                                     FieldByName('id').AsString ) = true then
                             Edit
                        else Exit;
                    end;

                    Application.CreateForm(TForm_users_003, Form_users_003);

                    Form_users_003.public_Menu_Worked := public_Menu_Worked;

                    if public_Solo_Ver = true then
                    begin
                        Form_users_003.public_Solo_Ver := true;
                    end;

                    Form_users_003.para_Empezar;

                    Form_users_003.ShowModal;
                    if Form_users_003.public_Pulso_Aceptar = true then
                        begin
                            SetLength(var_Campos_para_Existe_ya, 2);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Id_Users').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'Id_Users';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_Campos_para_Existe_ya[1].Campo_Valor  := FieldByName('Id_Menus').AsString;
                            var_Campos_para_Existe_ya[1].Campo_Nombre := 'Id_Menus';
                            var_Campos_para_Existe_ya[1].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_menus',                      // param_nombre_tabla
                                                                      'ORDER BY users_menus.Id_Users, ' +
                                                                               'users_menus.id_Menus',    // param_order_by
                                                                      FieldByName('Id').AsString,         // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );        // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    Form_users_003.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( form_users_000.SQLQuery_Users_Menus ) = true then
                                               begin
                                                    FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                                    FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                                    UTI_RGTRO_Grabar_Antes( 'users_menus',
                                                                            form_users_000.SQLQuery_Users_Menus );
                                               end
                                            else Cancel;

                                            Form_users_003.Free;
                                        end
                                    else
                                        begin
                                            Form_users_003.Free;
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add('Menu repetido.');

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add('Y está dado de baja.');
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            Form_users_003.Free;
                            Cancel;
                        end;

                    UTI_RGTRO_UnLock( 'users_menus',
                                      var_id );
                end;
            end
        else
            begin
                var_msg.Add(rs_no_Hay_Rgtros);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end;
    end;
    var_msg.Free;
end;

procedure Tform_users_001.Editar_Registro_Menus_Permisos;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_Form                  : TForm_users_004;
  var_record_Existe         : Trecord_Existe;
  var_id                    : ShortString;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Menus_Permisos do
    begin
        var_msg := TStringList.Create;

        if (RecordCount > 0) and
           (Active = true)   then
            begin
                var_id := FieldByName('id').AsString;

                if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
                begin
                    if UTI_RGTRO_isLock( 'users_menus_permissions',
                                         FieldByName('id').AsString,
                                         true ) = true then

                        begin
                            Exit;
                        end
                    else
                        begin
                            if UTI_RGTRO_Lock( 'users_menus_permissions',
                                               FieldByName('id').AsString ) = true then
                                 Edit
                            else Exit;
                        end;

                    var_Form := TForm_users_004.Create(nil);

                    var_Form.public_Menu_Worked := public_Menu_Worked;

                    if public_Solo_Ver = true then
                    begin
                        var_Form.public_Solo_Ver := true;
                    end;

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                        begin
                            SetLength(var_Campos_para_Existe_ya, 3);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Id_Users').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'Id_Users';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_Campos_para_Existe_ya[1].Campo_Valor  := FieldByName('Id_Menus').AsString;
                            var_Campos_para_Existe_ya[1].Campo_Nombre := 'Id_Menus';
                            var_Campos_para_Existe_ya[1].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_Campos_para_Existe_ya[2].Campo_Valor  := FieldByName('Tipo_CRUD').AsString;
                            var_Campos_para_Existe_ya[2].Campo_Nombre := 'Tipo_CRUD';
                            var_Campos_para_Existe_ya[2].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_menus_permissions',                      // param_nombre_tabla
                                                                      'ORDER BY users_menus_permissions.Id_Users, ' +
                                                                               'users_menus_permissions.id_Menus, ' +
                                                                               'users_menus_permissions.Tipo_CRUD',   // param_order_by
                                                                      FieldByName('Id').AsString,                     // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );                    // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    var_Form.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( form_users_000.SQLQuery_Users_Menus_Permisos ) = true then
                                               begin
                                                    FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                                    FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                                    UTI_RGTRO_Grabar_Antes( 'users_menus_permissions',
                                                                            form_users_000.SQLQuery_Users_Menus_Permisos );
                                               end
                                            else Cancel;
                                            var_Form.Free;
                                        end
                                    else
                                        begin
                                            var_Form.Free;
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add('Permiso repetido para el menú elegido.');

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add('Y está dado de baja.');
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            var_Form.Free;
                            Cancel;
                        end;

                    UTI_RGTRO_UnLock( 'users_menus_permissions',
                                      var_id );
                end;
            end
        else
            begin
                var_msg.Add(rs_no_Hay_Rgtros);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end;
    end;
    var_msg.Free;
end;

procedure TForm_users_001.Insertar_Registro_Passwords;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_Form                  : TForm_users_002;
  var_record_Existe         : Trecord_Existe;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Passwords do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
        begin
            if public_Solo_Ver = True then
                begin
                    var_msg.Clear;
                    var_msg.Add(rs_Solo_Visualizar);
                    UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                end
            else
                begin
                    Insert;

                    FieldByName('Id_Users').AsString           := form_users_000.SQLQuery_Users.FieldByName('Id').AsString;
                    FieldByName('Password_Expira_SN').AsString := 'S';
                    FieldByName('Obligado_NICK_SN').AsString   := 'S';

                    var_Form := TForm_users_002.Create(nil);

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                        begin
                            var_Form.Free;

                            SetLength(var_Campos_para_Existe_ya, 1);

                            var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Password').AsString;
                            var_Campos_para_Existe_ya[0].Campo_Nombre := 'Password';
                            var_Campos_para_Existe_ya[0].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                            var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_passwords',                   // param_nombre_tabla
                                                                      'ORDER BY users_passwords.Password', // param_order_by
                                                                      '',                                  // param_id_a_no_traer ... Estoy insertando
                                                                      var_Campos_para_Existe_ya );         // param_Campos_para_Existe_ya

                            if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    // var_Form.Free;
                                    Cancel;
                                end
                            else
                                begin
                                    if var_record_Existe.Existe = false then
                                        begin
                                            FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                                            FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                                            UTI_RGTRO_Grabar_Antes( 'users_passwords',
                                                                    form_users_000.SQLQuery_Users_Passwords );
                                        end
                                    else
                                        begin
                                            Cancel;
                                            var_msg.Clear;
                                            var_msg.Add('Contraseña repetida, pertenece al usuario ' + Trim(var_record_Existe.OT_Descripcion_Nick) + '.');

                                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                                            begin
                                                var_msg.Add('Y está dada de baja.');
                                            end;

                                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                        end;
                                end;
                        end
                    else
                        begin
                            var_Form.Free;
                            Cancel;
                        end;
                end;
        end;

        var_msg.Free;
    end;
end;

procedure TForm_users_001.Insertar_Registro_Menus;
var
  var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
  var_msg                   : TStrings;
  var_Form                  : TForm_users_003;
  var_record_Existe         : Trecord_Existe;

begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Menus do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
        begin
            if UpperCase(Trim(form_users_000.SQLQuery_Users.FieldByName('Permiso_Total_SN').AsString)) = 'S' then
            begin
                var_msg.Clear;
                var_msg.Add('El usuario tiene permisos totales, no hace falta crearle los menús/permisos a los que tiene puede entrar.');
                UTI_GEN_Aviso(true, var_msg, 'YA TIENE PERMISOS TOTALES', True, False);
            end else begin
                if public_Solo_Ver = True then
                begin
                    var_msg.Clear;
                    var_msg.Add(rs_Solo_Visualizar);
                    UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                end else begin
                    Insert;

                    FieldByName('Id_Users').AsString                := form_users_000.SQLQuery_Users.FieldByName('id').AsString;
                    FieldByName('Forcing_Why_Delete').AsString      := 'S';
                    FieldByName('Modulo_Permiso_Total_SN').AsString := 'S';

                    var_Form := TForm_users_003.Create(nil);

                    var_Form.para_Empezar;

                    var_Form.ShowModal;
                    if var_Form.public_Pulso_Aceptar = true then
                    begin
                        var_Form.Free;

                        SetLength(var_Campos_para_Existe_ya, 2);

                        var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Id_Users').AsString;
                        var_Campos_para_Existe_ya[0].Campo_Nombre := 'Id_Users';
                        var_Campos_para_Existe_ya[0].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                        var_Campos_para_Existe_ya[1].Campo_Valor  := FieldByName('Id_Menus').AsString;
                        var_Campos_para_Existe_ya[1].Campo_Nombre := 'Id_Menus';
                        var_Campos_para_Existe_ya[1].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                        var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_menus',                      // param_nombre_tabla
                                                                  'ORDER BY users_menus.Id_Users, ' +
                                                                           'users_menus.id_Menus',    // param_order_by
                                                                  '',                                 // param_id_a_no_traer ... Estoy insertando
                                                                  var_Campos_para_Existe_ya );        // param_Campos_para_Existe_ya

                        if var_record_Existe.Fallo_en_Conexion_BD = true then
                        begin
                            // var_Form.Free;
                            Cancel;
                        end else begin
                            if var_record_Existe.Existe = false then
                            begin
                                FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                                FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                                UTI_RGTRO_Grabar_Antes( 'users_menus',
                                                        form_users_000.SQLQuery_Users_Menus );
                            end else begin
                                Cancel;
                                var_msg.Clear;
                                var_msg.Add('Menu repetido.');

                                if UpperCase(var_record_Existe.deBaja) = 'S' then
                                begin
                                    var_msg.Add('Y está dado de baja.');
                                end;

                                UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                            end;
                        end;
                    end else begin
                        var_Form.Free;
                        Cancel;
                    end;
                end;
            end;
        end;

        var_msg.Free;
    end;
end;

procedure TForm_users_001.Insertar_Registro_Menus_Permisos;
var
    var_Campos_para_Existe_ya : Array of TCampos_para_Existe_ya;
    var_msg                   : TStrings;
    var_Form                  : TForm_users_004;
    var_record_Existe         : Trecord_Existe;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_users_000.SQLQuery_Users_Menus_Permisos do
    begin
        var_msg := TStringList.Create;

        if form_users_000.SQLQuery_Users_Menus.RecordCount > 0 then
        begin
            if UpperCase(Trim(form_users_000.SQLQuery_Users.FieldByName('Permiso_Total_SN').AsString)) = 'S' then
            begin
                var_msg.Clear;
                var_msg.Add('El usuario tiene permisos totales, no hace falta crearle los menús/permisos a los que tiene puede entrar.');
                UTI_GEN_Aviso(true, var_msg, 'YA TIENE PERMISOS TOTALES', True, False);
            end else begin
                if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
                begin
                    if UpperCase(Trim(form_users_000.SQLQuery_Users_Menus.FieldByName('Modulo_Permiso_Total_SN').AsString)) = 'S' then
                    begin
                        var_msg.Clear;
                        var_msg.Add('El módulo/menú tiene permisos totales, no se pueden crear permisos parciales para él.');
                        UTI_GEN_Aviso(true, var_msg, 'YA TIENE PERMISOS TOTALES', True, False);
                    end else begin
                        if public_Solo_Ver = True then
                        begin
                            var_msg.Clear;
                            var_msg.Add(rs_Solo_Visualizar);
                            UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
                        end else begin
                            Insert;

                            FieldByName('Id_Users').AsString  := form_users_000.SQLQuery_Users_Menus.FieldByName('Id_Users').AsString;
                            FieldByName('Id_Menus').AsString  := form_users_000.SQLQuery_Users_Menus.FieldByName('Id_Menus').AsString;
                            FieldByName('PermisoSN').AsString := 'S';

                            var_Form := TForm_users_004.Create(nil);

                            var_Form.para_Empezar;

                            var_Form.ShowModal;
                            if var_Form.public_Pulso_Aceptar = true then
                            begin
                                var_Form.Free;

                                SetLength(var_Campos_para_Existe_ya, 3);

                                var_Campos_para_Existe_ya[0].Campo_Valor  := FieldByName('Id_Users').AsString;
                                var_Campos_para_Existe_ya[0].Campo_Nombre := 'Id_Users';
                                var_Campos_para_Existe_ya[0].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                                var_Campos_para_Existe_ya[1].Campo_Valor  := FieldByName('Id_Menus').AsString;
                                var_Campos_para_Existe_ya[1].Campo_Nombre := 'Id_Menus';
                                var_Campos_para_Existe_ya[1].Campo_Tipo   := 0; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                                var_Campos_para_Existe_ya[2].Campo_Valor  := FieldByName('Tipo_CRUD').AsString;
                                var_Campos_para_Existe_ya[2].Campo_Nombre := 'Tipo_CRUD';
                                var_Campos_para_Existe_ya[2].Campo_Tipo   := 1; // 0: Numerico, 1: String, 2:Fecha ó Fecha+Hora, 3:Hora

                                var_record_Existe := UTI_RGTRO_Existe_Ya( 'users_menus_permissions',                      // param_nombre_tabla
                                                                          'ORDER BY users_menus_permissions.Id_Users, ' +
                                                                                   'users_menus_permissions.id_Menus, ' +
                                                                                   'users_menus_permissions.Tipo_CRUD',   // param_order_by
                                                                          '',                                 // param_id_a_no_traer ... Estoy insertando
                                                                          var_Campos_para_Existe_ya );        // param_Campos_para_Existe_ya

                                if var_record_Existe.Fallo_en_Conexion_BD = true then
                                begin
                                    // var_Form.Free;
                                    Cancel;
                                end else begin
                                    if var_record_Existe.Existe = false then
                                    begin
                                        FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                                        FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                                        UTI_RGTRO_Grabar_Antes( 'users_menus_permissions',
                                                                form_users_000.SQLQuery_Users_Menus_Permisos );
                                    end else begin
                                        Cancel;
                                        var_msg.Clear;
                                        var_msg.Add('Permiso repetido para el menú elegido.');

                                        if UpperCase(var_record_Existe.deBaja) = 'S' then
                                        begin
                                            var_msg.Add('Y está dado de baja.');
                                        end;

                                        UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                                    end;
                                end;
                            end else begin
                                var_Form.Free;
                                Cancel;
                            end;
                        end;
                    end;
                end;
            end;
        end else begin
            var_msg.Clear;
            var_msg.Add('No tiene ninguna autorización.');
            UTI_GEN_Aviso(true, var_msg, 'NO EXISTE.-', True, False);
        end;

        var_msg.Free;
    end;
end;

procedure TForm_users_001.Borrar_Registro_Passwords;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
    begin
        UTI_RGTRO_Borrar( 'users_passwords',
                          form_users_000.SQLQuery_Users_Passwords,
                          public_Solo_Ver,
                          public_Menu_Worked );
    end;
end;

procedure TForm_users_001.Borrar_Registro_Menus;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
    begin
        UTI_RGTRO_Borrar( 'users_menus',
                          form_users_000.SQLQuery_Users_Menus,
                          public_Solo_Ver,
                          public_Menu_Worked );
    end;
end;

procedure TForm_users_001.Borrar_Registro_Menus_Permisos;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
    begin
        UTI_RGTRO_Borrar( 'users_menus_permissions',
                          form_users_000.SQLQuery_Users_Menus_Permisos,
                          public_Solo_Ver,
                          public_Menu_Worked );
    end;
end;

end.


