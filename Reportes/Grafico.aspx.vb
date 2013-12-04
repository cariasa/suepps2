Imports DevExpress.XtraCharts.Web
Imports DevExpress.XtraCharts
Imports DevExpress.XtraGauges.Core.Model
Imports DevExpress.Web.ASPxGauges.Gauges.Circular
Imports DevExpress.Web.ASPxGauges
Imports DevExpress.XtraGauges.Base
Imports DevExpress.XtraGauges.Core.Drawing
Imports System.Drawing



Partial Class Reportes_Grafico
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Dim Porcentaje As Double = uf.QueryStringDecode(Request.QueryString.Get(7))
        ' Add a circular gauge.

        Dim circularGauge As CircularGauge = gaugeControl.AddGauge(GaugeType.Circular)


        circularGauge.AddDefaultElements()

        ' Changes the background layer's paint style.
        Dim background As ArcScaleBackgroundLayer = circularGauge.BackgroundLayers(0)
        background.ShapeType = BackgroundLayerShapeType.CircularFull_Style2

        ' Customizes the scale's settings.
        Dim scale As ArcScaleComponent = circularGauge.Scales(0)
        scale.MinValue = 0
        scale.MaxValue = 100
        scale.Value = (Porcentaje * 100)
        scale.MajorTickCount = 6
        scale.MajorTickmark.FormatString = "{0:F0}"
        scale.MajorTickmark.ShapeType = TickmarkShapeType.Circular_Style1_2
        scale.MajorTickmark.ShapeOffset = -9
        scale.MajorTickmark.AllowTickOverlap = True
        scale.MinorTickCount = 3
        scale.MinorTickmark.ShapeType = TickmarkShapeType.Circular_Style2_1
        scale.AppearanceTickmarkText.TextBrush = New SolidBrushObject(Color.Gray)

        Dim range As ScaleRange = New ArcScaleRange
        ''range.EndValue = 20
        ''range.StartValue = 0

        ''range.AppearanceRange.ContentBrush = New SolidBrushObject(System.Drawing.Color.Red)
        ''scale.Ranges.Add(range)

        ' Changes the needle's paint style.
        Dim needle As ArcScaleNeedleComponent = circularGauge.Needles(0)
        needle.ShapeType = NeedleShapeType.CircularFull_Style3

        ' Adds the gauge control to the Page.
        gaugeControl.Width = 250
        gaugeControl.Height = 250
        gaugeControl.AutoLayout = True
        'Page.Form.Controls.Add(gaugeControl)

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim tipo As Integer = uf.QueryStringDecode(Request.QueryString.Get(2))
        Dim nombre As String = uf.QueryStringDecode(Request.QueryString.Get(0))
        Dim Q1 As Double = uf.QueryStringDecode(Request.QueryString.Get(3))
        Dim Q2 As Double = uf.QueryStringDecode(Request.QueryString.Get(4))
        Dim Q3 As Double = uf.QueryStringDecode(Request.QueryString.Get(5))
        Dim Q4 As Double = uf.QueryStringDecode(Request.QueryString.Get(6))
        Dim Porcentaje As Double = uf.QueryStringDecode(Request.QueryString.Get(7))

        chart.Height = 300
        chart.Width = 500

        Dim chartSeries As New Series("Side-by-Side Bar Series 1", ViewType.Bar)


        If tipo = 0 Then


            chartSeries.Points.Add(New SeriesPoint("T1", New Double() {Q1 * 100}))
            chartSeries.Points.Add(New SeriesPoint("T2", New Double() {Q2 * 100}))
            chartSeries.Points.Add(New SeriesPoint("T3", New Double() {Q3 * 100}))
            chartSeries.Points.Add(New SeriesPoint("T4", New Double() {Q4 * 100}))



        ElseIf tipo = 1 Then

            chartSeries.Points.Add(New SeriesPoint("S1", New Double() {((Q1 + Q2) / 2) * 100}))
            chartSeries.Points.Add(New SeriesPoint("S2", New Double() {((Q3 + Q4) / 2) * 100}))

        Else

            chartSeries.Points.Add(New SeriesPoint("Total", New Double() {Porcentaje * 100}))


        End If
        chartSeries.LegendText = nombre
        chart.Series.Add(chartSeries)




    End Sub


End Class
