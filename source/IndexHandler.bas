B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Index Handler class
' Version 6.00
Sub Class_Globals
	'Private DB As MiniORM
	Private App As EndsMeet
	Private Request As ServletRequest
	Private Response As ServletResponse
End Sub

Public Sub Initialize
	App = Main.App
	'DB.Initialize(Main.DBType, Null)
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	Log($"${Request.Method}: ${Request.RequestURI}"$)
	Dim path As String = req.RequestURI
	If path = "/" Then
		'Dim www As String = App.staticfiles.Folder
		'Dim content As String = File.ReadString(www, "index.html")
		
		Dim index1 As IndexView
		index1.Initialize
		Dim doc As Document
		doc.Initialize
		doc.AppendDocType
		doc.Append(index1.View.Build)
		'App.WriteHtml(Response, doc.ToString)
		App.WriteHtml2(Response, doc.ToString, Main.App.ctx)
	End If
End Sub