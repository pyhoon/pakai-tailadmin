B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Index Handler class
' Version 6.00
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
	Dim path As String = req.RequestURI
	If path = "/" Then
		RenderPage
	Else If path = "/api/products/table" Then
		HandleTable
	Else If path = "/api/products/search" Then
		HandleSearch
	Else If path = "/api/products/add" Then
		HandleAddModal
	Else If path.StartsWith("/api/products/edit/") Then
		HandleEditModal
	Else If path.StartsWith("/api/products/delete/") Then
		HandleDeleteModal
	Else
		HandleProducts
	End If
End Sub

Private Sub RenderPage
	Dim main1 As MainView
	main1.Initialize
	main1.PageName = "products"
	main1.LoadContent(ContentContainer)
	main1.LoadSubContent(GitHubLink)
	'main1.LoadModal(ModalContainer)
	'main1.LoadToast(ToastContainer)

	Dim page1 As MiniHtml = main1.View

    Dim doc As MiniHtml
    doc.Initialize("")
    doc.Write("<!DOCTYPE html>")
    doc.Write(page1.build)
	App.WriteHtml2(Response, doc.ToString, App.ctx)
	'App.WriteHtml2(Response, page1.Build, App.ctx)
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

Sub H4 As MiniHtml
    Return CreateTag("h4")
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
	heading3.textWrap("Products")
	
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
	button4.textWrap("Add Product")
	button4.attr("@click", "isModalOpen = !isModalOpen")

	Dim container1 As MiniHtml = Div.up(div4)
	container1.cls("max-w-full overflow-x-auto custom-scrollbar")

	container1.attr("id", "products-container")
	container1.attr("hx-get", "/api/products/table")
	container1.attr("hx-trigger", "load")
	container1.text("Loading...")
	
	div4.attr("x-data", "{isModalOpen: false}")
	Dim modal1 As MiniHtml = ModalContainer.up(div4)
	Dim modalContent As MiniHtml = modal1.Child(modal1.Children.Size-1)
	
	Dim form1 As MiniHtml = Form.up(modalContent)
	form1.attr("hx-post", "/api/products")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	H4.cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90").text("Add Product").up(form1)
	Dim modalBody As MiniHtml = Div.cls("grid grid-cols-1 gap-x-6 gap-y-5 sm:grid-cols-2").up(form1)
	Div.attr("id", "modal-messages").cls("col-span-2").up(modalBody)
	Dim group1 As MiniHtml = Div.cls("col-span-1").up(modalBody)
	Label.attr("for", "category1").up(group1).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Category ").add(Span.cls("text-danger").text("*"))
	Dim div12 As MiniHtml = Div.up(group1)
	div12.cls("relative z-20 bg-transparent")
	Dim select1 As MiniHtml = CreateCategoriesDropdown(-1)
	select1.attr("id", "category1")
	select1.attr("name", "category")
	select1.up(div12)
	Dim span12 As MiniHtml = Span.up(div12)
	span12.cls("pointer-events-none absolute top-1/2 right-4 z-30 -translate-y-1/2 text-gray-500 dark:text-gray-400")
	Dim svg12 As MiniHtml = Svg.up(span12)
	svg12.cls("stroke-current")
	svg12.attr("width", 20).attr("height", 20)
	svg12.attr("viewBox", "0 0 20 20")
	Dim path3 As MiniHtml = SvgPath.up(svg12)
	path3.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path3.attr("d", "M4.79175 7.396L10.0001 12.6043L15.2084 7.396")
	path3.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")

	Dim group2 As MiniHtml = Div.cls("col-span-1").up(modalBody)
	Label.up(group2).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Code ").add(Span.cls("text-red").text("*"))
	Input.up(group2).attr("type", "text").attr("name", "code").required.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")

	Dim group3 As MiniHtml = Div.cls("col-span-1").up(modalBody)
	Label.up(group3).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Name ").add(Span.cls("text-danger").text("*"))
	Input.up(group3).attr("type", "text").attr("name", "name").required.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")

	Dim group4 As MiniHtml = Div.cls("col-span-1").up(modalBody)
	Label.up(group4).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Price ")
	Input.up(group4).attr("type", "text").attr("name", "price").cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")
	
	Dim modalFooter As MiniHtml = Div.cls("flex items-center justify-end w-full gap-3 mt-6").up(form1)
	Button.up(modalFooter).text("Create").attr("type", "button").cls("flex justify-center w-full px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto")
	Button.up(modalFooter).text("Close").attr("type", "button").attr("@click", "isModalOpen = false").cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto")
	
	Return content1
End Sub

Private Sub GitHubLink As MiniHtml
	Dim div1 As MiniHtml = Div
	div1.cls("text-center flex flex-col items-center justify-center")
	Dim anchor1 As MiniHtml = Anchor.up(div1)
	anchor1.attr("href", "https://github.com/pyhoon/pakai-server-b4j")
	anchor1.cls("text-brand-500 mr-1")
	anchor1.attr("aria-label", "github").attr("title", "GitHub").attr("target", "_blank")
	
	Dim svg1 As MiniHtml = Svg.up(anchor1)
	'svg1.attr("aria-hidden", "true")
	svg1.cls("text-gray-500 hover:text-gray-800 dark:text-gray-400 dark:hover:text-white/90")
	svg1.attr("width", 24).attr("height", 24)
	'svg1.attr("version", "1.1")
	svg1.attr("viewBox", "0 0 20 20")
	Dim path1 As MiniHtml = SvgPath.up(svg1)
	'path1.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path1.attr("fill-rule", "evenodd")
	path1.attr("d", "M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z")
	path1.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")
	path1.attr("fill", "")
	path1.Mode = "self"
	Return div1
End Sub

Private Sub ModalContainer As MiniHtml
	Dim modal1 As MiniHtml = Div.attr("x-show", "isModalOpen").attr("id", "modal-container")
	modal1.cls("fixed inset-0 flex items-center justify-center p-5 overflow-y-auto modal z-99999")
	modal1.sty("display: none")
	modal1.add(Div.cls("modal-close-btn fixed inset-0 h-full w-full bg-gray-400/50 backdrop-blur-[32px]"))
	Dim modalDialog As MiniHtml = Div.up(modal1).attr("@click.outside", "isModalOpen = false")
	modalDialog.cls("relative w-full max-w-[584px] rounded-3xl bg-white p-6 dark:bg-gray-900 lg:p-10")
	modalDialog.comment(" close btn ")
	Dim button1 As MiniHtml = Button.up(modalDialog).attr("@click", "isModalOpen = false")
	button1.cls("group absolute right-3 top-3 z-999 flex h-9.5 w-9.5 items-center justify-center rounded-full bg-gray-200 text-gray-500 transition-colors hover:bg-gray-300 hover:text-gray-500 dark:bg-gray-800 dark:hover:bg-gray-700 sm:right-6 sm:top-6 sm:h-11 sm:w-11")
	Dim svg1 As MiniHtml = Svg.up(button1)
	svg1.cls("transition-colors fill-current group-hover:text-gray-600 dark:group-hover:text-gray-200")
	svg1.attr("width", 24).attr("height", 24)
	svg1.attr("viewBox", "0 0 24 24")
	Dim path1 As MiniHtml = SvgPath.up(svg1)
	path1.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
	path1.attr("d", "M6.04289 16.5413C5.65237 16.9318 5.65237 17.565 6.04289 17.9555C6.43342 18.346 7.06658 18.346 7.45711 17.9555L11.9987 13.4139L16.5408 17.956C16.9313 18.3466 17.5645 18.3466 17.955 17.956C18.3455 17.5655 18.3455 16.9323 17.955 16.5418L13.4129 11.9997L17.955 7.4576C18.3455 7.06707 18.3455 6.43391 17.955 6.04338C17.5645 5.65286 16.9313 5.65286 16.5408 6.04338L11.9987 10.5855L7.45711 6.0439C7.06658 5.65338 6.43342 5.65338 6.04289 6.0439C5.65237 6.43442 5.65237 7.06759 6.04289 7.45811L10.5845 11.9997L6.04289 16.5413Z")
	path1.attr("fill", "")
	Div.cls("modal-content").up(modalDialog)
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
	App.WriteHtml(Response, CreateProductsTable.Build)
End Sub

' Search product using keyword
Private Sub HandleSearch
	Dim table1 As MiniHtml = Table.cls("table table-bordered table-hover rounded small")
	Dim thead1 As MiniHtml = table1.add(Thead.cls("table-light"))
	thead1.add(Th.sty("text-align: right; width: 50px").text("#"))
	thead1.add(Th.text("Code"))
	thead1.add(Th.text("Name"))
	thead1.add(Th.text("Category"))
	thead1.add(Th.sty("text-align: right").text("Price"))
	thead1.add(Th.sty("text-align: center; width: 120px").text("Actions"))
	Dim tbody1 As MiniHtml = table1.add(Tbody)

	DB.SQL = DB.Open
	DB.Table = "tbl_products p"
	DB.Columns = Array("p.id id", "p.category_id catid", "c.category_name category", "p.product_code code", "p.product_name AS name", "p.product_price price")
	DB.Join("tbl_categories c", "p.category_id = c.id", "")
	Dim keyword As String = Request.GetParameter("keyword")
	If keyword <> "" Then
		DB.Where = Array("p.product_code LIKE ? Or UPPER(p.product_name) LIKE ? Or UPPER(c.category_name) LIKE ?")
		DB.Parameters = Array("%" & keyword & "%", "%" & keyword.ToUpperCase & "%", "%" & keyword.ToUpperCase & "%")
	End If
	DB.OrderBy = CreateMap("p.id": "")
	DB.Query
	For Each row As Map In DB.Results
		Dim id As Int = row.Get("id")
		Dim code As String = row.Get("code")
		Dim name As String = row.Get("name")
		Dim price As Double = row.Get("price")
		Dim category As String = row.Get("category")

		Dim tr1 As MiniHtml = Tr.up(tbody1)
		tr1.add(Td.cls("align-middle").sty("text-align: right").text(id))
		tr1.add(Td.cls("align-middle").text(code))
		tr1.add(Td.cls("align-middle").text(name))
		tr1.add(Td.cls("align-middle").text(category))
		tr1.add(Td.cls("align-middle").sty("text-align: right").text(NumberFormat2(price, 1, 2, 2, True)))
		Dim td1 As MiniHtml = tr1.add(Td.cls("align-middle text-center px-1 py-1"))

		Dim anchor1 As MiniHtml = Anchor.cls("edit text-primary mx-2").up(td1)
		anchor1.attr("hx-get", $"/api/products/edit/${id}"$)
		anchor1.attr("hx-target", "#modal-content")
		anchor1.attr("hx-trigger", "click")
		anchor1.attr("data-bs-toggle", "modal")
		anchor1.attr("data-bs-target", "#modal-container")
		anchor1.add(Icon.cls("bi bi-pencil"))
		anchor1.attr("title", "Edit")
		
		Dim anchor2 As MiniHtml = Anchor.cls("delete text-danger mx-2").up(td1)
		anchor2.attr("hx-get", $"/api/products/delete/${id}"$)
		anchor2.attr("hx-target", "#modal-content")
		anchor2.attr("hx-trigger", "click")
		anchor2.attr("data-bs-toggle", "modal")
		anchor2.attr("data-bs-target", "#modal-container")
		anchor2.add(Icon.cls("bi bi-trash3"))
		anchor2.attr("title", "Delete")
	Next
	DB.Close
	App.WriteHtml(Response, table1.Build)
End Sub

' Add modal
Private Sub HandleAddModal
	Dim form1 As MiniHtml = Form
	form1.attr("hx-post", "/api/products")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
	H4.up(form1).cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90").text("Add Product")
	
	Dim modalBody As MiniHtml = Div.up(form1)
	modalBody.cls("grid grid-cols-1 gap-x-6 gap-y-5 sm:grid-cols-2")
	Div.up(modalBody).attr("id", "modal-messages")
	
	Dim group1 As MiniHtml = Div.up(modalBody).cls("col-span-1")
	Label.attr("for", "category2").cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Category ").up(group1).add(Span.cls("text-danger")).text("*")
	Dim select1 As MiniHtml = CreateCategoriesDropdown(-1).up(group1)
	select1.attr("id", "category1")
	select1.attr("name", "category")
	
	Dim group2 As MiniHtml = Div.up(modalBody)
	group2.cls("col-span-1")
	Label.up(group2).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Code ").add(Span.cls("text-red").text("*"))
	Input.up(group2).attr("type", "text").cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800").attr("name", "code").required
	
	Dim modalFooter As MiniHtml = Div.up(form1).cls("flex items-center justify-end w-full gap-3 mt-6")
	Button.up(modalFooter).attr("type", "button").attr("@click", "isModalOpen = false").cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto").text("Close")
	Button.up(modalFooter).attr("type", "button").cls("flex justify-center w-full px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto").text("Create")
End Sub

' Edit modal
Private Sub HandleEditModal
	Dim id As String = Request.RequestURI.SubString("/api/products/edit/".Length)
	Dim form1 As MiniHtml = Form
	form1.attr("hx-put", "/api/products")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
		
	DB.SQL = DB.Open
	DB.Table = "tbl_products"
	DB.Columns = Array("category_id category", "product_code code", "product_name name", "product_price price")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim row As Map = DB.First
		Dim code As String = row.Get("code")
		Dim name As String = row.Get("name")
		Dim price As Double = row.Get("price")
		Dim category_id As Int = row.Get("category")

		H4.up(form1).cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90").text("Edit Product")
		
		Dim modalBody As MiniHtml = Div.up(form1).cls("grid grid-cols-1 gap-x-6 gap-y-5 sm:grid-cols-2")
		Div.up(modalBody).attr("id", "modal-messages")
		Input.up(modalBody).attr("type", "hidden").attr("name", "id").attr("value", id)
		
		Dim group1 As MiniHtml = Div.up(modalBody).cls("col-span-1")
		Label.up(group1).attr("for", "category2").cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Category ").add(Span.cls("text-danger")).text("*")
		Dim select1 As MiniHtml = CreateCategoriesDropdown(category_id)
		select1.attr("id", "category2")
		select1.attr("name", "category")
		select1.up(group1)
		
		Dim group2 As MiniHtml = Div.cls("col-span-1").up(modalBody)
		Label.cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Code ").up(group2).add(Span.cls("text-red").text("*"))
		group2.add(Input.attr("type", "text").cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800").attr("name", "code").attr("value", code))
		
		Dim group3 As MiniHtml = Div.cls("col-span-1").up(modalBody)
		Label.up(group3).text("Name ").cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").add(Span.cls("text-danger").text("*"))
		Input.up(group3).attr("type", "text").cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800").attr("name", "name").attr("value", name).required

		Dim group4 As MiniHtml = Div.cls("col-span-1").up(modalBody)
		Label.up(group4).text("Price ").cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400")
		Input.up(group4).attr("type", "text").cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800").attr("name", "price").attr("value", NumberFormat2(price, 1, 2, 2, False))
		
		Dim modalFooter As MiniHtml = Div.up(form1).cls("flex items-center justify-end w-full gap-3 mt-6")
		Button.up(modalFooter).attr("type", "button").attr("@click", "isModalOpen = false").cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto").text("Close")
		Button.up(modalFooter).attr("type", "button").cls("flex justify-center w-full px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto").text("Update")
	End If
	DB.Close
	App.WriteHtml(Response, form1.Build)
End Sub

Private Sub CreateCategoriesDropdown (selected As Int) As MiniHtml
	Dim select1 As MiniHtml = CreateTag("select").cls("dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full appearance-none rounded-lg border border-gray-300 bg-transparent bg-none px-4 py-2.5 pr-11 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30")
	select1.required
	select1.attr("hx-get", "/api/categories/list")
	CreateTag("option").up(select1).attr("value", "").text("Select Category").attr3(IIf(selected < 1, "selected", ""))'.disabled

	DB.SQL = DB.Open
	DB.Table = "tbl_categories"
	DB.Columns = Array("id", "category_name AS name")
	DB.Query
	For Each row As Map In DB.Results
		Dim catid As Int = row.Get("id")
		Dim catname As String = row.Get("name")
		If catid = selected Then
			CreateTag("option").attr("value", catid).selected.text(catname).up(select1)
		Else
			CreateTag("option").attr("value", catid).text(catname).up(select1)
		End If
	Next
	DB.Close
	Return select1
End Sub

' Delete modal
Private Sub HandleDeleteModal
	Dim id As String = Request.RequestURI.SubString("/api/products/delete/".Length)
	Dim form1 As MiniHtml = Form
	form1.attr("hx-delete", $"/api/products"$)
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
		
	DB.SQL = DB.Open
	DB.Table = "tbl_products"
	DB.Columns = Array("id", "product_code AS code", "product_name AS name")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim row As Map = DB.First
		Dim code As String = row.Get("code")
		Dim name As String = row.Get("name")

		Dim modalHeader As MiniHtml = Div.up(form1).cls("modal-header")
		H5.up(modalHeader).cls("modal-title").text("Delete Product")
		Button.up(modalHeader).attr("type", "button").cls("btn-close").attr("data-bs-dismiss", "modal")
		
		Dim modalBody As MiniHtml = Div.up(form1).cls("modal-body")
		Div.up(modalBody).attr("id", "modal-messages")
		Input.up(modalBody).attr("type", "hidden").attr("name", "id").attr("value", id)
		CreateTag("p").up(modalBody).text($"Delete (${code}) ${name}?"$)
		
		Dim modalFooter As MiniHtml = Div.up(form1).cls("modal-footer")
		Button.up(modalFooter).cls("btn btn-danger px-3").text("Delete")
		Input.up(modalFooter).attr("type", "button").cls("btn btn-secondary px-3").attr("data-bs-dismiss", "modal").attr("value", "Cancel")
	End If
	DB.Close
	App.WriteHtml(Response, form1.Build)
End Sub

' Handle CRUD operations
Private Sub HandleProducts
	Select Method
		Case "POST"
			' Create
			Dim code As String = Request.GetParameter("code")
			Dim name As String = Request.GetParameter("name")
			Dim tempprice As String = Request.GetParameter("price")
			Dim price As Double = IIf(tempprice.Trim = "", 0, tempprice)
			Dim category As Int = Request.GetParameter("category")

			If code = "" Or code.Trim.Length < 2 Then
				ShowAlert("Product Code must be at least 2 characters long.", "warning")
				Return
			End If
			
			' Check conflict
			Try
				DB.SQL = DB.Open
				DB.Table = "tbl_products"
				DB.Where = Array("product_code = ?")
				DB.Parameters = Array(code)
				DB.Query
				If DB.Found Then
					ShowAlert("Product Code already exists!", "warning")
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
				DB.Columns = Array("category_id", "product_code", "product_name", "product_price", "created_date")
				DB.Parameters = Array(category, code, name, price, Main.CurrentDateTime)
				DB.Save
				ShowToast("Product", "created", "Product created successfully!", "success")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
		Case "PUT"
			' Update
			Dim id As Int = Request.GetParameter("id")
			Dim code As String = Request.GetParameter("code")
			Dim name As String = Request.GetParameter("name")
			Dim price As Double = Request.GetParameter("price")
			Dim category As Int = Request.GetParameter("category")
			
			If code = "" Or code.Trim.Length < 2 Then
				ShowAlert("Product Code must be at least 2 characters long.", "warning")
				Return
			End If
			
			DB.SQL = DB.Open
			DB.Table = "tbl_products"
			DB.Find(id)
			If DB.Found = False Then
				ShowAlert("Product not found!", "warning")
				DB.Close
				Return
			End If

			DB.Reset
			DB.Where = Array("product_code = ?", "id <> ?")
			DB.Parameters = Array(code, id)
			DB.Query
			If DB.Found Then
				ShowAlert("Product Code already exists!", "warning")
				DB.Close
				Return
			End If
			
			' Update row
			Try
				DB.Reset
				DB.Columns = Array("category_id", "product_code", "product_name", "product_price", "modified_date")
				DB.Parameters = Array(category, code, name, price, Main.CurrentDateTime)
				DB.Id = id
				DB.Save
				ShowToast("Product", "updated", "Product updated successfully!", "info")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
		Case "DELETE"
			' Delete
			Dim id As Int = Request.GetParameter("id")
			
			DB.SQL = DB.Open
			DB.Table = "tbl_products"
			DB.Find(id)
			If DB.Found = False Then
				ShowAlert("Product not found!", "warning")
				DB.Close
				Return
			End If

			' Delete row
			Try
				DB.Table = "tbl_products"
				DB.Id = id
				DB.Delete
				ShowToast("Product", "deleted", "Product deleted successfully!", "danger")
			Catch
				ShowAlert($"Database error: ${LastException.Message}"$, "danger")
			End Try
			DB.Close
	End Select
End Sub

Private Sub CreateProductsTable As MiniHtml
	Dim table1 As MiniHtml = Table.cls("min-w-full")
	Dim thead1 As MiniHtml = Thead.up(table1).cls("border-gray-100 border-y bg-gray-50 dark:border-gray-800 dark:bg-gray-900")
	Dim trow1 As MiniHtml = Tr.up(thead1)
	
	Dim th1 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv1 As MiniHtml = Div.up(th1).cls("flex items-center justify-end")
	CreateTag("p").up(thdiv1).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("#")
	
	Dim th2 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv2 As MiniHtml = Div.up(th2).cls("flex items-center")
	CreateTag("p").up(thdiv2).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Code")
	
	Dim th3 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv3 As MiniHtml = Div.up(th3).cls("flex items-center")
	CreateTag("p").up(thdiv3).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Name")
	
	Dim th4 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv4 As MiniHtml = Div.up(th4).cls("flex items-center")
	CreateTag("p").up(thdiv4).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Category")
	
	Dim th5 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv5 As MiniHtml = Div.up(th5).cls("flex items-center justify-end")
	CreateTag("p").up(thdiv5).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Price")
	
	Dim th6 As MiniHtml = Th.up(trow1).cls("px-6 py-3 whitespace-nowrap")
	Dim thdiv6 As MiniHtml = Div.up(th6).cls("flex items-center justify-center")
	CreateTag("p").up(thdiv6).cls("font-medium text-gray-500 text-theme-xs dark:text-gray-400").text("Actions")
	
	Dim tbody1 As MiniHtml = Tbody.up(table1).cls("divide-y divide-gray-100 dark:divide-gray-800")

	DB.SQL = DB.Open
	DB.Table = "tbl_products p"
	DB.Columns = Array("p.id id", "p.category_id catid", "c.category_name category", "p.product_code code", "p.product_name name", "p.product_price price")
	DB.Join("tbl_categories c", "p.category_id = c.id", "")
	DB.OrderBy = CreateMap("p.id": "")
	DB.Query
	For Each row As Map In DB.Results
		Dim tr1 As MiniHtml = CreateProductsRow(row)
		tr1.up(tbody1)
	Next
	DB.Close
	Return table1
End Sub

Private Sub CreateProductsRow (data As Map) As MiniHtml
	Dim id As Int = data.Get("id")
	Dim code As String = data.Get("code")
	Dim name As String = data.Get("name")
	Dim price As Double = data.Get("price")
	Dim category As String = data.Get("category")

	Dim tr1 As MiniHtml = Tr
	Dim td1 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td1.add(Div.cls("flex items-center justify-end")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(id))
	td1.multiline
	
	Dim td2 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td2.add(Div.cls("flex items-center")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(code))
	td2.multiline
	
	Dim td3 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td3.add(Div.cls("flex items-center")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(name))
	td3.multiline
	
	Dim td4 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td4.add(Div.cls("flex items-center")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(category))
	td4.multiline
	
	Dim td5 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td5.add(Div.cls("flex items-center justify-end")).add(CreateTag("p").cls("text-gray-700 text-theme-sm dark:text-gray-400").text(NumberFormat2(price, 1, 2, 2, True)))
	td5.multiline
	
	Dim td6 As MiniHtml = Td.up(tr1).cls("px-6 py-3 whitespace-nowrap")
	td6.multiline
	Dim div6 As MiniHtml = Div.up(td6).cls("flex items-center justify-center")
	div6.attr("x-data", "{isModalOpen: false}")
	
	Dim anchor1 As MiniHtml = Anchor.up(div6).cls("edit mx-2")
	anchor1.add(Icon.cls("bi bi-pencil text-brand-600 hover:text-blue-300"))
	anchor1.attr("title", "Edit")
	anchor1.attr("@click", "isModalOpen = !isModalOpen")
	
	Dim modal1 As MiniHtml = ModalContainer.up(div6)
	Dim modalContent As MiniHtml = modal1.Child(modal1.Children.Size-1)
	
	Dim form1 As MiniHtml = Form.up(modalContent)
	form1.attr("hx-put", "/api/products")
	form1.attr("hx-target", "#modal-messages")
	form1.attr("hx-swap", "innerHTML")
		
	DB.SQL = DB.Open
	DB.Table = "tbl_products"
	DB.Columns = Array("category_id category", "product_code code", "product_name name", "product_price price")
	DB.WhereParam("id = ?", id)
	DB.Query
	If DB.Found Then
		Dim row As Map = DB.First
		Dim code As String = row.Get("code")
		Dim name As String = row.Get("name")
		Dim price As Double = row.Get("price")
		Dim category_id As Int = row.Get("category")

		H4.up(form1).cls("mb-6 text-lg font-medium text-gray-800 dark:text-white/90").text("Edit Product")
		Dim modalBody As MiniHtml = Div.up(form1).cls("grid grid-cols-1 gap-x-6 gap-y-5 sm:grid-cols-2")
		Div.up(modalBody).attr("id", "modal-messages").cls("col-span-2")
		Input.up(modalBody).attr("type", "hidden").attr("name", "id").attr("value", id)
		Dim group1 As MiniHtml = Div.up(modalBody).cls("col-span-1")
		Label.up(group1).attr("for", "category2").cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Category ").add(Span.cls("text-danger").text("*"))
		Dim div12 As MiniHtml = Div.up(group1)
		div12.cls("relative z-20 bg-transparent")
		Dim select1 As MiniHtml = CreateCategoriesDropdown(category_id).up(div12)
		select1.attr("id", "category2")
		select1.attr("name", "category")
		Dim span12 As MiniHtml = Span.up(div12)
		span12.cls("pointer-events-none absolute top-1/2 right-4 z-30 -translate-y-1/2 text-gray-500 dark:text-gray-400")
		Dim svg12 As MiniHtml = Svg.up(span12)
		svg12.cls("stroke-current")
		svg12.attr("width", 20).attr("height", 20)
		svg12.attr("viewBox", "0 0 20 20")
		Dim path3 As MiniHtml = SvgPath.up(svg12)
		path3.attr("fill-rule", "evenodd").attr("clip-rule", "evenodd")
		path3.attr("d", "M4.79175 7.396L10.0001 12.6043L15.2084 7.396")
		path3.attr("stroke", "").attr("stroke-width", "1.5").attr("stroke-linecap", "round").attr("stroke-linejoin", "round")

		Dim group2 As MiniHtml = Div.up(modalBody).cls("col-span-1")
		Label.up(group2).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Code ").add(Span.cls("text-red").text("*"))
		Input.up(group2).attr("type", "text").attr("name", "code").attr("value", code).required.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")

		Dim group3 As MiniHtml = Div.cls("col-span-1").up(modalBody)
		Label.up(group3).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Name ").add(Span.cls("text-danger").text("*"))
		Input.up(group3).attr("type", "text").attr("name", "name").attr("value", name).required.cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")

		Dim group4 As MiniHtml = Div.cls("col-span-1").up(modalBody)
		Label.up(group4).cls("mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400").text("Price ")
		Input.up(group4).attr("type", "text").attr("name", "price").attr("value", NumberFormat2(price, 1, 2, 2, False)).cls("dark:bg-dark-900 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 shadow-theme-xs placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 dark:focus:border-brand-800")
	
		Dim modalFooter As MiniHtml = Div.cls("flex items-center justify-end w-full gap-3 mt-6").up(form1)
		Button.up(modalFooter).attr("type", "button").text("Update").cls("flex justify-center w-full px-4 py-3 text-sm font-medium text-white rounded-lg bg-brand-500 shadow-theme-xs hover:bg-brand-600 sm:w-auto")
		Button.up(modalFooter).attr("type", "button").text("Close").attr("@click", "isModalOpen = false").cls("flex w-full justify-center rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm font-medium text-gray-700 shadow-theme-xs transition-colors hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:w-auto")
	End If
	DB.Close
	
	Dim anchor2 As MiniHtml = Anchor.up(div6).cls("delete mx-2")
	anchor2.attr("hx-get", $"/api/products/delete/${id}"$)
	anchor2.attr("hx-target", "#modal-content")
	anchor2.attr("hx-trigger", "click")
	anchor2.attr("data-bs-toggle", "modal")
	anchor2.attr("data-bs-target", "#modal-container")
	anchor2.add(Icon.cls("bi bi-trash3 text-danger-600 hover:text-red-300"))
	anchor2.attr("title", "Delete")

	Return tr1
End Sub

Private Sub ShowAlert (message As String, status As String)
	Dim div1 As MiniHtml = Div.cls("alert alert-" & status).text(message)
	App.WriteHtml(Response, div1.Build)
End Sub

Private Sub ShowToast (entity As String, action As String, message As String, status As String)
	Dim div1 As MiniHtml = Div.attr("id", "products-container")
	div1.attr("hx-swap-oob", "true")
	div1.add(CreateProductsTable)

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