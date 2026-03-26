B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Categories Handler class
' Version 6.51
Sub Class_Globals
	Private DB As MiniORM
	Private App As EndsMeet
	Private Method As String
	Private Request As ServletRequest
	Private Response As ServletResponse
End Sub

Public Sub Initialize
	DB = Main.DB
	App = Main.App
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	Method = req.Method
	Log($"${Request.Method}: ${Request.RequestURI}"$)
	Dim Path As String = req.RequestURI
	If Path = "/categories" Then
		RenderPage
	Else If Path = "/api/categories/table" Then
		HandleTable
	Else If Path = "/api/categories/add" Then
		HandleAddModal
	Else If Path.StartsWith("/api/categories/edit/") Then
		HandleEditModal
	Else If Path.StartsWith("/api/categories/delete/") Then
		HandleDeleteModal
	Else
		HandleCategories
	End If
End Sub

Private Sub RenderPage
	Dim main1 As MainView
	main1.Initialize
	main1.PageName = "categories"
	main1.LoadContent(ContentContainer)
	main1.LoadModal(ModalContainer)
	'main1.LoadToast(ToastContainer)

	Dim page1 As MiniHtml = main1.View
    Dim doc As MiniHtml
    doc.Initialize("")
    doc.Write("<!DOCTYPE html>")
    doc.Write(page1.build)
	App.WriteHtml2(Response, doc.ToString, App.ctx)
End Sub

Sub CreateTag (Name As String) As MiniHtml
    Dim tag1 As MiniHtml
    tag1.Initialize(Name)
    Return tag1
End Sub

Sub Anchor As MiniHtml
    Return CreateTag("a")
End Sub

Sub Button As MiniHtml
    Return CreateTag("button")
End Sub

Sub Span As MiniHtml
    Return CreateTag("span")
End Sub

Sub Div As MiniHtml
    Return CreateTag("div")
End Sub

Sub Icon As MiniHtml
    Return CreateTag("i")
End Sub

Sub H2 As MiniHtml
    Return CreateTag("h2")
End Sub

Sub H3 As MiniHtml
    Return CreateTag("h3")
End Sub

Sub H5 As MiniHtml
    Return CreateTag("h5")
End Sub

Sub Svg As MiniHtml
    Return CreateTag("svg")
End Sub

Sub SvgPath As MiniHtml
    Return CreateTag("path")
End Sub

Sub Form As MiniHtml
    Return CreateTag("form")
End Sub

Sub Input As MiniHtml
    Return CreateTag("input")
End Sub

Sub Label As MiniHtml
    Return CreateTag("label")
End Sub

Sub Table As MiniHtml
    Return CreateTag("table")
End Sub

Sub Thead As MiniHtml
    Return CreateTag("thead")
End Sub

Sub Tbody As MiniHtml
    Return CreateTag("tbody")
End Sub

Sub Th As MiniHtml
    Return CreateTag("th")
End Sub

Sub Tr As MiniHtml
    Return CreateTag("tr")
End Sub

Sub Td As MiniHtml
    Return CreateTag("td")
End Sub

Private Sub ContentContainer As MiniHtml
	Dim content1 As MiniHtml = Div.cls("mx-auto max-w-(--breakpoint-2xl) p-4 pb-20 md:p-6 md:pb-6")
	content1.comment(" Breadcrumb Start ")
	Dim bread1 As MiniHtml = Div.attr("x-data", "{ pageName: `Categories`}").up(content1)
	Dim bread2 As MiniHtml = Div.cls("flex flex-wrap items-center justify-between gap-3 mb-6").up(bread1)
	Dim heading2 As MiniHtml = H2.up(bread2)
	heading2.cls("text-xl font-semibold text-gray-800 dark:text-white/90")
	heading2.text("$HOME_TITLE$")
	Dim version1 As MiniHtml = Div.cls("text-sm text-gray-800 dark:text-white/90").up(bread2)
	version1.text("Version: $VERSION$").uniline
	content1.comment(" Breadcrumb End ")
	
	Dim div1 As MiniHtml = Div.cls("space-y-5 sm:space-y-6").up(content1)
	Dim div2 As MiniHtml = Div.cls("rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03]").up(div1)
	Dim div3 As MiniHtml = Div.cls("border-t border-gray-100 p-5 sm:p-6 dark:border-gray-800").up(div2)	
	Dim div4 As MiniHtml = Div.cls("overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-gray-800 dark:bg-white/[0.03]").up(div3)
	
	Dim div5 As MiniHtml = Div.cls("flex flex-col gap-5 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between").up(div4)
	Dim div6 As MiniHtml = Div.up(div5)
	Dim heading3 As MiniHtml = H3.up(div6)
	heading3.cls("text-lg font-semibold text-gray-800 dark:text-white/90")
	heading3.textWrap("Categories")
	
	Dim div7 As MiniHtml = Div.up(div5)
	div7.cls("flex flex-col gap-3 sm:flex-row sm:items-center")

	Dim form1 As MiniHtml = Form.up(div7)
	Dim div8 As MiniHtml = Div.up(form1)
	div8.cls("relative")
	Dim span1 As MiniHtml = Div.up(div8)
	span1.cls("absolute -translate-y-1/2 pointer-events-none top-1/2 left-4")
	Dim svg1 As MiniHtml = Svg.up(span1)
	svg1.cls("fill-gray-500 dark:fill-gray-400")
	svg1.attr("width", 20).attr("height", 20)
	svg1.attr("viewBox", "0 0 20 20")
	Dim path1 As MiniHtml = SvgPath.up(svg1)
	path1.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path1.attr("d", "M3.04199 9.37381C3.04199 5.87712 5.87735 3.04218 9.37533 3.04218C12.8733 3.04218 15.7087 5.87712 15.7087 9.37381C15.7087 12.8705 12.8733 15.7055 9.37533 15.7055C5.87735 15.7055 3.04199 12.8705 3.04199 9.37381ZM9.37533 1.54218C5.04926 1.54218 1.54199 5.04835 1.54199 9.37381C1.54199 13.6993 5.04926 17.2055 9.37533 17.2055C11.2676 17.2055 13.0032 16.5346 14.3572 15.4178L17.1773 18.2381C17.4702 18.531 17.945 18.5311 18.2379 18.2382C18.5308 17.9453 18.5309 17.4704 18.238 17.1775L15.4182 14.3575C16.5367 13.0035 17.2087 11.2671 17.2087 9.37381C17.2087 5.04835 13.7014 1.54218 9.37533 1.54218Z")
	path1.attr("fill", "")
	path1.Mode = "self"
	Dim input1 As MiniHtml = Input.up(div8)
	input1.attr("type", "text")
	input1.attr("placeholder", "Search...")
	input1.attr("id", "search-input")
	input1.cls("dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-10 w-full rounded-lg border border-gray-300 bg-transparent py-2.5 pr-4 pl-[42px] text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden xl:w-[300px] dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30")
	input1.FormatAttributes = True
	Dim div9 As MiniHtml = Div.up(div7)
	Dim button1 As MiniHtml = Button.up(div9)
	button1.cls("text-theme-sm shadow-theme-xs inline-flex h-10 items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200")
	Dim svg1 As MiniHtml = Svg.up(button1)
	svg1.cls("stroke-current fill-white dark:fill-gray-800")
	svg1.attr("width", 20).attr("height", 20)
	svg1.attr("viewBox", "0 0 20 20")
	Dim path1 As MiniHtml = SvgPath.up(svg1)
	path1.attr("d", "M2.29004 5.90393H17.7067")
	path1.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")
	Dim path2 As MiniHtml = SvgPath.up(svg1)
	path2.attr("d", "M17.7075 14.0961H2.29085")
	path2.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")
	Dim path3 As MiniHtml = SvgPath.up(svg1)
	path3.attr("d", "M12.0826 3.33331C13.5024 3.33331 14.6534 4.48431 14.6534 5.90414C14.6534 7.32398 13.5024 8.47498 12.0826 8.47498C10.6627 8.47498 9.51172 7.32398 9.51172 5.90415C9.51172 4.48432 10.6627 3.33331 12.0826 3.33331Z")
	path3.attr("stroke", "").attr("stroke-width", "1.5")
	Dim path4 As MiniHtml = SvgPath.up(svg1)
	path4.attr("d", "M7.91745 11.525C6.49762 11.525 5.34662 12.676 5.34662 14.0959C5.34661 15.5157 6.49762 16.6667 7.91745 16.6667C9.33728 16.6667 10.4883 15.5157 10.4883 14.0959C10.4883 12.676 9.33728 11.525 7.91745 11.525Z")
	path4.attr("stroke", "").attr("stroke-width", "1.5")
	button1.textWrap(" Filter ")
	
	Dim div10 As MiniHtml = Div.up(div7)
	div10.attr("x-data", "{openDropDown: false}")
	div10.cls("relative")
	Dim button2 As MiniHtml = Button.up(div10)
	button2.attr("@click", "openDropDown = !openDropDown")
	button2.attr(":class", "openDropDown ? 'text-gray-700 dark:text-white' : 'text-gray-400 hover:text-gray-700 dark:hover:text-white'")
	button2.cls("text-gray-400 hover:text-gray-700 dark:hover:text-white")
	Dim svg2 As MiniHtml = Svg.up(button2)
	svg2.cls("fill-current")
	svg2.attr("width", 24).attr("height", 24)
	svg2.attr("viewBox", "0 0 24 24")
	Dim path21 As MiniHtml = SvgPath.up(svg2)
	path21.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path21.attr("d", "M10.2441 6C10.2441 5.0335 11.0276 4.25 11.9941 4.25H12.0041C12.9706 4.25 13.7541 5.0335 13.7541 6C13.7541 6.9665 12.9706 7.75 12.0041 7.75H11.9941C11.0276 7.75 10.2441 6.9665 10.2441 6ZM10.2441 18C10.2441 17.0335 11.0276 16.25 11.9941 16.25H12.0041C12.9706 16.25 13.7541 17.0335 13.7541 18C13.7541 18.9665 12.9706 19.75 12.0041 19.75H11.9941C11.0276 19.75 10.2441 18.9665 10.2441 18ZM11.9941 10.25C11.0276 10.25 10.2441 11.0335 10.2441 12C10.2441 12.9665 11.0276 13.75 11.9941 13.75H12.0041C12.9706 13.75 13.7541 12.9665 13.7541 12C13.7541 11.0335 12.9706 10.25 12.0041 10.25H11.9941Z")
	path21.attr("fill", "")
	
	Dim div11 As MiniHtml = Div.up(div10)
	div11.attr("x-show", "openDropDown")
	div11.attr("@click.outside", "openDropDown = false")
	div11.cls("absolute right-0 z-40 w-40 p-2 space-y-1 bg-white border border-gray-200 shadow-theme-lg dark:bg-gray-dark top-full rounded-2xl dark:border-gray-800")
	div11.sty("display: none")
	
	Dim button4 As MiniHtml = Button.up(div11)
	button4.cls("flex w-full px-3 py-2 font-medium text-left text-gray-500 rounded-lg text-theme-xs hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-white/5 dark:hover:text-gray-300")
	button4.textWrap("Add Category")
	
	Dim container1 As MiniHtml = Div.up(div4)
	container1.cls("max-w-full overflow-x-auto custom-scrollbar")
	container1.attr("id", "categories-container")
	container1.attr("hx-get", "/api/categories/table")
	container1.attr("hx-trigger", "load")
	container1.text("Loading...")

	Return content1
End Sub

Private Sub ModalContainer As MiniHtml
	Dim modal1 As MiniHtml = Div.attr("id", "modal-container")
	modal1.cls("modal fade")
	modal1.attr("tabindex", "-1")
	modal1.attr("aria-hidden", "true")
	Dim modalDialog As MiniHtml = Div.up(modal1).cls("modal-dialog modal-dialog-centered")
	Div.cls("modal-content").attr("id", "modal-content").up(modalDialog)
	Return modal1
End Sub

'Private Sub ToastContainer As MiniHtml
'	Dim div1 As MiniHtml = Div.cls("position-fixed end-0 p-3")
'	div1.sty("z-index: 2000")
'	div1.sty("bottom: 0%")
'	Dim toast1 As MiniHtml = Div.attr("id", "toast-container").up(div1)
'	toast1.cls("toast align-items-center text-bg-success border-0")
'	toast1.attr("role", "alert")
'	Dim div2 As MiniHtml = Div.cls("d-flex").up(toast1)
'	Dim div3 As MiniHtml = Div.cls("toast-body").attr("id", "toast-body").up(div2)
'	div3.text("Operation successful!")
'	Dim button1 As MiniHtml = Button.attr("type", "button").up(div2)
'	button1.cls("btn-close btn-close-white me-2 m-auto")
'	button1.attr("data-bs-dismiss", "toast")
'	Return div1
'End Sub

' Return table HTML
Private Sub HandleTable
	App.WriteHtml(Response, CreateCategoriesTable.Build)
End Sub

' Add modal
Private Sub HandleAddModal
	Dim form1 As MiniHtml = Form
	form1.attr("hx-post", "/api/categories")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	
	Dim modalHeader As MiniHtml = Div.up(form1).cls("modal-header")
	H5.up(modalHeader).cls("modal-title").text("Add Category")
	Button.up(modalHeader).attr("type", "button").cls("btn-close").attr("data-bs-dismiss", "modal")

	Dim modalBody As MiniHtml = Div.up(form1).cls("modal-body")
	Div.up(modalBody).attr("id", "modal-messages")
	
	Dim group1 As MiniHtml = Div.up(modalBody).cls("form-group")
	Label.up(group1).attr("for", "name").text("Name ").add(Span.cls("text-danger").text("*"))
	Input.up(group1).attr("type", "text").attr("id", "name").attr("name", "name").cls("form-control").required

	Dim modalFooter As MiniHtml = Div.up(form1).cls("modal-footer")
	Button.up(modalFooter).attr("type", "submit").cls("btn btn-success px-3").text("Create")
	Button.up(modalFooter).attr("type", "button").cls("btn btn-secondary px-3").attr("data-bs-dismiss", "modal").text("Cancel")
	App.WriteHtml(Response, form1.Build)
End Sub

' Edit modal
Private Sub HandleEditModal
	Dim id As String = Request.RequestURI.SubString("/api/categories/edit/".Length)
	Dim form1 As MiniHtml = Form
	form1.attr("hx-put", $"/api/categories"$)
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
		
	DB.SQL = DB.Open
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim name As String = DB.First.Get("name")

		Dim modalHeader As MiniHtml = Div.up(form1).cls("modal-header")
		H5.up(modalHeader).cls("modal-title").text("Edit Category")
		Button.up(modalHeader).attr("type", "button").cls("btn-close").attr("data-bs-dismiss", "modal")
		
		Dim modalBody As MiniHtml = Div.up(form1).cls("modal-body")
		Div.up(modalBody).attr("id", "modal-messages")
		Input.up(modalBody).attr("type", "hidden").attr("name", "id").attr("value", id)
		
		Dim group1 As MiniHtml = Div.up(modalBody).cls("form-group")
		Label.up(group1).attr("for", "name").text("Name ").add(Span.cls("text-danger").text("*"))
		Input.up(group1).attr("type", "text").cls("form-control").attr("id", "name").attr("name", "name").attr("value", name).required

		Dim modalFooter As MiniHtml = Div.up(form1).cls("modal-footer")
		Button.attr("type", "submit").cls("btn btn-primary px-3").text("Update").up(modalFooter)
		Button.attr("type", "button").cls("btn btn-secondary px-3").attr("data-bs-dismiss", "modal").text("Cancel").up(modalFooter)
	End If
	DB.Close
	App.WriteHtml(Response, form1.Build)
End Sub

' Delete modal
Private Sub HandleDeleteModal
	Dim id As String = Request.RequestURI.SubString("/api/categories/delete/".Length)
	Dim form1 As MiniHtml = Form
	form1.attr("hx-delete", $"/api/categories"$)
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")

	DB.SQL = DB.Open
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim name As String = DB.First.Get("name")

		Dim modalHeader As MiniHtml = Div.up(form1).cls("modal-header")
		H5.up(modalHeader).cls("modal-title").text("Delete Category")
		Button.up(modalHeader).attr("type", "button").cls("btn-close").attr("data-bs-dismiss", "modal")
		
		Dim modalBody As MiniHtml = Div.up(form1).cls("modal-body")
		Div.up(modalBody).attr("id", "modal-messages")
		Input.up(modalBody).attr("type", "hidden").attr("name", "id").attr("value", id)
		CreateTag("p").up(modalBody).text($"Delete ${name}?"$)

		Dim modalFooter As MiniHtml = Div.up(form1).cls("modal-footer")
		Button.up(modalFooter).attr("type", "submit").cls("btn btn-danger px-3").text("Delete")
		Button.up(modalFooter).attr("type", "button").cls("btn btn-secondary px-3").attr("data-bs-dismiss", "modal").text("Cancel")
	End If
	DB.Close
	App.WriteHtml(Response, form1.Build)
End Sub

' Handle CRUD operations
Private Sub HandleCategories
	Select Method
		Case "POST"
			' Create
			Dim name As String = Request.GetParameter("name")
			If name = "" Or name.Trim.Length < 2 Then
				ShowAlert("Category name must be at least 2 characters long.", "warning")
				Return
			End If
			Try
				DB.SQL = DB.Open
				DB.Table = "tbl_categories"
				DB.Conditions = Array("category_name = ?")
				DB.Parameters = Array(name)
				DB.Query
				If DB.Found Then
					ShowAlert("Category already exists!", "warning")
					DB.Close
					Return
				End If
			Catch
				Log(LastException)
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try

			' Insert new row
			Try
				DB.Reset
				DB.Columns = Array("category_name", "created_date")
				DB.Parameters = Array(name, Main.CurrentDateTime)
				DB.Save
				ShowToast("Category", "created", "Category created successfully!", "success")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
		Case "PUT"
			' Update
			Dim id As Int = Request.GetParameter("id")
			Dim name As String = Request.GetParameter("name")
			DB.SQL = DB.Open
			DB.Table = "tbl_categories"
			
			DB.Find(id)
			If DB.Found = False Then
				ShowAlert("Category not found!", "warning")
				DB.Close
				Return
			End If

			DB.Reset
			DB.Conditions = Array("category_name = ?", "id <> ?")
			DB.Parameters = Array(name, id)
			DB.Query
			If DB.Found Then
				ShowAlert("Category already exists!", "warning")
				DB.Close
				Return
			End If
			
			' Update row
			Try
				DB.Reset
				DB.Columns = Array("category_name", "modified_date")
				DB.Parameters = Array(name, Main.CurrentDateTime)
				DB.Id = id
				DB.Save
				ShowToast("Category", "updated", "Category updated successfully!", "info")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
		Case "DELETE"
			' Delete
			Dim id As Int = Request.GetParameter("id")
			DB.SQL = DB.Open
			DB.Table = "tbl_categories"
			
			DB.Find(id)
			If DB.Found = False Then
				ShowAlert("Category not found!", "warning")
				DB.Close
				Return
			End If
			
			DB.Table = "tbl_products"
			DB.WhereParam("category_id = ?", id)
			DB.Query
			If DB.Found Then
				ShowAlert("Cannot delete category with associated products!", "warning")
				DB.Close
				Return
			End If

			' Delete row
			Try
				DB.Table = "tbl_categories"
				DB.Id = id
				DB.Delete
				ShowToast("Category", "deleted", "Category deleted successfully!", "danger")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
	End Select
End Sub

Private Sub CreateCategoriesTable As MiniHtml
	Dim table1 As MiniHtml = Table.cls("min-w-full")
	Dim thead1 As MiniHtml = Thead.up(table1).cls("border-gray-100 border-y bg-gray-50 dark:border-gray-800 dark:bg-gray-900")
	Dim trow1 As MiniHtml = Tr.up(thead1)

	Dim th1 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv1 As MiniHtml = Div.up(th1).cls("flex items-center justify-end")
	CreateTag("p").up(thdiv1).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("#")
	
	Dim th2 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv2 As MiniHtml = Div.up(th2).cls("flex items-center")
	CreateTag("p").up(thdiv2).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Name")
	
	Dim th3 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv3 As MiniHtml = Div.up(th3).cls("flex items-center justify-center")
	CreateTag("p").up(thdiv3).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Actions")
	
	Dim tbody1 As MiniHtml = Tbody.up(table1).cls("divide-y divide-gray-100 dark:divide-gray-800")
	
	DB.SQL = DB.Open
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.OrderBy = CreateMap("id": "")
	DB.Query
	For Each row As Map In DB.Results
		Dim tr1 As MiniHtml = CreateCategoriesRow(row)
		tr1.up(tbody1)
	Next
	DB.Close
	Return table1
End Sub

Private Sub CreateCategoriesRow (data As Map) As MiniHtml
	Dim id As Int = data.Get("id")
	Dim name As String = data.Get("name")

	Dim tr1 As MiniHtml = Tr
	Dim td1 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td1.add(Div.cls("flex items-center justify-end")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(id))
	td1.multiline
	Dim td2 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td2.add(Div.cls("flex items-center")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(name))
	td2.multiline
	Dim td3 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td3.multiline
	Dim div3 As MiniHtml = Div.up(td3).cls("flex items-center justify-center")
	
	Dim anchor1 As MiniHtml = Anchor.up(div3).cls("edit text-primary mx-2")
	anchor1.attr("hx-get", $"/api/categories/edit/${id}"$)
	anchor1.attr("hx-target", "#modal-content")
	anchor1.attr("hx-trigger", "click")
	anchor1.attr("data-bs-toggle", "modal")
	anchor1.attr("data-bs-target", "#modal-container")
	anchor1.add(Icon.cls("bi bi-pencil"))
	anchor1.attr("title", "Edit")
		
	Dim anchor2 As MiniHtml = Anchor.up(div3).cls("delete text-danger mx-2")
	anchor2.attr("hx-get", $"/api/categories/delete/${id}"$)
	anchor2.attr("hx-target", "#modal-content")
	anchor2.attr("hx-trigger", "click")
	anchor2.attr("data-bs-toggle", "modal")
	anchor2.attr("data-bs-target", "#modal-container")
	anchor2.add(Icon.cls("bi bi-trash3"))
	anchor2.attr("title", "Delete")
	
	Return tr1
End Sub

Private Sub ShowAlert (message As String, status As String)
	Dim div1 As MiniHtml = Div.cls("alert alert-" & status).text(message)
	App.WriteHtml(Response, div1.Build)
End Sub

Private Sub ShowToast (entity As String, action As String, message As String, status As String)
	Dim div1 As MiniHtml = Div.attr("id", "categories-container")
	div1.attr("hx-swap-oob", "true")
	div1.add(CreateCategoriesTable)

	Dim script1 As MiniJs
	script1.Initialize
	script1.AddCustomEventDispatch("entity:changed", _
	CreateMap( _
	"entity": entity, _
	"action": action, _
	"message": message, _
	"status": status))

	App.WriteHtml(Response, div1.Build & CRLF & script1.Generate)
End Sub