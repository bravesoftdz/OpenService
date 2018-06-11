unit proveedores_001;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, ButtonPanel, db,
    utilidades_usuarios, utilidades_forms_Filtrar, StdCtrls, DbCtrls, Buttons, DBGrids, ComCtrls,
    utilidades_contabilidad, utilidades_bd, sqldb, utilidades_rgtro, utilidades_general, EditBtn,
    utilidades_datos_tablas, Grids;

type

    { Tform_proveedores_001 }

    Tform_proveedores_001 = class(TForm)
      BitBtn_eMAIL1: TBitBtn;
        BitBtn_SMS: TBitBtn;
        BitBtn_eMail: TBitBtn;
        BitBtn_Ver_Situacion_Registro_Contactos: TBitBtn;
        Boton_Elegir_Agencia_Transporte: TBitBtn;
        Boton_Elegir_Cta_Bco_Pais: TBitBtn;
        Boton_Elegir_Cta_Bco_Poblacion: TBitBtn;
        Boton_Elegir_Cta_Bco_Provincia: TBitBtn;
        Boton_Elegir_Forma_Pago: TBitBtn;
        Boton_Elegir_Pais: TBitBtn;
        Boton_Elegir_Pais1: TBitBtn;
        Boton_Elegir_Poblacion: TBitBtn;
        Boton_Elegir_Proveedor_Tipo: TBitBtn;
        Boton_Elegir_Actividad: TBitBtn;
        Boton_Elegir_Provincia: TBitBtn;
        Boton_Elegir_Provincia1: TBitBtn;
        ButtonPanel1: TButtonPanel;
        DateEdit_Cta_Bco_Mandato_Fecha_de_Firma: TDateEdit;
        DBCheckBox_IVA_con_Recargo_SN: TDBCheckBox;
        DBCheckBox_IVA_Excluido_SN: TDBCheckBox;
        DBCheckBox_Vencimientos_automaticos_SN: TDBCheckBox;
        DBEdit_Cta_Bco_BIC_SWIFT: TDBEdit;
        DBEdit_Cta_Bco_Cuenta: TDBEdit;
        DBEdit_Cta_Bco_Digito_Control: TDBEdit;
        DBEdit_Cta_Bco_Entidad: TDBEdit;
        DBEdit_Cta_Bco_IBAN: TDBEdit;
        DBEdit_Cta_Bco_Mandato_Ref: TDBEdit;
        DBEdit_Cta_Bco_Sucursal: TDBEdit;
        DBEdit_Cuenta_Contable: TDBEdit;
        DBEdit_DBEdit_Cta_Bco_Direccion: TDBEdit;
        DBEdit_DBEdit_Cta_Bco_Direccion_Codigo_Postal: TDBEdit;
        DBEdit_DBEdit_Cta_Bco_Direccion_Numero: TDBEdit;
        DBEdit_DBEdit_Cta_Bco_Direccion_Piso_Letra: TDBEdit;
        DBEdit_Descuento_Comercial_1: TDBEdit;
        DBEdit_Descuento_Comercial_2: TDBEdit;
        DBEdit_Descuento_Final: TDBEdit;
        DBEdit_Descuento_Linea: TDBEdit;
        DBEdit_Descuento_Pronto_Pago: TDBEdit;
        DBEdit_eMail: TDBEdit;
        DBEdit_eMail1: TDBEdit;
        DBEdit_Forma_pago_Dia_1: TDBEdit;
        DBEdit_Forma_pago_Dia_2: TDBEdit;
        DBEdit_Forma_pago_Vacaciones_Dia_Fin: TDBEdit;
        DBEdit_Forma_pago_Vacaciones_Dia_Inicio: TDBEdit;
        DBEdit_Forma_pago_Vacaciones_Mes_Fin: TDBEdit;
        DBEdit_Forma_pago_Vacaciones_Mes_Inicio: TDBEdit;
        DBEdit_Nombre_RazonSocial: TDBEdit;
        DBEdit_Codigo_Postal: TDBEdit;
        DBEdit_Direccion: TDBEdit;
        DBEdit_Direccion_Numero: TDBEdit;
        DBEdit_Direccion_Piso_Letra: TDBEdit;
        DBEdit_FAX: TDBEdit;
        DBEdit_Movil: TDBEdit;
        DBEdit_NIF_CIF: TDBEdit;
        DBEdit_Nombre_Comercial: TDBEdit;
        DBEdit_Pagina_Web: TDBEdit;
        DBEdit_Retencion: TDBEdit;
        DBEdit_Tfno_Fijo_1: TDBEdit;
        DBEdit_Tfno_Fijo_2: TDBEdit;
        DBGrid_Contactos: TDBGrid;
        DBMemo_Observaciones_Comentarios: TDBMemo;
        DBNavigator_Contactos: TDBNavigator;
        Edit_Cta_Bco_Descripcion_Pais: TEdit;
        Edit_Cta_Bco_Descripcion_Poblacion: TEdit;
        Edit_Cta_Bco_Descripcion_Provincia: TEdit;
        Edit_Descripcion_Agencia_Transporte: TEdit;
        Edit_Descripcion_Forma_Pago: TEdit;
        Edit_Descripcion_Pais: TEdit;
        Edit_Descripcion_Poblacion: TEdit;
        Edit_Descripcion_Proveedor_Tipo: TEdit;
        Edit_Descripcion_Actividad: TEdit;
        Edit_Descripcion_Provincia: TEdit;
        Edit_Movil_agencia_transporte: TEdit;
        Edit_Tfno_Fijo_1_agencia_transporte: TEdit;
        GroupBox1: TGroupBox;
        GroupBox11: TGroupBox;
        GroupBox3: TGroupBox;
        GroupBox4: TGroupBox;
        GroupBox6: TGroupBox;
        GroupBox7: TGroupBox;
        GroupBox_Descuentos: TGroupBox;
        GroupBox_Internet: TGroupBox;
        GroupBox_Contactos: TGroupBox;
        GroupBox_Regimen_IVA: TGroupBox;
        Label1: TLabel;
        Label10: TLabel;
        Label11: TLabel;
        Label12: TLabel;
        Label13: TLabel;
        Label14: TLabel;
        Label15: TLabel;
        Label16: TLabel;
        Label17: TLabel;
        Label18: TLabel;
        Label19: TLabel;
        Label2: TLabel;
        Label20: TLabel;
        Label22: TLabel;
        Label24: TLabel;
        Label25: TLabel;
        Label26: TLabel;
        Label27: TLabel;
        Label28: TLabel;
        Label29: TLabel;
        Label3: TLabel;
        Label30: TLabel;
        Label31: TLabel;
        Label32: TLabel;
        Label33: TLabel;
        Label34: TLabel;
        Label35: TLabel;
        Label36: TLabel;
        Label37: TLabel;
        Label38: TLabel;
        Label39: TLabel;
        Label4: TLabel;
        Label40: TLabel;
        Label41: TLabel;
        Label42: TLabel;
        Label44: TLabel;
        Label45: TLabel;
        Label46: TLabel;
        Label47: TLabel;
        Label5: TLabel;
        Label50: TLabel;
        Label51: TLabel;
        Label52: TLabel;
        Label53: TLabel;
        Label54: TLabel;
        Label55: TLabel;
        Label56: TLabel;
        Label57: TLabel;
        Label58: TLabel;
        Label59: TLabel;
        Label6: TLabel;
        Label60: TLabel;
        Label61: TLabel;
        Label62: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        Label_Fecha1: TLabel;
        PageControl_Otros_Datos: TPageControl;
        Panel_Observaciones: TPanel;
        RadioGroup_Bajas: TRadioGroup;
        TabSheet2: TTabSheet;
        TabSheet_DatosAdicionales: TTabSheet;

        procedure Comprobar_Resto_Datos_Poblacion(param_id : String);
        procedure Borrar_Registro_Contactos;
        function  Comprobar_No_Tocar( param_Reproducir_Mensajes, param_Ejecutar_No_Tocar : Boolean ) : Boolean;
        procedure BitBtn_eMailClick(Sender: TObject);
        procedure Boton_Elegir_ActividadClick(Sender: TObject);
        procedure Edit_Descripcion_ActividadClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        function  Elegir_Proveedor(param_id_no_aparecer : ShortString) : TRecord_Rgtro_Comun;
        procedure Insertar_Registro_Contactos;
        procedure Editar_Registro_Contactos;
        procedure RadioGroup_BajasClick(Sender: TObject);
        function  Existe_Proveedor_Contacto_Ya( param_Id, param_nombre : String ) : Trecord_Existe;
        procedure BitBtn_Ver_Situacion_Registro_ContactosClick(Sender: TObject);
        procedure Boton_Elegir_Agencia_TransporteClick(Sender: TObject);
        procedure DBGrid_ContactosDblClick(Sender: TObject);
        procedure DBGrid_ContactosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
        procedure DBGrid_ContactosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure DBNavigator_ContactosBeforeAction(Sender: TObject; Button: TDBNavButtonType);
        procedure Edit_Descripcion_Agencia_TransporteClick(Sender: TObject);
        procedure Refrescar_Registros;
        procedure BitBtn_SMSClick(Sender: TObject);
        procedure Comprobar_Vencimientos(param_msg : TStrings);
        procedure Presentar_Datos;
        procedure no_Tocar;
        procedure Boton_Elegir_Cta_Bco_PaisClick(Sender: TObject);
        procedure Boton_Elegir_Cta_Bco_PoblacionClick(Sender: TObject);
        procedure Boton_Elegir_Cta_Bco_ProvinciaClick(Sender: TObject);
        procedure Boton_Elegir_Forma_PagoClick(Sender: TObject);
        procedure Boton_Elegir_PaisClick(Sender: TObject);
        procedure Boton_Elegir_PoblacionClick(Sender: TObject);
        procedure Boton_Elegir_Proveedor_TipoClick(Sender: TObject);
        procedure Boton_Elegir_ProvinciaClick(Sender: TObject);
        procedure CancelButtonClick(Sender: TObject);
        procedure Comprobar_Toda_Fecha_Hora( param_msg : TStrings );
        procedure Actualizar_Campos_Fecha_Hora_Si_Completado( param_msg : TStrings );
        procedure Edit_Cta_Bco_Descripcion_PaisClick(Sender: TObject);
        procedure Edit_Cta_Bco_Descripcion_PoblacionClick(Sender: TObject);
        procedure Edit_Cta_Bco_Descripcion_ProvinciaClick(Sender: TObject);
        procedure Edit_Descripcion_Forma_PagoClick(Sender: TObject);
        procedure Edit_Descripcion_PaisClick(Sender: TObject);
        procedure Edit_Descripcion_PoblacionClick(Sender: TObject);
        procedure Edit_Descripcion_Proveedor_TipoClick(Sender: TObject);
        procedure Edit_Descripcion_ProvinciaClick(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure para_Empezar;
        procedure OKButtonClick(Sender: TObject);

    private
        { private declarations }
        private_Salir_OK          : Boolean;
        private_Cta_Ctble_elegida : String;

        procedure Traer_poblacion_xID( param_id : String; param_SQLTransaction : TSQLTransaction; param_SQLConnector : TSQLConnector; param_SQLQuery : TSQLQuery );

    public
        { public declarations }
        public_Solo_Ver      : Boolean;
        public_Menu_Worked   : Integer;
        public_Pulso_Aceptar : Boolean;
        public_Record_Rgtro  : TRecord_Rgtro_Comun;
    end;

var
    form_proveedores_001: Tform_proveedores_001;

implementation

{$R *.lfm}

uses menu, proveedores_000, proveedores_002, proveedores_004;

{ Tform_proveedores_001 }

procedure Tform_proveedores_001.OKButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := true;
end;

procedure Tform_proveedores_001.Comprobar_Toda_Fecha_Hora( param_msg : TStrings );
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

procedure Tform_proveedores_001.CancelButtonClick(Sender: TObject);
begin
    private_Salir_OK     := True;
    public_Pulso_Aceptar := false;
end;

procedure Tform_proveedores_001.Actualizar_Campos_Fecha_Hora_Si_Completado( param_msg : TStrings );
var var_Fecha_Hora : ShortString;
begin
    WITH form_proveedores_000.SQLQuery_Proveedores DO
    BEGIN
      { ********************************************************************************************
        ** FECHA DE FIRMA DEL MANDATO DE DATOS BANCARIOS                                          **
        ******************************************************************************************** }
        var_Fecha_Hora := '';
        if DateEdit_Cta_Bco_Mandato_Fecha_de_Firma.Text <> '  /  /    ' then
        begin
             var_Fecha_Hora := DateEdit_Cta_Bco_Mandato_Fecha_de_Firma.Text;
        end;

      { ********************************************************************************************
        ** Por si tiene control de hora                                                           **
        ********************************************************************************************
        if MaskEdit_Hora_Inicio.Text <> '  :  :  '     then
        begin
            if var_Fecha_Hora <> '' then
                 var_Fecha_Hora := var_Fecha_Hora + ' ' + MaskEdit_Hora_Inicio.Text
            else var_Fecha_Hora := MaskEdit_Hora_Inicio.Text;
        end; }

        Try
            if var_Fecha_Hora <> '' then
                   begin
                     FieldByName('Cta_Bco_Mandato_Fecha_de_Firma').AsString := var_Fecha_Hora;
                end
            else
                begin
                    FieldByName('Cta_Bco_Mandato_Fecha_de_Firma').Clear;
                end;
        Except
            param_msg.Add('** ERROR en el campo FECHA DE FIRMA del mandato de los datos bancarios **');
        end;
    END;
end;

procedure Tform_proveedores_001.Boton_Elegir_PaisClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Paises( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_paises').AsString := Trim(var_Registro.id_1);
             Edit_Descripcion_Pais.Text        := var_Registro.descripcion_1;
        end;
    end;
end;

procedure Tform_proveedores_001.Boton_Elegir_ProvinciaClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Provincias( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_provincias').AsString := Trim(var_Registro.id_1);
             FieldByName('id_paises').AsString     := Trim(var_Registro.id_2);
             Edit_Descripcion_Provincia.Text       := var_Registro.descripcion_1;
             Edit_Descripcion_Pais.Text            := var_Registro.descripcion_2;
        end;
    end;
end;

procedure Tform_proveedores_001.Boton_Elegir_PoblacionClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Poblaciones( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_poblaciones').AsString := Trim(var_Registro.id_1);
             FieldByName('id_provincias').AsString  := Trim(var_Registro.id_2);
             FieldByName('id_paises').AsString      := Trim(var_Registro.id_3);

             Edit_Descripcion_Poblacion.Text        := var_Registro.descripcion_1;
             Edit_Descripcion_Provincia.Text        := var_Registro.descripcion_2;
             Edit_Descripcion_Pais.Text             := var_Registro.descripcion_3;

             Comprobar_Resto_Datos_Poblacion( Trim(var_Registro.id_1) );
        end;
    end;
end;

procedure Tform_proveedores_001.Traer_poblacion_xID( param_id : String;
                                                     param_SQLTransaction : TSQLTransaction;
                                                     param_SQLConnector : TSQLConnector;
                                                     param_SQLQuery : TSQLQuery );
begin
    // ********************************************************************************************* //
    // ** Abrimos la Transaccion y la conexión con el motor BD                                    ** //
    // ********************************************************************************************* //
    if UTI_CN_Connector_Open( param_SQLTransaction,
                              param_SQLConnector ) = false then UTI_GEN_Salir;

    // ********************************************************************************************* //
    // ** Al SQLQuery le pasamos el SQLConnector                                                  ** //
    // ********************************************************************************************* //
    param_SQLQuery.Name     := 'SQLQuery_Traer_poblacion_xID';
    param_SQLQuery.Database := param_SQLConnector;

    // ********************************************************************************************* //
    // ** Creamos la SQL                                                                          ** //
    // ********************************************************************************************* //
    param_SQLQuery.SQL.Clear;
    param_SQLQuery.SQL.AddStrings( 'SELECT pb.*,' + ' ' +
                                          'pr.descripcion AS OT_descripcion_provincia,' + ' ' +
                                          'ps.descripcion AS OT_descripcion_pais' + ' ' +
                                   'FROM poblaciones AS pb' + ' ' +

                                   'LEFT JOIN provincias AS pr' + ' ' +
                                   'ON pb.id_provincias = pr.id' + ' ' +

                                   'LEFT JOIN paises AS ps' + ' ' +
                                   'ON pb.id_paises = ps.id' + ' ' );

    // ********************************************************************************************* //
    // ** Continuamos con la confección de la SQL                                                 ** //
    // ********************************************************************************************* //
    param_SQLQuery.SQL.Add( 'WHERE pb.id = ' + Trim(param_id) );
    param_SQLQuery.SQL.Add( 'ORDER BY pb.id ASC' );

    // ********************************************************************************************* //
    // ** Abrimos la Query                                                                        ** //
    // ********************************************************************************************* //
    if UTI_TB_Query_Open( '', '', '',
                          param_SQLConnector,
                          param_SQLQuery,
                          -1, // asi me trae todos los registros de golpe
                          param_SQLQuery.SQL.Text ) = false then UTI_GEN_Salir;
end;

procedure Tform_proveedores_001.Comprobar_Resto_Datos_Poblacion(param_id : String);
var var_SQLTransaction : TSQLTransaction;
    var_SQLConnector   : TSQLConnector;
    var_SQLQuery       : TSQLQuery;
begin
    try
        // ***************************************************************************************** //
        // ** Creamos la Transaccion y la conexión con el motor BD, y la abrimos                  ** //
        // ***************************************************************************************** //
        var_SQLTransaction := TSQLTransaction.Create(nil);
        var_SQLConnector   := TSQLConnector.Create(nil);
        var_SQLQuery       := TSQLQuery.Create(nil);

        Traer_poblacion_xID( param_id,
                             var_SQLTransaction,
                             var_SQLConnector,
                             var_SQLQuery );

        // ***************************************************************************************** //
        // ** Hacemos las comprobaciones que nos hagan falta de la SQL que hemos hecho            ** //
        // ***************************************************************************************** //
        with var_SQLQuery do
        begin
            if RecordCount <> 0 then
            begin
                if Trim(FieldByName('Codigo_Postal').AsString) <> '' then
                begin
                    if Trim(form_proveedores_000.SQLQuery_Proveedores.FieldByName('Codigo_Postal').AsString) = '' then
                    begin
                        form_proveedores_000.SQLQuery_Proveedores.FieldByName('Codigo_Postal').AsString := FieldByName('Codigo_Postal').AsString;
                    end;
                end;
            end;
        end;

        // ***************************************************************************************** //
        // ** Cerramos la tabla y asi se cierra automaticamente La transacción y conexión con BD  ** //
        // ***************************************************************************************** //
        if UTI_TB_Cerrar( var_SQLConnector,
                          var_SQLTransaction,
                          var_SQLQuery ) = false then UTI_GEN_Salir;

        // ***************************************************************************************** //
        // ** Destruimos la tabla y conexiones                                                    ** //
        // ***************************************************************************************** //
        var_SQLQuery.Free;
        var_SQLTransaction.Free;
        var_SQLConnector.Free;
    except
        on error : Exception do
        begin
            UTI_GEN_Error_Log( 'Ocurrió un error al intentar traer todos los datos de la población elegida.' +
                               '. El error ocurrió desde el módulo ' + Screen.ActiveForm.Name,
                               error );
            try
                var_SQLTransaction.Free;
                var_SQLConnector.Free;
                var_SQLQuery.Free;
            except
            end;
        end;
    end;
end;

procedure Tform_proveedores_001.Edit_Descripcion_PaisClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS el PAIS');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_paises').Clear;
         Edit_Descripcion_Pais.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Edit_Descripcion_PoblacionClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la POBLACIÓN');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_poblaciones').Clear;
         Edit_Descripcion_Poblacion.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Edit_Descripcion_ProvinciaClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la PROVINCIA');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_provincias').Clear;
         Edit_Descripcion_Provincia.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Boton_Elegir_Cta_Bco_PoblacionClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Poblaciones( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_Cta_Bco_poblaciones').AsString := Trim(var_Registro.id_1);
             FieldByName('id_Cta_Bco_provincias').AsString  := Trim(var_Registro.id_2);
             FieldByName('id_Cta_Bco_pais').AsString        := Trim(var_Registro.id_3);
             Edit_Cta_Bco_Descripcion_Poblacion.Text        := var_Registro.descripcion_1;
             Edit_Cta_Bco_Descripcion_Provincia.Text        := var_Registro.descripcion_2;
             Edit_Cta_Bco_Descripcion_Pais.Text             := var_Registro.descripcion_3;
        end;
    end;
end;

procedure Tform_proveedores_001.Boton_Elegir_Cta_Bco_PaisClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Paises( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_Cta_Bco_pais').AsString := Trim(var_Registro.id_1);
             Edit_Cta_Bco_Descripcion_Pais.Text      := var_Registro.descripcion_1;
        end;
    end;
end;

procedure Tform_proveedores_001.Boton_Elegir_Cta_Bco_ProvinciaClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Provincias( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_Cta_Bco_provincias').AsString := Trim(var_Registro.id_1);
             FieldByName('id_Cta_Bco_pais').AsString       := Trim(var_Registro.id_2);
             Edit_Cta_Bco_Descripcion_Provincia.Text       := var_Registro.descripcion_1;
             Edit_Cta_Bco_Descripcion_Pais.Text            := var_Registro.descripcion_2;
        end;
    end;
end;

procedure Tform_proveedores_001.Edit_Cta_Bco_Descripcion_PoblacionClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la POBLACIÓN del banco?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_Cta_Bco_poblaciones').Clear;
         Edit_Cta_Bco_Descripcion_Poblacion.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Edit_Cta_Bco_Descripcion_ProvinciaClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la PROVINCIA del banco?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_Cta_Bco_provincias').Clear;
         Edit_Cta_Bco_Descripcion_Provincia.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Edit_Cta_Bco_Descripcion_PaisClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS el PAIS del banco?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_Cta_Bco_pais').Clear;
         Edit_Cta_Bco_Descripcion_Pais.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Boton_Elegir_Forma_PagoClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_FormasPago( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_formas_pago').AsString := Trim(var_Registro.id_1);
             Edit_Descripcion_Forma_Pago.Text       := var_Registro.descripcion_1;
        end;
    end;
end;

procedure Tform_proveedores_001.Edit_Descripcion_Forma_PagoClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la FORMA DE PAGO?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_formas_pago').Clear;
         Edit_Descripcion_Forma_Pago.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Edit_Descripcion_Proveedor_TipoClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS el TIPO DE PROVEEDOR?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_proveedores_tipos').Clear;
         Edit_Descripcion_Proveedor_Tipo.Text := '';
         private_Cta_Ctble_elegida            := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.Comprobar_Vencimientos(param_msg : TStrings);
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        if Trim(FieldByName('Vencimientos_automaticos_SN').AsString) = '' then
        begin
            param_msg.Add( '* Generar vencimientos automáticos (Si/No) en la gestión de cobro.');
        end;
    end;
end;

procedure Tform_proveedores_001.BitBtn_SMSClick(Sender: TObject);
begin
    UTI_GEN_Enviar_SMS;
end;

procedure Tform_proveedores_001.Refrescar_Registros;
begin
    form_proveedores_000.Refrescar_Registros_Contactos;
end;

procedure Tform_proveedores_001.Edit_Descripcion_Agencia_TransporteClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la AGENCIA DE TRANSPORTE');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_Agencias_Transporte').Clear;
         Edit_Descripcion_Agencia_Transporte.Text := '';
    end;
    var_msg.Free;
end;

function Tform_proveedores_001.Elegir_Proveedor(param_id_no_aparecer : ShortString) : TRecord_Rgtro_Comun;
var var_msg : TStrings;
begin
    Result.id_1 := '';

    if UTI_GEN_Form_Abierto_Ya('form_proveedores_004') = false then
    begin
        Application.CreateForm(Tform_proveedores_004, form_proveedores_004);

        form_proveedores_004.public_id_que_no_tiene_que_aparecer := param_id_no_aparecer;

        form_proveedores_004.public_Solo_Ver    := true;
        form_proveedores_004.public_Elegimos    := true;
        form_proveedores_004.public_Menu_Worked := public_Menu_Worked;

        form_proveedores_004.para_Empezar;

        form_proveedores_004.ShowModal;

        if form_proveedores_004.public_Rgtro_Seleccionado = true then
        begin
            with form_proveedores_004.SQLQuery_Proveedores do
            begin
                Result := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                      '',
                                                      '',

                                                      FieldByName('nombre_propietario').AsString,
                                                      FieldByName('Tfno_Fijo_1').AsString,
                                                      FieldByName('Movil').AsString );
            end;
        end;

        form_proveedores_004.Free;
    end else begin
        var_msg := TStringList.Create;
        var_msg.Add(rs_Modulo_Abierto);
        UTI_GEN_Aviso(true, var_msg, 'AVISAMOS DE ... ', True, False);
        var_msg.Free;
        Exit;
    end;
end;

procedure Tform_proveedores_001.Boton_Elegir_Agencia_TransporteClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = true then
        begin
            var_Registro := Elegir_Proveedor( FieldByName('id').AsString );
        end;

        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_Agencias_Transporte').AsString := Trim(var_Registro.id_1);
             Edit_Descripcion_Agencia_Transporte.Text       := var_Registro.descripcion_1;

             Edit_Tfno_Fijo_1_agencia_transporte.Text       := var_Registro.descripcion_2;
             Edit_Movil_agencia_transporte.Text             := var_Registro.descripcion_3;
        end;
    end;
end;

procedure Tform_proveedores_001.DBGrid_ContactosDblClick(Sender: TObject);
begin
    Editar_Registro_Contactos;
end;

procedure Tform_proveedores_001.BitBtn_Ver_Situacion_Registro_ContactosClick(Sender: TObject);
begin
    if UTI_USR_Permiso_SN(public_Menu_Worked, '', True) = True then
    begin
        if form_proveedores_000.SQLQuery_Proveedores_Contactos.RecordCount > 0 then
        begin
            UTI_RGTRO_Ver_Estado_Registro( 'proveedores_contactos',
                                           form_proveedores_000.SQLQuery_Proveedores_Contactos,
                                           form_proveedores_000.DataSource_Proveedores_Contactos,
                                           DBGrid_Contactos );
        end;
    end;
end;

procedure Tform_proveedores_001.DBGrid_ContactosDrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
var var_Color_Normal : TColor;
begin
    with Sender as TDBGrid do
    begin
        if form_proveedores_000.SQLQuery_Proveedores_Contactos.RecordCount = 0 then Exit;

        var_Color_Normal := Canvas.Brush.Color;

      { ************************************************************************
        Primero comprobamos si es un registro dado de baja o no
        ************************************************************************ }
        if not form_proveedores_000.SQLQuery_Proveedores_Contactos.FieldByName('Del_WHEN').IsNull then
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
                    if Trim(form_proveedores_000.SQLQuery_Proveedores_Contactos.FieldByName('id_medio').asString) = '1' then
                    begin
                        Canvas.StretchDraw(param_Rect, Image_Confirmado.Picture.Graphic);
                    end;
                    }
                end;
            end;

        Canvas.Font.Color := var_Color_Normal;
    end;
end;

procedure Tform_proveedores_001.DBGrid_ContactosKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = 13 then Editar_Registro_Contactos;
end;

procedure Tform_proveedores_001.DBNavigator_ContactosBeforeAction(Sender: TObject;
    Button: TDBNavButtonType);
begin
    case Button of
        nbInsert : begin
            Insertar_Registro_Contactos;
            Abort;
        end;

        nbEdit : begin
            Editar_Registro_Contactos;
            Abort;
        end;

        nbDelete : begin
            Borrar_Registro_Contactos;
            Abort;
        end;

        nbRefresh : begin
            form_proveedores_000.Refrescar_Registros_Contactos;
            Abort;
        end;
    end;
end;

procedure Tform_proveedores_001.RadioGroup_BajasClick(Sender: TObject);
begin
    //UTI_TB_Ver_Bajas_SN('um', Memo_Filtros.Lines, RadioGroup_Bajas.ItemIndex);
    Refrescar_Registros;
end;

procedure Tform_proveedores_001.no_Tocar;
begin
    DBEdit_Nombre_RazonSocial.Enabled                     := False;
    DBEdit_Nombre_Comercial.Enabled                       := False;
    DBEdit_NIF_CIF.Enabled                                := False;
    DBEdit_Direccion.Enabled                              := False;
    DBEdit_Direccion_Numero.Enabled                       := False;
    DBEdit_Direccion_Piso_Letra.Enabled                   := False;
    DBEdit_Codigo_Postal.Enabled                          := False;
    Boton_Elegir_Poblacion.Enabled                        := False;
    Edit_Descripcion_Poblacion.Enabled                    := False;
    Boton_Elegir_Provincia.Enabled                        := False;
    Edit_Descripcion_Provincia.Enabled                    := False;
    Boton_Elegir_Pais.Enabled                             := False;
    Edit_Descripcion_Pais.Enabled                         := False;
    DBEdit_Tfno_Fijo_1.Enabled                            := False;
    DBEdit_Tfno_Fijo_2.Enabled                            := False;
    DBEdit_FAX.Enabled                                    := False;
    BitBtn_SMS.Enabled                                    := False;
    DBEdit_Movil.Enabled                                  := False;
    DBGrid_Contactos.Enabled                              := False;
    DBNavigator_Contactos.Enabled                         := False;
    BitBtn_Ver_Situacion_Registro_Contactos.Enabled       := False;

    Boton_Elegir_Proveedor_Tipo.Enabled                   := False;
    Edit_Descripcion_Proveedor_Tipo.Enabled               := False;

    Boton_Elegir_Agencia_Transporte.Enabled               := False;
    Edit_Descripcion_Agencia_Transporte.Enabled           := False;
    DBEdit_eMail.Enabled                                  := False;
    DBEdit_Pagina_Web.Enabled                             := False;
    DBEdit_Cuenta_Contable.Enabled                        := False;

    DBMemo_Observaciones_Comentarios.Enabled              := False;

    DBEdit_Cta_Bco_Entidad.Enabled                        := False;
    DBEdit_Cta_Bco_Sucursal.Enabled                       := False;
    DBEdit_Cta_Bco_Digito_Control.Enabled                 := False;
    DBEdit_Cta_Bco_Cuenta.Enabled                         := False;
    DBEdit_Cta_Bco_BIC_SWIFT.Enabled                      := False;
    DBEdit_Cta_Bco_IBAN.Enabled                           := False;
    DBEdit_DBEdit_Cta_Bco_Direccion.Enabled               := False;
    DBEdit_DBEdit_Cta_Bco_Direccion_Numero.Enabled        := False;
    DBEdit_DBEdit_Cta_Bco_Direccion_Piso_Letra.Enabled    := False;
    DBEdit_DBEdit_Cta_Bco_Direccion_Codigo_Postal.Enabled := False;
    DateEdit_Cta_Bco_Mandato_Fecha_de_Firma.Enabled       := False;
    DBEdit_Cta_Bco_Mandato_Ref.Enabled                    := False;

    Boton_Elegir_Forma_Pago.Enabled                       := False;
    Edit_Descripcion_Forma_Pago.Enabled                   := False;
    DBEdit_Forma_pago_Dia_1.Enabled                       := False;
    DBEdit_Forma_pago_Dia_2.Enabled                       := False;
    DBEdit_Forma_pago_Vacaciones_Dia_Inicio.Enabled       := False;
    DBEdit_Forma_pago_Vacaciones_Mes_Inicio.Enabled       := False;
    DBEdit_Forma_pago_Vacaciones_Dia_Fin.Enabled          := False;
    DBEdit_Forma_pago_Vacaciones_Mes_Fin.Enabled          := False;
    DBCheckBox_Vencimientos_automaticos_SN.Enabled        := False;

    DBCheckBox_IVA_Excluido_SN.Enabled                    := False;
    DBCheckBox_IVA_con_Recargo_SN.Enabled                 := False;
    DBEdit_Retencion.Enabled                              := False;

    DBEdit_Descuento_Linea.Enabled                        := False;
    DBEdit_Descuento_Comercial_1.Enabled                  := False;
    DBEdit_Descuento_Comercial_2.Enabled                  := False;
    DBEdit_Descuento_Pronto_Pago.Enabled                  := False;
    DBEdit_Descuento_Final.Enabled                        := False;
end;

procedure Tform_proveedores_001.Boton_Elegir_Proveedor_TipoClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_TiposProveedores( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_proveedores_tipos').AsString := Trim(var_Registro.id_1);
             Edit_Descripcion_Proveedor_Tipo.Text         := var_Registro.descripcion_1;
             private_Cta_Ctble_elegida                    := var_Registro.descripcion_3;

             if Trim(FieldByName('Cuenta_Contable').AsString) = '' then
             begin
                 FieldByName('Cuenta_Contable').Value := var_Registro.descripcion_2;
             end;
        end;
    end;
end;

procedure Tform_proveedores_001.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var var_msg : TStrings;
begin
    ButtonPanel1.SetFocus; // Con esto consigo que salga del campo que este y pueda actualizarlo

    var_msg := TStringList.Create;

    if public_Pulso_Aceptar = true then
    begin
        with form_proveedores_000.SQLQuery_Proveedores do
        begin
            Comprobar_Toda_Fecha_Hora(var_msg);

            if Trim(FieldByName('nombre_propietario').AsString) = '' then
            begin
                var_msg.Add( '* El nombre/descripción de a quien facturamos.');
            end;

            if Trim(FieldByName('Direccion').AsString) = '' then
            begin
                var_msg.Add( '* La dirección de quien facturamos.');
            end;

            if Trim(FieldByName('id_poblaciones').AsString) = '' then
            begin
                var_msg.Add( '* La población de quien facturamos.');
            end;

            if Trim(FieldByName('id_provincias').AsString) = '' then
            begin
                var_msg.Add( '* La provincia de quien facturamos.');
            end;

            if Trim(FieldByName('id_paises').AsString) = '' then
            begin
                var_msg.Add( '* El país de quien facturamos.');
            end;

            if Trim(FieldByName('id_proveedores_tipos').AsString) = '' then
            begin
                var_msg.Add( '* El tipo de proveedor.');
            end;

            if Trim(FieldByName('id_formas_pago').AsString) = '' then
            begin
                var_msg.Add( '* La forma de pago.');
            end;

            if Trim(FieldByName('id_actividades').AsString) = '' then
            begin
                var_msg.Add( '* La actividad.');
            end;

            Comprobar_Vencimientos(var_msg);

            if Trim(FieldByName('IVA_con_Recargo_SN').AsString) = '' then
            begin
                var_msg.Add( '* Con RECARGO (Si/No) en REGIMEN DE IVA bajo DATOS COMERCIALES.');
            end;

            if Trim(FieldByName('IVA_Excluido_SN').AsString) = '' then
            begin
                var_msg.Add( '* Con IVA EXCLUIDO (Si/No) en REGIMEN DE IVA bajo DATOS COMERCIALES.');
            end;

            form_Menu.Traer_Configuracion_APP;

            UTI_CONTA_esta_NIF_BIEN( form_menu.public_User_Configuracion.Proveedores_Obligar_NIF_SN,  //.... aqui tambien permitir el control de exigirlo o no
                                     var_msg,
                                     form_proveedores_000.SQLQuery_Proveedores,
                                     'proveedores' );

            UTI_CONTA_esta_Cta_Ctble_BIEN( form_menu.public_User_Configuracion.Proveedores_Obligar_Cuenta_Contable_SN, //.... aqui tambien permitir el control de exigirlo o no
                                           var_msg,
                                           form_proveedores_000.SQLQuery_Proveedores,
                                           private_Cta_Ctble_elegida,
                                           'proveedores',
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
            if form_Menu.public_Salir_OK = False then CloseAction := TCloseAction.caNone;
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

procedure Tform_proveedores_001.BitBtn_eMailClick(Sender: TObject);
begin
    UTI_GEN_Enviar_eMAIL;
end;

procedure Tform_proveedores_001.Presentar_Datos;
var var_Hora : tTime;
    var_Dia  : tDate;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        Edit_Descripcion_Poblacion.Text          := FieldByName('OT_descripcion_poblacion').AsString;
        Edit_Descripcion_Provincia.Text          := FieldByName('OT_descripcion_provincia').AsString;
        Edit_Descripcion_Pais.Text               := FieldByName('OT_descripcion_pais').AsString;
        Edit_Descripcion_Proveedor_Tipo.Text     := FieldByName('OT_descripcion_proveedor_tipo').AsString;

        Edit_Descripcion_Agencia_Transporte.Text := FieldByName('OT_descripcion_agencia_transporte').AsString;
        Edit_Tfno_Fijo_1_agencia_transporte.Text := FieldByName('OT_Tfno_Fijo_1_agencia_transporte').AsString;
        Edit_Movil_agencia_transporte.Text       := FieldByName('OT_Movil_agencia_transporte').AsString;

        Edit_Cta_Bco_Descripcion_Poblacion.Text  := FieldByName('OT_Cta_Bco_descripcion_poblacion').AsString;
        Edit_Cta_Bco_Descripcion_Provincia.Text  := FieldByName('OT_Cta_Bco_descripcion_provincia').AsString;
        Edit_Cta_Bco_Descripcion_Pais.Text       := FieldByName('OT_Cta_Bco_descripcion_pais').AsString;

        Edit_Descripcion_Forma_Pago.Text         := FieldByName('OT_descripcion_forma_pago').AsString;

        Edit_Descripcion_Actividad.Text          := FieldByName('OT_descripcion_actividad').AsString;

        if not FieldByName('Cta_Bco_Mandato_Fecha_de_Firma').IsNull then
        begin
            var_Dia  := FieldByName('Cta_Bco_Mandato_Fecha_de_Firma').AsDateTime;
            DateEdit_Cta_Bco_Mandato_Fecha_de_Firma.Text := DateToStr(var_Dia);
        end;
    end;
end;

procedure Tform_proveedores_001.FormCreate(Sender: TObject);
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

      // ********************************************************************************************* //
      // ** Solo para este formulario                                                               ** //
      // ********************************************************************************************* //
      private_Cta_Ctble_elegida := Trim(form_proveedores_000.SQLQuery_Proveedores.FieldByName('OT_Cuenta_Contable_proveedor_tipo').AsString);
end;

procedure Tform_proveedores_001.para_Empezar;
begin
  { ****************************************************************************
    Solo para formularios que traten con datos
    **************************************************************************** }
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        public_Record_Rgtro := UTI_Guardar_Datos_Registro( FieldByName('id').AsString,
                                                           '',
                                                           '',

                                                           FieldByName('nombre_propietario').AsString,
                                                           FieldByName('Tfno_Fijo_1').AsString,
                                                           FieldByName('Movil').AsString );
    end;

    Presentar_Datos;

  { ****************************************************************************
    SOLO PARA ESTE FORM
    **************************************************************************** }
    PageControl_Otros_Datos.ActivePage := TabSheet_DatosAdicionales;
end;

function Tform_proveedores_001.Existe_Proveedor_Contacto_Ya( param_Id,
                                                             param_nombre : String ) : Trecord_Existe;
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

        if UTI_CN_Connector_Open( var_SQLTransaction,
                                  var_SQLConnector ) = False then UTI_GEN_Salir;

      { ****************************************************************************
        Creamos la SQL Según el motor de BD
        **************************************************************************** }
        var_SQL := TStringList.Create;

        var_SQL.Add('SELECT prc.*' );

        var_SQL.Add(  'FROM proveedores_contactos AS prc' );

        var_SQL.Add(' WHERE prc.nombre = ' +  UTI_GEN_Comillas(Trim(param_nombre)) );

        if Trim(param_Id) <> '' then
        begin
             var_SQL.Add(  ' AND NOT prc.id_proveedores = ' + Trim(param_Id) );
        end;

        var_SQL.Add(' ORDER BY prc.id_proveedores ASC, prc.nombre ASC' );

      { ****************************************************************************
        Abrimos la tabla
        **************************************************************************** }
        var_SQLQuery      := TSQLQuery.Create(nil);
        var_SQLQuery.Name := 'SQLQuery_Existe_Proveedor_Contacto_Ya';

        if UTI_TB_Query_Open( '', '', '',
                              var_SQLConnector,
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
            UTI_GEN_Error_Log( 'Error al comprobar si el contacto existe ya.' +
                               'La tabla ha sido ' + var_SQLQuery.Name + ' desde el módulo ' +
                               Screen.ActiveForm.Name,
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

procedure Tform_proveedores_001.Boton_Elegir_ActividadClick(Sender: TObject);
var var_Registro : TRecord_Rgtro_Comun;
begin
    with form_proveedores_000.SQLQuery_Proveedores do
    begin
        var_Registro := UTI_Abrir_Modulo_Actividades( true, false, '1' );
        if var_Registro.id_1 <> '' then
        begin
             FieldByName('id_actividades').AsString := Trim(var_Registro.id_1);
             Edit_Descripcion_Actividad.Text        := var_Registro.descripcion_1;
        end;
    end;
end;

procedure Tform_proveedores_001.Edit_Descripcion_ActividadClick(Sender: TObject);
var var_msg : TStrings;
begin
    var_msg := TStringList.Create;
    var_msg.Add('¿QUITAMOS la ACTIVIDAD?');
    if UTI_GEN_Aviso(true, var_msg, rs_OK, True, True) = True then
    begin
         form_proveedores_000.SQLQuery_Proveedores.FieldByName('id_actividades').Clear;
         Edit_Descripcion_Actividad.Text := '';
    end;
    var_msg.Free;
end;

procedure Tform_proveedores_001.FormActivate(Sender: TObject);
begin
    If form_proveedores_000.public_Elegimos = true then
    begin
        with Self do
        begin
            Color := $00B9959C;
        end;
    end;

    Comprobar_No_Tocar(true, true);
end;

function Tform_proveedores_001.Comprobar_No_Tocar( param_Reproducir_Mensajes,
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

procedure Tform_proveedores_001.Editar_Registro_Contactos;
var var_msg           : TStrings;
    var_Form          : Tform_proveedores_002;
    var_record_Existe : Trecord_Existe;
    var_id            : ShortString;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_proveedores_000.SQLQuery_Proveedores_Contactos do
    begin
        var_msg := TStringList.Create;

        if (RecordCount > 0) and
           (Active = true)   then
        begin
            var_id := FieldByName('id').AsString;

            if UTI_USR_Permiso_SN(public_Menu_Worked, 'M', True) = True then
            begin
                if UTI_RGTRO_isLock( 'proveedores_contactos',
                                     FieldByName('id').AsString,
                                     true ) = true then
                begin
                    Exit;
                end else begin
                    if UTI_RGTRO_Lock( 'proveedores_contactos',
                                       FieldByName('id').AsString ) = true then
                         Edit
                    else Exit;
                end;

                var_Form := Tform_proveedores_002.Create(nil);

                var_Form.public_Menu_Worked := public_Menu_Worked;

                if public_Solo_Ver = true then
                begin
                    var_Form.public_Solo_Ver := true;
                end;

                var_Form.para_Empezar;

                var_Form.ShowModal;
                if var_Form.public_Pulso_Aceptar = true then
                begin
                    var_record_Existe := Existe_Proveedor_Contacto_Ya( FieldByName('id_proveedores').AsString,
                                                                       FieldByName('nombre').AsString );

                    if var_record_Existe.Fallo_en_Conexion_BD = true then
                    begin
                        var_Form.Free;
                        Cancel;
                    end else begin
                        if var_record_Existe.Existe = false then
                        begin
                            if UTI_DATOS_TABLA_SeCambioAlgoEnRgtro( form_proveedores_000.SQLQuery_Proveedores_Contactos ) = true then
                            begin
                                FieldByName('Change_WHEN').Value    := UTI_CN_Fecha_Hora;
                                FieldByName('Change_Id_User').Value := Form_Menu.public_User;

                                UTI_RGTRO_Grabar_Antes( 'proveedores_contactos',
                                                        form_proveedores_000.SQLQuery_Proveedores_Contactos );
                            end else begin
                                Cancel;
                            end;

                            var_Form.Free;

                        end else begin
                            var_Form.Free;
                            Cancel;
                            var_msg.Clear;
                            var_msg.Add( 'Contacto repetido para este proveedor.');

                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                            begin
                                var_msg.Add(rs_Rgtro_Borrado);
                            end;

                            UTI_GEN_Aviso(true, var_msg, rs_Ya_Existe, True, False);
                        end;
                    end;
                end else begin
                    var_Form.Free;
                    Cancel;
                end;

                UTI_RGTRO_UnLock( 'proveedores_contactos',
                                  var_id );
            end;
        end else begin
            var_msg.Add(rs_no_Hay_Rgtros);
            UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
        end;
    end;

    var_msg.Free;
end;

procedure Tform_proveedores_001.Insertar_Registro_Contactos;
var var_msg           : TStrings;
    var_Form          : Tform_proveedores_002;
    var_record_Existe : Trecord_Existe;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    with form_proveedores_000.SQLQuery_Proveedores_Contactos do
    begin
        var_msg := TStringList.Create;

        if UTI_USR_Permiso_SN(public_Menu_Worked, 'A', True) = True then
        begin
            if public_Solo_Ver = True then
            begin
                var_msg.Clear;
                var_msg.Add(rs_Solo_Visualizar);
                UTI_GEN_Aviso(true, var_msg, rs_No_Se_Puede, True, False);
            end else begin
                Insert;

                FieldByName('id_proveedores').AsString := form_proveedores_000.SQLQuery_Proveedores.FieldByName('id').AsString;

                var_Form := Tform_proveedores_002.Create(nil);

                var_Form.para_Empezar;

                var_Form.ShowModal;
                if var_Form.public_Pulso_Aceptar = true then
                begin
                    var_Form.Free;

                    var_record_Existe := Existe_Proveedor_Contacto_Ya( '', // Estoy insertando/creando y lo que tengo que comprobar es que no exista la pwd en cualquier otro usuario, por lo que el campo id_Users no lo paso
                                                                       FieldByName('nombre').AsString );

                    if var_record_Existe.Fallo_en_Conexion_BD = true then
                    begin
                        // var_Form.Free;
                        Cancel;
                    end else begin
                        if var_record_Existe.Existe = false then
                        begin
                            FieldByName('Insert_WHEN').Value    := UTI_CN_Fecha_Hora;
                            FieldByName('Insert_Id_User').Value := Form_Menu.public_User;

                            UTI_RGTRO_Grabar_Antes( 'proveedores_contactos',
                                                    form_proveedores_000.SQLQuery_Proveedores_Contactos );
                        end else begin
                            Cancel;
                            var_msg.Clear;

                            var_msg.Add( 'Contacto repetido para este proveedor.');

                            if UpperCase(var_record_Existe.deBaja) = 'S' then
                            begin
                                var_msg.Add(rs_Rgtro_Borrado);
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

        var_msg.Free;
    end;
end;

procedure Tform_proveedores_001.Borrar_Registro_Contactos;
begin
    if Comprobar_No_Tocar(true, false) = true then
    begin
        Exit;
    end;

    if UTI_USR_Permiso_SN(public_Menu_Worked, 'B', True) = True then
    begin
        UTI_RGTRO_Borrar( 'proveedores_contactos',
                          form_proveedores_000.SQLQuery_Proveedores_Contactos,
                          public_Solo_Ver,
                          public_Menu_Worked );
    end;
end;

end.


