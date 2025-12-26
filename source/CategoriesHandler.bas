B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Categories Handler class
' Version 6.00
Sub Class_Globals
	Private DB As MiniORM
	Private App As EndsMeet
	Private Method As String
	Private Request As ServletRequest
	Private Response As ServletResponse
End Sub

Public Sub Initialize
	App = Main.App
	DB.Initialize(Main.DBType, Null)
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	Method = req.Method
	Log($"${Request.Method}: ${Request.RequestURI}"$)
	Dim path As String = req.RequestURI
	If path = "/categories" Then
		RenderPage
	Else If path = "/api/categories/table" Then
		HandleTable
	Else If path = "/api/categories/add" Then
		HandleAddModal
	Else If path.StartsWith("/api/categories/edit/") Then
		HandleEditModal
	Else If path.StartsWith("/api/categories/delete/") Then
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
	main1.LoadToast(ToastContainer)

	Dim page1 As Tag = main1.View
'	Dim body1 As Tag = page1.Child(1)
'	Dim nav1 As Tag = body1.Child(1)
'	Dim container1 As Tag = nav1.Child(0)
'	Dim navbar1 As Tag = container1.Child(3)
'	Dim ulist1 As Tag = navbar1.Child(0)
'	Dim list1 As Tag = Li.cls("nav-item d-block d-lg-block").up(ulist1)
'	Dim anchor1 As Tag = Anchor.href("#").up(list1)
'	anchor1.cls("nav-link")
'	anchor1.text("Categories")

	' Sample for adding additional menu link
	'Dim list2 As Tag = Li.cls("nav-item d-block d-lg-block").up(ulist1)
	'Dim anchor2 As Tag = Anchor.href("/users").up(list2)
	'anchor2.cls("nav-link")
	'anchor2.text("Users")
	
'	Dim doc As Document
'	doc.Initialize
'	doc.AppendDocType
'	doc.Append(page1.build)
'	App.WriteHtml2(Response, doc.ToString, App.ctx)
	App.WriteHtml2(Response, page1.Build, App.ctx)
End Sub

Private Sub ContentContainer As Tag
'	Dim content1 As Tag = Div.cls("row mt-3 text-center align-items-center justify-content-center")
'	Dim col1 As Tag = Div.cls("col-md-12 col-lg-6").up(content1)
'	Dim form1 As Tag = Form.cls("form mb-3").action("").up(col1)
'	Dim row1 As Tag = Div.cls("row").up(form1)
'	Dim col2 As Tag = Div.cls("col-md-6 col-lg-6 text-start").up(row1)
'	H3.text("CATEGORY LIST").up(col2)
'	Dim div1 As Tag = Div.cls("col-md-6 col-lg-6").up(row1)
'	Dim div2 As Tag = Div.cls("text-end mt-2").up(div1)
'	
'	Dim anchor1 As Tag = Anchor.up(div2)
'	anchor1.hrefOf("$SERVER_URL$")
'	anchor1.cls("btn btn-primary me-2")
'	anchor1.add(Icon.cls("bi bi-house me-2"))
'	anchor1.text("Home")
'
'	Dim button2 As Tag = Button.up(div2)
'	button2.cls("btn btn-success ml-2")
'	button2.hxGet("/api/categories/add")
'	button2.hxTarget("#modal-content")
'	button2.hxTrigger("click")
'	button2.data("bs-toggle", "modal")
'	button2.data("bs-target", "#modal-container")
'	button2.add(Icon.cls("bi bi-plus-lg me-2"))
'	button2.text("Add Category")

	Dim content1 As Tag = Div.cls("mx-auto max-w-(--breakpoint-2xl) p-4 pb-20 md:p-6 md:pb-6")
	content1.comment(" Breadcrumb Start ")
	Dim bread1 As Tag = Div.x("data", "{ pageName: `Categories`}").up(content1)
	Dim bread2 As Tag = Div.cls("flex flex-wrap items-center justify-between gap-3 mb-6").up(bread1)
	Dim heading2 As Tag = H2.up(bread2)
	heading2.cls("text-xl font-semibold text-gray-800 dark:text-white/90")
	heading2.text("$HOME_TITLE$")
	Dim version1 As Tag = Div.cls("text-sm text-gray-800 dark:text-white/90").up(bread2)
	version1.text("Version: $VERSION$").uniline
	content1.comment(" Breadcrumb End ")
	
	Dim div1 As Tag = Div.cls("space-y-5 sm:space-y-6").up(content1)
	Dim div2 As Tag = Div.cls("rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03]").up(div1)
	Dim div3 As Tag = Div.cls("border-t border-gray-100 p-5 sm:p-6 dark:border-gray-800").up(div2)	
	Dim div4 As Tag = Div.cls("overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-gray-800 dark:bg-white/[0.03]").up(div3)
	
	Dim div5 As Tag = Div.cls("flex flex-col gap-5 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between").up(div4)
	Dim div6 As Tag = Div.up(div5)
	Dim heading3 As Tag = H3.up(div6)
	heading3.cls("text-lg font-semibold text-gray-800 dark:text-white/90")
	heading3.textWrap("Categories")
	
	Dim div7 As Tag = Div.up(div5)
	div7.cls("flex flex-col gap-3 sm:flex-row sm:items-center")

	Dim form1 As Tag = Form.up(div7)
	Dim div8 As Tag = Div.up(form1)
	div8.cls("relative")
	Dim span1 As Tag = Div.up(div8)
	span1.cls("absolute -translate-y-1/2 pointer-events-none top-1/2 left-4")
	Dim svg1 As Tag = Svg.up(span1)
	svg1.cls("fill-gray-500 dark:fill-gray-400")
	svg1.width(20).height(20)
	svg1.viewBox("0 0 20 20")
	Dim path1 As Tag = SvgPath.up(svg1)
	path1.rules("evenodd", "evenodd")
	path1.d("M3.04199 9.37381C3.04199 5.87712 5.87735 3.04218 9.37533 3.04218C12.8733 3.04218 15.7087 5.87712 15.7087 9.37381C15.7087 12.8705 12.8733 15.7055 9.37533 15.7055C5.87735 15.7055 3.04199 12.8705 3.04199 9.37381ZM9.37533 1.54218C5.04926 1.54218 1.54199 5.04835 1.54199 9.37381C1.54199 13.6993 5.04926 17.2055 9.37533 17.2055C11.2676 17.2055 13.0032 16.5346 14.3572 15.4178L17.1773 18.2381C17.4702 18.531 17.945 18.5311 18.2379 18.2382C18.5308 17.9453 18.5309 17.4704 18.238 17.1775L15.4182 14.3575C16.5367 13.0035 17.2087 11.2671 17.2087 9.37381C17.2087 5.04835 13.7014 1.54218 9.37533 1.54218Z")
	path1.fill("")
	path1.Mode = "self"
	Dim input1 As Tag = Input.up(div8)
	input1.typeOf("text")
	input1.attr("placeholder", "Search...")
	input1.id("search-input")
	input1.cls("dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-10 w-full rounded-lg border border-gray-300 bg-transparent py-2.5 pr-4 pl-[42px] text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden xl:w-[300px] dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30")
	input1.FormatAttributes = True
	Dim div9 As Tag = Div.up(div7)
	Dim button1 As Tag = Button.up(div9)
	button1.cls("text-theme-sm shadow-theme-xs inline-flex h-10 items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200")
	Dim svg1 As Tag = Svg.up(button1)
	svg1.cls("stroke-current fill-white dark:fill-gray-800")
	svg1.width(20).height(20)
	svg1.viewBox("0 0 20 20")
	Dim path1 As Tag = SvgPath.up(svg1)
	path1.d("M2.29004 5.90393H17.7067")
	path1.strokes("", "1.5", "round", "round")
	Dim path2 As Tag = SvgPath.up(svg1)
	path2.d("M17.7075 14.0961H2.29085")
	path2.strokes("", "1.5", "round", "round")
	Dim path3 As Tag = SvgPath.up(svg1)
	path3.d("M12.0826 3.33331C13.5024 3.33331 14.6534 4.48431 14.6534 5.90414C14.6534 7.32398 13.5024 8.47498 12.0826 8.47498C10.6627 8.47498 9.51172 7.32398 9.51172 5.90415C9.51172 4.48432 10.6627 3.33331 12.0826 3.33331Z")
	path3.strokes("", "1.5", "", "")
	Dim path4 As Tag = SvgPath.up(svg1)
	path4.d("M7.91745 11.525C6.49762 11.525 5.34662 12.676 5.34662 14.0959C5.34661 15.5157 6.49762 16.6667 7.91745 16.6667C9.33728 16.6667 10.4883 15.5157 10.4883 14.0959C10.4883 12.676 9.33728 11.525 7.91745 11.525Z")
	path4.strokes("", "1.5", "", "")
	button1.textWrap(" Filter ")
	
	Dim div10 As Tag = Div.up(div7)
	div10.x("data", "{openDropDown: false}")
	div10.cls("relative")
	Dim button2 As Tag = Button.up(div10)
	button2.on("click", "openDropDown = !openDropDown")
	button2.bind("class", "openDropDown ? 'text-gray-700 dark:text-white' : 'text-gray-400 hover:text-gray-700 dark:hover:text-white'")
	button2.cls("text-gray-400 hover:text-gray-700 dark:hover:text-white")
	Dim svg2 As Tag = Svg.up(button2)
	svg2.cls("fill-current")
	svg2.width(24).height(24)
	svg2.viewBox("0 0 24 24")
	Dim path21 As Tag = SvgPath.up(svg2)
	path21.rules("evenodd", "evenodd")
	path21.d("M10.2441 6C10.2441 5.0335 11.0276 4.25 11.9941 4.25H12.0041C12.9706 4.25 13.7541 5.0335 13.7541 6C13.7541 6.9665 12.9706 7.75 12.0041 7.75H11.9941C11.0276 7.75 10.2441 6.9665 10.2441 6ZM10.2441 18C10.2441 17.0335 11.0276 16.25 11.9941 16.25H12.0041C12.9706 16.25 13.7541 17.0335 13.7541 18C13.7541 18.9665 12.9706 19.75 12.0041 19.75H11.9941C11.0276 19.75 10.2441 18.9665 10.2441 18ZM11.9941 10.25C11.0276 10.25 10.2441 11.0335 10.2441 12C10.2441 12.9665 11.0276 13.75 11.9941 13.75H12.0041C12.9706 13.75 13.7541 12.9665 13.7541 12C13.7541 11.0335 12.9706 10.25 12.0041 10.25H11.9941Z")
	path21.fill("")
	
	Dim div11 As Tag = Div.up(div10)
	div11.x("show", "openDropDown")
	div11.on("click.outside", "openDropDown = false")
	div11.cls("absolute right-0 z-40 w-40 p-2 space-y-1 bg-white border border-gray-200 shadow-theme-lg dark:bg-gray-dark top-full rounded-2xl dark:border-gray-800")
	div11.sty("display: none")
	
	'Dim button3 As Tag = Button.up(div11)
	'button3.cls("flex w-full px-3 py-2 font-medium text-left text-gray-500 rounded-lg text-theme-xs hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-white/5 dark:hover:text-gray-300")
	'button3.textWrap("Home")
	Dim button4 As Tag = Button.up(div11)
	button4.cls("flex w-full px-3 py-2 font-medium text-left text-gray-500 rounded-lg text-theme-xs hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-white/5 dark:hover:text-gray-300")
	button4.textWrap("Add Category")
	
'	Dim anchor1 As Tag = Anchor.up(div9)
'	anchor1.hrefOf("$SERVER_URL$")
'	anchor1.cls("btn btn-primary me-2")
'	anchor1.add(Icon.cls("bi bi-house me-2"))
'	anchor1.text("Home")
'
'	Dim button2 As Tag = Button.up(div9)
'	button2.cls("btn btn-success ml-2")
'	button2.hxGet("/api/categories/add")
'	button2.hxTarget("#modal-content")
'	button2.hxTrigger("click")
'	button2.data("bs-toggle", "modal")
'	button2.data("bs-target", "#modal-container")
'	button2.add(Icon.cls("bi bi-plus-lg me-2"))
'	button2.text("Add Category")
	
	Dim container1 As Tag = Div.up(div4)
	container1.cls("max-w-full overflow-x-auto custom-scrollbar")

	'Dim container1 As Tag = Div.up(div5)
	container1.id("categories-container")
	container1.hxGet("/api/categories/table")
	container1.hxTrigger("load")
	container1.text("Loading...")

	Return content1
End Sub

Private Sub ModalContainer As Tag
	Dim modal1 As Tag = Div.id("modal-container")
	modal1.cls("modal fade")
	modal1.attr("tabindex", "-1")
	modal1.aria("hidden", "true")
	Dim modalDialog As Tag = Div.up(modal1).cls("modal-dialog modal-dialog-centered")
	Div.cls("modal-content").id("modal-content").up(modalDialog)
	Return modal1
End Sub

Private Sub ToastContainer As Tag
	Dim div1 As Tag = Div.cls("position-fixed end-0 p-3")
	div1.sty("z-index: 2000")
	div1.sty("bottom: 0%")
	Dim toast1 As Tag = Div.id("toast-container").up(div1)
	toast1.cls("toast align-items-center text-bg-success border-0")
	toast1.attr("role", "alert")
	Dim div2 As Tag = Div.cls("d-flex").up(toast1)
	Dim div3 As Tag = Div.cls("toast-body").id("toast-body").up(div2)
	div3.text("Operation successful!")
	Dim button1 As Tag = Button.typeOf("button").up(div2)
	button1.cls("btn-close btn-close-white me-2 m-auto")
	button1.data("bs-dismiss", "toast")
	Return div1
End Sub

' Return table HTML
Private Sub HandleTable
	App.WriteHtml(Response, CreateCategoriesTable.Build)
End Sub

' Add modal
Private Sub HandleAddModal
	Dim form1 As Tag = Form.init
	form1.hxPost("/api/categories")
	form1.hxTarget("#modal-messages")
	form1.hxSwap("innerHTML")
	
	Dim modalHeader As Tag = Div.cls("modal-header").up(form1)
	H5.cls("modal-title").text("Add Category").up(modalHeader)
	Button.typeOf("button").cls("btn-close").data("bs-dismiss", "modal").up(modalHeader)

	Dim modalBody As Tag = Div.cls("modal-body").up(form1)
	Div.id("modal-messages").up(modalBody)'.hxSwapOob("true")
	
	Dim group1 As Tag = modalBody.add(Div.cls("form-group"))
	Label.forId("name").text("Name ").up(group1).add(Span.cls("text-danger").text("*"))
	Input.typeOf("text").up(group1).id("name").name("name").cls("form-control").attr3("required")

	Dim modalFooter As Tag = Div.cls("modal-footer").up(form1)
	Button.typeOf("submit").cls("btn btn-success px-3").text("Create").up(modalFooter)
	Button.typeOf("button").cls("btn btn-secondary px-3").data("bs-dismiss", "modal").text("Cancel").up(modalFooter)
	App.WriteHtml(Response, form1.Build)
End Sub

' Edit modal
Private Sub HandleEditModal
	Dim id As String = Request.RequestURI.SubString("/api/categories/edit/".Length)
	Dim form1 As Tag = Form.init
	form1.hxPut($"/api/categories"$)
	form1.hxTarget("#modal-messages")
	form1.hxSwap("innerHTML")
		
	DB.SQL = Main.DBOpen
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim name As String = DB.First.Get("name")

		Dim modalHeader As Tag = Div.cls("modal-header").up(form1)
		H5.cls("modal-title").text("Edit Category").up(modalHeader)
		Button.typeOf("button").cls("btn-close").data("bs-dismiss", "modal").up(modalHeader)
		
		Dim modalBody As Tag = Div.cls("modal-body").up(form1)
		Div.id("modal-messages").up(modalBody)
		Input.typeOf("hidden").up(modalBody).name("id").valueOf(id)
		
		Dim group1 As Tag = Div.cls("form-group").up(modalBody)
		Label.forId("name").text("Name ").up(group1).add(Span.cls("text-danger").text("*"))
		Input.typeOf("text").cls("form-control").id("name").name("name").valueOf(name).attr3("required").up(group1)

		Dim modalFooter As Tag = Div.cls("modal-footer").up(form1)
		Button.typeOf("submit").cls("btn btn-primary px-3").text("Update").up(modalFooter)
		Button.typeOf("button").cls("btn btn-secondary px-3").data("bs-dismiss", "modal").text("Cancel").up(modalFooter)
	End If
	DB.Close
	App.WriteHtml(Response, form1.Build)
End Sub

' Delete modal
Private Sub HandleDeleteModal
	Dim id As String = Request.RequestURI.SubString("/api/categories/delete/".Length)
	Dim form1 As Tag = Form.init
	form1.hxDelete($"/api/categories"$)
	form1.hxTarget("#modal-messages")
	form1.hxSwap("innerHTML")

	DB.SQL = Main.DBOpen
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim name As String = DB.First.Get("name")

		Dim modalHeader As Tag = Div.cls("modal-header").up(form1)
		H5.cls("modal-title").text("Delete Category").up(modalHeader)
		Button.typeOf("button").cls("btn-close").data("bs-dismiss", "modal").up(modalHeader)
		
		Dim modalBody As Tag = Div.cls("modal-body").up(form1)
		Div.id("modal-messages").up(modalBody)
		Input.typeOf("hidden").name("id").valueOf(id).up(modalBody)
		Paragraph.text($"Delete ${name}?"$).up(modalBody)

		Dim modalFooter As Tag = Div.cls("modal-footer").up(form1)
		Button.typeOf("submit").cls("btn btn-danger px-3").text("Delete").up(modalFooter)
		Button.typeOf("button").cls("btn btn-secondary px-3").data("bs-dismiss", "modal").text("Cancel").up(modalFooter)
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
				DB.SQL = Main.DBOpen
				DB.Table = "tbl_categories"
				DB.Where = Array("category_name = ?")
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
			DB.SQL = Main.DBOpen
			DB.Table = "tbl_categories"
			
			DB.Find(id)
			If DB.Found = False Then
				ShowAlert("Category not found!", "warning")
				DB.Close
				Return
			End If

			DB.Reset
			DB.Where = Array("category_name = ?", "id <> ?")
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
			DB.SQL = Main.DBOpen
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

Private Sub CreateCategoriesTable As Tag
	
'	Dim div1 As Tag = Div.cls("space-y-5 sm:space-y-6")
'	Dim div2 As Tag = Div.cls("rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03]").up(div1)
'	Dim div3 As Tag = Div.cls("border-t border-gray-100 p-5 sm:p-6 dark:border-gray-800").up(div2)	
'	Dim div4 As Tag = Div.cls("overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-gray-800 dark:bg-white/[0.03]").up(div3)
	
'	Dim div5 As Tag = Div.cls("flex flex-col gap-5 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between").up(div4)
'	div5.add(Div.add(H3.cls("text-lg font-semibold text-gray-800 dark:text-white/90").textWrap("Categories")))
'	Dim div6 As Tag = div5.add(Div.cls("flex flex-col gap-3 sm:flex-row sm:items-center"))
'	
'	Dim form1 As Tag = Form.up(div6)
'	Dim div7 As Tag = Div.up(form1)
'	div7.cls("relative")
'	Dim span1 As Tag = Div.up(div7)
'	span1.cls("absolute -translate-y-1/2 pointer-events-none top-1/2 left-4")
'	Dim svg1 As Tag = Svg.up(span1)
'	svg1.cls("fill-gray-500 dark:fill-gray-400")
'	svg1.width(20).height(20)
'	svg1.viewBox("0 0 20 20")
'	Dim path1 As Tag = SvgPath.up(svg1)
'	path1.rules("evenodd", "evenodd")
'	path1.d("M3.04199 9.37381C3.04199 5.87712 5.87735 3.04218 9.37533 3.04218C12.8733 3.04218 15.7087 5.87712 15.7087 9.37381C15.7087 12.8705 12.8733 15.7055 9.37533 15.7055C5.87735 15.7055 3.04199 12.8705 3.04199 9.37381ZM9.37533 1.54218C5.04926 1.54218 1.54199 5.04835 1.54199 9.37381C1.54199 13.6993 5.04926 17.2055 9.37533 17.2055C11.2676 17.2055 13.0032 16.5346 14.3572 15.4178L17.1773 18.2381C17.4702 18.531 17.945 18.5311 18.2379 18.2382C18.5308 17.9453 18.5309 17.4704 18.238 17.1775L15.4182 14.3575C16.5367 13.0035 17.2087 11.2671 17.2087 9.37381C17.2087 5.04835 13.7014 1.54218 9.37533 1.54218Z")
'	path1.fill("")
'	path1.Mode = "self"
'	Dim input1 As Tag = Input.up(div7)
'	input1.typeOf("text")
'	input1.attr("placeholder", "Search...")
'	input1.id("search-input")
'	input1.cls("dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-10 w-full rounded-lg border border-gray-300 bg-transparent py-2.5 pr-4 pl-[42px] text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden xl:w-[300px] dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30")
'	input1.FormatAttributes = True
'	Dim div8 As Tag = Div.up(div6)
'	Dim button1 As Tag = Button.up(div8)
'	button1.cls("text-theme-sm shadow-theme-xs inline-flex h-10 items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200")
'	Dim svg1 As Tag = Svg.up(button1)
'	svg1.cls("stroke-current fill-white dark:fill-gray-800")
'	svg1.width(20).height(20)
'	svg1.viewBox("0 0 20 20")
'	Dim path1 As Tag = SvgPath.up(svg1)
'	path1.d("M2.29004 5.90393H17.7067")
'	path1.strokes("", "1.5", "round", "round")
'	Dim path2 As Tag = SvgPath.up(svg1)
'	path2.d("M17.7075 14.0961H2.29085")
'	path2.strokes("", "1.5", "round", "round")
'	Dim path3 As Tag = SvgPath.up(svg1)
'	path3.d("M12.0826 3.33331C13.5024 3.33331 14.6534 4.48431 14.6534 5.90414C14.6534 7.32398 13.5024 8.47498 12.0826 8.47498C10.6627 8.47498 9.51172 7.32398 9.51172 5.90415C9.51172 4.48432 10.6627 3.33331 12.0826 3.33331Z")
'	path3.strokes("", "1.5", "", "")
'	Dim path4 As Tag = SvgPath.up(svg1)
'	path4.d("M7.91745 11.525C6.49762 11.525 5.34662 12.676 5.34662 14.0959C5.34661 15.5157 6.49762 16.6667 7.91745 16.6667C9.33728 16.6667 10.4883 15.5157 10.4883 14.0959C10.4883 12.676 9.33728 11.525 7.91745 11.525Z")
'	path4.strokes("", "1.5", "", "")
'	button1.textWrap(" Filter ")
'	
'	Dim div5 As Tag = Div.up(div4)
'	div5.cls("max-w-full overflow-x-auto custom-scrollbar")
	
	Dim table1 As Tag = HtmlTable.cls("min-w-full")
	Dim thead1 As Tag = Thead.cls("border-gray-100 border-y bg-gray-50 dark:border-gray-800 dark:bg-gray-900").up(table1)
	Dim trow1 As Tag = Tr.up(thead1)

	Dim th1 As Tag = Th.cls("px-6 py-3 whitespace-nowrap").up(trow1)
	Dim thdiv1 As Tag = Div.cls("flex items-center justify-end").up(th1)
	Paragraph.cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("#").up(thdiv1)
	
	Dim th2 As Tag = Th.cls("px-6 py-3 whitespace-nowrap").up(trow1)
	Dim thdiv2 As Tag = Div.cls("flex items-center").up(th2)
	Paragraph.cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Name").up(thdiv2)
	
	Dim th3 As Tag = Th.cls("px-6 py-3 whitespace-nowrap").up(trow1)
	Dim thdiv3 As Tag = Div.cls("flex items-center justify-center").up(th3)
	Paragraph.cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Actions").up(thdiv3)
	
	Dim tbody1 As Tag = Tbody.cls("divide-y divide-gray-100 dark:divide-gray-800").up(table1)
	
	DB.SQL = Main.DBOpen
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.OrderBy = CreateMap("id": "")
	DB.Query
	For Each row As Map In DB.Results
		Dim tr1 As Tag = CreateCategoriesRow(row)
		tr1.up(tbody1)
	Next
	DB.Close
	Return table1
End Sub

Private Sub CreateCategoriesRow (data As Map) As Tag
	Dim id As Int = data.Get("id")
	Dim name As String = data.Get("name")

	Dim tr1 As Tag = Tr.init
	Dim td1 As Tag = Td.cls("px-6 py-3 whitespace-nowrap").up(tr1)
	td1.add(Div.cls("flex items-center justify-end")).add(Paragraph.cls("text-gray-700 text-theme-sm dark:text-gray-400").text(id))
	td1.multiline
	Dim td2 As Tag = Td.cls("px-6 py-3 whitespace-nowrap").up(tr1)
	td2.add(Div.cls("flex items-center")).add(Paragraph.cls("text-gray-700 text-theme-sm dark:text-gray-400").text(name))
	td2.multiline
	Dim td3 As Tag = Td.cls("px-6 py-3 whitespace-nowrap").up(tr1)
	td3.multiline
	Dim div3 As Tag = Div.cls("flex items-center justify-center").up(td3)
	
	Dim anchor1 As Tag = Anchor.cls("edit text-primary mx-2").up(div3)
	anchor1.hxGet($"/api/categories/edit/${id}"$)
	anchor1.hxTarget("#modal-content")
	anchor1.hxTrigger("click")
	anchor1.data("bs-toggle", "modal")
	anchor1.data("bs-target", "#modal-container")
	anchor1.add(Icon.cls("bi bi-pencil"))
	anchor1.attr("title", "Edit")
		
	Dim anchor2 As Tag = Anchor.cls("delete text-danger mx-2").up(div3)
	anchor2.hxGet($"/api/categories/delete/${id}"$)
	anchor2.hxTarget("#modal-content")
	anchor2.hxTrigger("click")
	anchor2.data("bs-toggle", "modal")
	anchor2.data("bs-target", "#modal-container")
	anchor2.add(Icon.cls("bi bi-trash3"))
	anchor2.attr("title", "Delete")
	
	Return tr1
End Sub

Private Sub ShowAlert (message As String, status As String)
	Dim div1 As Tag = Div.cls("alert alert-" & status).text(message)
	App.WriteHtml(Response, div1.Build)
End Sub

Private Sub ShowToast (entity As String, action As String, message As String, status As String)
	Dim div1 As Tag = Div.id("categories-container")
	div1.hxSwapOob("true")
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