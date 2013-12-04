Imports DevExpress.Web.ASPxGridView

Partial Class Consultas_MapTest
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Session("NombrePrograma") = uf.QueryStringDecode(Request.QueryString.Get(0))
        Session("CodPrograma") = uf.QueryStringDecode(Request.QueryString.Get(1))


        SqlMetaIndicadores.SelectCommand = "SELECT c.IdIndicador,c.DescripcionIndicador, " & _
              "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
              "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
              "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
              "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
              "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
              "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
              "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
              "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
              "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
              "FROM [MetaYMonitoreoPorPeriodo] a " & _
              "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
              "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
              "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
              "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 and b.Activo=1 and c.Activo=1 " & _
              "GROUP BY c.IdIndicador,c.DescripcionIndicador"

        SqlAno.SelectParameters(0).DefaultValue = Session("CodPrograma")
        cmbAno.DataBind()

        SqlDataSourceCabeceras.SelectCommand = "select " & _
          "I.IdIndicador," & _
          "I.DescripcionIndicador," & _
          "IPP.IdPrograma," & _
          "IPP.Activo," & _
          "MMPP.Activo," & _
          "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
          "ADI.IdAreaDeInfluencia," & _
          "ADI.DescripcionAreaDeInfluencia," & _
          "UPAI.IdDepartamento," & _
          "D.DescripcionDepartamento," & _
          "UPAI.IdMunicipio," & _
          "M.DescripcionMunicipio," & _
          "MG.Latitud," & _
          "MG.Longitud " & _
          "from " & _
          "IndicadoresPorPrograma IPP " & _
          "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
          "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
          "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
          "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
          "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
          "join vMunicipios M ON M.IdMunicipio = UPAI.IdMunicipio " & _
          "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
          "where " & _
          "IPP.IdPrograma = @Programa " & _
          "and MMPP.Ano= @Ano " & _
          "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
          "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
          "and MG.Latitud is not null " & _
          "and IPP.IdIndicador= @Indicador " & _
          "union " & _
          "select " & _
          "I.IdIndicador," & _
          "I.DescripcionIndicador," & _
          "IPP.IdPrograma," & _
          "IPP.Activo," & _
          "MMPP.Activo," & _
          "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
          "ADI.IdAreaDeInfluencia," & _
          "ADI.DescripcionAreaDeInfluencia," & _
              "UPAI.IdDepartamento," & _
              "D.DescripcionDepartamento," & _
              "UPAI.IdMunicipio," & _
              "M.DescripcionMunicipio," & _
              "MG.Latitud," & _
              "MG.Longitud " & _
              "from " & _
          "IndicadoresPorPrograma IPP " & _
          "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
          "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
          "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
          "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
          "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
          "join vMunicipios M ON M.IdDepartamento = D.IdDepartamento " & _
          "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
          "where " & _
          "IPP.IdPrograma = @Programa " & _
          "and MMPP.Ano= @Ano " & _
          "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
          "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
          "and MG.CabeceraMunicipal = 1 " & _
          "and UPAI.IdMunicipio is null " & _
          "and IPP.IdIndicador= @Indicador " & _
            "union " & _
            "select " & _
            "I.IdIndicador," & _
            "I.DescripcionIndicador," & _
            "IPP.IdPrograma," & _
            "IPP.Activo," & _
            "MMPP.Activo, " & _
            "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
                "ADI.IdAreaDeInfluencia," & _
                "ADI.DescripcionAreaDeInfluencia," & _
               " M.IdDepartamento," & _
               " LL.DescripcionDepartamento," & _
                "UPAI.IdMunicipio," & _
                "M.DescripcionMunicipio," & _
               " LL.Latitud," & _
                "LL.Longitud " & _
        "from " & _
            "IndicadoresPorPrograma IPP " & _
            "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
            "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
            "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
            "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
            "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
            "join vMunicipios M ON M.IdDepartamento= D.IdDepartamento " & _
            "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
            "join (select D2.IdDepartamento,D2.DescripcionDepartamento,M2.IdMunicipio,M2.DescripcionMunicipio,MG2.Latitud,MG2.Longitud from MunicipiosGeoreferenciados MG2 join vMunicipios M2 on MG2.IdMunicipio = M2.IdMunicipio join vDepartamentos D2 on M2.IdDepartamento=D2.IdDepartamento where MG2.CabeceraMunicipal = 1 ) LL ON LL.IdDepartamento = D.IdDepartamento " & _
            "where " & _
            "IPP.IdPrograma= @Programa " & _
            "and MMPP.Ano= @Ano " & _
            "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
            "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
            "and MG.Latitud is null " & _
            "and IPP.IdIndicador= @Indicador "


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.04) 'este es el Id definido en el MOCA
            If dtMOCA.Rows.Count() > 0 Then
                ''Activa o Inactiva los objetos,(sean botones, grid, hiperlinks, etc),  
                ''en la pagina que se indique deacuerdo al parametro indicado
                'btnAgregar.Visible = dtMOCA.Rows.Item(0).Item("AllowAdd")

                ''Los siguientes datos pueden ser cambiados por los nombres de Objetos a los que corresponde la acción que se desea realizar, 
                ''si no hay necesidad de utilizar esta sección silo la eliminan dejandola en blanco y solo evaluando el acceso a la pagina
                'btnModificar.Visible = dtMOCA.Rows.Item(0).Item("AllowUpdate")
                'btnEliminar.Visible = dtMOCA.Rows.Item(0).Item("AllowDelete")
                'btnAutorizar.Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
                ''Object5.Visible = dtMOCA.Rows.Item(0).Item("AllowAction02")
                ''Object6.Visible = dtMOCA.Rows.Item(0).Item("AllowAction03")
                ''Object7.Visible = dtMOCA.Rows.Item(0).Item("AllowAction04")
                ''Object8.Visible = dtMOCA.Rows.Item(0).Item("AllowAction05")
                ''Object9.Visible = dtMOCA.Rows.Item(0).Item("AllowAction06")
                ''Object10.Visible = dtMOCA.Rows.Item(0).Item("AllowAction07")

                'Para activar o desactivar los botones en un ASPxGridView preferiblemente use variables de sessión
                Session("AllowAdd") = dtMOCA.Rows.Item(0).Item("AllowAdd")
                Session("AllowUpdate") = dtMOCA.Rows.Item(0).Item("AllowUpdate")
                Session("AllowDelete") = dtMOCA.Rows.Item(0).Item("AllowDelete")
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using
        Session("NombrePrograma") = uf.QueryStringDecode(Request.QueryString.Get(0))
        Session("CodPrograma") = uf.QueryStringDecode(Request.QueryString.Get(1))


        SqlMetaIndicadores.SelectCommand = "SELECT c.IdIndicador,c.DescripcionIndicador, " & _
            "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
            "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
            "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
            "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
            "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
            "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
            "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
            "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
            "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
            "FROM [MetaYMonitoreoPorPeriodo] a " & _
            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
            "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 and b.Activo=1 and c.Activo=1 " & _
            "GROUP BY c.IdIndicador,c.DescripcionIndicador"

        SqlAno.SelectParameters(0).DefaultValue = Session("CodPrograma")
        cmbAno.DataBind()


        SqlDataSourceCabeceras.SelectCommand = "select " & _
               "I.IdIndicador," & _
               "I.DescripcionIndicador," & _
               "IPP.IdPrograma," & _
               "IPP.Activo," & _
               "MMPP.Activo," & _
               "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
               "ADI.IdAreaDeInfluencia," & _
               "ADI.DescripcionAreaDeInfluencia," & _
               "UPAI.IdDepartamento," & _
               "D.DescripcionDepartamento," & _
               "UPAI.IdMunicipio," & _
               "M.DescripcionMunicipio," & _
               "MG.Latitud," & _
               "MG.Longitud " & _
               "from " & _
               "IndicadoresPorPrograma IPP " & _
               "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
               "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
               "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
               "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
               "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
               "join vMunicipios M ON M.IdMunicipio = UPAI.IdMunicipio " & _
               "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
               "where " & _
               "IPP.IdPrograma = @Programa " & _
               "and MMPP.Ano= @Ano " & _
               "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
               "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
               "and MG.Latitud is not null " & _
               "and IPP.IdIndicador= @Indicador " & _
               "union " & _
               "select " & _
               "I.IdIndicador," & _
               "I.DescripcionIndicador," & _
               "IPP.IdPrograma," & _
               "IPP.Activo," & _
               "MMPP.Activo," & _
               "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
               "ADI.IdAreaDeInfluencia," & _
               "ADI.DescripcionAreaDeInfluencia," & _
                   "UPAI.IdDepartamento," & _
                   "D.DescripcionDepartamento," & _
                   "UPAI.IdMunicipio," & _
                   "M.DescripcionMunicipio," & _
                   "MG.Latitud," & _
                   "MG.Longitud " & _
                   "from " & _
               "IndicadoresPorPrograma IPP " & _
               "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
               "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
               "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
               "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
               "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
               "join vMunicipios M ON M.IdDepartamento = D.IdDepartamento " & _
               "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
               "where " & _
               "IPP.IdPrograma = @Programa " & _
               "and MMPP.Ano= @Ano " & _
               "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
               "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
               "and MG.CabeceraMunicipal = 1 " & _
               "and UPAI.IdMunicipio is null " & _
               "and IPP.IdIndicador= @Indicador " & _
                 "union " & _
                 "select " & _
                 "I.IdIndicador," & _
                 "I.DescripcionIndicador," & _
                 "IPP.IdPrograma," & _
                 "IPP.Activo," & _
                 "MMPP.Activo, " & _
                 "(MMPP.EjecutadoQ1 +  MMPP.EjecutadoQ2 +  MMPP.EjecutadoQ3 +  MMPP.EjecutadoQ4 ) / (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4) as PorcentajeEjecucion," & _
                     "ADI.IdAreaDeInfluencia," & _
                     "ADI.DescripcionAreaDeInfluencia," & _
                    " M.IdDepartamento," & _
                    " LL.DescripcionDepartamento," & _
                     "UPAI.IdMunicipio," & _
                     "M.DescripcionMunicipio," & _
                    " LL.Latitud," & _
                     "LL.Longitud " & _
             "from " & _
                 "IndicadoresPorPrograma IPP " & _
                 "join Indicadores I ON I.IdIndicador = IPP.IdIndicador " & _
                 "join MetaYMonitoreoPorPeriodo MMPP ON IPP.IdIndicadoresPorPrograma = MMPP.IdIndicadorPorPrograma " & _
                 "join AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia = MMPP.IdAreaDeInfluencia " & _
                 "join UbicacionPorAreaDeInfluencia UPAI ON UPAI.IdAreaDeInfluencia = ADI.IdAreaDeInfluencia " & _
                 "join vDepartamentos D ON D.IdDepartamento=UPAI.IdDepartamento " & _
                 "join vMunicipios M ON M.IdDepartamento= D.IdDepartamento " & _
                 "join MunicipiosGeoreferenciados MG ON MG.IdMunicipio = M.IdMunicipio " & _
                 "join (select D2.IdDepartamento,D2.DescripcionDepartamento,M2.IdMunicipio,M2.DescripcionMunicipio,MG2.Latitud,MG2.Longitud from MunicipiosGeoreferenciados MG2 join vMunicipios M2 on MG2.IdMunicipio = M2.IdMunicipio join vDepartamentos D2 on M2.IdDepartamento=D2.IdDepartamento where MG2.CabeceraMunicipal = 1 ) LL ON LL.IdDepartamento = D.IdDepartamento " & _
                 "where " & _
                 "IPP.IdPrograma= @Programa " & _
                 "and MMPP.Ano= @Ano " & _
                 "and (MMPP.ProyectadoQ1 +MMPP.ProyectadoQ2 +MMPP.ProyectadoQ3 +MMPP.ProyectadoQ4 <> 0) " & _
                 "and IPP.Activo=1 and MMPP.Activo=1 and ADI.Activo=1 and UPAI.Activo=1 " & _
                 "and MG.Latitud is null " & _
                 "and IPP.IdIndicador= @Indicador "


    End Sub

    Protected Sub GridIndicadores_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        SqlMetaIndicadores.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaIndicadores.SelectParameters(1).DefaultValue = cmbAno.Text
        SqlMetaIndicadores.DataBind()
        GridIndicadores.DataBind()
    End Sub

    Protected Sub GridIndicadores_Load(sender As Object, e As EventArgs)
        SqlMetaIndicadores.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaIndicadores.SelectParameters(1).DefaultValue = cmbAno.Text
        SqlMetaIndicadores.DataBind()
        GridIndicadores.DataBind()
    End Sub

    Protected Sub GridIndicadores_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
        If e.DataColumn.FieldName = "P1" Then
            Session("Porcenta1") = Convert.ToDouble(e.CellValue)
        End If


        If e.DataColumn.Name = "S1" Then


            If Session("Porcenta1") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta1") >= 0.5 And Session("Porcenta1") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta1") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If


        If e.DataColumn.FieldName = "P2" Then
            Session("Porcenta2") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S2" Then


            If Session("Porcenta2") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta2") >= 0.5 And Session("Porcenta2") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta2") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If



        If e.DataColumn.FieldName = "P3" Then
            Session("Porcenta3") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S3" Then


            If Session("Porcenta3") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta3") >= 0.5 And Session("Porcenta3") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta3") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "P4" Then
            Session("Porcenta4") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S4" Then


            If Session("Porcenta4") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta4") >= 0.5 And Session("Porcenta4") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta4") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "PAA" Then
            Session("Porcenta5") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "SA" Then


            If Session("Porcenta5") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta5") >= 0.5 And Session("Porcenta5") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta5") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)



    End Sub

    Protected Sub DataGrid_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)


        Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("CodPrograma")
        Me.SqlDataSourceCabeceras.SelectParameters(1).DefaultValue = cmbAno.Text
        Me.SqlDataSourceCabeceras.DataBind()
        Me.DataGrid.DataBind()
    End Sub

    Protected Sub link1_Click(sender As Object, e As EventArgs)


        Dim index As Integer = GridIndicadores.FocusedRowIndex()
        Dim idindicador As Integer = CInt(GridIndicadores.GetRowValues(index, "IdIndicador"))

        Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("CodPrograma")
        Me.SqlDataSourceCabeceras.SelectParameters(1).DefaultValue = cmbAno.Text
        Me.SqlDataSourceCabeceras.SelectParameters(2).DefaultValue = idindicador
        Me.SqlDataSourceCabeceras.DataBind()
        Me.DataGrid.DataBind()
    End Sub

    Protected Sub SqlDataSourceCabeceras_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        'Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("CodPrograma")
        'Me.SqlDataSourceCabeceras.SelectParameters(1).DefaultValue = cmbAno.Text
        'Me.SqlDataSourceCabeceras.DataBind()
        'Me.DataGrid.DataBind()
    End Sub

    Protected Sub DataGrid_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("CodPrograma")
        Me.SqlDataSourceCabeceras.SelectParameters(1).DefaultValue = cmbAno.Text
        Me.SqlDataSourceCabeceras.DataBind()
        Me.DataGrid.DataBind()
    End Sub
End Class
