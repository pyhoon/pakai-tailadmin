B4J=true
Group=Views
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' Categories View
' Version 6.80
Sub Class_Globals
	Private App As EndsMeet
	Private CategoryMap As Map
End Sub

Public Sub Initialize
	App = Main.App
End Sub

Private Sub ExistInCache (Key As String) As Boolean
	Return App.ctx.ContainsKey(Key)
End Sub

Private Sub ReadFromCache (Key As String) As Object
	Dim Value As Object = App.ctx.Get(Key)
	If Value Is MiniHtml Then
		Return Value
	Else If GetType(Value) = "[B" Then
		Return MH.ConvertFromBytes(Value)
	Else
		Return Value
	End If
End Sub

Private Sub WriteToCache (Key As String, Value As Object)
	App.ctx.Put(Key, Value)
End Sub

Public Sub setCategory (Data As Map)
	CategoryMap = Data
End Sub

Public Sub Show As String
	Dim CacheName As String = "Categories Page"
	If ExistInCache(CacheName) = False Then
		WriteToCache(CacheName, CategoriesPage)
	End If
	Dim page1 As MiniHtml = ReadFromCache(CacheName)
	Dim doc As MiniHtml
	doc.Initialize("")
	doc.Write("<!DOCTYPE html>")
	doc.Write(page1.build)
	Return doc.ToString
End Sub

Public Sub Modal (Action As String) As String
	Select Action
		Case "Add"
			Dim CacheName As String = "Categories Add Modal"
			If ExistInCache(CacheName) = False Then
				WriteToCache(CacheName, ModalAdd)
			End If
		Case "Edit"
			Dim CacheName As String = "Categories Edit Modal"
			If ExistInCache(CacheName) = False Then
				WriteToCache(CacheName, ModalEdit)
			End If
		Case "Delete"
			Dim CacheName As String = "Categories Delete Modal"
			If ExistInCache(CacheName) = False Then
				WriteToCache(CacheName, ModalDelete)
			End If
	End Select
	Dim modal1 As MiniHtml = ReadFromCache(CacheName)
	Return modal1.build
End Sub

Public Sub Alert (info As AlertInfo) As String
	Dim div1 As MiniHtml = MH.Div
	div1.cls("alert alert-" & info.Status)
	div1.text(info.Message)
	Return div1.build
End Sub

Public Sub Toast (info As ToastInfo, data As List) As String
	Dim div1 As MiniHtml = MH.Div
	div1.attr("id", "categories-container")
	div1.attr("hx-swap-oob", "true")
	CategoriesTableFilled(data).up(div1)
	Dim script1 As MiniJs
	script1.Initialize
	script1.AddCustomEventDispatch("entity:changed", _
	CreateMap( _
	"entity": info.Entity, _
	"action": info.Action, _
	"message": info.Message, _
	"status": info.Status))
	Return div1.build & CRLF & script1.Generate
End Sub

Public Sub RenderedTable (data As List) As String
	Return CategoriesTableFilled(data).build
End Sub

Private Sub CategoriesPage As MiniHtml
	Dim main1 As MainView
	main1.Initialize
	main1.LoadContent(ContainerContent)
	'main1.LoadModal(ContainerModal)
	'main1.LoadToast(ContainerToast)
	Dim page1 As MiniHtml = main1.Render
	Return page1
End Sub

Private Sub ContainerContent As MiniHtml
	Dim content1 As MiniHtml = MH.Div.cls("mx-auto max-w-(--breakpoint-2xl) p-4 pb-20 md:p-6 md:pb-6")
	content1.comment(" Breadcrumb Start ")
	Dim bread1 As MiniHtml = MH.Div.up(content1).attr("x-data", "{ pageName: `Categories`}")
	Dim bread2 As MiniHtml = MH.Div.up(bread1).cls("flex flex-wrap items-center justify-between gap-3 mb-6")
	Dim heading2 As MiniHtml = MH.H2.up(bread2)
	heading2.cls("text-xl font-semibold text-gray-800 dark:text-white/90")
	heading2.text("$HOME_TITLE$")
	Dim version1 As MiniHtml = MH.Div.cls("text-sm text-gray-800 dark:text-white/90").up(bread2)
	version1.text("Version: $VERSION$").uniline
	content1.comment(" Breadcrumb End ")
	
	Dim div1 As MiniHtml = MH.Div.up(content1).cls("space-y-5 sm:space-y-6")
	Dim div2 As MiniHtml = MH.Div.up(div1).cls("rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03]")
	Dim div3 As MiniHtml = MH.Div.up(div2).cls("border-t border-gray-100 p-5 sm:p-6 dark:border-gray-800")
	Dim div4 As MiniHtml = MH.Div.up(div3).cls("overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-gray-800 dark:bg-white/[0.03]")
	div4.attr("x-data", "{isModalOpen: false}")
	div4.attr("@entity:changed", "isModalOpen = false")
	
	Dim div5 As MiniHtml = MH.Div.cls("flex flex-col gap-5 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between").up(div4)
	Dim div6 As MiniHtml = MH.Div.up(div5)
	Dim heading3 As MiniHtml = MH.H3.up(div6)
	heading3.cls("text-lg font-semibold text-gray-800 dark:text-white/90")
	heading3.textWrap("Categories")
	
	Dim div7 As MiniHtml = MH.Div.up(div5)
	div7.cls("flex flex-col gap-3 sm:flex-row sm:items-center")

	Dim form1 As MiniHtml = MH.Form.up(div7)
	Dim div8 As MiniHtml = MH.Div.up(form1)
	div8.cls("relative")
	Dim span1 As MiniHtml = MH.Div.up(div8)
	span1.cls("absolute -translate-y-1/2 pointer-events-none top-1/2 left-4")
	Dim svg1 As MiniHtml = MH.Svg.up(span1)
	svg1.cls("fill-gray-500 dark:fill-gray-400")
	svg1.attr("width", 20).attr("height", 20)
	svg1.attr("viewBox", "0 0 20 20")
	Dim path1 As MiniHtml = MH.Path.up(svg1)
	path1.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path1.attr("d", "M3.04199 9.37381C3.04199 5.87712 5.87735 3.04218 9.37533 3.04218C12.8733 3.04218 15.7087 5.87712 15.7087 9.37381C15.7087 12.8705 12.8733 15.7055 9.37533 15.7055C5.87735 15.7055 3.04199 12.8705 3.04199 9.37381ZM9.37533 1.54218C5.04926 1.54218 1.54199 5.04835 1.54199 9.37381C1.54199 13.6993 5.04926 17.2055 9.37533 17.2055C11.2676 17.2055 13.0032 16.5346 14.3572 15.4178L17.1773 18.2381C17.4702 18.531 17.945 18.5311 18.2379 18.2382C18.5308 17.9453 18.5309 17.4704 18.238 17.1775L15.4182 14.3575C16.5367 13.0035 17.2087 11.2671 17.2087 9.37381C17.2087 5.04835 13.7014 1.54218 9.37533 1.54218Z")
	path1.attr("fill", "")
	path1.Mode = "self"
	Dim input1 As MiniHtml = MH.Input.up(div8)
	input1.attr("type", "text")
	input1.attr("placeholder", "Search...")
	input1.attr("id", "search-input")
	input1.cls("dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-10 w-full rounded-lg border border-gray-300 bg-transparent py-2.5 pr-4 pl-[42px] text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden xl:w-[300px] dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30")
	input1.FormatAttributes = True
	Dim div9 As MiniHtml = MH.Div.up(div7)
	Dim button1 As MiniHtml = MH.Button.up(div9)
	button1.cls("text-theme-sm shadow-theme-xs inline-flex h-10 items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200")
	Dim svg1 As MiniHtml = MH.Svg.up(button1)
	svg1.cls("stroke-current fill-white dark:fill-gray-800")
	svg1.attr("width", 20).attr("height", 20)
	svg1.attr("viewBox", "0 0 20 20")
	Dim path1 As MiniHtml = MH.Path.up(svg1)
	path1.attr("d", "M2.29004 5.90393H17.7067")
	path1.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")
	Dim path2 As MiniHtml = MH.Path.up(svg1)
	path2.attr("d", "M17.7075 14.0961H2.29085")
	path2.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")
	Dim path3 As MiniHtml = MH.Path.up(svg1)
	path3.attr("d", "M12.0826 3.33331C13.5024 3.33331 14.6534 4.48431 14.6534 5.90414C14.6534 7.32398 13.5024 8.47498 12.0826 8.47498C10.6627 8.47498 9.51172 7.32398 9.51172 5.90415C9.51172 4.48432 10.6627 3.33331 12.0826 3.33331Z")
	path3.attr("stroke", "").attr("stroke-width", "1.5")
	Dim path4 As MiniHtml = MH.Path.up(svg1)
	path4.attr("d", "M7.91745 11.525C6.49762 11.525 5.34662 12.676 5.34662 14.0959C5.34661 15.5157 6.49762 16.6667 7.91745 16.6667C9.33728 16.6667 10.4883 15.5157 10.4883 14.0959C10.4883 12.676 9.33728 11.525 7.91745 11.525Z")
	path4.attr("stroke", "").attr("stroke-width", "1.5")
	button1.textWrap(" Filter ")
	
	Dim div10 As MiniHtml = MH.Div.up(div7)
	div10.attr("x-data", "{openDropDown: false}")
	div10.cls("relative")
	Dim button2 As MiniHtml = MH.Button.up(div10)
	button2.attr("@click", "openDropDown = !openDropDown")
	button2.attr(":class", "openDropDown ? 'text-gray-700 dark:text-white' : 'text-gray-400 hover:text-gray-700 dark:hover:text-white'")
	button2.cls("text-gray-400 hover:text-gray-700 dark:hover:text-white")
	Dim svg2 As MiniHtml = MH.Svg.up(button2)
	svg2.cls("fill-current")
	svg2.attr("width", 24).attr("height", 24)
	svg2.attr("viewBox", "0 0 24 24")
	Dim path21 As MiniHtml = MH.Path.up(svg2)
	path21.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path21.attr("d", "M10.2441 6C10.2441 5.0335 11.0276 4.25 11.9941 4.25H12.0041C12.9706 4.25 13.7541 5.0335 13.7541 6C13.7541 6.9665 12.9706 7.75 12.0041 7.75H11.9941C11.0276 7.75 10.2441 6.9665 10.2441 6ZM10.2441 18C10.2441 17.0335 11.0276 16.25 11.9941 16.25H12.0041C12.9706 16.25 13.7541 17.0335 13.7541 18C13.7541 18.9665 12.9706 19.75 12.0041 19.75H11.9941C11.0276 19.75 10.2441 18.9665 10.2441 18ZM11.9941 10.25C11.0276 10.25 10.2441 11.0335 10.2441 12C10.2441 12.9665 11.0276 13.75 11.9941 13.75H12.0041C12.9706 13.75 13.7541 12.9665 13.7541 12C13.7541 11.0335 12.9706 10.25 12.0041 10.25H11.9941Z")
	path21.attr("fill", "")
	
	Dim div11 As MiniHtml = MH.Div.up(div10)
	div11.attr("x-show", "openDropDown")
	div11.attr("@click.outside", "openDropDown = false")
	div11.cls("absolute right-0 z-40 w-40 p-2 space-y-1 bg-white border border-gray-200 shadow-theme-lg dark:bg-gray-dark top-full rounded-2xl dark:border-gray-800")
	div11.sty("display: none")
	
	Dim button4 As MiniHtml = MH.Button.up(div11)
	button4.cls("flex w-full px-3 py-2 font-medium text-left text-gray-500 rounded-lg text-theme-xs hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-white/5 dark:hover:text-gray-300")
	button4.textWrap("Add Category")
	button4.attr("hx-get", "/hx/categories/add")
	button4.attr("hx-target", "#modal-content")
	button4.attr("hx-swap", "innerHTML")
	button4.attr("@click", "isModalOpen = true")
	
	' Load ContainerModal shell
	ContainerModal.up(div4)
	
	Dim container1 As MiniHtml = MH.Div.up(div4)
	container1.cls("max-w-full overflow-x-auto custom-scrollbar")
	container1.attr("id", "categories-container")
	container1.attr("hx-get", "/hx/categories/table")
	container1.attr("hx-trigger", "load")
	container1.text("Loading...")

	Return content1
End Sub

Private Sub CategoriesTableFilled (data As List) As MiniHtml
	Dim CacheName As String = "Categories Table"
	If ExistInCache(CacheName) = False Then
		WriteToCache(CacheName, CategoriesTable)
	End If
	
	Dim CacheName As String = "Categories Table Row"
	If ExistInCache(CacheName) = False Then
		WriteToCache(CacheName, CategoriesTableRow.ConvertToBytes) ' bytes()
	End If
	
	Dim table1 As MiniHtml = ReadFromCache("Categories Table")
	Dim tbody1 As MiniHtml = table1.Child(1)
	tbody1.Children.Clear
	For Each row As Map In data
		Dim tr1 As MiniHtml = ReadFromCache("Categories Table Row") ' bytes()
		tr1.Child(0).Child(0).Child(0).text2(row.Get("id"))
		tr1.Child(1).Child(0).Child(0).text2(row.Get("category_name"))
		tr1.Child(2).Child(0).Child(0).attr("hx-get", "/hx/categories/edit/" & row.Get("id"))
		tr1.Child(2).Child(0).Child(1).attr("hx-get", "/hx/categories/delete/" & row.Get("id"))
		tr1.up(tbody1)
	Next
	Return table1
End Sub

Private Sub CategoriesTable As MiniHtml
	Dim table1 As MiniHtml = MH.Table.cls("min-w-full")
	Dim thead1 As MiniHtml = MH.Thead.up(table1).cls("border-gray-100 border-y bg-gray-50 dark:border-gray-800 dark:bg-gray-900")
	Dim tr1 As MiniHtml = MH.Tr.up(thead1)

	Dim th1 As MiniHtml = MH.Th.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv1 As MiniHtml = MH.Div.up(th1).cls("flex items-center justify-end")
	MH.P.up(thdiv1).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("#")
	
	Dim th2 As MiniHtml = MH.Th.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv2 As MiniHtml = MH.Div.up(th2).cls("flex items-center")
	MH.P.up(thdiv2).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Name")

	Dim th3 As MiniHtml = MH.Th.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv3 As MiniHtml = MH.Div.up(th3).cls("flex items-center justify-center")
	MH.P.up(thdiv3).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Actions")
	MH.Tbody.up(table1).cls("divide-y divide-gray-100 dark:divide-gray-800")
	Return table1
End Sub

Private Sub CategoriesTableRow As MiniHtml
	Dim tr1 As MiniHtml = MH.Tr
	Dim td1 As MiniHtml = MH.Td.up(tr1).cls("px-6 py-3 whitespace-nowrap").multiline
	Dim div1 As MiniHtml = MH.Div.up(td1).cls("flex items-center justify-end")
	MH.P.up(div1).cls("text-gray-700 text-theme-sm dark:text-gray-400").text("{id}")
	Dim td2 As MiniHtml = MH.Td.up(tr1).cls("px-6 py-3 whitespace-nowrap").multiline
	Dim div2 As MiniHtml = MH.Div.up(td2).cls("flex items-center").multiline
	MH.P.up(div2).cls("text-gray-700 text-theme-sm dark:text-gray-400").text("{name}")
	Dim td3 As MiniHtml = MH.Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	Dim div3 As MiniHtml = MH.Div.up(td3).cls("flex items-center justify-center")
	
'	Dim anchor1 As MiniHtml = MH.Anchor.up(div3).cls("edit text-primary mx-2")
'	anchor1.attr("hx-get", "/hx/categories/edit/{id}")
'	anchor1.attr("hx-target", "#modal-content")
'	anchor1.attr("hx-trigger", "click")
'	anchor1.attr("data-bs-toggle", "modal")
'	anchor1.attr("data-bs-target", "#modal-container")
'	anchor1.add(MH.Icon.cls("bi bi-pencil"))
'	anchor1.attr("title", "Edit")
'		
'	Dim anchor2 As MiniHtml = MH.Anchor.up(div3).cls("delete text-danger mx-2")
'	anchor2.attr("hx-get", "/hx/categories/delete/{id}")
'	anchor2.attr("hx-target", "#modal-content")
'	anchor2.attr("hx-trigger", "click")
'	anchor2.attr("data-bs-toggle", "modal")
'	anchor2.attr("data-bs-target", "#modal-container")
'	anchor2.add(MH.Icon.cls("bi bi-trash3"))
'	anchor2.attr("title", "Delete")
	
	Dim anchor1 As MiniHtml = MH.Anchor.up(div3)
	anchor1.cls("edit mx-2 cursor-pointer")
	anchor1.attr("hx-target", "#modal-content")
	anchor1.attr("hx-swap", "innerHTML")
	anchor1.attr("@click", "isModalOpen = true")
	MH.Icon.up(anchor1).cls("bi bi-pencil text-brand-600 hover:text-blue-300")
	anchor1.attr("title", "Edit")
	
	Dim anchor2 As MiniHtml = MH.Anchor.up(div3)
	anchor2.cls("delete mx-2 cursor-pointer")
	anchor2.attr("hx-target", "#modal-content")
	anchor2.attr("hx-swap", "innerHTML")
	anchor2.attr("@click", "isModalOpen = true")
	MH.Icon.up(anchor2).cls("bi bi-trash3 text-danger-600 hover:text-red-300")
	anchor2.attr("title", "Delete")
	
	Return tr1
End Sub

Private Sub ModalAdd As MiniHtml
	Dim form1 As MiniHtml = MH.Form
	form1.attr("hx-post", "/hx/categories")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	MH.H4.up(form1).cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90").text("Add Category")
	
'	Dim modalHeader As MiniHtml = MH.Div.up(form1).cls("modal-header")
'	Dim h51 As MiniHtml = MH.H5.up(modalHeader)
'	h51.cls("modal-title").text("Add Category")
'	Dim close1 As MiniHtml = MH.Button.up(modalHeader)
'	close1.attr("type", "button")
'	close1.cls("btn-close")
'	close1.attr("data-bs-dismiss", "modal")
	
	Dim modalBody As MiniHtml = MH.Div.up(form1)
	modalBody.cls("grid grid-cols-1 gap-x-6 gap-y-5")
	
	MH.Div.up(modalBody).attr("id", "modal-messages")
	
	Dim group1 As MiniHtml = MH.Div.up(modalBody).cls("col-span-1") '.cls("form-group")
	Dim label1 As MiniHtml = MH.Label.up(group1)
	label1.attr("for", "name").text("Name ")
	Dim span1 As MiniHtml = MH.Span.up(label1)
	span1.cls("text-danger").text("*")
	
	Dim input1 As MiniHtml = MH.Input.attr("type", "text").up(group1)
	input1.attr("id", "name")
	input1.attr("name", "name")
	'input1.cls("form-control").required
	input1.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")
	input1.required
	
	Dim modalFooter As MiniHtml = MH.Div.up(form1).cls("modal-footer")
	
'	Dim button1 As MiniHtml = MH.Button.up(modalFooter)
'	button1.attr("type", "submit")
'	button1.cls("btn btn-success px-3")
'	button1.text("Create")
'	Dim button2 As MiniHtml = MH.Button.up(modalFooter)
'	button2.attr("type", "button")
'	button2.cls("btn btn-secondary px-3")
'	button2.attr("data-bs-dismiss", "modal")
'	button2.text("Cancel")
	
	Dim modalFooter As MiniHtml = MH.Div.up(form1)
	modalFooter.cls("flex items-center justify-end w-full gap-3 mt-6")
	
	Dim button1 As MiniHtml = MH.Button.up(modalFooter)
	button1.cls("flex justify-center px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto")
	button1.attr("type", "submit")
	button1.text("Create")
	
	Dim button2 As MiniHtml = MH.Button.up(modalFooter)
	button2.cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto")
	button2.attr("type", "button")
	button2.attr("@click", "isModalOpen = false")
	button2.text("Close")
	
	Return form1
End Sub

Private Sub ModalEdit As MiniHtml
	Dim form1 As MiniHtml = MH.Form
	form1.attr("hx-put", "/hx/categories")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	
	'Dim modalHeader As MiniHtml = MH.Div.up(form1)
	'modalHeader.cls("modal-header")
	'Dim h51 As MiniHtml = MH.H5.up(modalHeader)
	'h51.cls("modal-title").text("Edit Category")
	'Dim close1 As MiniHtml = MH.Button.up(modalHeader)
	'close1.attr("type", "button")
	'close1.cls("btn-close")
	'close1.attr("data-bs-dismiss", "modal")
	
	Dim h41 As MiniHtml = MH.H4.up(form1)
	h41.cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90")
	h41.text("Edit Category")
	
	Dim modalBody As MiniHtml = MH.Div.up(form1)
	'modalBody.cls("modal-body")
	modalBody.cls("grid grid-cols-1 gap-x-6 gap-y-5 sm:grid-cols-2")
	
	'Dim div1 As MiniHtml = MH.Div.up(modalBody)
	'div1.attr("id", "modal-messages")
	'Dim id1 As MiniHtml = MH.Input.up(modalBody)
	'id1.attr("type", "hidden")
	'id1.attr("name", "id")
	'id1.attr("value", "$id$")
	
	Dim div1 As MiniHtml = MH.Div.up(modalBody)
	div1.attr("id", "modal-messages")
	div1.cls("col-span-2")
	
	Dim id1 As MiniHtml = MH.Input.up(modalBody)
	id1.attr("type", "hidden")
	id1.attr("name", "id")
	id1.attr("value", CategoryMap.Get("id"))
	
	Dim group1 As MiniHtml = MH.Div.up(modalBody)
	group1.cls("col-span-1")
	
	Dim label1 As MiniHtml = MH.Label.up(group1)
	label1.attr("for", "name")
	label1.cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400")
	label1.text("Name ")
	Dim span1 As MiniHtml = MH.Span.up(label1)
	span1.cls("text-danger").text("*")
	
	Dim input1 As MiniHtml = MH.Input.up(group1)
	input1.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")
	input1.attr("type", "text")
	input1.attr("id", "name")
	input1.attr("name", "name")
	input1.attr("value", CategoryMap.Get("category_name"))
	input1.required
	
	Dim modalFooter As MiniHtml = MH.Div.up(form1)
	modalFooter.cls("flex items-center justify-end w-full gap-3 mt-6")
	
	Dim button1 As MiniHtml = MH.Button.up(modalFooter)
	button1.cls("flex justify-center px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto")
	button1.attr("type", "submit")
	button1.text("Update")
	
	Dim button2 As MiniHtml = MH.Button.up(modalFooter)
	button2.cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto")
	button2.attr("type", "button")
	button2.attr("data-bs-dismiss", "modal")
	button2.text("Cancel")
	
	Return form1
End Sub

Private Sub ModalDelete As MiniHtml
	Dim form1 As MiniHtml = MH.Form
	form1.attr("hx-delete", "/hx/categories")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	
	'Dim modalHeader As MiniHtml = MH.Div.up(form1).cls("modal-header")
	'Dim h51 As MiniHtml = MH.H5.up(modalHeader)
	'h51.cls("modal-title").text("Delete Category")
	'Dim close1 As MiniHtml = MH.Button.up(modalHeader)
	'close1.attr("type", "button")
	'close1.cls("btn-close")
	'close1.attr("data-bs-dismiss", "modal")
	
	Dim h41 As MiniHtml = MH.H4.up(form1)
	h41.cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90")
	h41.text("Delete Category")
	
	Dim modalBody As MiniHtml = MH.Div.up(form1)
	modalBody.cls("grid grid-cols-1 gap-x-6 gap-y-5")
	
	Dim div1 As MiniHtml = MH.Div.up(modalBody)
	div1.attr("id", "modal-messages")
	
	Dim input1 As MiniHtml = MH.Input.up(modalBody)
	input1.attr("type", "hidden")
	input1.attr("name", "id")
	input1.attr("value", CategoryMap.Get("id"))

	'MH.P.up(modalBody).text($"Delete $category_name$?"$)
	Dim p1 As MiniHtml = MH.P.up(modalBody)
	p1.cls("text-gray-700 dark:text-gray-400")
	p1.text2($"Delete ${CategoryMap.Get("category_name")}?"$)
	
	'Dim modalFooter As MiniHtml = MH.Div.up(form1).cls("modal-footer")
	'Dim button1 As MiniHtml = MH.Button.up(modalFooter)
	'button1.attr("type", "submit")
	'button1.cls("btn btn-danger px-3")
	'button1.text("Delete")
	'Dim button2 As MiniHtml = MH.Button.up(modalFooter)
	'button2.attr("type", "button")
	'button2.cls("btn btn-secondary px-3")
	'button2.attr("data-bs-dismiss", "modal")
	'button2.text("Cancel")
	
	Dim modalFooter As MiniHtml = MH.Div.up(form1)
	modalFooter.cls("flex items-center justify-end w-full gap-3 mt-6")
	
	Dim button1 As MiniHtml = MH.Button.up(modalFooter)
	button1.cls("flex justify-center w-full px-4 py-3 text-sm font-medium text-white rounded-lg bg-error-600 shadow-theme-xs hover:bg-error-700 sm:w-auto")
	button1.attr("type", "submit")
	button1.text("Delete")
	
	Dim button2 As MiniHtml = MH.Button.up(modalFooter)
	button2.cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto")
	button2.attr("type", "button")
	button2.text("Cancel")
	button2.attr("@click", "isModalOpen = false")
	
	Return form1
End Sub

Private Sub ContainerModal As MiniHtml
	Dim modal1 As MiniHtml = MH.Div
	modal1.attr("x-show", "isModalOpen")
	modal1.attr("id", "modal-container")
	modal1.cls("fixed inset-0 flex items-center justify-center p-5 overflow-y-auto modal z-99999")
	modal1.attr("x-cloak", "")
	
	MH.Div.up(modal1).cls("modal-close-btn fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]")
	
	Dim modalDialog As MiniHtml = MH.Div.up(modal1)
	modalDialog.attr("@click.outside", "isModalOpen = false")
	modalDialog.cls("relative w-full max-w-[584px] rounded-3xl bg-white p-6 dark:bg-gray-900 lg:p-10")
	modalDialog.comment(" close btn ")
	
	Dim button1 As MiniHtml = MH.Button.up(modalDialog).attr("@click", "isModalOpen = false")
	button1.cls("group absolute right-3 top-3 z-999 flex h-9.5 w-9.5 items-center justify-center rounded-full bg-gray-200 text-gray-500 transition-colors hover:bg-gray-300 hover:text-gray-500 dark:bg-gray-800 dark:hover:bg-gray-700 sm:right-6 sm:top-6 sm:h-11 sm:w-11")
	
	Dim svg1 As MiniHtml = MH.Svg.up(button1)
	svg1.cls("transition-colors fill-current group-hover:text-gray-600 dark:group-hover:text-gray-200")
	svg1.attr("width", 24).attr("height", 24)
	svg1.attr("viewBox", "0 0 24 24")
	Dim path1 As MiniHtml = MH.Path.up(svg1)
	path1.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path1.attr("d", "M6.04289 16.5413C5.65237 16.9318 5.65237 17.565 6.04289 17.9555C6.43342 18.346 7.06658 18.346 7.45711 17.9555L11.9987 13.4139L16.5408 17.956C16.9313 18.3466 17.5645 18.3466 17.955 17.956C18.3455 17.5655 18.3455 16.9323 17.955 16.5418L13.4129 11.9997L17.955 7.4576C18.3455 7.06707 18.3455 6.43391 17.955 6.04338C17.5645 5.65286 16.9313 5.65286 16.5408 6.04338L11.9987 10.5855L7.45711 6.0439C7.06658 5.65338 6.43342 5.65338 6.04289 6.0439C5.65237 6.43442 5.65237 7.06759 6.04289 7.45811L10.5845 11.9997L6.04289 16.5413Z")
	path1.attr("fill", "")
	
	MH.Div.up(modalDialog).attr("id", "modal-content")
	
	Return modal1
End Sub

Private Sub ContainerToast As MiniHtml
	Dim div1 As MiniHtml = MH.Div.cls("position-fixed end-0 p-3")
	div1.sty("z-index: 2000")
	div1.sty("bottom: 0%")
	Dim toast1 As MiniHtml = MH.Div.up(div1)
	toast1.attr("id", "toast-container")
	toast1.cls("toast align-items-center text-bg-success border-0")
	toast1.attr("role", "alert")
	Dim div2 As MiniHtml = MH.Div.up(toast1)
	div2.cls("d-flex")
	Dim div3 As MiniHtml = MH.Div.up(div2)
	div3.cls("toast-body")
	div3.attr("id", "toast-body")
	div3.text("Operation successful!")
	Dim button1 As MiniHtml = MH.Button.up(div2)
	button1.attr("type", "button")
	button1.cls("btn-close btn-close-white me-2 m-auto")
	button1.attr("data-bs-dismiss", "toast")
	Return div1
End Sub